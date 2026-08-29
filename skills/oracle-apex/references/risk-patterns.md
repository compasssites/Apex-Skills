# Risk Patterns

Use this file when an Oracle APEX change looks plausible but may hide workflow mistakes.

## High Risk

- main app DDL edited for a page-scoped task
- full app import suggested when a page import exists
- backend SQL embedded in an unrelated page export
- instructions that run directly on a live server
- invented or stale `apex.*` APIs presented as fact

## Medium Risk

- shared component placed in a page file or vice versa
- import command path does not match the changed file
- answer includes long walkthrough text instead of a concise operator handoff
- no reference to the target APEX release when the change depends on version-specific behavior

## Lower Risk But Worth Mentioning

- naming of backend SQL files is inconsistent
- the change spans UI and database layers but the response does not make the split explicit
- residual testing expectations are not called out

## Silent-Failure Patterns

These pass review because the code looks defensive. It is the defensiveness that hides
the bug.

- **A catch-all fallback on a filter.** `if regexp_like(...) then parse else keep default`
  with a default of `trunc(sysdate)` renders today's figures under whatever date range
  the user selected. The screen is internally inconsistent and nobody notices for days.
  A filter that cannot read its own input must say so.
- **A guard clause that gives up quietly.** `if ($el.length) {...} else { done(); return; }`
  turns a missing element into a no-op with no request, no console error, and no server
  log. There is nothing left to debug from.
- **`exception when others then null`** anywhere near a value the user will read as fact.
- Any code path whose failure produces a *plausible* number rather than an error.

## Fragile-Reference Patterns

- **JavaScript addressing components by internal id.** `apex.region("R" + component_id)`
  or `$("#R200000000000000010")` breaks whenever APEX regenerates ids — a copy, an
  upgrade, a rebuild. Use the component's **static id**; keep the internal id only as a
  fallback.
- **A page relying on its navigation entry for authorization.** Hiding a menu item does
  not stop a direct URL. Page-level authorization is separate and must be set explicitly.
- **A page or menu entry referencing a deleted authorization scheme.** APEX cannot
  resolve the id, and the reference may fail open. Symptom: a dictionary query
  (`apex_application_pages.authorization_scheme`) returns a raw number instead of a
  scheme name. Restore the scheme with its **original component id** rather than
  repointing every page.
