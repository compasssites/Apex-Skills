# Oracle APEX Agent Skills

Focused Agent Skills for Oracle APEX development workflows in IDEs and CLIs.

The collection is designed for:

- Antigravity
- Codex
- Claude Code
- Cursor
- GitHub Copilot agent mode

## Included Skills

- `oracle-apex-export-navigation`: locate page and shared component exports, then emit the correct SQLcl import command.
- `oracle-apex-safe-edit`: implement APEX changes without defaulting to main app DDL edits.
- `oracle-apex-review`: review APEX export changes for workflow mistakes and version-specific risks.

## Design Goals

- Keep Oracle APEX split exports navigable for agents.
- Separate backend SQL from APEX page exports.
- Bias toward Oracle APEX 24.2 documentation.
- End with concise operator handoff commands instead of noisy walkthroughs.
- Never run live Oracle server changes from the agent.

## Local Development

Link the skills into another project with:

```sh
./scripts/link_skills.sh /path/to/project codex claude-code cursor github-copilot antigravity
```

This creates symlinks in the target project's skill directories so you can test trigger behavior before publishing.

## Publish Path

1. Commit this repository to GitHub.
2. Test install each skill explicitly, for example:
   `npx skills add https://github.com/<owner>/<repo> --skill oracle-apex-safe-edit`
3. Share the repository URL and the per-skill install commands.

## Validation

Run:

```sh
python3 scripts/validate_skills.py
```

If you later want to use the upstream validator from the `skill-creator` toolkit, install `PyYAML` and run `quick_validate.py` against each skill.
