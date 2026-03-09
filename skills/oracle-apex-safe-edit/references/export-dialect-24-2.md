# APEX 24.2 Export Dialect

Use this file when generating or heavily editing Oracle APEX export SQL instead of doing small surgical changes.

This guidance is distilled from the project-specific agent endpoint at:

- `https://apex-docs-5ka.pages.dev/agent?v=8`

## Core Rules

- Treat APEX export files as the source of truth for structure and call shape.
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

Inside a page block, preserve parent-before-child order. Typical safe order:

1. `create_page`
2. `create_page_plug`
3. report/grid child definitions such as worksheet or IG metadata
4. `create_page_item`
5. `create_page_button`
6. validations, processes, branches
7. dynamic action event, then dynamic action actions

Breaking export order is a common cause of import failures and FK issues.

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
- Do not guess template ids, user interface ids, or shared component ids.
- Copy stable attributes from the nearest valid export when uncertain.

## Failure Recovery

- If a page import fails mid-run, prefer the repository’s existing delete-and-rerun pattern rather than continuing from a partial page state.
