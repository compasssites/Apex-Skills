# SQLcl Exports

Use this file when the split export on disk is missing a page or component that exists in the live application.

## Rules

- Do not fabricate a missing `page_XXXXX.sql` file.
- Emit the SQLcl export command needed to pull the artifact first, then stop.
- Prefer split exports so the file layout matches source control.

## Full Application Export

Export a full split application tree:

```sql
apex export -applicationid 1234 -split
```

This creates the `f1234` directory with split files, including `install.sql` and the `application/` tree.

## Selected Component Export

Export only the missing page or components into split files:

```sql
apex export -applicationid 1234 -split -expComponents PAGE:50
```

Example for a page and a shared LOV:

```sql
apex export -applicationid 1234 -split -expComponents PAGE:50 LOV:23618973754424510000
```

With `-split -expComponents`, SQLcl produces only the required files plus helper scripts such as `install_component.sql`.

## When To Use Which Command

- Use `-applicationid ... -split` when the whole export tree is stale or missing.
- Use `-expComponents` when one page or shared component is missing from an otherwise valid split export.
- If the app ID is unclear, inspect the export header first and confirm before emitting commands.

## Source Note

These command patterns are based on Oracle APEX Administration Guide examples for `apex export -applicationid ... -split` and `-expComponents`.
