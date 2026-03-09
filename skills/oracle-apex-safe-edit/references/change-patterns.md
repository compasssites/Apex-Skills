# Change Patterns

Use this file to map a request to the correct Oracle APEX artifact.

## Usually Page-Scoped

- item changes
- region changes
- button behavior
- validations
- computations
- dynamic actions
- page processes
- page-level JavaScript or CSS

These usually belong in the matching `application/pages/page_*.sql` export.

## Usually Shared Components

- shared LOVs
- navigation lists
- breadcrumbs
- templates
- authentication and authorization schemes
- application items
- reusable page groups
- static application files

These usually belong under `application/shared_components`.

## Usually Separate Backend SQL

- tables
- views
- packages
- triggers
- grants
- seed data
- data fixes
- deployment migrations

These should usually be emitted as standalone SQL scripts instead of being hidden inside an APEX export.

## Mixed Changes

When one request spans UI and database work:

1. Update the APEX export file that references the behavior.
2. Create a separate SQL script for the backend change.
3. Return both file paths and the SQLcl import command for the APEX artifact.
