---
name: project-init
description: >-
  Bootstrap a new project's AI "brain" so context is never lost across sessions
  (chống "rớt não"). Run this FIRST when starting any new project folder, whether
  software or marketing/work. It interviews the user for the project's purpose and
  hard rules, scaffolds CLAUDE.md + AGENTS.md + repo docs, sets up an Obsidian vault
  project brain as the single source of truth, then hands off to implementation
  planning. Triggers: "start a new project", "khởi tạo dự án", "bootstrap project",
  "init project", "project-init", "tạo cấu trúc dự án", "chạy skill đầu tiên".
---

# project-init

Bootstrap the durable context ("brain") for a new project so any future AI session
picks up exactly where the last one left off, instead of drifting or contradicting
past decisions ("rớt não").

## The problem this solves

Rớt não happens because context lives in chat: the window fills up and gets
compacted, a new session starts blank, and decisions made verbally are never written
down, so the agent later contradicts them. Chat is RAM; files are disk. The fix is
not "more folders." It is three things working together:

1. A single canonical **re-entry point** a cold session reads first.
2. Durable **context files** that hold purpose, scope, decisions, and status.
3. A **write-back discipline** that keeps those files current after every unit of work.

This skill reproduces a proven convention (CLAUDE.md + AGENTS.md carrying named
"hard rules", with an Obsidian vault as the source of truth) for any new project.

## When to use

At the very start of a new project folder, before writing code or producing
deliverables. Also when adopting an existing folder that has no CLAUDE.md / brain yet.

## When NOT to use

Do not run on a project that already has a maintained CLAUDE.md + vault brain (switch
to update mode, see Phase 0). Do not use it to generate a decorative folder tree; a
tree with empty directories does not prevent rớt não and is explicitly discouraged.

## Core principles (non-negotiable)

- **Vault is the source of truth.** Project memory lives in Obsidian. Do not mirror
  vault notes into the repo, and do not save project state to the AI memory system.
- **Integrate, don't duplicate.** Reuse existing vault stakeholder notes, brand
  playbooks, and Fibery data. Never create a fifth parallel context store. Parallel
  versions are the failure mode, not the goal.
- **Minimum viable scaffold.** No empty-folder graveyards. Create only files that
  will actually be maintained. Expand later when the project earns it.
- **Cross-agent parity.** CLAUDE.md and AGENTS.md carry the SAME hard rules, phrased
  for Claude Code and for generic agents (Codex and others). They must stay in sync.
- **Idempotent.** Detect existing artifacts; never clobber; offer to update instead.
- **One re-entry point.** Every project gets a "start here" so a cold session knows
  its current state and next action.

## Phase 0 - Preflight

1. Establish the project folder (current working directory, or ask).
2. Detect existing `CLAUDE.md`, `AGENTS.md`, `docs/AGENT_BOOTSTRAP.md`, and the vault
   folder `20 - MarCom/Projects/<name>/`. If any exist, switch to **update mode**:
   read them, summarize the current state back to the user, and ask what to change.
   Do not overwrite a maintained brain.
3. Load the user's global conventions and vault frontmatter rules if available.

## Phase 1 - Interview (ask, do not assume)

Ask concisely in the user's language. Use the interactive question tool when
available; group related questions; keep to about five rounds. Offer smart defaults
so the user can confirm fast rather than answer everything from scratch.

- **Q1 Purpose.** One-liner (what it does). Project type: code app / marketing
  campaign / event / content / research / automation / other. Why it exists. Expected
  outcome and definition of done.
- **Q2 Identity.** Folder path. Is there a Git repo (URL, branch model)? Vault project
  name (default = folder name). Primary hierarchy if any (e.g. Project to Work Package
  to Task).
- **Q3 Hard rules.** Walk the menu in `references/hard-rules-library.md`. For each
  rule the user includes, edits, or skips. Always propose: read-vault-first,
  write-back-after-work, plans-in-obsidian, verify-before-done. Propose
  tag+changelog-on-push only when there is a Git repo. Capture any custom hard rules
  verbatim. This is the step the user explicitly wants: confirm each hard rule one by
  one.
- **Q4 Obsidian brain.** Create the vault project folder and notes? Default note set:
  `README` (index), `00 - Project Overview`, `03 - Implementation Status`. Add
  `01 - Product Model` or other domain notes only if warranted. Ask what supplementary
  context to capture now, then pull it: link existing `[[Stakeholder]]` notes, point to
  the correct brand playbook (per `has_playbook`), and pull the Fibery project/tasks if
  the connector is available.
