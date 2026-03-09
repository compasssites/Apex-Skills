# Review Checklist

Use this file to review Oracle APEX export changes in a stable order.

## Sequence

1. Identify every changed export path.
2. Check whether any whole-application entrypoint was edited.
3. Check whether a page-level request landed in the correct `page_*.sql` file.
4. Check whether shared components were routed under `application/shared_components`.
5. Check whether backend SQL was separated into its own script.
6. Check whether the closing guidance contains narrow SQLcl imports.
7. Check Oracle APEX 24.2 compatibility for any new `apex.*` JavaScript calls, any `wwv_flow_*` package calls, and any workspace or application context setup logic.

## Findings Format

- Lead with severity.
- Include the affected file path.
- State the risk in one sentence.
- Add a short fix direction only when it is obvious.
