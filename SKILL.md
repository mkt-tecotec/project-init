---
name: project-init
description: >-
  Bootstrap a new project's AI "brain" so context is never lost across sessions
  (chống "rớt não"). Run this FIRST when starting any new project folder, whether
  software or marketing/work. It detects which knowledge backend is reachable (the
  team KDB on Outline at doc.tecotec.top, a personal Obsidian vault, or the repo
  alone), asks which one is canonical, interviews the user for purpose and hard
  rules, scaffolds CLAUDE.md + AGENTS.md + repo docs, creates the project brain in
  the chosen backend, then hands off to implementation planning. Triggers: "start a
  new project", "khởi tạo dự án", "bootstrap project", "init project",
  "project-init", "tạo cấu trúc dự án", "chạy skill đầu tiên".
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
2. Durable **context documents** holding purpose, scope, decisions, and status.
3. A **write-back discipline** that keeps those documents current after every unit of
   work.

## Who runs this

Anyone at TECOTEC, not only the skill's author. That has consequences the skill must
honour: the person running it may have no Obsidian, may have read-only access to parts
of the knowledge base, and may be working in Cowork with no Git repo at all. Never
assume the author's setup. Detect, ask, and degrade honestly.

## When to use

At the very start of a new project folder or a new project branch in the knowledge
base, before writing code or producing deliverables. Also when adopting an existing
folder that has no brain yet.

## When NOT to use

Do not run on a project that already has a maintained brain (switch to update mode,
see Phase 0). Do not use it to generate a decorative folder tree or a set of empty
placeholder documents; neither prevents rớt não and both are explicitly discouraged.

## Core principles (non-negotiable)

- **One canonical brain, chosen deliberately.** The backend is a per-project decision
  made in Phase 0.5 and written into the hard rules, never an assumption.
- **Integrate, don't duplicate.** Reuse existing stakeholder documents, brand
  playbooks, KDB templates, and Fibery data. Never create a fifth parallel context
  store. Parallel versions are the failure mode, not the goal.
- **Permission before placement.** In a shared knowledge base, where a document lives
  decides who can read it. Decide the zone before creating anything.
- **Minimum viable scaffold.** No empty-folder graveyards, no placeholder documents.
  Create only what will actually be maintained.
- **Cross-agent parity.** CLAUDE.md and AGENTS.md carry the SAME hard rules, phrased
  for Claude Code and for generic agents. They must stay in sync.
- **Idempotent.** Detect existing artifacts; never clobber; offer to update instead.
- **One re-entry point.** Every project gets a "start here" so a cold session knows
  its current state and next action.

## Phase 0 - Preflight

1. Establish the project folder (current working directory, or ask). A project with no
   local folder at all is valid: a pure knowledge-base project skips the repo scaffold.
2. Detect existing `CLAUDE.md`, `AGENTS.md`, `docs/AGENT_BOOTSTRAP.md`, and any
   existing project branch in the knowledge base or vault. If any exist, switch to
   **update mode**: read them, summarize the current state back to the user, and ask
   what to change. Do not overwrite a maintained brain.
3. Load the user's global conventions if available.

## Phase 0.5 - Detect the backend, then ask which is canonical

Read `references/brain-backends.md` and follow it. In short:

1. Probe each backend by actually calling it: Outline (`list_collections`), Obsidian
   (`vault_list`), repo `docs/`. A tool appearing in the tool list is not proof it is
   authenticated.
2. Report in one line what responded.
3. Ask which backend is canonical for this project, offering only what responded, with
   a recommendation and a one-clause trade-off each.
4. If a second backend will also be used, establish which is canonical and the one-way
   sync direction now, and put both into hard rule R3. Two canonical brains is not an
   option; say so plainly if requested.

If the chosen backend is the TECOTEC KDB, read `references/tecotec-kdb.md` before
writing anything to it.

## Phase 1 - Interview (ask, do not assume)

Ask concisely in the user's language. Use the interactive question tool when
available; group related questions; keep to about five rounds. Offer smart defaults so
the user can confirm fast rather than answer everything from scratch.

- **Q0 Who is running this.** Department or team, and whether they have write access
  to the target collection or folder. Verify the write access rather than trusting the
  answer: a failed write halfway through a scaffold leaves a half-built brain. If they
  lack access, stop and name who can grant it.
- **Q1 Purpose.** One-liner (what it does). Project type: code app / marketing
  campaign / event / content / research / automation / software product / other. Why it
  exists. Expected outcome and definition of done.
- **Q2 Identity and placement.** Folder path. Is there a Git repo (URL, branch model)?
  Project name. For a knowledge-base backend: which collection the branch belongs in
  (use the routing table in `references/tecotec-kdb.md`) and whether any part of this
  project will involve budget, a proposal to leadership, or HR content, because that
  part must be placed in the restricted collection separately from day one.
- **Q3 Hard rules.** Walk the menu in `references/hard-rules-library.md`. For each
  rule the user includes, edits, or skips. Always propose R1, R2, R3, R4, R7. Propose
  R6 only when there is a Git repo. Propose R9, R10, R11 whenever the backend is a
  shared knowledge base. Capture any custom hard rules verbatim. Confirm each hard rule
  one by one.
- **Q4 Brain content.** Confirm the document set to create. Default: re-entry page,
  `00 - Project Overview`, and `03 - Implementation Status` for build projects. Add
  domain documents only if warranted. Ask what supplementary context to pull now: link
  existing stakeholder documents, point to the correct brand playbook, and link the
  Fibery project or tasks if the connector is available. Link, do not copy.
- **Q5 Tier and confirm.** Prototype vs production. Then show the exact list of files
  and documents that will be created, with their destination collection or folder, and
  get explicit confirmation before writing.

