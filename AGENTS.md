# Agent Instructions

<!-- compass:start:global -->
# Global Defaults

The owner is not a technical user. Finish the whole job yourself (code, checks, migrations, shipping) and report in plain language. Never hand the owner a terminal command, migration, or deploy step.

## Working

- Keep changes small and match the surrounding code. Do not change the stack (Cloudflare-native unless the project says otherwise) or invent credentials, services, or architecture.
- Find code from the literal in the request (UI text, route, field, error message) with `rg`, after checking the Feature Map in the Project section. Never list or read `node_modules`, `dist`, `build`, `.wrangler`, coverage, lockfiles, or minified files.
- Decide reversible choices yourself and state the assumption in one line. Ask at most one question, and only when the answers lead to different work.
- For a screenshot-led UI fix, fix what is shown; do not redesign neighbouring areas.
- Pipe installs, builds, and tests through `tail -40`. Run dev servers and watchers only in the background and stop them before you finish. macOS has no `timeout` command.
- Never run a repo-wide formatter for a targeted change.
- Scratch files go in `.agent-tmp/`; delete the ones you made. Do not delete files you did not create; mention them instead.
- Work that spans sessions gets a `plans/YYYY-MM-DD-topic.md` file, kept current.

## Hard limits

These are enforced by hooks and permissions. A "Compass guard" refusal is policy; do not work around it.

- No browser, headless browser, screenshot, or visual-regression tools on this machine. The owner supplies screenshots; verify with typecheck, build, tests, and `curl`.
- No DNS or zone changes. Tell the owner what to change in the Cloudflare dashboard.
- Cloudflare writes (deploys, migrations, non-SELECT D1, secrets, R2 and KV writes) prompt once each. Ask, run, verify; never skip them or hand them to the owner.
- No subagents unless the owner asks for one in that message.

## Keeping notes

- If the Project section says "Unknown" for something you worked out (deploy style, build command, database, worker name), write the value into the repo's `AGENTS.md` Project section and `~/CompassAgentMemory/projects/<repo>.md` in the same turn.
- Do not edit the other Compass-managed sections. Add a dated line under Manual Notes and tell the owner.
<!-- compass:end:global -->

<!-- compass:start:security -->
# Security

- Never read, print, export, or commit secrets: `.env`, `.dev.vars`, private keys, API tokens, database passwords, wallet files, Wrangler auth files. If unsure whether a file holds secrets, do not display it.
- Never ask the owner to paste a token or secret into chat, and never dump environment variables.
- Use existing authenticated sessions. Set a secret you can generate yourself with `wrangler secret put` (it prompts once); for a third-party key, tell the owner exactly which Cloudflare dashboard field to fill.
<!-- compass:end:security -->

<!-- compass:start:stack -->
# Generic Project Defaults

- Follow global and security rules.
- Inspect project files before changing stack or workflow.
<!-- compass:end:stack -->

<!-- compass:start:project -->
# Project: Apex-Skills

## Basic Info

Path: /Users/macpro/Dev/Apps/Apex Skills
Detected stack: generic
Main app type: Unknown
Deploy style: GitHub Actions workflow
Git branch: main
Deploy trigger: Unknown (options: push-to-main auto-deploys via Cloudflare git integration / manual wrangler deploy / other)

## Project Commands

Build: Unknown
Test: Unknown
Check: Unknown
Deploy: Unknown

## Interface Profile

UI personality: Unknown (choose institutional / product / expressive)
Component foundation: Unknown

## Cloudflare Notes

Wrangler config: None found
D1 bindings: Unknown
R2 bindings: Unknown
Pages project: Unknown
Worker name: Unknown

## Database Notes

Database type: Unknown
Migration style: Unknown
Migrations: Unknown (options: manual — agent must run them / automatic / none)
Backup notes: Unknown

## Manual Notes

Add human notes here.
<!-- compass:end:project -->

<!-- compass:start:workflows -->
# Shipping and verification

- Ship each meaningful change with `/Users/macpro/CompassAgentMemory/bin/compass-ship "message" [files…]`. It stages (everything, or the files named), refuses secret-looking files, runs the project check, commits, and pushes in one approval. Do not run `git add`, `git commit`, or `git push` yourself, and do not re-run the check it runs. Name the files when the tree holds work that is not yours.
- Run D1 migrations yourself right after adding them: `npx wrangler d1 migrations apply <DB> --remote`. A git-push deploy never applies them.
- In an auto-deploy repo the push is the deploy. Do not sleep, wait, or poll for it. Check a live URL only when the change altered URL or API behaviour; if the new build is not live yet, say it is building and stop.
- Deploy styles, what counts as verification, and the client summary format: load the `compass-workflow` skill.
- When the owner relays client feedback, ship the fix, then add a plain-text summary they can paste into an email: one sentence per item, no technical terms, in its own block.
- Final message under 150 words: what changed, what was verified, what is left.
<!-- compass:end:workflows -->
