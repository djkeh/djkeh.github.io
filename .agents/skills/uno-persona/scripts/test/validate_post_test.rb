# frozen_string_literal: true

require "fileutils"
require "json"
require "minitest/autorun"
require "stringio"
require "tmpdir"
require_relative "../validate_post"

class ValidatePostTest < Minitest::Test
  FIXTURES = File.expand_path("fixtures", __dir__)

  def run_cli(*args)
    out = StringIO.new
    err = StringIO.new
    status = UnoPersona::CLI.run(args, out: out, err: err)
    [status, out.string, err.string]
  end

  def fixture(relative)
    File.join(FIXTURES, relative)
  end

  def with_root
    Dir.mktmpdir("uno-validator") do |directory|
      FileUtils.cp_r(File.join(FIXTURES, "."), directory)
      yield directory
    end
  end

  def test_valid_draft_passes
    file = fixture("_drafts/2026-08-08-Contract-first-writing-kor.md")
    status, out, err = run_cli("--root", FIXTURES, file)

    assert_equal 0, status
    assert_equal "OK\n", out
    assert_empty err
  end

  def test_valid_published_post_with_mermaid_and_no_front_matter_flag_passes
    file = fixture("_posts/articles/2026-08-08-Contract-first-writing-kor.md")
    status, out, = run_cli("--root", FIXTURES, file)

    assert_equal 0, status
    assert_equal "OK\n", out
  end

  def test_mermaid_front_matter_is_rejected_as_unnecessary
    with_root do |root|
      path = File.join(root, "_posts/articles/2026-08-08-Contract-first-writing-kor.md")
      source = File.read(path)
      File.write(path, source.sub("sitemap: true\n", "sitemap: true\nmermaid: true\n"))

      status, out, = run_cli("--root", root, path)

      assert_equal 1, status
      assert_includes out, "FM020"
      assert_includes out, "Remove the mermaid key"
    end
  end

  def test_duplicate_yaml_key_and_unsafe_alias_fail_without_execution
    with_root do |root|
      path = File.join(root, "_drafts/2026-08-08-Unsafe-yaml-kor.md")
      File.write(path, <<~MARKDOWN)
        ---
        layout: post
        layout: post
        categories: articles
        title: &title Unsafe
        excerpt: *title
        tags: [ai]
        date: 2026-08-07 16:00:00
        last_modified_at: 2026-08-07 16:00:00
        sitemap: false
        ---

        ## Reference

        * [https://example.com](https://example.com)
      MARKDOWN

      status, out, = run_cli("--root", root, path)

      assert_equal 1, status
      assert_includes out, "FM003"
      assert_includes out, "FM005"
    end
  end

  def test_body_contract_diagnostics_are_stable_json
    with_root do |root|
      path = File.join(root, "_drafts/2026-08-08-Broken-body-kor.md")
      File.write(path, <<~MARKDOWN)
        ---
        layout: post
        categories: articles
        title: Broken
        excerpt: Broken body
        tags: [AI]
        date: 2026-08-08 16:00:00
        last_modified_at: 2026-08-08 16:00:01
        sitemap: true
        ---

        # Not allowed

        ```
        code
        ```

        ```mermaid
        graph LR
        ```

        ## Reference

        * [Example](https://example.com)
      MARKDOWN

      status, out, = run_cli("--root", root, "--format", "json", path)
      result = JSON.parse(out)
      codes = result.fetch("diagnostics").map { |item| item.fetch("code") }

      assert_equal 1, status
      refute result.fetch("valid")
      %w[TAG002 DATE003 DATE004 STATE003 HEAD001 CODE001 REF006].each do |code|
        assert_includes codes, code
      end
      sorted = result.fetch("diagnostics").sort_by do |item|
        [item["file"], item["line"], item["column"], item["severity"], item["code"], item["message"]]
      end
      assert_equal sorted, result.fetch("diagnostics")
    end
  end

  def test_reference_accepts_star_and_dash_but_must_be_last
    with_root do |root|
      source = File.read(File.join(root, "_drafts/2026-08-08-Contract-first-writing-kor.md"))
      path = File.join(root, "_drafts/2026-08-08-Reference-order-kor.md")
      File.write(path, source.sub("* [https://example.com/docs](https://example.com/docs)", <<~TEXT.chomp))
        - [https://example.com/docs](https://example.com/docs)

        ## Later section

        text
      TEXT

      status, out, = run_cli("--root", root, path)

      assert_equal 1, status
      assert_includes out, "REF002"
    end
  end

  def test_local_images_follow_convention_and_must_exist
    with_root do |root|
      path = File.join(root, "_drafts/2026-08-08-Image-check-kor.md")
      source = File.read(File.join(root, "_drafts/2026-08-08-Contract-first-writing-kor.md"))
      source = source.sub("글을 쓰기 전에", "![빠진 그림이 조용히 자리만 지키는 화면](/images/20260808_image_check/01-missing.png)\n\n글을 쓰기 전에")
      File.write(path, source)

      status, out, = run_cli("--root", root, path)

      assert_equal 1, status
      assert_includes out, "IMG005"
    end
  end

  def test_new_images_accept_up_to_five_directory_words_and_reading_order
    with_root do |root|
      path = File.join(root, "_drafts/2026-08-08-Image-order-kor.md")
      source = File.read(File.join(root, "_drafts/2026-08-08-Contract-first-writing-kor.md"))
      image_dir = File.join(root, "images/20260808_practical_ai_blog_image_flow")
      FileUtils.mkdir_p(image_dir)
      File.write(File.join(image_dir, "01-overview.png"), "image")
      File.write(File.join(image_dir, "02-running-demo.jpg"), "image")
      images = <<~MARKDOWN.chomp
        ![전체 구조를 한눈에 보여주는 그림](/images/20260808_practical_ai_blog_image_flow/01-overview.png)

        ![AI 생성: 데모를 실행하며 식은땀 흘리는 로봇](/images/20260808_practical_ai_blog_image_flow/02-running-demo.jpg)

        글을 쓰기 전에
      MARKDOWN
      File.write(path, source.sub("글을 쓰기 전에", images))

      status, out, = run_cli("--root", root, path)

      assert_equal 0, status
      assert_equal "OK\n", out
    end
  end

  def test_new_images_reject_bad_directory_filename_order_alt_and_remote_path
    with_root do |root|
      path = File.join(root, "_drafts/2026-08-08-Image-rules-kor.md")
      source = File.read(File.join(root, "_drafts/2026-08-08-Contract-first-writing-kor.md"))
      image_dir = File.join(root, "images/20260808_one_two_three_four_five_six")
      FileUtils.mkdir_p(image_dir)
      File.write(File.join(image_dir, "02-wrong-order.png"), "image")
      File.write(File.join(image_dir, "bad-name.png"), "image")
      images = <<~MARKDOWN.chomp
        ![overview](/images/20260808_one_two_three_four_five_six/02-wrong-order.png)

        ![번호표를 잃어버린 그림](/images/20260808_one_two_three_four_five_six/bad-name.png)

        ![원격 이미지](https://example.com/remote.png)

        글을 쓰기 전에
      MARKDOWN
      File.write(path, source.sub("글을 쓰기 전에", images))

      status, out, = run_cli("--root", root, path)

      assert_equal 1, status
      %w[IMG003 IMG008 IMG009 IMG010 IMG011].each { |code| assert_includes out, code }
    end
  end

  def test_update_preserves_legacy_image_filename
    with_root do |root|
      target = File.join(root, "_posts/articles/2026-08-08-Contract-first-writing-kor.md")
      source = File.read(target).sub(
        "글을 쓰기 전에",
        "![기존 빌드 로그 화면](/images/20260808_legacy_image/build-log.png)\n\n글을 쓰기 전에"
      )
      image_dir = File.join(root, "images/20260808_legacy_image")
      FileUtils.mkdir_p(image_dir)
      File.write(File.join(image_dir, "build-log.png"), "image")
      original = File.join(root, "original.md")
      File.write(original, source)
      File.write(target, source.sub("last_modified_at: 2026-08-07 16:00:00", "last_modified_at: 2026-08-07 17:00:00"))

      status, out, = run_cli("--root", root, "--lifecycle", "update", "--original", original, target)

      assert_equal 0, status
      assert_equal "OK\n", out
    end
  end

  def test_update_preserves_date_and_sitemap
    with_root do |root|
      original = File.join(root, "original.md")
      target = File.join(root, "_posts/articles/2026-08-08-Contract-first-writing-kor.md")
      FileUtils.cp(target, original)
      updated = File.read(target).sub("date: 2026-08-07 16:00:00", "date: 2026-08-07 17:00:00")
                                 .sub("last_modified_at: 2026-08-07 16:00:00", "last_modified_at: 2026-08-07 18:00:00")
                                 .sub("sitemap: true", "sitemap: false")
      File.write(target, updated)

      status, out, = run_cli("--root", root, "--original", original, target)

      assert_equal 1, status
      assert_includes out, "STATE011"
      assert_includes out, "STATE003"
    end
  end

  def test_fresh_uses_utc_now_and_clock_skew
    file = fixture("_drafts/2026-08-08-Contract-first-writing-kor.md")
    status, out, = run_cli(
      "--root", FIXTURES,
      "--fresh",
      "--now", "2026-08-07T16:00:10Z",
      "--max-clock-skew", "10",
      file
    )

    assert_equal 0, status
    assert_equal "OK\n", out
  end

  def test_empty_alt_is_an_error_for_new_posts
    with_root do |root|
      path = File.join(root, "_drafts/2026-08-08-Empty-alt-kor.md")
      source = File.read(File.join(root, "_drafts/2026-08-08-Contract-first-writing-kor.md"))
      FileUtils.mkdir_p(File.join(root, "images/20260808_empty_alt"))
      File.write(File.join(root, "images/20260808_empty_alt/01-present.png"), "image")
      File.write(path, source.sub("글을 쓰기 전에", "![](/images/20260808_empty_alt/01-present.png)\n\n글을 쓰기 전에"))

      normal_status, normal_out, = run_cli("--root", root, path)

      assert_equal 1, normal_status
      assert_includes normal_out, "IMG001"
    end
  end

  def test_strict_turns_text_warning_into_failure
    with_root do |root|
      path = File.join(root, "_drafts/2026-08-08-Strict-warning-kor.md")
      source = File.read(File.join(root, "_drafts/2026-08-08-Contract-first-writing-kor.md"))
      File.write(path, source.sub("글을 쓰기 전에", "잘못된 한a글 표현입니다.\n\n글을 쓰기 전에"))

      normal_status, normal_out, = run_cli("--root", root, path)
      strict_status, = run_cli("--root", root, "--strict", path)

      assert_equal 0, normal_status
      assert_includes normal_out, "TEXT001"
      assert_equal 1, strict_status
    end
  end

  def test_no_files_and_non_file_return_usage_status
    status, = run_cli
    assert_equal 2, status

    status, out, = run_cli(FIXTURES)
    assert_equal 2, status
    assert_includes out, "PATH001"
  end

  def test_missing_root_is_usage_error_and_outside_input_is_validation_error
    file = fixture("_drafts/2026-08-08-Contract-first-writing-kor.md")
    status, _out, err = run_cli("--root", File.join(FIXTURES, "missing"), file)

    assert_equal 2, status
    assert_includes err, "--root must be an existing directory"
    refute_includes err, "PATH999"

    Dir.mktmpdir("uno-empty-root") do |root|
      status, out, = run_cli("--root", root, file)

      assert_equal 1, status
      assert_includes out, "PATH003"
      refute_includes out, "PATH999"
    end
  end

  def test_input_symlink_cannot_escape_root
    with_root do |root|
      Dir.mktmpdir("uno-outside") do |outside|
        external = File.join(outside, "post.md")
        FileUtils.cp(fixture("_drafts/2026-08-08-Contract-first-writing-kor.md"), external)
        link = File.join(root, "_drafts/2026-08-08-Escaping-link-kor.md")
        File.symlink(external, link)

        status, out, = run_cli("--root", root, link)

        assert_equal 1, status
        assert_includes out, "PATH005"
        refute_includes out, "PATH999"
      end
    end
  end

  def test_image_paths_reject_traversal_and_symlink_escape
    with_root do |root|
      path = File.join(root, "_drafts/2026-08-08-Image-security-kor.md")
      source = File.read(File.join(root, "_drafts/2026-08-08-Contract-first-writing-kor.md"))
      source = source.sub(
        "글을 쓰기 전에",
        "![이동](/images/20260808_image_security/../outside.png)\n\n" \
        "![링크](/images/20260808_image_security/escape.png)\n\n글을 쓰기 전에"
      )
      image_dir = File.join(root, "images/20260808_image_security")
      FileUtils.mkdir_p(image_dir)
      Dir.mktmpdir("uno-image-outside") do |outside|
        external = File.join(outside, "external.png")
        File.write(external, "image")
        File.symlink(external, File.join(image_dir, "escape.png"))
        File.write(path, source)

        status, out, = run_cli("--root", root, path)

        assert_equal 1, status
        assert_includes out, "IMG006"
        assert_includes out, "IMG007"
      end
    end
  end

  def test_original_must_be_distinct_and_have_valid_front_matter
    with_root do |root|
      target = File.join(root, "_posts/articles/2026-08-08-Contract-first-writing-kor.md")
      status, out, = run_cli("--root", root, "--original", target, target)

      assert_equal 1, status
      assert_includes out, "STATE012"

      invalid_original = File.join(root, "invalid-original.md")
      File.write(invalid_original, "---\nlayout: post\n---\n")
      status, out, = run_cli("--root", root, "--original", invalid_original, target)

      assert_equal 2, status
      assert_includes out, "PATH010"
      refute_includes out, "PATH999"
    end
  end

  def test_setext_h1_is_rejected_only_outside_fences
    with_root do |root|
      path = File.join(root, "_drafts/2026-08-08-Setext-heading-kor.md")
      source = File.read(File.join(root, "_drafts/2026-08-08-Contract-first-writing-kor.md"))
      source = source.sub("글을 쓰기 전에", <<~BODY.chomp)
        금지된 제목
        ===

        ```text
        허용되는 코드
        ===
        ```

        글을 쓰기 전에
      BODY
      File.write(path, source)

      status, out, = run_cli("--root", root, path)

      assert_equal 1, status
      assert_equal 1, out.scan("HEAD002").length
    end
  end

  def test_reference_parser_accepts_balanced_parentheses_and_validates_uri
    with_root do |root|
      valid_path = File.join(root, "_drafts/2026-08-08-Reference-parentheses-kor.md")
      source = File.read(File.join(root, "_drafts/2026-08-08-Contract-first-writing-kor.md"))
      valid_url = "https://example.com/spec(v1)"
      File.write(valid_path, source.sub(
        "* [https://example.com/docs](https://example.com/docs)",
        "* [#{valid_url}](#{valid_url})"
      ))

      status, out, = run_cli("--root", root, valid_path)

      assert_equal 0, status
      assert_equal "OK\n", out

      invalid_path = File.join(root, "_drafts/2026-08-08-Reference-invalid-kor.md")
      File.write(invalid_path, source.sub(
        "* [https://example.com/docs](https://example.com/docs)",
        "* [https://example.com/has space](https://example.com/has space)\n" \
        "- [https:///missing-host](https:///missing-host)"
      ))

      status, out, = run_cli("--root", root, invalid_path)

      assert_equal 1, status
      assert_equal 2, out.scan("REF005").length
    end
  end

  def test_new_lifecycle_rejects_original_as_usage_error
    file = fixture("_drafts/2026-08-08-Contract-first-writing-kor.md")
    status, _out, err = run_cli(
      "--root", FIXTURES,
      "--lifecycle", "new",
      "--original", file,
      file
    )

    assert_equal 2, status
    assert_includes err, "cannot be combined"
  end

  def test_help_uses_injected_output_and_returns_zero
    status, out, err = run_cli("--help")

    assert_equal 0, status
    assert_includes out, "Usage: validate_post.rb"
    assert_empty err
  end

  def test_ascii_letter_between_hangul_syllables_is_reported_in_prose
    with_root do |root|
      path = File.join(root, "_drafts/2026-08-08-Hangul-typo-kor.md")
      source = File.read(File.join(root, "_drafts/2026-08-08-Contract-first-writing-kor.md"))
      File.write(path, source.sub("글을 쓰기 전에", "이 블c로그에서는 계약을 먼저 살펴봅니다.\n\n글을 쓰기 전에"))

      status, out, = run_cli("--root", root, path)
      strict_status, strict_out, = run_cli("--root", root, "--strict", path)

      assert_equal 0, status
      assert_includes out, "TEXT001"
      assert_includes out, "블c로그"
      assert_includes out, "warning TEXT001"
      assert_equal 1, strict_status
      assert_includes strict_out, "TEXT001"
    end
  end

  def test_adjacent_single_letter_technical_terms_are_non_blocking_warnings
    with_root do |root|
      path = File.join(root, "_drafts/2026-08-08-Adjacent-technical-terms-kor.md")
      source = File.read(File.join(root, "_drafts/2026-08-08-Contract-first-writing-kor.md"))
      prose = "국내e커머스, 배열의i번째 원소, 좌표의x축, 타입T입니다, 한글N그램을 설명합니다."
      File.write(path, source.sub("글을 쓰기 전에", "#{prose}\n\n글을 쓰기 전에"))

      status, out, = run_cli("--root", root, path)

      assert_equal 0, status
      assert_includes out, "warning TEXT001"
    end
  end

  def test_technical_tokens_urls_and_code_do_not_trigger_hangul_typo_check
    with_root do |root|
      path = File.join(root, "_drafts/2026-08-08-Technical-tokens-kor.md")
      source = File.read(File.join(root, "_drafts/2026-08-08-Contract-first-writing-kor.md"))
      prose = <<~BODY.chomp
        JDK와 Spring Boot, Java 21을 사용합니다. OAuth2와 SpringBoot3, k8s클러스터도 독립 식별자입니다.
        자세한 주소는 https://example.com/블c로그 이고, 인라인 예시는 `블c로그`입니다.

        ```text
        블c로그
        ```

        글을 쓰기 전에
      BODY
      File.write(path, source.sub("글을 쓰기 전에", prose))

      status, out, = run_cli("--root", root, path)

      assert_equal 0, status
      refute_includes out, "TEXT001"
    end
  end
end
