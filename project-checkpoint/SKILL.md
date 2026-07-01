---
name: project-checkpoint
description: >-
  Close out a work session by forcing the write-back loop so the project's brain
  never goes stale (the 80% that prevents "rớt não"). Run at the END of a unit of
  work or session: gather what actually changed, update the Obsidian vault (status,
  decisions, gotchas, next action), bump frontmatter, and emit an accurate handoff
  for the next cold session. Companion to project-init. Triggers: "checkpoint",
  "đóng phiên", "close out", "cập nhật vault", "project-checkpoint", "handoff",
  "kết thúc phiên", "ghi lại tiến độ".
---

# project-checkpoint

Close a work session by writing the real delta back into the project's brain, so the
re-entry point stays accurate and the next session does not drift.

## Why this exists

`project-init` builds the brain. That is 20% of the value. This skill keeps it alive,
the other 80%. Rớt não returns the moment the brain stops matching reality: a stale
note misleads the next session worse than no note at all. This skill runs the
write-back loop that `project-init` sets up as a hard rule.

## When to use

At the end of a session, right after finishing a unit of work (feature, fix,
migration, deliverable, decision), or before any handoff to another person or agent.
If a code repo is about to be pushed, run this first.

## When NOT to use

If nothing material changed, do not manufacture updates. Say "no material change" and
stop. Noise erodes the signal the brain depends on.

## Core principles

- **Durable delta, not a dump.** Record only what a future session must know.
- **One accurate next action.** The single most important output of every checkpoint.
- **Vault is the source of truth.** Never mirror into the repo or the AI memory system.
- **Honest and idempotent.** Only record what actually happened; verify before writing.
  Running twice must not double-write.
- **Formatting.** Full Vietnamese diacritics; never the em dash character.

## Phase 0 - Locate the brain

Determine the active project and its vault folder from the `CLAUDE.md` "Canonical
memory" pointer (or ask). Read the vault `README.md` and the `00`/`03` notes first so
updates append to truth rather than overwrite it. If Obsidian is unavailable, write to
`docs/AGENT_BOOTSTRAP.md` and tell the user, then sync to the vault once it is back.

## Phase 1 - Gather the delta

- **Code project:** run `git status`, `git diff --stat`, and `git log` since the last
  checkpoint to see real changes. Cross-check against what the user reports.
- **Work / marketing project:** ask the user for the one to three concrete outputs,
  decisions, and blockers from this session.
- Capture five things: what changed, decisions and their reasons, new gotchas, new
  verification recipes, and the single next action.

## Phase 2 - Write back to the vault (the loop)

In the project's vault folder, update:

1. `03 - Implementation Status` (or the `00` current-status paragraph): rewrite the
   current state; set the next action explicitly.
2. Key decisions log: append dated decisions with their reason. Never silently drop a
   prior decision; if reversing one, record the reversal and why.
3. Gotchas and verification: append anything a future session would trip on.
4. `README` re-entry block: update Status, Next action, and Active plan.
5. Active implementation plan: append to its Status log; flip a phase's status if it
   closed.
6. Frontmatter: bump `updated` and `last_synced` to today on every note touched.

## Phase 3 - Release gate (code + tag/changelog rule only)

If the repo carries the tag-and-changelog hard rule and a push is imminent: prepare the
`CHANGELOG.md` entry and propose the semver bump and tag, but do not push, tag, or
publish automatically. Surface the exact commands for the user to run.

## Phase 4 - Guardrails

- No parallel versions: repo docs stay pointers; the vault holds canonical content.
- Leave `CLAUDE.md` / `AGENTS.md` untouched unless a hard rule actually changed, in
  which case edit both to keep them mirror-identical.
- Frontmatter valid; full diacritics; no em dash.

## Phase 5 - Emit the handoff

Print a short handoff (under about eight lines): what changed, where it was logged
(note paths), and the one next action. This is what the next session, `project-init`
update mode, or a teammate reads first. If nothing changed, say so plainly.

## Reference

- `references/checkpoint-checklist.md` - the write-back checklist to run every time.
