---
name: oracle-apex
description: Complete Oracle APEX skill for split exports, safe edits, targeted SQLcl export and import commands, APEX 24.2 API verification, and findings-first review. Use when an IDE agent needs to locate the right APEX page or shared component file, implement a change in exported applications, keep backend SQL separate, or review an Oracle APEX diff for regressions and import safety.
---

# Oracle APEX

Use this skill for Oracle APEX work in exported applications. It covers export navigation, safe implementation, SQLcl handoff, and review in one place.

## Workflow Decision

1. Confirm the export root, application id, and Oracle APEX version from the export header before editing anything.
2. If the task is locating a file, refreshing a missing export, or generating SQLcl commands, follow the export navigation workflow.
3. If the task is implementing behavior, UI, process, or shared component changes, follow the safe edit workflow.
4. If the task is reviewing a diff or validating generated SQL, follow the review workflow.
5. Treat Oracle APEX 24.2 as the default compatibility target unless the export header shows otherwise.

## Non-Negotiables

- Never directly change the main app DDL as the default path.
- Keep backend SQL in separate scripts instead of hiding it in unrelated page exports.
- If a page or shared component export already exists, update that file in place.
- Never execute changes against a live Oracle server. Give commands only.
- End with concise SQLcl commands only, not a long walkthrough or fake success output.
- Prefer official Oracle APEX 24.2 documentation plus `https://apex-docs-5ka.pages.dev` when details are uncertain.

Read [references/operator-guardrails.md](references/operator-guardrails.md) for the operator preferences behind this skill.

## Export Navigation Workflow

- Confirm the correct export tree using [references/export-layouts.md](references/export-layouts.md).
- For pages, use `scripts/find_page_file.sh <root> <page-number>`.
- For shared components, search under `application/shared_components` before creating new folders.
- If a requested page or component is missing from the split export, do not fabricate a file. Emit the SQLcl export command from [references/sqlcl-exports.md](references/sqlcl-exports.md) and stop.
- Use `scripts/emit_sqlcl_import.sh <root> <file>` to generate the narrowest `@...` import path.
- Use [references/sqlcl-imports.md](references/sqlcl-imports.md) for import conventions and [references/lookup-sources.md](references/lookup-sources.md) for icons, CSS, internal views, and Oracle APEX documentation lookup.

## Safe Edit Workflow

1. Find the exact target export file first.
2. Run `scripts/check_guardrails.sh <path...>` when there is any chance the main app DDL is involved.
3. Route the change to the smallest correct artifact:
   - matching `application/pages/page_*.sql` file for page-scoped work
   - `application/shared_components/...` for cross-page shared objects
   - separate SQL scripts for database objects, grants, data fixes, or deployment logic
4. Keep the existing split-export structure intact and implement the narrowest possible edit.
5. End with only the relevant SQLcl commands and a brief completion note.

Read [references/change-patterns.md](references/change-patterns.md) when the request spans page, shared component, and backend layers.

## APEX 24.2 Compatibility

- Verify `apex.*` JavaScript APIs and PL/SQL package signatures against [references/apex-24-2-reference-map.md](references/apex-24-2-reference-map.md).
- When generating or heavily editing export SQL, follow [references/export-dialect-24-2.md](references/export-dialect-24-2.md) before changing call order, headers, IDs, package names, or Interactive Grid metadata.
- Avoid falling back to older APEX syntax or invented helper APIs.

## Review Workflow

- Present findings first, ordered by severity.
- Flag direct edits to main app DDL or whole-app imports when narrower imports exist.
- Flag backend SQL that should have been separated into its own script.
- Flag page/shared-component misplacement, stale APEX 24.2 APIs, and weak SQLcl handoff instructions.
- If there are no findings, say so explicitly and note residual testing gaps.

Use [references/review-checklist.md](references/review-checklist.md) for review order and [references/risk-patterns.md](references/risk-patterns.md) for common Oracle APEX failure modes.

## Reference Map

- [references/export-layouts.md](references/export-layouts.md): split export roots, app-id/version header checks, multi-app disambiguation, plugin locations.
- [references/sqlcl-exports.md](references/sqlcl-exports.md): refresh missing pages or components with split SQLcl exports.
- [references/sqlcl-imports.md](references/sqlcl-imports.md): concise `@...` import commands and context assumptions.
- [references/change-patterns.md](references/change-patterns.md): route requests to page exports, shared components, or separate backend SQL.
- [references/apex-24-2-reference-map.md](references/apex-24-2-reference-map.md): official Oracle APEX 24.2 sources and verification triggers.
- [references/export-dialect-24-2.md](references/export-dialect-24-2.md): export SQL rules, Interactive Grid handling, review checks, and failure recovery.
- [references/lookup-sources.md](references/lookup-sources.md): Oracle APEX docs, Font APEX icons, Universal Theme utilities, and internal-view lookup.
