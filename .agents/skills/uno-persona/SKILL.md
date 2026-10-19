---
name: uno-persona
description: >
  Draft, revise, prepare, publish, or translate posts and supporting images in
  Uno's voice for the djkeh.github.io Jekyll blog. Use when the user requests
  one of these content actions for this repository's _drafts, _posts/articles,
  or _posts/blog. Do not use for unrelated articles, press releases, or other
  authors' blogs.
compatibility: Web access and an image-generation tool are needed to add new supporting images.
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
4. For newly generated filenames and image directories, derive date segments from the current calendar date in `Asia/Seoul`. Write front matter `date` and `last_modified_at` as KST timestamps in `YYYY-MM-DD HH:mm:ss +09:00` format; always append the ` +09:00` offset. Existing posts may still carry legacy offset-less values: leave their `date` as it is and do not convert it. Do not rename an existing file solely to refresh its date.
5. When using Mermaid, write a `mermaid` fenced code block and do not add a `mermaid` key to front matter. Jekyll renders these diagrams without that key.

### Short or underspecified prompt

For a short prompt or single-sentence topic, do not create or edit files. Return an initial outline and introduction draft, then ask for feedback or the technical points that should shape the full post.

### New draft

When the request includes enough notes, an outline, or clear technical requirements, write a complete first draft under `_drafts/` using `{YYYY-MM-DD}-{Title}-{lang}.md`, where the date follows the `Asia/Seoul` rule above. Set `sitemap: false`, and set `date` and `last_modified_at` to the same current KST timestamp (`+09:00`).

### Images for a new post

Add an image only when it explains or evidences something that prose cannot show as clearly. Do not stop for image approval during writing.

1. For a research finding, product screen, event, chart, or other evidence, search the web, choose the most relevant usable original from its source page rather than a search thumbnail, download it, and add the original page URL to `## Reference`.
2. For a general illustration or explanatory visual, generate the image with the available image-generation tool and copy the selected final output into the post's image directory. Do not replace evidence with a synthetic image.
3. Create one directory named `images/YYYYMMDD_brief_title`, using the post filename date and lowercase snake case. Aim for three title words and never exceed five.
4. Save selected assets in reading order as `01-short-name.ext`, `02-short-name.ext`, and so on. Use short lowercase kebab-case names and keep each final asset inside the repository.
5. Write concise Korean alt text that describes the visible content before adding light humor. Prefix generated-image alt text with `AI 생성:`.
6. Embed the final local path immediately. Do not leave a placeholder in a complete post. If a required tool or suitable evidence image remains unavailable after trying an alternative, omit that image and report the omission at the end instead of blocking the post.
7. In the completion report, list saved image paths, original-page URLs for downloaded images, and which images were generated. Leave source suitability and visual quality for the user's final review.

### Existing post revision

Edit the target in place. Preserve its claims, factual scope, author stance, examples, links, assets, and requested metadata unless the user asks for a substantive change. Meaning preservation does not require retaining the original sentence, paragraph, or recap shape. After local copyediting, make one reader-flow pass across the introduction, section transitions, and conclusion: frame the reader's concrete problem, make causal or sequential links explicit, and make already-established actions easy to scan. Reorder or reformat existing material only when it improves that flow; do not add claims, steps, or personal judgment.

Preserve the category, language, and `sitemap` value unless the user requests otherwise. Among the timestamps, preserve `date` and update only `last_modified_at` to the current KST timestamp (`+09:00`), even when the preserved `date` is a legacy offset-less value. Do not silently turn a draft into a published post.

### Translation

Never overwrite the source post. Create a new file with the requested language suffix, preserve the source category and meaning, and use the current `Asia/Seoul` date in its filename. Default the translation to `_drafts/` with `sitemap: false`; publish it only when explicitly requested. Because the translation is a new file, set both `date` and `last_modified_at` to the same current KST timestamp (`+09:00`).

### Explicit publication

Publish only when the user explicitly requests publication or promotion to a public post. Place the file under `_posts/articles/` or `_posts/blog/` and set `sitemap: true`. For a new post published directly, set `date` and `last_modified_at` to the same current KST timestamp (`+09:00`). When promoting an existing draft, preserve its `date` and update `last_modified_at` to the current KST timestamp (`+09:00`).

## Content integrity

* Verify time-sensitive facts, technical claims, quotations, and version-specific behavior against current primary or official sources. Separate sourced facts from Uno's judgment.
* Never invent Uno's experience, opinions, measurements, conversations, or product usage. Treat the corpus as style evidence, never as a source of new personal facts. Use personal facts supplied for the current task; retain or restate experience from an existing post only when revising that same post or when the user explicitly requests reuse. Otherwise write neutrally or mark the missing input for the user.
* Prefer original sources in `## Reference`. Use link text identical to the URL, and ensure every listed source supports the post.
* Add images only when they materially improve understanding. Reuse existing assets during revision unless the user requests replacements, and never claim an image is original, captured, or experienced by Uno without evidence.

## Clarification boundary

Ask before writing only when a missing answer would materially change factual accuracy, personal claims, language, category, or publication state and cannot be safely inferred. Otherwise apply the defaults above and proceed. The short-prompt workflow remains intentionally interactive.

## Validate

After creating a post, run:

```bash
ruby .agents/skills/uno-persona/scripts/validate_post.rb --lifecycle new <post-path>
```

For a revision, retain an unchanged snapshot and run:

```bash
ruby .agents/skills/uno-persona/scripts/validate_post.rb --lifecycle update --original <original-path> <post-path>
```

Resolve every error before reporting completion. Inspect every warning. Resolve `TEXT001` unless the flagged mixed-script adjacency is deliberate technical notation; report other warnings that require editorial judgment rather than forcing ornamental structure or unsupported content.
