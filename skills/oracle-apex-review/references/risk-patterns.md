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
- no reference to APEX 24.2 when the change depends on version-specific behavior

## Lower Risk But Worth Mentioning

- naming of backend SQL files is inconsistent
- the change spans UI and database layers but the response does not make the split explicit
- residual testing expectations are not called out
