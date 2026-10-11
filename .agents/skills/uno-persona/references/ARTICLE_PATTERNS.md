# Article Patterns

Select the closest pattern after identifying the reader's main job. Combine patterns only when the request genuinely has two jobs; keep one as the dominant structure.

## Technical explainer

### Select when

Use for a concept, terminology set, architecture, or relationship the reader wants to understand and apply.

### Flow

* Start with the situation in which the term becomes relevant.
* Define the central term in plain language, then precisely.
* Separate neighboring terms or components.
* Apply them to a concrete system or scenario.
* Explain tradeoffs, limits, and a practical starting point.

### Evidence

Use specifications, official documentation, canonical engineering guidance, and calculations that can be checked.

### Optional devices

Use a comparison table for several related terms, a diagram for relationships, or one analogy for an abstract boundary.

### Failure patterns

Avoid dictionary-style openings, unexplained acronym chains, analogies that replace definitions, and claims that one metric solves an organizational problem by itself.

## Tutorial or practical guide

### Select when

Use when the reader should complete a task, reproduce a result, or adopt a working convention.

### Flow

* State the outcome, prerequisites, and important constraints.
* Show the smallest safe path to the result.
* Explain why each non-obvious step matters.
* Demonstrate the result or verification command.
* Cover common mistakes, recovery, and when not to use the technique.
* Close with the decision or next actions already established by the body. Use a compact checklist when multiple ordered checks or steps become easier to scan; keep prose when the takeaway is singular or conceptual.

### Evidence

Use tested commands or code, official manuals, version constraints, and observable output. Mark environment-specific behavior.

### Optional devices

Use short code blocks, before-and-after output, screenshots for UI steps, or a compact checklist.

### Failure patterns

Avoid untested command sequences, hidden prerequisites, destructive steps without warnings, screenshots that carry information absent from text, and rules presented without scope.

## Product review or feature walkthrough

### Select when

Use when the reader needs to understand a product through hands-on features, workflow impact, limitations, and alternatives.

### Flow

* Establish the user's problem and the author's relationship to the product.
* Organize the body by meaningful tasks rather than marketing categories.
* For each feature, show what it does, where it helps, and what constrains it.
* Compare only the alternatives relevant to the decision.
* End with suitable users, unsuitable users, and a low-risk way to try it.

### Evidence

Use observed product behavior, screenshots, official feature documentation, plan limits, and clearly attributed vendor claims. Disclose affiliations or referral links.

### Optional devices

Use demos, annotated screenshots, a feature matrix, or a brief personal judgment grounded in use.

### Failure patterns

Avoid brochure language, undisclosed promotion, feature lists without workflow consequences, invented hands-on experience, and comparisons that ignore pricing or platform constraints.

## Release update

### Select when

Use for a new version whose changes matter to existing or prospective users.

### Flow

* Lead with the version, release timing, and two or three meaningful themes.
* Explain each important change in user terms.
* Add background for unfamiliar features only where needed.
* Note removals, regressions, migration concerns, or limited availability.
* Close with who should update or investigate now.

### Evidence

Use official release notes, compatibility documentation, download pages, and a verified current version. Time-stamp volatile facts.

### Optional devices

Use screenshots for visible changes, a before-and-after comparison, or a short migration command.

### Failure patterns

Avoid copying the entire changelog, treating every item as equally important, omitting affected platforms, and presenting vendor performance claims as measured results.

## Security or incident advisory

### Select when

Use when readers must assess exposure and take a safe, time-sensitive action.

### Flow

* State the issue, affected component, and urgency without sensationalism.
* Define affected and unaffected versions or configurations.
* Show a safe way to check exposure.
* Give the preferred remediation, then temporary mitigation if authoritative.
* Note residual risk and where to monitor updates.

### Evidence

Prioritize vendor advisories, CVE records, maintainer repositories, patches, and confirmed version data. Separate proof-of-concept behavior from observed exploitation.

### Optional devices

Use a compact affected-version table, safe diagnostic commands, or a timeline when sequence matters.

### Failure patterns

Avoid fear-driven headlines, unverified exploit claims, vulnerable-by-default assumptions, unsafe reproduction steps, and mitigation presented as a permanent fix.

## Promotion or announcement

### Select when

Use for a course, role, discount, event, or project announcement where the author's involvement matters.

### Flow

* Say what happened and why the author is sharing it.
* Identify the intended audience and practical value.
* Give terms, dates, eligibility, price, or availability clearly.
* Disclose the author's role, benefit, or referral relationship.
* End with the appropriate action and a non-promotional alternative when useful.

### Evidence

Use official campaign or registration pages, exact dates, plan terms, and supplied first-person context. Verify time-sensitive details immediately before publication.

### Optional devices

Use a campaign image, a concise eligibility list, a price calculation, or a candid behind-the-scenes note.

### Failure patterns

Avoid hiding incentives, manufacturing urgency, burying exclusions, overstating savings, and padding a short announcement into a generic technical essay.

## Event recap or reflective technical essay

### Select when

Use when the value lies in interpreting a talk, meetup, project experience, or changing engineering practice rather than transcribing it.

### Flow

* Establish the event or experience and the question it raised.
* Select a few ideas that support that question.
* Separate the speaker's claims, the author's interpretation, and later research.
* Connect the ideas to engineering decisions or practice.
* End with what changed in the author's thinking, plus limitations or unresolved questions.

### Evidence

Use supplied notes, event material, speaker resources, follow-up primary sources, and explicitly grounded personal observations. Attribute quotations and paraphrases.

### Optional devices

Use a short quotation, a reconstructed flow diagram, an equation, or a candid scene from the event when it advances the central question.

### Failure patterns

Avoid chronological transcripts, invented attendance details, attributing later research to the speaker, converting opinions into facts, and praising the event without analytical value.
