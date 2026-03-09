# Oracle APEX Agent Skill

Focused Oracle APEX skill for IDE agents and CLIs.

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

## Included Skill

- `oracle-apex`: one install that covers export navigation, safe edits, targeted SQLcl export/import commands, APEX 24.2 verification, and findings-first review.

## Trigger Examples

- "where is page 45 in this export?"
- "which file do I edit for this LOV?"
- "page 50 is missing from git, what should I export?"
- "add a validation to page 12"
- "update this process to use APEX_MAIL"
- "add an editable interactive grid to this page export"
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

This creates a symlink for the single `oracle-apex` skill in the target project's skill directory so you can test trigger behavior before publishing.

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

For the public repository, install the skill with:

```sh
npx skills add compasssites/Apex-Skills --skill oracle-apex
```

This GitHub install command is the path that `skills.sh` indexes and tracks for public discovery.

Useful checks:

```sh
npx skills add compasssites/Apex-Skills --list
npx skills add compasssites/Apex-Skills --skill oracle-apex -a claude-code
```

## Publish Checklist

1. Run the `npx skills add ... --skill oracle-apex` command above in a clean test project.
2. Confirm the installed skill appears in the target agent skill directory.
3. Share the repository URL and the exact install command.

## Validation

Run:

```sh
python3 scripts/validate_skills.py
```

If you later want to use the upstream validator from the `skill-creator` toolkit, install `PyYAML` and run `quick_validate.py` against each skill.
