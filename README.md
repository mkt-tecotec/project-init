# project-init

Bộ skill cho Claude Code / Cowork giúp dự án làm việc với AI không bị rớt não qua các
phiên. Dẫn xuất từ convention thực chiến của `mkt-tecotec/marcom-workspace` (fibery-clone):
CLAUDE.md + AGENTS.md mang các luật cứng, Obsidian vault là source of truth.

Repo chứa hai skill bổ trợ nhau:

- **project-init** (thư mục gốc): chạy đầu tiên khi mở dự án mới. Phỏng vấn mục đích +
  luật cứng, scaffold CLAUDE.md + AGENTS.md + repo docs, dựng vault brain, rồi sang
  implementation plan. Đây là 20%: dựng não.
- **project-checkpoint** (`project-checkpoint/`): chạy cuối mỗi phiên hoặc sau mỗi đơn vị
  công việc. Ép vòng write-back: cập nhật vault (status, quyết định, gotcha, next action),
  bump frontmatter, xuất handoff cho phiên sau. Đây là 80%: giữ não sống.

## Vấn đề: rớt não

Context sống trong chat: cửa sổ đầy thì bị nén, phiên mới thì trắng bảng, quyết định nói
miệng không ghi ra file nên AI về sau tự mâu thuẫn. Chat là RAM, file là ổ cứng. Cách
chữa không phải "thêm nhiều thư mục" mà là ba thứ đi cùng nhau: một điểm tái nhập, các
file context bền, và kỷ luật write-back sau mỗi đơn vị công việc. project-init dựng hai
thứ đầu, project-checkpoint giữ thứ ba.

## Cài đặt

Claude Code (cả hai skill), symlink để checkpoint được nhận diện như skill riêng và
`git pull` cập nhật cả hai:

```bash
git clone https://github.com/mkt-tecotec/project-init.git ~/.claude/skills/project-init
ln -s ~/.claude/skills/project-init/project-checkpoint ~/.claude/skills/project-checkpoint
```

Gọi `/project-init` khi mở dự án, `/project-checkpoint` khi đóng phiên. Cowork: thêm từng
skill qua Settings > Capabilities.

## Cấu trúc

```text
project-init/                (repo root = skill project-init)
├── SKILL.md
├── INSTALL.md
├── README.md
├── references/
│   └── hard-rules-library.md
├── templates/
│   ├── CLAUDE.md.template
│   ├── AGENTS.md.template
│   ├── AGENT_BOOTSTRAP.md.template
│   ├── vault-README.md.template
│   ├── vault-00-overview.md.template
│   └── vault-implementation-plan.md.template
└── project-checkpoint/      (skill project-checkpoint)
    ├── SKILL.md
    └── references/
        └── checkpoint-checklist.md
```

## Nguyên tắc cốt lõi

Vault là source of truth, không mirror vào repo, không lưu state dự án vào memory của AI.
Integrate chứ không tạo parallel versions. Scaffold tối thiểu, không empty-folder
graveyard. CLAUDE.md và AGENTS.md mirror luật cứng cho đa agent. Idempotent: phát hiện
brain cũ thì update, không đè. Luôn có một điểm tái nhập cho phiên nguội.
