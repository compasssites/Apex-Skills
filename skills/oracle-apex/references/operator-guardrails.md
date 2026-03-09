# Operator Guardrails

This file captures the operating style behind this skill.

## Required Behavior

- Never directly change the main app DDL by default.
- Put backend work in separate SQL scripts.
- If editing a page export, replace the matching file in the existing `application/pages` tree.
- End with SQLcl import commands that the operator can run manually.
- Keep the closing explanation brief.
- Keep SQLcl success messaging minimal or omit it entirely.
- Never run anything against an Oracle server directly. Give commands only.

## Source Preferences

When Oracle APEX details are uncertain, prefer:

- `https://apex-docs-5ka.pages.dev`
- `https://docs.oracle.com/en/database/oracle/apex/24.2/aexjs/index.html`
- `https://docs.oracle.com/en/database/oracle/apex/24.2/aeapi/oracle-apex-api-reference.pdf`

## Editing Bias

- Use the existing export layout.
- Prefer the smallest safe edit surface.
- Do not inflate the response with a long walkthrough unless the user asks for it.
