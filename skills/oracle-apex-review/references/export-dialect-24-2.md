# APEX 24.2 Export Dialect Review Checks

Use this file when reviewing generated or edited Oracle APEX export SQL.

Primary source:

- `https://apex-docs-5ka.pages.dev/agent?v=8`

## Review For These Failures

- `wwv_flow_api` or other legacy package usage where `wwv_flow_imp_*` should be used
- component ids not wrapped with `wwv_flow_imp.id(...)`
- page numbers incorrectly wrapped
- mixed `wwv_flow_imp_page.*` and `wwv_flow_imp_shared.*` calls in one block
- missing import-safe header or missing literal `wwv_flow_imp.g_flow_id` setup when the script expects standalone SQLcl import
- child components emitted before parent components
- new IDs that look guessed instead of copied from exports or allocated from a stable high-number strategy

## Findings Language

When one of these appears, state the concrete dialect break instead of saying only "APEX import may fail".
