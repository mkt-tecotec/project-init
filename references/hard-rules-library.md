# Hard rules library

A menu of reusable "hard rules" to offer during Phase 1 (Q3). Present each one, let the
user include / edit / skip, then inject the chosen blocks verbatim into `{{HARD_RULES}}`
in BOTH `CLAUDE.md` and `AGENTS.md`. A hard rule is a named, imperative law with
specifics, not a vague guideline.

Defaults to always propose: R1, R2, R3, R4, R7. Propose R6 only when there is a Git
repo. R5 whenever there is a live runtime or DB. Always invite custom rules (R8).

---

## R1 - Read the vault before doing real work

**Why:** the single biggest cause of rớt não is starting work without loading prior
context. This forces a re-entry read every session.

```md
## Hard rule: read the vault before doing real work

Canonical documentation lives in the Obsidian vault at `{{VAULT_PATH}}`. Before touching
code, data, or deliverables, read at least `README.md` and `00 - Project Overview.md`.
Prefer `mcp__obsidian__vault_read` over guessing paths. If Obsidian is unavailable, read
`docs/AGENT_BOOTSTRAP.md` and tell the user before doing context-dependent work.
```

## R2 - Update the vault after every completed unit of work

**Why:** this write-back loop is the part that actually prevents rớt não. Init without
it goes stale and starts misleading. This is the 80%.

```md
## Hard rule: update the vault after every completed unit of work

When you finish a unit of work (a feature, refactor, fix, migration, deliverable, or
decision), open the relevant note under `{{VAULT_PATH}}` and record what changed, new
decisions and their reasons, and any new gotcha or verification recipe. Bump the
`updated:` frontmatter to today. If the change is large, create a new numbered note and
link it from `README.md`.
```

## R3 - Vault is the source of truth

**Why:** prevents parallel versions, the exact failure the user's own rules forbid.

```md
## Hard rule: vault is the source of truth

The repo `docs/` folder is not canonical memory. Do not mirror vault notes into the
repo; keep repo docs as pointers or narrow technical references only. Do not save
project state to the AI memory system. When two sources disagree, the vault wins; fix
the other immediately rather than letting both live.
```

## R4 - Implementation plans live in Obsidian

**Why:** plans are context, not code; they belong with the brain, dated and findable.

```md
## Hard rule: implementation plans live in Obsidian

All implementation, architecture, and phase plans go to `{{VAULT_PATH}}/Implementation
Plans/`, named `YYYY-MM-DD - Short Topic.md`. The repo may hold brief pointers only. If
Obsidian is down, record a temporary dated fallback in `docs/AGENT_BOOTSTRAP.md`, tell
the user, and sync into Obsidian as soon as the vault is available.
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
verification (typecheck/build/test, Playwright, browser check, or a metric); confirm the
vault was updated or state why not.
```

## R8 - Custom rules

Capture any project-specific hard rule the user states, verbatim, in the same
`## Hard rule: <name>` format. Examples that often come up: language and formatting
constraints (full Vietnamese diacritics, no em dash), review gates before publishing,
brand-approval steps, data-privacy handling.
