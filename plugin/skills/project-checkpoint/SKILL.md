---
name: project-checkpoint
description: >-
  Close out a work session by forcing the write-back loop so the project's brain
  never goes stale (the 80% that prevents "rớt não"). Run at the END of a unit of
  work or session: gather what actually changed, update the project brain (status,
  decisions, gotchas, next action) in whichever backend is canonical for that
  project (the KDB on Outline, an Obsidian vault, or the repo), and emit an accurate
  handoff for the next cold session. Companion to project-init. Triggers:
  "checkpoint", "đóng phiên", "close out", "cập nhật KDB", "cập nhật vault",
  "project-checkpoint", "handoff", "kết thúc phiên", "ghi lại tiến độ", "xong rồi",
  "hoàn thành", "chốt lại", "bàn giao", "sắp push", "nghỉ đây", "mai làm tiếp",
  "tạm dừng ở đây", "done for today".
---

# project-checkpoint

**Version 0.3.0.** Say this version number in your first line of output when the skill
runs. Claude Code installs update themselves; a Cowork install does not.

Close a work session by writing the real delta back into the project's brain, so the
re-entry point stays accurate and the next session does not drift.

## Why this exists

`project-init` builds the brain. That is 20% of the value. This skill keeps it alive,
the other 80%. Rớt não returns the moment the brain stops matching reality: a stale
document misleads the next session worse than no document at all. This skill runs the
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
- **Write to the canonical backend.** Whichever one `CLAUDE.md` names. If a secondary
  drafting layer was used this session, the checkpoint is not done until the canonical
  side reflects it.
- **Permission before placement.** New budget, proposal, or HR content goes to the
  restricted collection, never appended into a team-wide project branch for
  convenience.
- **Knowledge, not operational state.** Do not copy task lists, percentages, or
  deadlines out of the operational system into the brain. Link instead.
- **Honest and idempotent.** Only record what actually happened; verify before writing.
  Running twice must not double-write.
- **Formatting.** Full Vietnamese diacritics; never the em dash character.

## Phase 0 - Locate the brain and its backend

Read the "Brain backend" block in `AGENTS.md` to learn which backend is canonical and
where the project's root document or folder is. Claude Code reaches it through the
`@AGENTS.md` import in `CLAUDE.md`; on Cowork, open `AGENTS.md` directly; a project with
no repo at all has no such file, so ask. If the block is missing, the project predates
the multi-backend convention: ask which backend is canonical, then add the block to
`AGENTS.md` before continuing.

Read the re-entry page and the `00` / `03` documents first so updates append to truth
rather than overwrite it. If the backend is unreachable, write to
`docs/AGENT_BOOTSTRAP.md`, tell the user, and sync once it is back.

Then read the staleness signal for this backend before writing anything, following
"Staleness signal" in `../project-init/references/brain-backends.md`: on Outline
`list_documents(collectionId)` for `updatedAt`, `updatedBy.name` and `revision`; on
Obsidian the `updated` and `last_synced` frontmatter; in a repo `git log -1`. Compare
`revision` against the value recorded in the status block at the last checkpoint and say
the delta out loud. If someone else edited the brain since then, read their change
before appending, so you do not quietly overwrite a decision you never saw.

## Phase 1 - Gather the delta

- **Code project:** run `git status`, `git diff --stat`, and `git log` since the last
  checkpoint to see real changes. Cross-check against what the user reports.
- **Work / marketing project:** ask the user for the one to three concrete outputs,
  decisions, and blockers from this session.
- Capture five things: what changed, decisions and their reasons, new gotchas, new
  verification recipes, and the single next action.

## Phase 2 - Write back to the brain (the loop)

In the project's brain, update:

1. `03 - Implementation Status` (or the `00` current-status paragraph): rewrite the
   current state; set the next action explicitly.
2. Key decisions log: append dated decisions with their reason. Never silently drop or
   edit a prior decision; if reversing one, add a new dated entry that names what it
   supersedes and why.
3. Gotchas and verification: append anything a future session would trip on.
4. Re-entry page: update Status, Next action, and Active plan.
5. Active implementation plan: append to its Status log; flip a phase's status if it
   closed.
6. Date stamp: on Outline, update the status block at the top of each document touched.
   On Obsidian, bump `updated` and `last_synced` frontmatter to today.

If a decision this session is significant beyond the project, also create a dated
decision document in the organisation's decision collection and link it from the
project.

## Phase 3 - Release gate (code + tag/changelog rule only)

If the repo carries the tag-and-changelog hard rule and a push is imminent: prepare the
`CHANGELOG.md` entry and propose the semver bump and tag, but do not push, tag, or
publish automatically. Surface the exact commands for the user to run.

## Phase 4 - Guardrails

- No parallel versions: repo docs stay pointers; the canonical brain holds content.
- If a secondary drafting layer was used, it synced one way into the canonical brain.
- Nothing sensitive was appended into a team-wide collection; no share link was enabled
  outside the designated external-sharing collection.
- No operational state copied out of the ops system into the brain.
- Leave `AGENTS.md` untouched unless a hard rule actually changed, in which case edit it
  there and only there. `CLAUDE.md` imports it with `@AGENTS.md` and needs no parallel
  edit. If you find a rule duplicated in `CLAUDE.md`, delete the duplicate rather than
  syncing it.
- Outline documents carry no YAML frontmatter and no leading H1; vault frontmatter is
  valid. Full diacritics; no em dash.

## Phase 5 - Emit the handoff

Print a short handoff (under about eight lines): what changed, where it was logged
(document URLs or note paths), and the one next action. This is what the next session,
`project-init` update mode, or a teammate reads first. If nothing changed, say so
plainly.

## Reference

- `references/checkpoint-checklist.md` - the write-back checklist to run every time.
