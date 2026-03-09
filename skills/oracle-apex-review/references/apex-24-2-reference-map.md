# Oracle APEX 24.2 Review Map

Use this file when a review needs source-backed confirmation for APEX-specific APIs or behavior.

## Primary Sources

- JavaScript API index:
  `https://docs.oracle.com/en/database/oracle/apex/24.2/aexjs/index.html`
- API reference PDF:
  `https://docs.oracle.com/en/database/oracle/apex/24.2/aeapi/oracle-apex-api-reference.pdf`
- Project-specific APEX notes:
  `https://apex-docs-5ka.pages.dev/agent?v=8`

## Review Triggers

- JavaScript added or changed under `apex.*`
- exported process logic depends on a package or procedure signature
- the diff uses syntax that looks older than APEX 24.2
- the requested behavior touches a known APEX subsystem such as Interactive Grid, Dynamic Actions, `APEX_MAIL`, authentication, or session state

## Review Habit

- Prefer "I could not verify this API in APEX 24.2" over guessing.
- Treat official Oracle docs as the primary source for behavioral claims.
