# project-init - cài đặt

Skill khởi tạo "não" cho dự án mới để không bị rớt não qua các phiên làm việc. Chạy đầu
tiên khi mở một thư mục dự án mới (code hoặc MarCom): phỏng vấn mục đích + luật cứng,
scaffold CLAUDE.md + AGENTS.md + repo docs, dựng vault brain làm source of truth, rồi mới
sang implementation plan.

## Cách chạy

Kích hoạt bằng `/project-init`, hoặc nói "khởi tạo dự án" / "bootstrap project" trong thư
mục dự án. Skill sẽ hỏi lại từng bước trước khi ghi file.

## Cài như Claude Code skill (khuyến nghị, dùng được cho mọi dự án)

Copy nguyên thư mục `project-init/` vào:

```text
~/.claude/skills/project-init/
```

Dùng cho một dự án cụ thể thì đặt tại `<dự-án>/.claude/skills/project-init/`. Mở lại
Claude Code để nạp skill. Yêu cầu: có `SKILL.md` ở gốc thư mục skill.

## Cài như Cowork skill

Dùng nút "Save skill" trên file `project-init.skill`, hoặc thêm qua Settings >
Capabilities. Không thể cắm nóng trong phiên đang chạy; skill có hiệu lực ở phiên sau.

## Nguồn chuẩn

Nên commit skill này vào repo skills của `mkt-tecotec` để đồng bộ như các skill khác
(content, martech, mkt-planner...). Sửa ở GitHub, không sửa bản cache local.

## Cấu trúc

```text
project-init/
├── SKILL.md
├── INSTALL.md
├── templates/
│   ├── CLAUDE.md.template
│   ├── AGENTS.md.template
│   ├── AGENT_BOOTSTRAP.md.template
│   ├── vault-README.md.template
│   ├── vault-00-overview.md.template
│   └── vault-implementation-plan.md.template
└── references/
    └── hard-rules-library.md
```