## Phase 2 - Scaffold the repo / work folder

Choose the tier from the project type. Do not create irrelevant directories. Skip this
phase entirely for a pure knowledge-base project with no local folder.

- **Code project.** `CLAUDE.md`, `AGENTS.md`, `README.md`, `docs/AGENT_BOOTSTRAP.md`,
  `.env.example`, `.gitignore`, and `CHANGELOG.md` (only if Git). Add stack-specific
  folders only when the chosen stack needs them; never invent technologies.
- **Marketing / work project.** `CLAUDE.md` (or a single `AGENTS.md`), `README.md`,
  and only the working folders the project will actually fill: `brief/`, `references/`,
  `drafts/`, `assets/`, `deliverables/`. Skip any folder that would sit empty.

Fill `CLAUDE.md` and `AGENTS.md` from `templates/`, injecting the selected hard rules
**verbatim into both**, plus the Brain backend block from Phase 0.5. The two files must
be mirror-identical in their rule set.

## Phase 3 - Scaffold the brain (source of truth)

### If the backend is the Outline KDB

Call `list_templates` first and reuse an existing template rather than inventing a
structure. Create the branch in the collection chosen in Q2:

```text
<Tên dự án>                       parent document, the re-entry point
├── 00 - Project Overview
├── 03 - Implementation Status     (build projects only)
└── Implementation Plans
```

Use `templates/kdb-*.template`. No YAML frontmatter: put the status block at the top
of the body instead. The body must not start with an H1, because the title is a
separate field. Links are full URLs; people are `@[Tên](mention://user/<id>)`. If the
project has budget or leadership-proposal content, create that document separately in
the restricted collection and tell the user to verify its permission in the UI.

### If the backend is an Obsidian vault

Under the vault project folder create the README re-entry note and
`00 - Project Overview.md` (plus `03 - Implementation Status.md` for build projects)
from `templates/vault-*.template`. Frontmatter must include `type`, `tags`, `status`,
`owner`, `working_dir`, `updated`, `last_synced`. Use `[[wikilinks]]` only for real
relationships; plain mentions stay as text. Create the `Implementation Plans/`
subfolder.

### Either way

Set the re-entry "Start here" line, the current status, the single next action, and an
active-plan marker. Formatting for all generated Vietnamese content: full diacritics,
and never the em dash character.

## Phase 4 - Wire the re-entry and write-back loop

- Hard rule R1 in CLAUDE.md and AGENTS.md points to the exact document or note to read
  first, by URL or path.
- `docs/AGENT_BOOTSTRAP.md` is the portable fallback: repo-only facts to use when the
  brain backend is unavailable. It is a fallback, not a second source of truth.
- Ensure the write-back hard rule and a "before you say done" checklist are present.
  This loop is what actually prevents rớt não. Do not omit it. The init is roughly 20%
  of the value; this maintenance loop is the other 80%.
- Tell the user that `project-checkpoint` is what runs the loop, and when to call it.

## Phase 5 - Guardrails check before finishing bootstrap

- No parallel versions: repo docs are pointers, the canonical brain holds the content.
- CLAUDE.md and AGENTS.md rule sets are identical.
- Every document was created in the collection or folder the user confirmed in Q5.
  Nothing sensitive landed in a team-wide collection. No share link was enabled outside
  the designated external-sharing collection.
- No operational state (task lists, percentages, deadlines) was copied into the brain.
- Outline documents carry no YAML frontmatter and no leading H1. Vault notes carry
  valid frontmatter.
- Vietnamese has full diacritics; no em dash anywhere.
- The re-entry point exists and states the real current state and next action.

## Phase 6 - Hand off to implementation planning

Only after the brain exists. Create the first plan under the project's
`Implementation Plans` container, named `YYYY-MM-DD - <topic>`, from
`templates/kdb-implementation-plan.md.template` or
`templates/vault-implementation-plan.md.template` depending on the backend. Mark it
active on the re-entry page, then run the planning conversation (goal, phases,
dependencies, risks, verification). The plan lives in the brain, never as a standalone
plan file in the repo.

## Placeholder convention

Templates use `{{DOUBLE_BRACE}}` placeholders. Replace every one before writing:
`{{PROJECT_NAME}}`, `{{ONE_LINER}}`, `{{PROJECT_TYPE}}`, `{{WHY}}`, `{{OUTCOME}}`,
`{{CODE_PATH}}`, `{{REPO_URL}}`, `{{BRANCH_MODEL}}`, `{{HIERARCHY}}`,
`{{BRAIN_NAME}}`, `{{BRAIN_ROOT}}`, `{{BRAIN_READ_TOOL}}`,
`{{SECONDARY_BRAIN_CLAUSE}}`, `{{OPS_SYSTEM}}`, `{{HARD_RULES}}`,
`{{OPERATIONAL_DEFAULTS}}`, `{{OWNER}}`, `{{TODAY}}`, `{{STAKEHOLDERS}}`,
`{{PLAYBOOK}}`, `{{TAGS}}`.

## Files in this skill

- `references/brain-backends.md` - detect the backend, ask which is canonical, and the
  Outline vs Obsidian differences that break a naive port.
- `references/tecotec-kdb.md` - the TECOTEC KDB preset: collection map, permission
  zones, routing, naming. Another department swaps this one file.
- `references/hard-rules-library.md` - the menu of reusable hard rules.
- `templates/CLAUDE.md.template` - Claude Code project instructions.
- `templates/AGENTS.md.template` - mirror for generic agents.
- `templates/AGENT_BOOTSTRAP.md.template` - portable repo-only fallback.
- `templates/kdb-*.template` - Outline documents (no frontmatter, no leading H1).
- `templates/vault-*.template` - Obsidian notes (frontmatter, wikilinks).
