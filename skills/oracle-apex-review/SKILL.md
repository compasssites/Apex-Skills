---
name: oracle-apex-review
description: Review Oracle APEX split-export changes for regressions, unsafe main-DDL edits, missing backend SQL separation, weak import guidance, and APEX 24.2 compatibility issues. Use when auditing a diff, checking an agent-generated Oracle APEX change, or doing code review on exported APEX pages and components.
---

# Oracle APEX Review

Use this skill for findings-first review of Oracle APEX export changes.

## Review Priorities

1. Flag direct edits to main app DDL or whole-app imports when narrower imports exist.
2. Flag backend SQL that should have been separated into its own script.
3. Flag edits placed in the wrong page or shared-component file.
4. Flag APEX 24.2 JavaScript or PL/SQL API usage that looks stale or invented.
5. Flag output that tells the operator to run commands on a server directly.

Read [references/review-checklist.md](references/review-checklist.md) for the review sequence and [references/risk-patterns.md](references/risk-patterns.md) for common failure modes.

## Output Style

- Present findings first, ordered by severity.
- Include file references when possible.
- Keep the summary short and secondary.
- If there are no findings, say so explicitly and note any residual testing gaps.

## APEX-Specific Heuristics

- Page-level work should usually land in a matching page export file.
- Cross-page shared objects should usually land under `application/shared_components`.
- Separate SQL deployment artifacts are preferred for backend changes.
- SQLcl guidance should be narrow and executable, usually `@fxxx/...`, not a vague description.
- Review against Oracle APEX 24.2 references when API compatibility is in doubt.
- For generated export SQL, also check the APEX export dialect rules in [references/export-dialect-24-2.md](references/export-dialect-24-2.md).

Read [references/apex-24-2-reference-map.md](references/apex-24-2-reference-map.md) when a change depends on JavaScript APIs, PL/SQL packages, or version-specific behavior.
