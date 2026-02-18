For python project, please always use "uv". Do not mess up the global python/python3.

For JavaScript/TypeScript projects, always use "pnpm" over "npm" unless the project already uses npm (e.g., has a package-lock.json).

## Always Create Agent Teams for Parallel Work

When a task goes through planning and the plan reveals independent, parallelizable subtasks:
- Always create an agent team to work on those subtasks concurrently instead of doing them sequentially.
- Each teammate should get a clearly scoped, self-contained task with no cross-dependencies on other in-flight work.
- Keep team size proportional to the number of truly independent work streams — don't over-parallelize tightly coupled changes.
- After all teammates finish, review and integrate their work, resolving any conflicts.
