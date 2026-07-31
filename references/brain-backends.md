# Brain backends

A project brain has five roles. Which tool holds them is a per-project choice, not a
constant. Never assume a backend: detect what is reachable, then ask.

| Role | What it holds |
|------|---------------|
| Brain root | The container for everything about this project |
| Re-entry point | The one page a cold session reads first: status, next action, active plan |
| Overview | Purpose, scope, stakeholders, decision log |
| Status | Current implementation state |
| Plans | Dated implementation plans |

## Supported backends

### A. Outline KDB (team-shared)

MCP tools: `list_collections`, `list_collection_documents`, `list_documents`,
`fetch`, `create_document`, `update_document`, `list_templates`, `move_document`.
Brain root is a top-level document (a "nhánh") inside a collection; child documents
nest under it, three levels maximum.

Pick this when anyone other than the user must be able to read the project, or when
the user has no Obsidian. For TECOTEC, read `references/tecotec-kdb.md` in full
before writing anything: the collection you write into decides who can see it.

### B. Obsidian vault (personal)

MCP tools: `mcp__obsidian__vault_read`, `vault_write`, `vault_list`, `search_query`.
Brain root is a folder; notes are files with YAML frontmatter and `[[wikilinks]]`.

A personal vault is invisible to teammates. Never pick it as the canonical brain for
work someone else may need to pick up. It is legitimate as a fast private drafting
layer, see "When two backends are in play".

### C. Repo-only (fallback)

Brain root is `docs/` in the repo, re-entry is `docs/AGENT_BOOTSTRAP.md`. Use only
when neither A nor B is reachable, or the project is a private code repo with no team
documentation need. Say plainly that this is the weakest option and why.

## Detect, then ask

1. **Detect.** Try in order: Outline (`list_collections`), Obsidian (`vault_list`),
   repo `docs/`. Record which actually responded. A tool being listed is not proof it
   works; an unauthenticated MCP server fails only when called.
2. **Report** what you found in one line. Do not silently pick a winner.
3. **Ask** which backend is canonical for THIS project. Offer only the detected
   options, with a recommendation and a one-clause trade-off each: Outline means
   teammates can read it; Obsidian means fast and private but only you can read it;
   repo-only means portable but weakest.
4. **Record** the answer in the "Brain backend" block of `CLAUDE.md` and `AGENTS.md`
   and inside hard rule R1. Once written, the choice is not re-litigated every
   session. Changing it later is a decision to log, not a preference to drift on.

## When two backends are in play

Exactly one is canonical. The other is a derived working layer, the sync direction is
one way only, and both facts go into the hard rules.

The common TECOTEC shape: the owner drafts fast in Obsidian, the KDB is canonical,
drafts flow Obsidian to Outline and never back. A checkpoint is not complete until the
canonical side matches reality.

Two canonical brains is the parallel-versions failure this skill exists to prevent. If
the user asks for both to be canonical, say plainly that the two copies will diverge
within weeks and make them choose one.

## Technical differences that break a naive port

| | Outline | Obsidian |
|---|---------|----------|
| YAML frontmatter | Not supported, renders as literal text. Use a "Trạng thái" block at the top of the body instead. | Required by convention: `type`, `tags`, `status`, `owner`, `updated`, `last_synced` |
| Internal links | Full URL `https://doc.../doc/<slug>` | `[[wikilinks]]` |
| People | `@[Tên](mention://user/<userId>)`, resolve ids with `list_users` | A `[[Stakeholder]]` note |
| Title | A separate field. The body must NOT start with an H1. | The filename, or the leading `# H1` |
| Address | Document id or urlId, never a path | Filesystem path |
| Ordering | `01 - `, `02 - ` prefixes inside the title | Filename prefixes |
| Permissions | Per collection, real and enforced | None, the whole vault is one trust zone |
| Drafts | Unpublished drafts exist and are invisible to others | No such concept |

Porting a note from Obsidian to Outline: lift the frontmatter into a status block,
convert wikilinks to URLs or plain text, drop the leading H1 into the title field, and
re-check which collection the content is allowed to live in. That last step is not
cosmetic, see the permission zones in `references/tecotec-kdb.md`.
