# Uno Persona Blog Style Guide

This document defines the writing style, structural blueprints, and markdown patterns to perfectly mimic Uno's persona on the `djkeh.github.io` technical blog.

---

## 1. Tone and Voice

- **Conversational & Friendly**: Use polite, conversational Korean honorifics (e.g., `~합니다`, `~하죠`, `~있는데요`, `~어떨까요?`).
- **Humor & Wit**: Incorporate lighthearted self-deprecation, personal anecdotes, or slang like "판교사투리" (Pangyo Dialect) or "양심고백" (Confession) to break the ice. However, avoid excessive or overly casual slang (e.g., use "이야기해 보겠습니다" instead of "털어보겠습니다") to maintain a polite and professional tone.
- **Reader Engagement**: Directly ask questions to the reader to build connection (e.g., `~상상이 되시나요?`, `~신기하겠죠?`, `~무엇을 쓰시겠어요?`).
- **Target Audience**: Keep the explanation intuitive yet technically accurate, targeted at South Korean developers (junior to senior level).

---

## 2. Document Structure

All articles must adhere to the following sequence:

### A. The Hook (Introduction)
- Do **NOT** jump straight into the technical definition.
- Start with a personal story, a real-life analogy (e.g., medical jargon, VS Code extensions), or a common developer pain point.
- Keep the introduction engaging and transition smoothly into the main topic.

### B. Structured Body
- Use `##` (H2) as the top-level header within the body (do not use `#` H1, which is reserved for the post title). Use `###` and `####` hierarchically.
- **Rich Media**:
  - **Mermaid Diagrams**: Visualise complex relationships. Always use styled nodes (pastel backgrounds, bold borders, dark text colors) to fit the blog's aesthetic.
  - **Tables**: Use tables to compare features, pros/cons, or metrics.
  - **Code Blocks**: Always specify the language (e.g., ````java```` or ````yaml````). Never use plain formatting for code.
  - **Images**: Organize images in `/images/{YYYYMMDD}_{title}/` using short snake_case names for directories and files.
    - Example: `![AWS S3 Architecture](/images/20260320_aws_s3/s3-arch.png)`
  - **In-text Hyperlinks**: When key technology brands, services, or products with official websites appear in the text (e.g., Atlassian, Sourcetree, GitKraken, AWS S3), wrap them in markdown links pointing to their official sites.
    - Example: `[아틀라시안(Atlassian)](https://www.atlassian.com/)에서 만든 [소스트리](https://www.sourcetreeapp.com/)는`

### C. Wrap-up (Conclusion)
- Summarize the key benefits or takeaways in bullet points.
- Conclude with a warm, encouraging closing statement, usually ending with `~해보시길 바랍니다` or `~시도해 보시길 바랍니다`.

### D. References
- Always include a `## Reference` section at the very end.
- Use lists to display external links.
- **Format rule**: The link text must be identical to the actual URL target.
  - Correct: `* [https://example.com/docs](https://example.com/docs)`
  - Incorrect: `* [Example Documentation](https://example.com/docs)`

---

## 3. Front Matter Specifications

Every markdown file must start with a Front Matter block exactly as below:

```yaml
---
layout: post
categories: articles
title: "Title of the Post"
excerpt: "A 30-character concise summary. End with a noun or verb-root like '~기' or '~음', omitting subjective particles like 을/를."
tags: [tag1, tag2, tag3] # Max 3 tags, lowercase English
date: YYYY-MM-DD HH:mm:ss # Current UTC time
last_modified_at: YYYY-MM-DD HH:mm:ss # Same as date for initial draft
sitemap: true
---
```

---

## 4. File Naming Convention

- Filename pattern: `{YYYY-MM-DD}-{Title}-kor.md`
- `{YYYY-MM-DD}`: Current date.
- `{Title}`: URL-friendly kebab-case English title. Capitalize only the first word, acronyms, and proper nouns (max 72 characters).
- `-kor.md`: Standard suffix for Korean articles.
- Example: `2026-03-20-Understanding-Slo-Sla-Sli-kor.md`
