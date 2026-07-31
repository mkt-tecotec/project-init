# Changelog

Định dạng theo semver. Mỗi lần push lên `main` phải có một mục ở đây kèm tag và release,
đúng luật cứng R6 mà chính skill này đi áp cho các dự án khác.

## 0.2.0 - Multi-backend brain và tách preset TECOTEC

Bối cảnh: KDB `doc.tecotec.top` (Outline) đã chạy thật với 9 collection và 3 vùng
quyền, và skill này được share cho team MarCom lẫn phòng ban khác. Bản cũ hardcode
Obsidian vault làm source of truth nên vừa không chạy được cho người không có Obsidian,
vừa không biết gì về vùng quyền nên có thể đặt tài liệu ngân sách vào collection cả
team đọc được.

Thêm:

- `references/brain-backends.md`: tách khái niệm "bộ não" khỏi công cụ. Quy trình detect
  bằng cách gọi thật rồi hỏi user chọn backend canonical cho từng dự án. Bảng khác biệt
  kỹ thuật Outline vs Obsidian: frontmatter, wikilink, title, quyền, draft.
- `references/tecotec-kdb.md`: bản đồ 9 collection kèm id, 3 vùng quyền, luật định
  tuyến 40/60/90/50, quy ước đặt tên, vòng đời tài liệu, ranh giới KDB với Fibery.
- `templates/kdb-README.md.template`, `kdb-00-overview.md.template`,
  `kdb-implementation-plan.md.template`: bản cho Outline, không YAML frontmatter,
  không H1 đầu body.
- Luật cứng R9 (vùng quyền), R10 (KDB giữ kiến thức, Fibery giữ số liệu vận hành),
  R11 (quyết định append-only).
- `CHANGELOG.md` (file này).

Đổi:

- `SKILL.md`: thêm Phase 0.5 detect và chọn backend; thêm Q0 hỏi phòng ban và kiểm tra
  quyền ghi trước khi scaffold; Q2 hỏi luôn dự án có phần ngân sách / tờ trình không để
  tách sang 90 ngay từ đầu; Phase 3 tách nhánh theo backend; Phase 5 thêm guardrail
  kiểm tra quyền và định dạng Outline. Thêm mục "Who runs this".
- `references/hard-rules-library.md`: R1-R4 chuyển sang placeholder `{{BRAIN_*}}` thay
  vì nói thẳng Obsidian. R3 đổi tên thành "One canonical brain" và thêm mệnh đề khai
  báo backend phụ kèm chiều đồng bộ một chiều.
- `project-checkpoint/SKILL.md` và checklist: write-back theo backend canonical ghi
  trong CLAUDE.md; thêm permission gate; bỏ giả định frontmatter Obsidian.
- `templates/CLAUDE.md.template`, `AGENTS.md.template`, `AGENT_BOOTSTRAP.md.template`:
  thay khối "Canonical memory lives in Obsidian" bằng khối "Brain backend" có tham số.
- `README.md`, `INSTALL.md`: thêm bảng chọn backend, hướng dẫn cho phòng ban ngoài
  MarCom, cài qua Cowork cho người không dùng git.

Cần verify khi áp vào dự án thật đầu tiên:

- Ranh giới collection 40 với 60 cho dự án xây phần mềm được suy ra từ mô tả collection,
  chưa được chủ KDB xác nhận.
- Danh sách template trong `tecotec-kdb.md` lấy từ doc "Cách dùng KDB này"; nên gọi
  `list_templates` để đối chiếu trước khi tin.

## 0.1.0 - Bản đầu

Hai skill `project-init` và `project-checkpoint`, mặc định Obsidian vault làm source of
truth. Không có tag cho bản này.
