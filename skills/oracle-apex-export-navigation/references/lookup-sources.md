# Lookup Sources

Use this file when the task is less about editing exports and more about finding Oracle APEX reference material quickly.

## Official Sources

- Oracle APEX 24.2 JavaScript API:
  `https://docs.oracle.com/en/database/oracle/apex/24.2/aexjs/index.html`
- Oracle APEX 24.2 API reference PDF:
  `https://docs.oracle.com/en/database/oracle/apex/24.2/aeapi/oracle-apex-api-reference.pdf`
- Project-specific documentation hub:
  `https://apex-docs-5ka.pages.dev`

## Search Categories

High-value APEX lookup areas include:

- documentation
- icons
- icon modifiers
- CSS classes
- CSS variables
- internal views
- HTML snippets
- APEX links

Treat those categories as a lookup checklist, not as a workflow format.

## Universal Theme Notes

- Prefer existing `fa-...` Font APEX icon names already used in the application or listed in the project docs.
- Prefer existing Universal Theme utility classes over guessed `u-...` class names.
- When touching CSS classes or variables, verify against the project docs or Oracle APEX references before inventing new utility names.
- If a UI change depends on exact icon modifiers or utility classes, cite the source used to choose them.

## Suggested Search Prompts

- "Find the Oracle APEX 24.2 JavaScript API for this function"
- "Locate the shared component export for this LOV"
- "Find the correct APEX internal view for this metadata question"
- "Find the font-apex icon or utility CSS class that matches this UI change"
