# TECOTEC KDB preset (Outline at doc.tecotec.top)

The MarCom knowledge base. Read this before creating or moving any document there.
This file is the only TECOTEC-specific part of the skill: a department with a
different knowledge base replaces this file and keeps everything else.

## Boundary: what belongs here and what does not

The KDB holds knowledge, decisions, and project documents with long-term value.
Operational numbers (tasks, progress, deadlines, assignees) live in **Fibery MarCom**.
Do not copy task state into the KDB: it goes stale and then misleads. Link to Fibery
instead.

## Collection map

| Collection | Id | Holds |
|-----------|-----|-------|
| 00 Bắt đầu | `5f8b82ab-fc10-452f-8df7-566b6fac9e14` | How to use the KDB, naming conventions, quick links |
| 10 Thương hiệu & Công ty | `fa58eb41-9b45-4d00-a946-ab8d889486b3` | Brands and org: TECOTEC Group, OES, TUMIKI, Cleveland Cyclewerks, TACKE, TMK, HSNL. Filtered stakeholder profiles only |
| 20 Quy trình & Best Practices | `a77039ae-c80b-4fc8-8336-6def0f3dd6f0` | SOPs shared across brands: SEO, Analytics, Design, WordPress, Email, internal tools |
| 30 Quyết định & Bài học | `b871d95a-8f48-419f-a0f2-cf5b92dd1dc0` | Decision log and post-campaign lessons. Append-only |
| 40 Dự án | `2c07dd26-698a-4e37-a1bb-c1aab1dce3e1` | One branch per running project or campaign. Archive the branch when it ends |
| 50 Chia sẻ ngoài | `ac3c5a7c-6ead-4c86-bf09-927179cc8611` | The ONLY place public share links are enabled, for agencies and partners |
| 60 Sản phẩm phần mềm | `72f1d0a0-574a-4b1f-8121-e51391e4c66c` | Software product specs (PC-17, VAAS, 3Di, Digital Twin). Never archived per project |
| 90 Nội bộ hẹp | `07d80287-afd2-46f1-8fa9-5814ea939540` | Budget, proposals to leadership, HR, candid stakeholder notes. BLĐ only |
| A30 Kỷ niệm 30 năm | `ec8e5b5a-22fc-44c1-9dab-a002c2b3fed5` | The 30th anniversary programme (1996-2026) |
| ~Template | `f543b651-89f5-4634-9509-72414d20f18a` | Draft templates before they are templatized |

Ids are stable but verify with `list_collections` if a write fails.

## Permission zones (the rule that matters most)

Three zones, boundaries follow collections. Writing to the wrong one exposes
information to the wrong people, and no later edit undoes that.

| Zone | Collections | Who sees it |
|------|-------------|-------------|
| Team-wide, the default | 00, 10, 20, 30, 40, 60, A30 | Every workspace member |
| Nội bộ hẹp | 90 | BLĐ and individually granted people |
| Chia sẻ ngoài | 50 | Team plus agencies and partners via public link |

Hard consequences for an agent scaffolding a project:

1. **Money, proposals to leadership, and HR always go to 90**, even when they belong
   to a project living in 40. Project documents stay in 40; the budget or proposal
   file is created separately in 90, named with the project name. Never create a
   budget document inside a 40 branch "for convenience".
2. **Public share links are enabled only in 50.** Sharing cascades to every child
   document, so one share on a 40 branch exposes the whole branch. Never enable
   sharing outside 50, not even temporarily.
3. **Candid commentary about people or departments goes to 90.** Only the filtered,
   factual version belongs in 10.
4. Sharing a single document with someone adds access, it never hides that document
   from people who can already see the collection. If something needs restricted
   access, move it to 90 rather than fiddling with per-document sharing.
5. Creating a document through the API does **not** inherit restrictive permissions
   automatically. After creating anything in 90, tell the user to verify the
   permission in the UI. Do not claim it is private because it sits in 90.

## Routing a new project

| Project kind | Brain root goes to |
|--------------|--------------------|
| Campaign, event, or marketing project | 40, a new branch |
| Software product specification | 60, a product branch that is never archived |
| A build project for a software product | 40 for the project branch, 60 for the product spec. Link the two, do not duplicate |
| Anything under the 30th anniversary programme | A30 |
| Budget or leadership proposal for any of the above | 90, always, as a separate document |

The split between 40 and 60 for software work is inferred from the collection
descriptions. Confirm it with the KDB owner the first time it comes up on a real
project rather than assuming.

## Standard shape of a project branch in 40

This mirrors the convention already in use (Fibery Clone MarCom, tecotec.tech, PC17):

```text
<Tên dự án>                       parent document, the re-entry point
├── 00 - Project Overview
├── 03 - Implementation Status
└── Implementation Plans
    └── YYYY-MM-DD - <Chủ đề>
```

Add numbered documents (`01 - `, `02 - `, ...) only when the project actually needs
them. Empty placeholder documents are the KDB version of an empty-folder graveyard.

## Naming conventions

- Project branch root: the project name, for example `TriAn-277-2026`, `GIS2026`.
- Child documents: numbered prefix `01 - `, `02 - ` to hold their order.
- Decisions in 30: `Quyết định: <việc> (YYYY-MM-DD)`.
- Budget and proposals in 90: `Dự trù ngân sách <dự án>`, `Tờ trình: <việc>`.
- Meeting recaps: `Recap <chủ đề> (YYYY-MM-DD)`.

## Document lifecycle

- Draft stays unpublished until it is worth reading; then publish.
- Project ends: archive the whole branch. It stays searchable.
- Decisions are append-only. Never edit a past decision. To reverse one, create a new
  decision document and link back to the old one.

## Use the existing templates

Call `list_templates` before inventing a document structure. The KDB already has
templates for: Tổng quan dự án, Kế hoạch sự kiện, Kế hoạch truyền thông chiến dịch,
Recap họp, Quyết định, Báo cáo sau chiến dịch, Quy trình / SOP, Outline bài SEO,
Creative brief cho agency, Tờ trình BLĐ, Dự trù ngân sách, Hồ sơ stakeholder, Kịch
bản chương trình. Pass the matching `templateId` to `create_document` instead of
writing a parallel structure.

## Writing rules specific to Outline

- The body must not begin with an H1. The title is a separate field.
- No YAML frontmatter. Put a short status block at the top of the body instead.
- Links are full URLs. People are `@[Tên](mention://user/<userId>)`, resolved through
  `list_users`.
- Full Vietnamese diacritics. Never the em dash character.

## Check write access before promising anything

Access differs per person and per collection. Before scaffolding, confirm the user can
actually write to the target collection. If the write fails, say so and stop; do not
silently fall back to another collection, because the fallback is usually a place the
content should not be.
