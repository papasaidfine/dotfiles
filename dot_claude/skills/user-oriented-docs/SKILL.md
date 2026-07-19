---
name: user-oriented-docs
description: Use when creating, rewriting, or reviewing any docs — README, guides, getting-started, project intro. Captures my preference for writing to the reader's purpose: cover what's relevant to using the thing, cut unrelated internals. README is the prime case. Trigger this even when I don't explicitly say "use my docs skill."
---

# User-Oriented Docs

Write docs for what the reader came to do. Include what serves that purpose; cut what doesn't.

By default the reader wants to *use* the thing — so cover install, run, configure, and usage, and leave out internals that don't affect using it. This is about relevance, not length: a thorough usage doc can be long. User-oriented ≠ concise.

The **README** is the purest case — the high-level, user-first entry point to the repo.

Don't repeat what the tool already documents. If it has `--help` or a manual, point to it instead of copying it here.

Leave out the development history. While working with an agent I might reject an idea, change my mind, or take a detour — none of that belongs in the docs. The reader doesn't care what the tool *used to* do, or what turned out to be wrong. Describe only what it is now.

**Exception:** when a doc's explicit job *is* the internals — architecture, design rationale, how it works under the hood — those details *are* the relevant content, so write them. The principle didn't change; the reader's purpose did.
