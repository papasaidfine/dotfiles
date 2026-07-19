## Package Managers

- CLI tools & language runtimes: install with `mise use -g <tool>` (mise is the polyglot version manager on this machine) — this includes the Node.js runtime itself. Don't reach for the system package manager or manual downloads for these.
- Python: always use `uv`. Do not touch the global `python`/`python3`.
- Node packages: always use `pnpm` over `npm`, unless the project already uses npm (e.g. has `package-lock.json`).

## Attribution

- Never add "co-authored by Codex" (or similar) to commits, PRs, issues, comments, or any other content.
- Never include a real email address in GitHub release notes.
