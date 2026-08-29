# Migrating And Testing An APEX Upgrade

Use this file when the instance has been upgraded, a theme refresh is on the table, or
someone proposes testing a change in a copy of the application.

## The Three Layers Move Independently

| Layer | Read it at | Required? |
|---|---|---|
| Engine version | `select version_no from apex_release;` | Set by the DBA/cloud provider |
| App compatibility mode | App Definition → Properties | **No** |
| Universal Theme version | Shared Components → Themes | **No** |

An app runs fully supported on a new engine while staying in an old compatibility mode
with an un-refreshed theme. Neither of the other two is a prerequisite for anything.
Treat each as its own change, with its own rollback, at its own time. Never bundle them
into a feature release.

## Order Of Operations

1. **Take a fresh split export first.** It is the rollback.
2. Run the **Upgrade Application** utility items one type at a time, checking between each.
   They are optional feature adoptions, not upgrade requirements — read the candidate
   list before applying and skip anything nobody asked for.
3. Change **compatibility mode**.
4. **Refresh the theme last** — widest blast radius, so a break after it is unambiguous.

## Theme Refresh: The Step Everyone Skips

Refreshing the Universal Theme leaves any **custom theme style no longer current**. The
app falls back to the stock style, and the result looks like broken CSS: basic fonts,
wrong colours, unexpected borders.

Immediately after refreshing, open **Theme Roller**, re-save the custom style, and set it
as current. Judge nothing until that is done — most apparent breakage disappears.

## Working Copies Are Not A Faithful Test Environment

A working copy is genuinely useful for theme and layout testing, but know its limits
before you trust a result:

- **It shares the same schema and live data.** It isolates the application, not the data.
  Anything that inserts, updates, or deletes writes to production through a different door.
- **Custom authentication may not carry across.** A copy runs under a different app id and
  alias; if the auth scheme depends on either, AJAX calls get redirected to the login page
  and blocked cross-origin. Every partial refresh on every page then silently does nothing.
- **Components may not render with the ids the parent app uses.** Any JavaScript or CSS
  keyed to a region id can fail in a copy while working perfectly in the real app.

Consequence: **a failure seen only in a working copy is not evidence of a production
problem.** Verify against the real application before spending time on it. Diagnosing a
copy-only artifact as an upgrade regression is an easy way to lose a day.

## Verifying, Cheaply

- Compare the same action in the copy and the real app before theorising about causes.
- Prefer one discriminating test over several confirmatory ones. "Click TODAY and see
  whether the numbers change" separates a broken filter from a broken data scope in five
  seconds.
- APEX **Debug** (dev toolbar → Debug → View Debug) shows what the server actually
  received. Each request is its own entry — a partial refresh is a separate entry from
  the page load, and exporting the wrong one wastes a round trip.
- If clicking produces **no new debug entry at all**, no request was made. Stop looking at
  the server.
- Items marked *store value encrypted in session state* appear as `***` in debug, and
  non-persistent items never reach session state at all — so an empty Session State view
  is not proof that a value was not submitted.

## apex_application_install

```sql
begin
  apex_application_install.set_workspace_id(<numeric id from the export header>);
  apex_application_install.set_application_id(<target app>);
end;
/
@path/to/page_00030.sql
```

- `set_workspace` takes the **workspace name**, which is usually not the schema name.
  Passing the schema raises `ORA-20987: Invalid workspace ID`. Prefer
  `set_workspace_id` with `p_default_workspace_id` copied from the export header.
- `set_keep_sessions_on_upgrade` does not exist in 26.1.
- **A failed block is dangerous, not merely unsuccessful.** If the anonymous block errors,
  the application id is never set and the `@import` that follows lands in whatever
  `p_default_application_id` the file declares — usually production. Check that the block
  succeeded before running the import.
- The App Builder's own **Export/Import → Import** avoids all of this by targeting the app
  you opened it from. Prefer it when importing into a copy.
