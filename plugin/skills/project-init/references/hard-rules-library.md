# Hard rules library

A menu of reusable "hard rules" to offer during Phase 1 (Q3). Present each one, let the
user include, edit, or skip, then inject the chosen blocks verbatim into
`{{HARD_RULES}}` in BOTH `CLAUDE.md` and `AGENTS.md`. A hard rule is a named,
imperative law with specifics, not a vague guideline.

The rules below are written against the brain backend chosen in Phase 0.5. Replace
`{{BRAIN_NAME}}` (for example "KDB doc.tecotec.top" or "Obsidian vault"),
`{{BRAIN_ROOT}}` (the collection branch URL or the vault folder path), and
`{{BRAIN_READ_TOOL}}` (for example `fetch` / `list_collection_documents`, or
`mcp__obsidian__vault_read`) before writing.

Defaults to always propose: R1, R2, R3, R4, R7. Propose R6 only when there is a Git
repo. R5 whenever there is a live runtime or DB. R9, R10, R11 whenever the backend is
a shared knowledge base. Always invite custom rules (R8).

---

## R1 - Read the brain before doing real work

**Why:** the single biggest cause of rớt não is starting work without loading prior
context. This forces a re-entry read every session.

```md
## Hard rule: read the brain before doing real work

Canonical documentation for this project lives in {{BRAIN_NAME}} at `{{BRAIN_ROOT}}`.
Before touching code, data, or deliverables, read at least the re-entry page and
`00 - Project Overview`. Use `{{BRAIN_READ_TOOL}}` rather than guessing at paths or
URLs. If that backend is unreachable, read `docs/AGENT_BOOTSTRAP.md` and tell the user
before doing any context-dependent work.
```

## R2 - Update the brain after every completed unit of work

**Why:** this write-back loop is the part that actually prevents rớt não. Init without
it goes stale and starts misleading. This is the 80%.

```md
## Hard rule: update the brain after every completed unit of work

When you finish a unit of work (a feature, refactor, fix, migration, deliverable, or
decision), open the relevant document under `{{BRAIN_ROOT}}` and record what changed,
new decisions and their reasons, and any new gotcha or verification recipe. Update the
status block or frontmatter date. If the change is large, create a new numbered
document and link it from the re-entry page.
```

## R3 - One canonical brain

**Why:** prevents parallel versions, the exact failure mode this skill exists to stop.

```md
## Hard rule: one canonical brain

{{BRAIN_NAME}} is canonical for this project. The repo `docs/` folder is not canonical
memory: keep it to pointers and narrow technical references. Do not save project state
to the AI memory system. {{SECONDARY_BRAIN_CLAUSE}} When two sources disagree, the
canonical one wins and the other is corrected immediately rather than left to drift.
```

If a second backend is in play, `{{SECONDARY_BRAIN_CLAUSE}}` states it explicitly and
names the one-way sync direction, for example: "The Obsidian vault is a personal
drafting layer only; content flows from Obsidian into the KDB and never back."

## R4 - Implementation plans live in the brain

**Why:** plans are context, not code; they belong with the brain, dated and findable.

```md
## Hard rule: implementation plans live in the brain

All implementation, architecture, and phase plans go under `{{BRAIN_ROOT}}` in an
`Implementation Plans` container, named `YYYY-MM-DD - Short Topic`. The repo may hold
brief pointers only. If the brain is unreachable, record a temporary dated fallback in
`docs/AGENT_BOOTSTRAP.md`, tell the user, and sync it into the brain as soon as the
backend is available.
```

## R5 - Keep paths and runtime state consistent

**Why:** avoids acting on the wrong folder, branch, container, or data volume.

```md
## Hard rule: keep paths and runtime state consistent

Code path: `{{CODE_PATH}}`. Repo: `{{REPO_URL}}`. Prefer `git status` / `git diff` /
`git log` for current code state. {{RUNTIME_SPECIFICS}} Verify the active runtime or DB
mount before destructive operations.
```

## R6 - Tag and changelog on every git push (Git only)

**Why:** every deployed state stays traceable to a published release.

```md
## Hard rule: tag and changelog on every git push

Never `git push` without cutting a release first: add a dated `## X.Y.Z - <topic>`
section to `CHANGELOG.md` (semver), commit it with the work, create an annotated tag
`git tag -a vX.Y.Z`, push with `git push --follow-tags`, then publish a GitHub Release
from the tag. No push without a matching CHANGELOG entry, tag, and published release.
```

## R7 - Verify before you say done

**Why:** stops "done" claims that are not actually verified.

```md
## Hard rule: verify before you say done

Before claiming done: confirm the change matches the request; run the appropriate
verification (typecheck/build/test, Playwright, browser check, or a metric); confirm
the brain was updated or state why not.
```

## R8 - Custom rules

Capture any project-specific hard rule the user states, verbatim, in the same
`## Hard rule: <name>` format. Examples that often come up: language and formatting
constraints (full Vietnamese diacritics, no em dash), review gates before publishing,
brand-approval steps, data-privacy handling.

## R9 - Respect the permission zones of the knowledge base

**Why:** in a shared KDB, the collection you write into decides who can read it. A
misplaced budget or a share link on the wrong branch cannot be undone by editing.

```md
## Hard rule: respect the permission zones of the knowledge base

Before creating any document, decide its zone, not just its topic. Money, proposals to
leadership, HR, and candid commentary about people go to the restricted collection,
even when they belong to a project documented elsewhere. Public share links are enabled
only in the designated external-sharing collection, never on a branch, because sharing
cascades to every child document. Creating through the API does not apply restrictive
permissions automatically: after writing anything sensitive, tell the user to verify
the permission in the UI. If a write to the correct collection fails, stop and say so;
never fall back to a different collection.
```

## R10 - The knowledge base holds knowledge, not operational state

**Why:** copied task state goes stale within days and then actively misleads, which is
worse than an empty page.

```md
## Hard rule: the knowledge base holds knowledge, not operational state

Tasks, progress percentages, deadlines, and assignees live in the operational system
({{OPS_SYSTEM}}). Do not mirror them into the knowledge base; link to the source
instead. The knowledge base carries purpose, decisions, gotchas, and documents with
long-term value.
```

## R11 - Decisions are append-only, and the brain stays readable

**Why:** an overwritten decision destroys the reason trail, and the next session
re-litigates a question that was already settled. But append-only with no size limit
ends in a re-entry page nobody reads, which fails the same way for the opposite reason.
Both halves belong in one rule so neither is applied without the other.

```md
## Hard rule: decisions are append-only, and the brain stays readable

Never edit or delete a recorded decision. To reverse one, add a new dated decision that
states what it supersedes and why, and link back to the original. Decision documents
are named `Quyết định: <việc> (YYYY-MM-DD)`.

Keep the brain bounded as it grows. The re-entry page stays inside one screen: status,
the single next action, the active plan, and links out. When the decision log passes
about 20 entries, move it into its own document, split into "còn hiệu lực" and "lịch
sử", and leave a link behind. Do the same for gotchas when they outgrow their section.
Moving content into a linked document is not deleting it; overwriting it is.
```
