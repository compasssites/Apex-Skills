# APEX 24.2 Export Dialect

Use this file when generating, heavily editing, or reviewing Oracle APEX export SQL instead of making a small surgical change.

Primary source:

- `https://apex-docs-5ka.pages.dev/agent?v=8`

## Core Rules

- Treat existing APEX export files as the source of truth for structure and call shape.
- Use `wwv_flow_imp_page.*` for page components.
- Use `wwv_flow_imp_shared.*` for shared components.
- Wrap component metadata IDs with `wwv_flow_imp.id(...)`.
- Do not wrap the page number passed to `create_page.p_id`.
- Do not fall back to legacy `wwv_flow_api` package usage for APEX 24.2 exports.

## Mandatory Header Pattern

- Add import-safe headers such as `set define off`.
- Add SQL error exit behavior.
- Set `wwv_flow_imp.g_flow_id` with a literal application id, not a bind variable.

## Ordering Rules

Inside a page block, preserve parent-before-child order. A common safe order is:

1. `create_page`
2. `create_page_plug`
3. report or grid child definitions such as worksheet or Interactive Grid metadata
4. `create_page_item`
5. `create_page_button`
6. validations, processes, branches
7. dynamic action event, then dynamic action actions

Breaking export order is a common cause of import failures and foreign-key issues.

## Interactive Grid Handling

Interactive Grid exports are easy to break because the region, IG metadata, columns, validations, and DML process are tightly linked.

- Create the IG parent region first with the exact wrapped region ID used by its child metadata.
- Follow the split-export order exactly. A common pattern is:
  1. `create_page_plug` for the IG region
  2. `create_ig_report`
  3. `create_ig_report_column` and sibling IG column metadata emitted by the export
  4. validations, row actions, or saved-report metadata in the same order as the export
  5. `create_page_process` for `NATIVE_IG_DML` when the grid is editable
- Keep `p_region_id` and related parent references identical to the parent region ID.
- Do not invent IG child call order from memory. Clone the nearest working IG export and edit only safe fields.
- If the export contains additional IG metadata calls, keep them in the exact emitted order.

## Shared Component Isolation

- Do not mix `wwv_flow_imp_shared.*` calls with `wwv_flow_imp_page.*` calls in the same begin/end block.
- Keep shared component changes in their own export script or matching split export file.

## ID Stability

- When modifying existing components, copy IDs from the latest export.
- Only generate new long-form IDs for truly new components.
- Do not invent short random numeric IDs.
- Maintain exact parent-child ID references.

## Offset And Import Context

- Use `apex_application_install.generate_offset` when the deployment flow requires collision-safe imports into an existing app.
- Set workspace, schema, and application context only if the project’s deployment pattern already does so.

## Safe Generation Strategy

- Clone the nearest existing export blueprint and edit only the required fields.
- Do not guess template ids, user interface ids, plugin ids, or shared component ids.
- Copy stable attributes from the nearest valid export when uncertain.

## Review For These Failures

- `wwv_flow_api` or other legacy package usage where `wwv_flow_imp_*` should be used
- component ids not wrapped with `wwv_flow_imp.id(...)`
- page numbers incorrectly wrapped
- mixed `wwv_flow_imp_page.*` and `wwv_flow_imp_shared.*` calls in one block
- missing import-safe header or missing literal `wwv_flow_imp.g_flow_id` setup when the script expects standalone SQLcl import
- child components emitted before parent components
- new IDs that look guessed instead of copied from exports or allocated from a stable high-number strategy
- Interactive Grid metadata that does not keep the exact parent region ID linkage
- Interactive Grid child calls reordered away from the emitted export structure
- page-failure recovery guidance that continues after a partial import instead of delete-and-rerun

## Failure Recovery

- If a page import fails mid-run, prefer the repository’s existing delete-and-rerun pattern rather than continuing from a partial page state.
- At page level, that usually means running the split-export delete script for the page, or `wwv_flow_imp_page.remove_page(...)` if that exact pattern is already present in the project, then rerunning the full page import.