- **Q5 Tier and confirm.** Prototype vs production. Then show the exact list of files
  and folders that will be created and get explicit confirmation before writing.

## Phase 2 - Scaffold the repo / work folder

Choose the tier from the project type. Do not create irrelevant directories.

- **Code project.** `CLAUDE.md`, `AGENTS.md`, `README.md`, `docs/AGENT_BOOTSTRAP.md`,
  `.env.example`, `.gitignore`, and `CHANGELOG.md` (only if Git). Add stack-specific
  folders only when the chosen stack needs them; never invent technologies.
- **Marketing / work project.** `CLAUDE.md` (or a single `AGENTS.md`), `README.md`,
  and only the working folders the project will actually fill: `brief/`, `references/`,
  `drafts/`, `assets/`, `deliverables/`. Skip any folder that would sit empty.

Fill `CLAUDE.md` and `AGENTS.md` from `templates/`, injecting the selected hard rules
**verbatim into both**. The two files must be mirror-identical in their rule set.

## Phase 3 - Scaffold the Obsidian brain (source of truth)

Under `20 - MarCom/Projects/<name>/` create `README.md` and `00 - Project Overview.md`
(plus `03 - Implementation Status.md` for code projects) from the vault templates.
Frontmatter must include: `type`, `tags`, `status`, `owner`, `working_dir`, `updated`,
`last_synced`. Use `[[wikilinks]]` only for real relationships (stakeholders, related
projects); plain mentions stay as text. Create the `Implementation Plans/` subfolder.
Set the README "Start here" line and an active-plan marker.

Formatting rules for all generated Vietnamese content: full diacritics, and never use
the em dash character.

## Phase 4 - Wire the re-entry and write-back loop

- Hard rule #1 in CLAUDE.md/AGENTS.md points to the exact vault notes to read first.
- `docs/AGENT_BOOTSTRAP.md` is the portable fallback: repo-only facts to use when the
  Obsidian MCP is unavailable. It is a fallback, not a second source of truth.
- Ensure the write-back hard rule and a "before you say done" checklist are present.
  This loop is what actually prevents rớt não. Do not omit it. The init is roughly 20%
  of the value; this maintenance loop is the other 80%.

## Phase 5 - Guardrails check before finishing bootstrap

- No parallel versions: repo docs are pointers, the vault holds the canonical content.
- CLAUDE.md and AGENTS.md rule sets are identical.
- Frontmatter is valid; Vietnamese has full diacritics; no em dash anywhere.
- The re-entry point exists and states the real current state and next action.

## Phase 6 - Hand off to implementation planning

Only after the brain exists. Create the first plan at
`20 - MarCom/Projects/<name>/Implementation Plans/YYYY-MM-DD - <topic>.md` from
`templates/vault-implementation-plan.md.template`, mark it active in the README, then
run the planning conversation (goal, phases, dependencies, risks, verification). The
plan lives in Obsidian, never as a standalone plan file in the repo.

## Placeholder convention

Templates use `{{DOUBLE_BRACE}}` placeholders. Replace every one before writing:
`{{PROJECT_NAME}}`, `{{ONE_LINER}}`, `{{PROJECT_TYPE}}`, `{{WHY}}`, `{{OUTCOME}}`,
`{{CODE_PATH}}`, `{{REPO_URL}}`, `{{BRANCH_MODEL}}`, `{{HIERARCHY}}`, `{{VAULT_PATH}}`,
`{{HARD_RULES}}`, `{{OPERATIONAL_DEFAULTS}}`, `{{OWNER}}`, `{{TODAY}}`,
`{{STAKEHOLDERS}}`, `{{PLAYBOOK}}`, `{{TAGS}}`.

## Files in this skill

- `templates/CLAUDE.md.template` - Claude Code project instructions.
- `templates/AGENTS.md.template` - mirror for generic agents.
- `templates/AGENT_BOOTSTRAP.md.template` - portable repo-only fallback.
- `templates/vault-README.md.template` - vault project index / re-entry point.
- `templates/vault-00-overview.md.template` - the project overview note.
- `templates/vault-implementation-plan.md.template` - dated implementation plan.
- `references/hard-rules-library.md` - the menu of reusable hard rules.
