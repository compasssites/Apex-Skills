# SQLcl Imports

Use this file when producing concise import commands after an Oracle APEX change.

## Rules

- Output commands only. Do not pretend they were executed.
- Prefer the narrowest import path that matches the changed artifact.
- Preserve the repository-relative export path.

## Examples

Page import:

```sql
@f111/application/pages/page_00042.sql
```

Shared component import:

```sql
@f111/application/shared_components/user_interface/lovs/customer_status.sql
```

User interfaces import:

```sql
@f111/application/user_interfaces.sql
```

## What To Avoid

- Whole-application imports unless the task explicitly needs them.
- Long walkthrough text around the command.
- Fake success text or narrated terminal output.

## Path Handling

- Convert absolute file paths back to repository-relative `@...` paths before presenting them.
- If the repository root sits above the app export folder, emit the path from the app export folder downward.
- Use `scripts/emit_sqlcl_import.sh` when the correct `@...` path is easy to get wrong.
