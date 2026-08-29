# Oracle APEX Reference Map

Use this file when an Oracle APEX task depends on version-specific APIs, exported SQL
behavior, or review claims that should be source-backed.

## Current Target

**Oracle APEX 26.1.** Confirm against the export header (`p_release`) before trusting
any version-specific claim — a project may sit on an older release, and the header is
the only authority.

## Primary Sources

- JavaScript API index:
  `https://docs.oracle.com/en/database/oracle/apex/26.1/aexjs/index.html`
- API reference:
  `https://docs.oracle.com/en/database/oracle/apex/26.1/aeapi/index.html`
- Project-specific APEX notes:
  `https://apex-docs-5ka.pages.dev/agent?v=8`

Substitute the release number in those URLs when working against a different version.
Oracle keeps the same path shape per release.

## When To Check

- The task introduces or changes `apex.*` JavaScript APIs.
- The task depends on a PL/SQL package or exported APEX API call.
- The diff adds `wwv_flow_*` procedures or context setup logic.
- The request touches Interactive Grid, Dynamic Actions, `APEX_MAIL`, authentication,
  session state, or other version-sensitive subsystems.
- The proposed solution looks copied from an older APEX version.

## Verification Habits

- Search the JavaScript index for the exact object or method name.
- Check the API reference before inventing package procedures, parameters, or signatures.
- Never assume a procedure exists because it did in an earlier release. Verify.
  `apex_application_install.set_keep_sessions_on_upgrade` does **not** exist in 26.1 and
  a block referencing it fails to compile — silently taking the rest of the block with it.

## Compatibility Mode Is Not The Engine Version

Three separate things, often confused:

| Layer | Where to read it |
|---|---|
| Engine version | `select version_no from apex_release;` |
| App compatibility mode | App Definition → Properties |
| Universal Theme version | Shared Components → Themes |

An app can run on a 26.1 engine while still in 24.2 compatibility mode with an
un-refreshed theme. All three move independently, none is required, and each should be
changed as its own reversible step.
