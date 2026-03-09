# Oracle APEX Agent Skills

Focused Agent Skills for Oracle APEX development workflows in IDEs and CLIs.

Repository:

- `https://github.com/compasssites/Apex-Skills`
- Skills CLI source: `compasssites/Apex-Skills`

The collection is designed for:

- Antigravity
- Codex
- Claude Code
- Cursor
- GitHub Copilot agent mode

Antigravity here means an agent workflow that reads project-local skills from `.agent/skills/`.

## Included Skills

- `oracle-apex-export-navigation`: locate page and shared component exports, then emit the correct SQLcl import command.
- `oracle-apex-safe-edit`: implement APEX changes without defaulting to main app DDL edits.
- `oracle-apex-review`: review APEX export changes for workflow mistakes and version-specific risks.

## Trigger Examples

- `oracle-apex-export-navigation`
  - "where is page 45 in this export?"
  - "which file do I edit for this LOV?"
  - "page 50 is missing from git, what should I export?"
- `oracle-apex-safe-edit`
  - "add a validation to page 12"
  - "update this process to use APEX_MAIL"
  - "add an editable interactive grid to this page export"
- `oracle-apex-review`
  - "review this APEX export diff"
  - "is this page import safe?"
  - "check whether this generated SQL matches APEX 24.2"

## Design Goals

- Keep Oracle APEX split exports navigable for agents.
- Separate backend SQL from APEX page exports.
- Bias toward Oracle APEX 24.2 documentation.
- End with concise operator handoff commands instead of noisy walkthroughs.
- Never run live Oracle server changes from the agent.

## Prerequisites

- The application export should already exist on disk in split format, or the operator should be able to run `apex export -applicationid ... -split`.
- The operator should already be connected in SQLcl with the correct workspace, schema, and application context before running import commands.
- Oracle APEX 24.2 is the default target unless the export header shows a different version.

## Local Development

Link the skills into another project with:

```sh
./scripts/link_skills.sh /path/to/project codex claude-code cursor github-copilot antigravity
```

This creates symlinks in the target project's skill directories so you can test trigger behavior before publishing.

### Claude Code

For Claude Code, the practical install path is local skills in `.claude/skills/` or `~/.claude/skills/`.

Project-local link example:

```sh
./scripts/link_skills.sh /path/to/project claude-code
```

### Codex, Cursor, Copilot, Antigravity

The same linker can create project-local skill symlinks for the other supported agents:

```sh
./scripts/link_skills.sh /path/to/project codex cursor github-copilot antigravity
```

## Install From GitHub

For a private repository, prefer the local symlink flow above.

Once the repository is public, install individual skills with:

```sh
npx skills add compasssites/Apex-Skills --skill oracle-apex-export-navigation
npx skills add compasssites/Apex-Skills --skill oracle-apex-safe-edit
npx skills add compasssites/Apex-Skills --skill oracle-apex-review
```

These GitHub install commands are the path that `skills.sh` indexes and tracks for public discovery.

Useful checks:

```sh
npx skills add compasssites/Apex-Skills --list
npx skills add compasssites/Apex-Skills --skill oracle-apex-safe-edit -a claude-code
```

## Publish Path

1. Change the GitHub repository visibility to public.
2. Run the three `npx skills add ... --skill ...` commands above in a clean test project.
3. Confirm the installed skills appear in the target agent skill directory.
4. Share the repository URL and the exact per-skill install commands.

## Validation

Run:

```sh
python3 scripts/validate_skills.py
```

If you later want to use the upstream validator from the `skill-creator` toolkit, install `PyYAML` and run `quick_validate.py` against each skill.
