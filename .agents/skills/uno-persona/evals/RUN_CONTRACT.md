# Uno Persona evaluation run contract

## Isolation and clock

Run every configuration in a fresh, disposable copy of the repository. Do not reuse a working tree, generated post, cache, or network result across runs. Set the run clock to `2026-08-08T00:00:00Z` and expose that value consistently to the executor and validator.

Disable network access for evaluation runs. The frozen source notes listed in `evals.json` are the complete evidence supplied to both configurations.

## Immutable inputs

Treat the skill snapshot, current skill, prompts, source notes, post fixture, and image fixture as immutable originals. Record a SHA-256 manifest of every original before preparing a run. Never let an executor edit files under the source skill's `evals/` directory.

For the revision case, copy inputs into the disposable repository before execution:

* Copy `evals/files/2025-11-14-Jekyll-build-troubleshooting-kor.md` to `_posts/articles/2025-11-14-Jekyll-build-troubleshooting-kor.md`.
* Copy `evals/files/images/20251114_jekyll_build/build-log.png` to `images/20251114_jekyll_build/build-log.png`.
* Keep an additional immutable copy of the original post outside the executor-visible repository for preservation checks.

For source-backed cases, make only the source-note files declared by that eval available as read-only inputs. Do not expose live browsing results, prior outputs, the competing skill, or the expected grading result.

## Manifests and output collection

Create pre-run and post-run manifests containing relative path, file type, byte size, and SHA-256 digest. Derive created, modified, renamed, and deleted paths from the manifest difference.

Copy only task outputs identified by that difference into the run's `outputs/` directory. Do not copy the repository, dependency caches, frozen evidence, fixtures, logs, prompts, harness scripts, manifests, or other harness metadata into the reviewed output set.

For a short-prompt run, save the assistant response as the sole task output and assert that the repository manifest did not change.

## Validation

Validate every created post using the fixed clock:

```bash
ruby .agents/skills/uno-persona/scripts/validate_post.rb \
  --root . \
  --fresh \
  --now 2026-08-08T00:00:00Z \
  POST_PATH
```

Validate the revision against the immutable original:

```bash
ruby .agents/skills/uno-persona/scripts/validate_post.rb \
  --root . \
  --mode publish \
  --lifecycle update \
  --original ORIGINAL_POST_PATH \
  --fresh \
  --now 2026-08-08T00:00:00Z \
  _posts/articles/2025-11-14-Jekyll-build-troubleshooting-kor.md
```

Store validator JSON and grading evidence as harness metadata outside `outputs/`.

## Paired comparison

Run the current skill and the preserved baseline skill once per eval with identical repository state, fixed clock, prompt, and inputs. Randomize which output is labeled A or B for each pair and retain the mapping outside reviewer-visible files.

Grade objective expectations before human review. Present A and B side by side for a blind human ranking using `QUALITATIVE_RUBRIC.md`; exclude configuration names, timing, token counts, validator output, manifests, paths that reveal the configuration, and all other harness metadata. Reveal the mapping only after the ranking is submitted.
