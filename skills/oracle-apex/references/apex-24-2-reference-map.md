# Oracle APEX 24.2 Reference Map

Use this file when an Oracle APEX task depends on version-specific APIs, exported SQL behavior, or review claims that should be source-backed.

## Primary Sources

- JavaScript API index:
  `https://docs.oracle.com/en/database/oracle/apex/24.2/aexjs/index.html`
- API reference PDF:
  `https://docs.oracle.com/en/database/oracle/apex/24.2/aeapi/oracle-apex-api-reference.pdf`
- Project-specific APEX notes:
  `https://apex-docs-5ka.pages.dev/agent?v=8`

## When To Check

- The task introduces or changes `apex.*` JavaScript APIs.
- The task depends on a PL/SQL package or exported APEX API call.
- The diff adds `wwv_flow_*` procedures or context setup logic.
- The request touches Interactive Grid, Dynamic Actions, `APEX_MAIL`, authentication, session state, or other version-sensitive subsystems.
- The proposed solution looks copied from an older APEX version.

## Verification Habits

- Search the 24.2 JavaScript index for the exact object or method name.
- Check the 24.2 API reference before inventing package procedures, parameters, or signatures.
- Prefer "I could not verify this in Oracle APEX 24.2" over guessing.
- Follow local project conventions only after confirming the underlying APEX 24.2 API surface is still valid.
