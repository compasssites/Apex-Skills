# Oracle APEX 24.2 Reference Map

Use this file when an Oracle APEX task depends on version-specific APIs or documentation.

## Primary Sources

- JavaScript API index:
  `https://docs.oracle.com/en/database/oracle/apex/24.2/aexjs/index.html`
- API reference PDF:
  `https://docs.oracle.com/en/database/oracle/apex/24.2/aeapi/oracle-apex-api-reference.pdf`
- Project-specific APEX notes:
  `https://apex-docs-5ka.pages.dev/agent?v=8`

## When To Check

- The task uses `apex.*` JavaScript APIs.
- The task relies on a PL/SQL package or exported APEX API call.
- The requested solution looks copied from an older APEX version.
- The agent is about to introduce a helper method from memory without a source.

## Verification Tactics

- Search the 24.2 JavaScript index for the exact object or method name.
- Check the 24.2 API reference before inventing package procedures or parameters.
- If the local project has stronger conventions than generic APEX docs, follow the project after confirming the API surface is still valid.
