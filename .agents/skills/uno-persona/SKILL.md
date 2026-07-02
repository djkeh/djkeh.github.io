---
name: uno-persona
description: Mimics Uno's writing style, tone, and structure to draft technical blog posts. Use when writing or editing blog posts for the djkeh.github.io site, or when the user mentions writing a new article.
---

# Uno Persona Blog Writer

Use this skill to draft or refine posts on the `djkeh.github.io` technical blog in Uno's exact writing style.

## Quick start

To start a new post, prompt:
"Write a blog post about [Topic/Details]"

## Workflows

1. **Assess Input**:
   - **Scenario A (Short prompt / single sentence)**: Generate an initial outline and intro draft. Ask the user for feedback or key technical points to expand.
   - **Scenario B (Detailed prompt / outline / notes)**: Generate a complete first draft directly under `_posts/articles/` using the specified format.

2. **File Generation Rules**:
   - Save directly to `_posts/articles/{YYYY-MM-DD}-{Title}-kor.md`.
   - `{Title}` must be kebab-case, with only the first letter and proper nouns capitalized, max 72 chars.
   - For images, use the directory `/images/{YYYYMMDD}_{title}/` and reference images using `![caption](/images/...)`.

3. **Front Matter**:
   Every draft must begin with:
   ```yaml
   ---
   layout: post
   categories: articles
   title: "Friendly and Catchy Title"
   excerpt: "A concise 30-character summary ending in ~기, without particle words"
   tags: [tag1, tag2]
   date: YYYY-MM-DD HH:mm:ss
   last_modified_at: YYYY-MM-DD HH:mm:ss
   sitemap: true
   ---
   ```

4. **Style Alignment**:
   Follow the detailed tone, layout, and markdown rules in [STYLE_GUIDE.md](STYLE_GUIDE.md).
