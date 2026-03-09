# Export Layouts

Use this file when the repository contains one or more Oracle APEX exports and the correct root is not obvious.

## Common Markers

- `application/pages/`: split page exports.
- `application/shared_components/`: split shared component exports.
- `application/user_interfaces.sql`: user interface export.
- `application/set_environment.sql`: split-export environment setup script.
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

Plugin exports commonly sit under `application/shared_components/plugins/` with further subdirectories by plugin type and name.

## Header Checks

Before choosing an export tree, inspect a top-level export file such as `application/set_environment.sql` or `application/create_application.sql` and confirm:

- the Oracle APEX version comment near the top, for example `-- Application Express Version 24.2.x`
- the application id from `wwv_flow_imp.g_flow_id := ...`

Use those values to disambiguate similar export trees.

## Navigation Tactics

- Prefer `scripts/find_page_file.sh` for pages.
- For non-page work, search inside `application/shared_components` before creating new directories.
- If multiple app exports exist in one repo, first match the requested app ID if it was provided.
- If the request does not include an app ID, match on `wwv_flow_imp.g_flow_id` and the nearest related artifact.
- If more than one export tree still fits, stop and ask which application should be edited.
- Keep edits inside the existing export tree so SQLcl import paths stay stable.
