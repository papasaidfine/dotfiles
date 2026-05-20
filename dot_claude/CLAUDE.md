## Package Managers

- Python: always use `uv`. Do not touch the global `python`/`python3`.
- JavaScript/TypeScript: always use `pnpm` over `npm`, unless the project already uses npm (e.g. has `package-lock.json`).

## Attribution

- Never add "co-authored by Claude" (or similar) to commits, PRs, issues, comments, or any other content.
- Never include a real email address in GitHub release notes.

## Response Style

- Keep user-facing responses (summaries, explanations, status updates) concise — I will ask for expansion if I want more detail.
- This applies to communication only. Do not let it shorten or weaken planning, design depth, or code implementation.

## Always Create Agent Teams for Parallel Work

When planning reveals independent, parallelizable subtasks, dispatch an agent team to run them concurrently instead of sequentially:
- Give each teammate a clearly scoped, self-contained task with no cross-dependencies on other in-flight work.
- Size the team to the number of truly independent work streams — don't over-parallelize tightly coupled changes.
- After all teammates finish, review and integrate their work, resolving any conflicts.
