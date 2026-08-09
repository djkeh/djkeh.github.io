#!/usr/bin/env ruby
# frozen_string_literal: true

require "date"
require "json"
require "optparse"
require "pathname"
require "psych"
require "time"
require "uri"

module UnoPersona
  Diagnostic = Struct.new(:file, :line, :column, :severity, :code, :message, :suggestion, keyword_init: true) do
    def to_h
      {
        file: file,
        line: line,
        column: column,
        severity: severity,
        code: code,
        message: message,
        suggestion: suggestion
      }
    end

    def sort_key
      [file.to_s, line || 0, column || 0, severity.to_s, code.to_s, message.to_s]
    end
  end

  Config = Struct.new(
    :root, :mode, :lifecycle, :original, :fresh, :now, :max_clock_skew, :format, :strict,
    keyword_init: true
  )

  ParsedPost = Struct.new(
    :path, :display_path, :text, :data, :raw_values, :key_locations, :body, :body_start_line,
    :filename_date, :language, :mode, keyword_init: true
  )

  class Validator
    DATE_FORMAT = "%Y-%m-%d %H:%M:%S"
    FILE_PATTERN = /\A(?<date>\d{4}-\d{2}-\d{2})-(?<slug>[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*)-(?<lang>kor|eng)\.md\z/
    TAG_PATTERN = /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/
    IMAGE_DIR_PATTERN = /\A\d{8}_[a-z0-9]+(?:_[a-z0-9]+)?\z/
    FRONT_MATTER_KEYS = %w[layout categories title excerpt tags date last_modified_at sitemap].freeze
    MODES = %w[auto draft publish].freeze
    LIFECYCLES = %w[auto new update].freeze

    attr_reader :diagnostics, :operational_error

    def initialize(config)
      @config = config
      @root = Pathname.new(config.root).expand_path
      @root_real = @root.realpath
      @diagnostics = []
      @operational_error = false
    end

    def validate(paths)
      paths.each { |path| validate_argument(path) }
      diagnostics.sort_by!(&:sort_key)
      diagnostics
    end

    private

    def validate_argument(argument)
      path = Pathname.new(argument).expand_path
      unless path.file?
        operational(path, "PATH001", "Input is not a readable regular file.", "Pass an explicit Markdown file path.")
        return
      end
      unless relative_path(path)
        add(path, 1, 1, "error", "PATH003", "File is outside --root.", "Move it below #{@root} or set --root.")
        return
      end
      unless realpath_contained?(path)
        add(path, 1, 1, "error", "PATH005", "Input resolves outside --root.", "Replace the escaping symlink with a file inside the repository.")
        return
      end

      post = parse_post(path)
      return unless post

      validate_path(post)
      validate_front_matter(post)
      validate_lifecycle(post)
      validate_body(post)
    rescue Errno::EACCES, Errno::ENOENT, Encoding::InvalidByteSequenceError, Encoding::UndefinedConversionError => e
      operational(path, "PATH002", "Unable to read input: #{e.message}", "Check the path and UTF-8 encoding.")
    rescue StandardError => e
      operational(path, "PATH999", "Internal validation error: #{e.class}: #{e.message}", "Report this validator error.")
    end

    def parse_post(path, report: true)
      text = File.binread(path).force_encoding(Encoding::UTF_8)
      raise Encoding::InvalidByteSequenceError, "invalid UTF-8" unless text.valid_encoding?

      lines = text.lines
      unless lines.first&.strip == "---"
        add(path, 1, 1, "error", "FM001", "Front matter must start on the first line.", "Add an opening --- delimiter.") if report
        return nil
      end

      closing_index = lines.each_index.drop(1).find { |index| lines[index].strip == "---" }
      unless closing_index
        add(path, 1, 1, "error", "FM002", "Front matter has no closing delimiter.", "Add a closing --- delimiter.") if report
        return nil
      end

      yaml = lines[1...closing_index].join
      ast = Psych.parse(yaml, filename: path.to_s)
      duplicates = duplicate_keys(ast)
      duplicates.each do |key, line, column|
        add(path, line + 2, column + 1, "error", "FM003", "Duplicate YAML key: #{key}.", "Keep only one #{key} entry.") if report
      end
      return nil if duplicates.any? && !report

      data = Psych.safe_load(
        yaml,
        permitted_classes: [Date, Time],
        permitted_symbols: [],
        aliases: false,
        filename: path.to_s
      )
      unless data.is_a?(Hash)
        add(path, 2, 1, "error", "FM004", "Front matter must be a YAML mapping.", "Use key: value entries.") if report
        return nil
      end

      raw_values, locations = root_scalar_metadata(ast)
      mode = resolved_mode(path)
      match = FILE_PATTERN.match(path.basename.to_s)
      ParsedPost.new(
        path: path,
        display_path: display_path(path),
        text: text,
        data: data,
        raw_values: raw_values,
        key_locations: locations,
        body: lines[(closing_index + 1)..]&.join.to_s,
        body_start_line: closing_index + 2,
        filename_date: match && match[:date],
        language: match && match[:lang],
        mode: mode
      )
    rescue Psych::Exception => e
      add(path, (e.respond_to?(:line) ? e.line.to_i + 1 : 2), (e.respond_to?(:column) ? e.column.to_i + 1 : 1),
          "error", "FM005", "Unsafe or invalid YAML: #{e.message.lines.first.strip}",
          "Use plain YAML without aliases, custom tags, or duplicate keys.") if report
      nil
    end

    def duplicate_keys(ast)
      duplicates = []
      walk = lambda do |node|
        if node.is_a?(Psych::Nodes::Mapping)
          seen = {}
          node.children.each_slice(2) do |key, value|
            if key.is_a?(Psych::Nodes::Scalar)
              duplicates << [key.value, key.start_line, key.start_column] if seen[key.value]
              seen[key.value] = true
            end
            walk.call(value)
          end
        else
          Array(node.children).each { |child| walk.call(child) } if node.respond_to?(:children)
        end
      end
      walk.call(ast)
      duplicates
    end

    def root_scalar_metadata(ast)
      document = ast.is_a?(Psych::Nodes::Document) ? ast : ast.children.first
      mapping = document&.children&.first
      return [{}, {}] unless mapping.is_a?(Psych::Nodes::Mapping)

      values = {}
      locations = {}
      mapping.children.each_slice(2) do |key, value|
        next unless key.is_a?(Psych::Nodes::Scalar)

        values[key.value] = value.value if value.is_a?(Psych::Nodes::Scalar)
        locations[key.value] = [key.start_line + 2, key.start_column + 1]
      end
      [values, locations]
    end

    def validate_path(post)
      relative = relative_path(post.path)
      unless relative
        add_post(post, 1, 1, "error", "PATH003", "File is outside --root.", "Move it below #{@root} or set --root.")
        return
      end

      inferred = inferred_mode(relative)
      if inferred.nil?
        add_post(post, 1, 1, "error", "PATH004", "File is outside _drafts or _posts/articles|blog.", "Use a supported blog content directory.")
      elsif @config.mode != "auto" && inferred != @config.mode
        add_post(post, 1, 1, "error", "STATE001", "Path is #{inferred}, but --mode is #{@config.mode}.", "Use the matching mode or move the file.")
      end

      match = FILE_PATTERN.match(post.path.basename.to_s)
      unless match
        add_post(post, 1, 1, "error", "NAME001", "Filename does not match YYYY-MM-DD-Title-kor|eng.md.", "Use a dated, kebab-case filename.")
        return
      end

      slug = match[:slug]
      add_post(post, 1, 12, "error", "NAME002", "Filename title exceeds 72 characters.", "Shorten the title slug.") if slug.length > 72
      unless slug.match?(/\A[A-Z]/)
        add_post(post, 1, 12, "error", "NAME003", "Filename title must start with an uppercase letter.", "Capitalize the first title word.")
      end
    end

    def validate_front_matter(post)
      missing = FRONT_MATTER_KEYS.reject { |key| post.data.key?(key) }
      missing.each do |key|
        add_post(post, 2, 1, "error", "FM010", "Missing front matter key: #{key}.", "Add #{key} to front matter.")
      end
      return unless missing.empty?

      typed_value(post, "layout", String, "FM011")
      typed_value(post, "categories", String, "FM012")
      typed_value(post, "title", String, "FM013")
      typed_value(post, "excerpt", String, "FM014")
      typed_value(post, "tags", Array, "FM015")
      typed_value(post, "sitemap", [TrueClass, FalseClass], "FM016")

      add_at_key(post, "layout", "error", "FM017", "layout must be post.", "Set layout: post.") unless post.data["layout"] == "post"
      unless %w[articles blog].include?(post.data["categories"])
        add_at_key(post, "categories", "error", "FM018", "categories must be articles or blog.", "Choose the directory-matching category.")
      end
      %w[title excerpt].each do |key|
        if post.data[key].is_a?(String) && post.data[key].strip.empty?
          add_at_key(post, key, "error", "FM019", "#{key} must not be empty.", "Add meaningful text.")
        end
      end

      validate_category_path(post)
      validate_tags(post)
      validate_dates(post)
      validate_state(post)
    end

    def typed_value(post, key, types, code)
      types = Array(types)
      return if types.any? { |type| post.data[key].is_a?(type) }

      names = types.map(&:name).join(" or ")
      add_at_key(post, key, "error", code, "#{key} must be #{names}.", "Correct the YAML value type.")
    end

    def validate_category_path(post)
      relative = relative_path(post.path)
      return unless relative && post.mode == "publish"

      expected = relative.each_filename.to_a[1]
      return unless %w[articles blog].include?(expected)
      return if post.data["categories"] == expected

      add_at_key(post, "categories", "error", "STATE002", "Category does not match _posts/#{expected}.", "Set categories: #{expected}.")
    end

    def validate_tags(post)
      tags = post.data["tags"]
      return unless tags.is_a?(Array)

      if tags.empty? || tags.length > 3
        add_at_key(post, "tags", "error", "TAG001", "tags must contain 1 to 3 values.", "Choose up to three descriptive tags.")
      end
      tags.each do |tag|
        next if tag.is_a?(String) && tag.match?(TAG_PATTERN)

        add_at_key(post, "tags", "error", "TAG002", "Tags must be lowercase English kebab-case strings.", "Use values such as ai or spring-boot.")
        break
      end
      if tags.uniq.length != tags.length
        add_at_key(post, "tags", "error", "TAG003", "tags contains duplicates.", "Remove duplicate tags.")
      end
    end

    def validate_dates(post)
      date = parse_front_matter_date(post, "date")
      modified = parse_front_matter_date(post, "last_modified_at")
      return unless date && modified

      if modified < date
        add_at_key(post, "last_modified_at", "error", "DATE002", "last_modified_at precedes date.", "Use a timestamp at or after date.")
      end

      if post.filename_date
        expected = (date + Rational(9, 24)).strftime("%Y-%m-%d")
        unless post.filename_date == expected
          add_post(post, 1, 1, "error", "DATE003", "Filename date must be the KST date of the UTC front matter date (expected #{expected}).", "Rename the file to start with #{expected}.")
        end
      end

      lifecycle = resolved_lifecycle
      if lifecycle == "new" && date != modified
        add_at_key(post, "last_modified_at", "error", "DATE004", "New posts must use identical date and last_modified_at.", "Copy date to last_modified_at.")
      end

      validate_freshness(post, lifecycle == "new" ? date : modified) if @config.fresh
    end

    def parse_front_matter_date(post, key)
      raw = post.raw_values[key]
      unless raw&.match?(/\A\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\z/)
        add_at_key(post, key, "error", "DATE001", "#{key} must use YYYY-MM-DD HH:mm:ss in UTC.", "Remove timezone suffixes and use the exact format.")
        return nil
      end
      DateTime.strptime(raw, DATE_FORMAT)
    rescue Date::Error
      add_at_key(post, key, "error", "DATE001", "#{key} is not a valid UTC timestamp.", "Use a real calendar date and time.")
      nil
    end

    def validate_freshness(post, timestamp)
      delta = ((timestamp - @config.now) * 86_400).abs.to_i
      return if delta <= @config.max_clock_skew

      add_at_key(post, resolved_lifecycle == "new" ? "date" : "last_modified_at", "error", "DATE005",
                 "Timestamp differs from --now by #{delta} seconds.",
                 "Use the current UTC time within #{@config.max_clock_skew} seconds.")
    end

    def validate_state(post)
      sitemap = post.data["sitemap"]
      return unless sitemap == true || sitemap == false

      expected = post.mode == "publish"
      return if sitemap == expected

      add_at_key(post, "sitemap", "error", "STATE003", "#{post.mode} posts require sitemap: #{expected}.", "Set sitemap: #{expected}.")
    end

    def validate_lifecycle(post)
      return unless resolved_lifecycle == "update"

      unless @config.original
        add_post(post, 1, 1, "error", "STATE010", "Update validation requires --original FILE.", "Pass the unmodified source file.")
        return
      end

      original_path = Pathname.new(@config.original).expand_path
      unless original_path.file?
        operational(original_path, "PATH010", "--original is not a readable regular file.", "Pass the unmodified source file.")
        return
      end

      if original_path.realpath == post.path.realpath
        add_post(post, 1, 1, "error", "STATE012", "--original and input resolve to the same file.", "Pass an unchanged snapshot as --original.")
        return
      end

      original = parse_post(original_path, report: false)
      unless original && valid_original_front_matter?(original)
        operational(original_path, "PATH010", "Unable to parse --original.", "Pass a readable original post.")
        return
      end

      %w[date sitemap].each do |key|
        next if comparable_value(post, key) == comparable_value(original, key)

        add_at_key(post, key, "error", "STATE011", "Updates must preserve original #{key}.", "Restore the original #{key} value.")
      end

      current_modified = safe_date(post.raw_values["last_modified_at"])
      original_modified = safe_date(original.raw_values["last_modified_at"])
      if current_modified && original_modified && current_modified < original_modified
        add_at_key(post, "last_modified_at", "error", "DATE010", "Update moves last_modified_at backwards.", "Use a timestamp at or after the original value.")
      end
    end

    def comparable_value(post, key)
      key == "date" ? post.raw_values[key] : post.data[key]
    end

    def safe_date(value)
      DateTime.strptime(value, DATE_FORMAT) if value&.match?(/\A\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\z/)
    rescue Date::Error
      nil
    end

    def valid_original_front_matter?(post)
      return false unless FRONT_MATTER_KEYS.all? { |key| post.data.key?(key) }
      return false unless post.data["layout"] == "post"
      return false unless %w[articles blog].include?(post.data["categories"])
      return false unless %w[title excerpt].all? { |key| post.data[key].is_a?(String) && !post.data[key].strip.empty? }

      tags = post.data["tags"]
      return false unless tags.is_a?(Array) && tags.length.between?(1, 3)
      return false unless tags.uniq.length == tags.length && tags.all? { |tag| tag.is_a?(String) && tag.match?(TAG_PATTERN) }
      return false unless [true, false].include?(post.data["sitemap"])

      date = safe_date(post.raw_values["date"])
      modified = safe_date(post.raw_values["last_modified_at"])
      date && modified && modified >= date
    end

    def validate_body(post)
      lines = post.body.lines
      in_fence = false
      fence_char = nil
      fence_size = nil
      headings = []
      previous_body_line = nil

      lines.each_with_index do |line, index|
        file_line = post.body_start_line + index
        if in_fence
          if line.match?(/^ {0,3}#{Regexp.escape(fence_char)}{#{fence_size},}\s*$/)
            in_fence = false
          end
          next
        end

        if (match = line.match(/^ {0,3}(`{3,}|~{3,})([^\r\n]*)$/))
          marker = match[1]
          info = match[2].strip
          if info.empty?
            add_post(post, file_line, 1, "error", "CODE001", "Fenced code block has no language.", "Add a language after the opening fence.")
          elsif info.split.first == "mermaid" && post.data["mermaid"] != true
            add_post(post, file_line, 1, "error", "CODE002", "Mermaid fence requires front matter mermaid: true.", "Add mermaid: true or remove the diagram.")
          end
          in_fence = true
          fence_char = marker[0]
          fence_size = marker.length
          previous_body_line = nil
          next
        end

        if line.match?(/^#(?!#)\s+/)
          add_post(post, file_line, 1, "error", "HEAD001", "Body H1 headings are not allowed.", "Use ## as the highest body heading.")
        end
        if line.match?(/^ {0,3}=+\s*$/) && previous_body_line && !previous_body_line.strip.empty?
          add_post(post, file_line - 1, 1, "error", "HEAD002", "Setext H1 headings are not allowed.", "Replace the underline with a ## heading.")
        end
        headings << [file_line, line.strip] if line.match?(/^##(?:\s+|$)/)
        validate_images_in_line(post, line, file_line)
        validate_hangul_ascii_typos(post, line, file_line)
        previous_body_line = line
      end

      add_post(post, post.body_start_line, 1, "error", "CODE003", "Unclosed fenced code block.", "Add a matching closing fence.") if in_fence
      validate_reference(post, lines, headings)
    end

    def validate_hangul_ascii_typos(post, line, file_line)
      prose = line.gsub(/(`+)(.*?)\1/) { |span| " " * span.length }
                  .gsub(%r{https?://[^\s<]+}) { |url| " " * url.length }

      prose.to_enum(:scan, /[가-힣][A-Za-z][가-힣]/).each do
        match = Regexp.last_match
        start_index = match.begin(0)
        end_index = match.end(0)
        characters = line.chars
        start_index -= 1 while start_index.positive? && characters[start_index - 1]&.match?(/[가-힣]/)
        end_index += 1 while end_index < characters.length && characters[end_index]&.match?(/[가-힣]/)
        token = characters[start_index...end_index].join

        add_post(post, file_line, match.begin(0) + 1, "warning", "TEXT001",
                 "Suspicious ASCII letter embedded in Hangul prose: #{token}.",
                 "Review the word and remove an accidental ASCII keystroke.")
      end
    end

    def validate_images_in_line(post, line, file_line)
      line.to_enum(:scan, /!\[([^\]]*)\]\(([^)\s]+)(?:\s+"[^"]*")?\)/).each do
        match = Regexp.last_match
        alt = match[1]
        target = match[2]
        column = match.begin(0) + 1
        if alt.strip.empty?
          add_post(post, file_line, column, "warning", "IMG001", "Image alt text is empty.", "Add a concise Korean description.")
        end
        next if target.match?(/\Ahttps?:\/\//)

        unless target.start_with?("/images/")
          add_post(post, file_line, column, "error", "IMG002", "Local image paths must start with /images/.", "Move the asset under the blog images directory.")
          next
        end

        components = target.delete_prefix("/").split("/")
        if components.any? { |component| component == "." || component == ".." }
          add_post(post, file_line, column, "error", "IMG006", "Local image path contains traversal components.", "Use a direct path below /images/.")
          next
        end

        directory = target.split("/")[2]
        unless directory&.match?(IMAGE_DIR_PATTERN)
          add_post(post, file_line, column, "error", "IMG003", "Image directory must be YYYYMMDD_one_or_two_words.", "Rename the image directory using lowercase snake_case.")
        end
        expected_prefix = post.filename_date&.delete("-")
        if expected_prefix && directory && !directory.start_with?("#{expected_prefix}_")
          add_post(post, file_line, column, "error", "IMG004", "Image directory date does not match the post filename.", "Use an image directory beginning #{expected_prefix}_.")
        end

        asset = @root.join(target.delete_prefix("/"))
        unless asset.file?
          add_post(post, file_line, column, "error", "IMG005", "Referenced local image does not exist.", "Create #{target} or correct the link.")
        else
          unless realpath_contained?(asset)
            add_post(post, file_line, column, "error", "IMG007", "Local image resolves outside --root.", "Replace the escaping symlink with an image inside the repository.")
          end
        end
      end
    end

    def validate_reference(post, lines, headings)
      reference = headings.find { |_, text| text == "## Reference" }
      unless reference
        add_post(post, post.body_start_line + lines.length, 1, "error", "REF001", "Missing final ## Reference section.", "Add Reference as the final H2 section.")
        return
      end

      if headings.last != reference
        add_post(post, reference[0], 1, "error", "REF002", "## Reference must be the final H2 section.", "Move it after all other sections.")
      end
      if headings.count { |_, text| text == "## Reference" } > 1
        add_post(post, reference[0], 1, "error", "REF003", "Only one ## Reference section is allowed.", "Merge duplicate sections.")
      end

      start = reference[0] - post.body_start_line + 1
      entries = lines[start..].to_a.each_with_index.reject { |(line, _)| line.strip.empty? }
      if entries.empty?
        add_post(post, reference[0], 1, "error", "REF004", "Reference section must contain at least one link.", "Add a source URL as a list item.")
        return
      end

      entries.each do |line, offset|
        file_line = post.body_start_line + start + offset
        parsed = parse_reference_entry(line)
        unless parsed
          add_post(post, file_line, 1, "error", "REF005", "References must be * or - list items containing one HTTP(S) link.", "Use * [https://example](https://example).")
          next
        end
        text, url = parsed
        next if text == url

        add_post(post, file_line, 1, "error", "REF006", "Reference link text must equal its URL.", "Use the target URL as the link text.")
      end
    end

    def parse_reference_entry(line)
      item = line.strip
      return nil unless item.match?(/\A[*-]\s+/)

      link = item.sub(/\A[*-]\s+/, "")
      separator = link.index("](")
      return nil unless link.start_with?("[") && separator

      text = link[1...separator]
      index = separator + 2
      depth = 1
      closing = nil
      while index < link.length
        case link[index]
        when "("
          depth += 1
        when ")"
          depth -= 1
          if depth.zero?
            closing = index
            break
          end
        end
        index += 1
      end
      return nil unless closing && link[(closing + 1)..].to_s.strip.empty?

      url = link[(separator + 2)...closing]
      return nil unless valid_http_url?(url)

      [text, url]
    end

    def valid_http_url?(url)
      return false if url.empty? || url.match?(/\s/)

      escaped_parentheses = url.gsub("(", "%28").gsub(")", "%29")
      uri = URI.parse(escaped_parentheses)
      %w[http https].include?(uri.scheme) && !uri.host.to_s.empty?
    rescue URI::Error
      false
    end

    def inferred_mode(relative)
      parts = relative.each_filename.to_a
      return "draft" if parts.first == "_drafts"
      return "publish" if parts.first == "_posts" && %w[articles blog].include?(parts[1])

      nil
    end

    def resolved_mode(path)
      return @config.mode unless @config.mode == "auto"

      relative = relative_path(path)
      inferred_mode(relative) || "draft"
    end

    def resolved_lifecycle
      return @config.lifecycle unless @config.lifecycle == "auto"

      @config.original ? "update" : "new"
    end

    def relative_path(path)
      relative = path.relative_path_from(@root)
      return nil if relative.each_filename.first == ".."

      relative
    rescue ArgumentError
      nil
    end

    def realpath_contained?(path)
      candidate = Pathname.new(path).realpath
      candidate == @root_real || candidate.to_s.start_with?("#{@root_real}#{File::SEPARATOR}")
    rescue Errno::EACCES, Errno::ENOENT, Errno::ELOOP
      false
    end

    def display_path(path)
      relative_path(path)&.to_s || path.to_s
    end

    def add_at_key(post, key, severity, code, message, suggestion)
      line, column = post.key_locations.fetch(key, [2, 1])
      add_post(post, line, column, severity, code, message, suggestion)
    end

    def add_post(post, line, column, severity, code, message, suggestion)
      diagnostics << Diagnostic.new(
        file: post.display_path, line: line, column: column, severity: severity,
        code: code, message: message, suggestion: suggestion
      )
    end

    def add(path, line, column, severity, code, message, suggestion)
      diagnostics << Diagnostic.new(
        file: display_path(Pathname.new(path)), line: line, column: column, severity: severity,
        code: code, message: message, suggestion: suggestion
      )
    end

    def operational(path, code, message, suggestion)
      @operational_error = true
      add(path, 1, 1, "error", code, message, suggestion)
    end
  end

  class CLI
    def self.run(argv, out: $stdout, err: $stderr)
      config = Config.new(
        root: Dir.pwd,
        mode: "auto",
        lifecycle: "auto",
        original: nil,
        fresh: false,
        now: DateTime.now.new_offset(0),
        max_clock_skew: 300,
        format: "text",
        strict: false
      )

      help_requested = false
      parser = option_parser(config) { help_requested = true }
      files = parser.parse(argv)
      if help_requested
        out.puts parser
        return 0
      end
      if files.empty?
        err.puts parser
        return 2
      end
      root = Pathname.new(config.root).expand_path
      unless root.directory?
        err.puts "validate_post.rb: --root must be an existing directory: #{root}"
        return 2
      end
      if config.original && files.length != 1
        err.puts "--original requires exactly one input FILE"
        return 2
      end
      if config.lifecycle == "new" && config.original
        err.puts "--lifecycle new cannot be combined with --original"
        return 2
      end

      validator = Validator.new(config)
      diagnostics = validator.validate(files)
      emit(out, diagnostics, config.format, strict: config.strict)
      return 2 if validator.operational_error

      failed = diagnostics.any? { |item| item.severity == "error" || (config.strict && item.severity == "warning") }
      failed ? 1 : 0
    rescue OptionParser::ParseError, ArgumentError, Date::Error => e
      err.puts "validate_post.rb: #{e.message}"
      err.puts parser if parser
      2
    end

    def self.option_parser(config, &on_help)
      OptionParser.new do |options|
        options.banner = "Usage: validate_post.rb [options] FILE..."
        options.on("--root DIR", "Repository root (default: current directory)") { |value| config.root = value }
        options.on("--mode MODE", Validator::MODES, "auto, draft, or publish") { |value| config.mode = value }
        options.on("--lifecycle TYPE", Validator::LIFECYCLES, "auto, new, or update") { |value| config.lifecycle = value }
        options.on("--original FILE", "Original file for update preservation checks") { |value| config.original = value }
        options.on("--fresh", "Require the lifecycle timestamp to be close to --now") { config.fresh = true }
        options.on("--now ISO8601", "Reference UTC time for --fresh") { |value| config.now = DateTime.iso8601(value).new_offset(0) }
        options.on("--max-clock-skew SECONDS", Integer, "Allowed --fresh difference (default: 300)") do |value|
          raise OptionParser::InvalidArgument, "clock skew must be non-negative" if value.negative?

          config.max_clock_skew = value
        end
        options.on("--format FORMAT", %w[text json], "text or json") { |value| config.format = value }
        options.on("--strict", "Treat warnings as validation failures") { config.strict = true }
        options.on("-h", "--help", "Show this help") do
          on_help.call
        end
      end
    end

    def self.emit(out, diagnostics, format, strict: false)
      if format == "json"
        out.puts JSON.pretty_generate(
          valid: diagnostics.none? { |item| item.severity == "error" || (strict && item.severity == "warning") },
          diagnostics: diagnostics.map(&:to_h)
        )
      elsif diagnostics.empty?
        out.puts "OK"
      else
        diagnostics.each do |item|
          out.puts "#{item.file}:#{item.line}:#{item.column}: #{item.severity} #{item.code}: #{item.message} Suggestion: #{item.suggestion}"
        end
      end
    end
  end
end

exit UnoPersona::CLI.run(ARGV) if $PROGRAM_NAME == __FILE__
