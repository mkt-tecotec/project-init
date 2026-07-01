# project-init

Skill cho Claude Code / Cowork: khởi tạo "não" cho dự án mới để không bị rớt não qua các
phiên làm việc với AI. Dẫn xuất từ convention thực chiến của
`mkt-tecotec/marcom-workspace` (fibery-clone): CLAUDE.md + AGENTS.md mang các luật cứng,
Obsidian vault là source of truth.

## Vấn đề: rớt não

Context sống trong chat: cửa sổ đầy thì bị nén, phiên mới thì trắng bảng, quyết định nói
miệng không ghi ra file nên AI về sau tự mâu thuẫn. Chat là RAM, file là ổ cứng. Cách
chữa không phải "thêm nhiều thư mục" mà là ba thứ đi cùng nhau: một điểm tái nhập, các
file context bền, và kỷ luật write-back sau mỗi đơn vị công việc.

## Skill làm gì

Chạy đầu tiên khi mở một dự án mới. Sáu phase: phỏng vấn mục đích, duyệt từng luật cứng,
dựng brain trong Obsidian, scaffold CLAUDE.md + AGENTS.md + repo docs, nối vòng
re-entry/write-back, rồi mới sang implementation plan.

## Cài đặt

Claude Code: copy nội dung repo vào `~/.claude/skills/project-init/`, gọi `/project-init`.
Cowork: dùng nút "Save skill" trên bản đóng gói `.skill`, hoặc Settings > Capabilities.
Chi tiết trong `INSTALL.md`.

## Cấu trúc

```text
project-init/
├── SKILL.md
├── INSTALL.md
├── README.md
├── references/
│   └── hard-rules-library.md
└── templates/
    ├── CLAUDE.md.template
    ├── AGENTS.md.template
    ├── AGENT_BOOTSTRAP.md.template
    ├── vault-README.md.template
    ├── vault-00-overview.md.template
    └── vault-implementation-plan.md.template
```

## Nguyên tắc cốt lõi

Vault là source of truth, không mirror vào repo, không lưu state dự án vào memory của AI.
Integrate chứ không tạo parallel versions. Scaffold tối thiểu, không empty-folder
graveyard. CLAUDE.md và AGENTS.md mirror luật cứng cho đa agent. Idempotent: phát hiện
brain cũ thì update, không đè. Luôn có một điểm tái nhập cho phiên nguội.
