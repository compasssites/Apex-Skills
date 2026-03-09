---
name: oracle-apex-safe-edit
description: Safely implement Oracle APEX changes in split export files while avoiding direct edits to main app DDL, keeping backend SQL separate, and ending with targeted SQLcl import commands only. Use when an IDE agent is asked to modify APEX pages, shared components, JavaScript, dynamic actions, processes, or supporting SQL artifacts in an exported application.
---

# Oracle APEX Safe Edit

Use this skill to implement Oracle APEX changes with conservative file targeting and operator-safe output.

## Non-Negotiables

- Never directly change the main app DDL as the default path.
- Keep backend SQL in separate scripts instead of hiding it inside unrelated page exports.
- If a page export already exists, update that page file in place.
- End with concise SQLcl import commands only.
- Never execute server changes or claim they were run.
- Treat Oracle APEX 24.2 as the compatibility target unless the repository says otherwise.

Read [references/operator-guardrails.md](references/operator-guardrails.md) before editing when the task resembles the operator preferences in this skill.

## Workflow

1. Use `$oracle-apex-export-navigation` logic to find the exact exported file.
2. Run `scripts/check_guardrails.sh <path...>` on candidate edits when there is any chance the main app DDL is involved.
3. Decide whether the request belongs in:
   - an existing page export,
   - an existing shared component export, or
   - a separate backend SQL script.
4. Implement the narrowest possible change.
5. End with only the relevant import commands and a brief completion note.

## Change Routing

- Page rendering, items, buttons, regions, dynamic actions, validations, computations, and processes usually belong in the matching page export.
- Shared LOVs, templates, navigation, authorization schemes, lists, and similar cross-page artifacts usually belong under `application/shared_components`.
- Database objects, grants, data fixes, package changes, and migration-style work belong in separate SQL scripts that follow the repository's existing convention.
- If no backend SQL convention exists, prefer a simple sibling folder such as `database/` or `sql/` with descriptive filenames.

Read [references/change-patterns.md](references/change-patterns.md) when the task spans multiple artifact types.

## APEX 24.2 Compatibility

- Prefer Oracle APEX 24.2 documentation and APIs over memory or older snippets.
- If JavaScript APIs, PL/SQL packages, or export semantics are uncertain, read [references/apex-24-2-reference-map.md](references/apex-24-2-reference-map.md) and verify against official docs.
- If the task involves generating or restructuring export SQL, read [references/export-dialect-24-2.md](references/export-dialect-24-2.md) before changing call order, headers, IDs, or package names.
- Avoid inventing older `apex.*` APIs when the task explicitly targets 24.2 behavior.

## Output Contract

- Keep the closing explanation brief.
- List only the SQLcl commands the operator should run.
- Do not include noisy success-message mockups.
- Do not include instructions that run on a live Oracle server.

If the task is to assess risk or review a diff rather than edit files, use `$oracle-apex-review`.
