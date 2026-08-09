---
name: uno-persona
description: >
  Draft, revise, prepare, publish, or translate posts in Uno's voice for the
  djkeh.github.io Jekyll blog. Use when the user requests one of these content
  actions for this repository's _drafts, _posts/articles, or _posts/blog. Do
  not use for unrelated articles, press releases, or other authors' blogs.
---

# Uno Persona Blog Writer

Create accurate, readable posts for `djkeh.github.io` while preserving Uno's voice and the repository's publishing safeguards.

## Load guidance

* Read [STYLE_GUIDE.md](STYLE_GUIDE.md) before drafting or revising prose.
* Read [references/ARTICLE_PATTERNS.md](references/ARTICLE_PATTERNS.md) when selecting a structure for the post type.
* Read [references/CORPUS_NOTES.md](references/CORPUS_NOTES.md) only when calibrating voice, checking whether a mannerism is representative, or resolving style ambiguity.
* Follow the repository `AGENTS.md` for canonical naming, front matter, Markdown, image, and reference rules.

## Decide the task

1. Classify the request as a short prompt, new draft, revision, translation, or explicit publication request.
2. Determine language and category from the request or target file. Default new content to Korean (`kor`) and `articles`; use `eng` only when English is requested and `blog` only for personal or daily-life writing.
3. Preserve the target file's language, category, publication state, and original `date` when revising unless the user explicitly asks to change them.
4. For newly generated filenames and image directories, derive date segments from the current calendar date in `Asia/Seoul`. Write front matter `date` and `last_modified_at` as UTC timestamps without a timezone suffix. Do not rename an existing file solely to refresh its date.
5. When using Mermaid, write a `mermaid` fenced code block and do not add a `mermaid` key to front matter. Jekyll renders these diagrams without that key.

### Short or underspecified prompt

For a short prompt or single-sentence topic, do not create or edit files. Return an initial outline and introduction draft, then ask for feedback or the technical points that should shape the full post.

### New draft

When the request includes enough notes, an outline, or clear technical requirements, write a complete first draft under `_drafts/` using `{YYYY-MM-DD}-{Title}-{lang}.md`, where the date follows the `Asia/Seoul` rule above. Set `sitemap: false`, and set `date` and `last_modified_at` to the same current UTC timestamp.

### Existing post revision

Edit the target in place. Preserve its claims, factual scope, author stance, examples, links, assets, and requested metadata unless the user asks for a substantive change. Meaning preservation does not require retaining the original sentence, paragraph, or recap shape. After local copyediting, make one reader-flow pass across the introduction, section transitions, and conclusion: frame the reader's concrete problem, make causal or sequential links explicit, and make already-established actions easy to scan. Reorder or reformat existing material only when it improves that flow; do not add claims, steps, or personal judgment.

Preserve the category, language, and `sitemap` value unless the user requests otherwise. Among the timestamps, preserve `date` and update only `last_modified_at` to the current UTC timestamp. Do not silently turn a draft into a published post.

### Translation

Never overwrite the source post. Create a new file with the requested language suffix, preserve the source category and meaning, and use the current `Asia/Seoul` date in its filename. Default the translation to `_drafts/` with `sitemap: false`; publish it only when explicitly requested. Because the translation is a new file, set both `date` and `last_modified_at` to the same current UTC timestamp.

### Explicit publication

Publish only when the user explicitly requests publication or promotion to a public post. Place the file under `_posts/articles/` or `_posts/blog/` and set `sitemap: true`. For a new post published directly, set `date` and `last_modified_at` to the same current UTC timestamp. When promoting an existing draft, preserve its `date` and update `last_modified_at` to the current UTC timestamp.

## Content integrity

* Verify time-sensitive facts, technical claims, quotations, and version-specific behavior against current primary or official sources. Separate sourced facts from Uno's judgment.
* Never invent Uno's experience, opinions, measurements, conversations, or product usage. Treat the corpus as style evidence, never as a source of new personal facts. Use personal facts supplied for the current task; retain or restate experience from an existing post only when revising that same post or when the user explicitly requests reuse. Otherwise write neutrally or mark the missing input for the user.
* Prefer original sources in `## Reference`. Use link text identical to the URL, and ensure every listed source supports the post.
* Add images only when they materially improve understanding. Reuse authorized assets, generate or search only when requested or appropriate, and never claim an image is original, captured, or experienced by Uno without evidence. Use a clearly labeled placeholder when an asset is still needed.

## Clarification boundary

Ask before writing only when a missing answer would materially change factual accuracy, personal claims, language, category, or publication state and cannot be safely inferred. Otherwise apply the defaults above and proceed. The short-prompt workflow remains intentionally interactive.

## Validate

After creating or editing a post, run:

```bash
ruby .agents/skills/uno-persona/scripts/validate_post.rb <post-path>
```

Resolve every error before reporting completion. Inspect every warning. Resolve `TEXT001` unless the flagged mixed-script adjacency is deliberate technical notation; report other warnings that require editorial judgment rather than forcing ornamental structure or unsupported content.
