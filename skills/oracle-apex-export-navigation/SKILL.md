---
name: oracle-apex-export-navigation
description: Navigate Oracle APEX split exports, locate the correct page or shared component files, and generate targeted SQLcl import commands without defaulting to full-app imports. Use when working inside exported APEX application folders, mapping a requested page or component to files, or preparing concise import instructions for an IDE agent workflow.
---

# Oracle APEX Export Navigation

Use this skill to map an Oracle APEX task to the correct exported files before editing anything.

## Workflow

1. Confirm the export root.
2. Inspect the export header to confirm the application ID and Oracle APEX version before assuming 24.2 behavior.
3. Locate the exact page or shared component file that matches the request.
4. If the requested page or component is not present in the split export, emit the SQLcl export command needed to pull it first, then stop.
5. Preserve the existing split-export structure.
6. Produce the narrowest SQLcl import command that matches the changed file.

## Confirm The Export Root

- Prefer a folder that contains `application/pages`.
- Expect shared components under `application/shared_components`.
- Treat files such as `f123.sql`, `create_application.sql`, or other whole-app entrypoints as high-risk import targets. Do not default to them.
- Check the export header for `-- Application Express Version ...` and `wwv_flow_imp.g_flow_id := ...` before assuming the app ID or dialect.
- Read [references/export-layouts.md](references/export-layouts.md) when the repository layout is unclear.

## Locate The Right File

- For page work, use `scripts/find_page_file.sh <root> <page-number>`.
- For shared component work, search under `application/shared_components` before creating new folders.
- If a requested page file is missing, do not fabricate `page_XXXXX.sql`. Emit the SQLcl export command from [references/sqlcl-exports.md](references/sqlcl-exports.md) and stop.
- If the task mentions icons, CSS utilities, internal views, or documentation search, read [references/lookup-sources.md](references/lookup-sources.md).
- Replace the matching exported file in place when it already exists. Do not invent an alternate mirror path.

## Emit SQLcl Imports

- Use `scripts/emit_sqlcl_import.sh <root> <file>` to generate `@...` import paths.
- Prefer page-level or component-level imports over whole-application imports.
- Keep the import guidance concise. Output the command, not a long walkthrough.
- Read [references/sqlcl-imports.md](references/sqlcl-imports.md) for examples and edge cases.
- Read [references/sqlcl-exports.md](references/sqlcl-exports.md) when the export tree must be refreshed or a page is missing from version control.

## Operating Rules

- Never assume the user wants the main app DDL imported.
- Keep backend SQL separate from exported APEX page files.
- If the repository already has a database or deployment convention, keep using it.
- If the request is really about implementing the change, hand off to `$oracle-apex-safe-edit`.
- If the request is a review of a diff or generated change, hand off to `$oracle-apex-review`.
