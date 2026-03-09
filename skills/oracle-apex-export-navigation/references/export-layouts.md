# Export Layouts

Use this file when the repository contains one or more Oracle APEX exports and the correct root is not obvious.

## Common Markers

- `application/pages/`: split page exports.
- `application/shared_components/`: split shared component exports.
- `application/user_interfaces.sql`: user interface export.
- `f123.sql`, `f1234.sql`, or `create_application.sql`: whole-application entrypoints. Treat as high-risk by default.

## Page File Patterns

Common page export names include:

- `application/pages/page_00001.sql`
- `application/pages/page_00123.sql`
- `application/pages/page_01234.sql`

Zero-padding varies by export configuration. Search by page number rather than assuming a fixed width.

## Shared Component Areas

Look under `application/shared_components` for artifacts such as:

- navigation and lists
- lovs
- security and authorization
- templates and themes
- breadcrumbs
- plugins
- application processes
- files and static assets

## Navigation Tactics

- Prefer `scripts/find_page_file.sh` for pages.
- For non-page work, search inside `application/shared_components` before creating new directories.
- If multiple app exports exist in one repo, choose the one that already contains the nearest related artifact.
- Keep edits inside the existing export tree so SQLcl import paths stay stable.
