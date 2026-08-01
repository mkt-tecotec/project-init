# Changelog

Định dạng theo semver. Mỗi lần push lên `main` phải có một mục ở đây kèm tag và release,
đúng luật cứng R6 mà chính skill này đi áp cho các dự án khác.

## 0.3.0 - Chuyển kỷ luật write-back từ văn xuôi sang cơ chế

Bối cảnh: rà lại bản 0.2.0 thấy chẩn đoán đúng nhưng phần enforcement hỏng. Toàn bộ vòng
write-back, đúng cái skill tự nhận là 80% giá trị, được cài bằng lời dặn và phụ thuộc
việc ai đó nhớ gõ `/project-checkpoint`. Bằng chứng: bản cài local trễ 5 commit mà không
có gì báo; các nhánh marketing trong KDB (GIS 2026, TSTY-100, Hermes, Tri ân 27.7) không
có điểm tái nhập nào, tức là đúng nhóm người dùng chính thì skill chưa từng chạm tới; tìm
tiếng Việt "tổng quan dự án" không ra bất kỳ tài liệu `00 - Project Overview` nào;
`list_templates` trả về rỗng nên bước "reuse an existing template" là nhánh chết.

Thêm:

- **Phát hiện stale.** Mục "Staleness signal" trong `brain-backends.md`: Outline dùng
  `list_documents(collectionId)` để lấy `updatedAt`, `updatedBy.name`, `revision`;
  Obsidian dùng frontmatter; repo dùng `git log -1`. Ghi rõ bẫy
  `list_collection_documents` không trả timestamp và `lastViewedAt` không phải tín hiệu
  sửa. Phase 0 của cả hai skill bắt buộc đọc và nói ra tín hiệu này trước khi tin bộ não.
  Kèm cảnh báo `revision` tăng cả khi người khác sửa lỗi chính tả, nên delta khác 0 không
  đồng nghĩa có việc thực chất.
- **Phase 7 cold-start test** trong `project-init`: mở phiên mới, chỉ đưa điểm tái nhập,
  hỏi "việc tiếp theo là gì và tại sao". Đây là tiêu chí nghiệm thu, thay cho việc chỉ
  kiểm tra hình thức.
- **Plugin cho Claude Code**: `.claude-plugin/marketplace.json`, `plugin/`, và
  `hooks/hooks.json` với `SessionStart` (nạp điểm tái nhập), `PreCompact` (giữ trạng thái
  qua lần nén), `Stop` kiểu prompt (chặn đóng phiên khi có delta chưa ghi). Script
  `brain-status.sh` im lặng hoàn toàn ở thư mục không có khối Brain backend.
- `templates/settings.json.template` đặt `autoMemoryEnabled: false`, vì auto memory bật
  mặc định sẽ tự tích một kho state song song ở `~/.claude/projects/<project>/memory/`,
  đúng loại parallel store mà R3 cấm nhưng không chặn được bằng lời.
- Dấu phiên bản trong cả hai `SKILL.md`, để người dùng Cowork biết bản mình đang chạy.

Đổi:

- **Một nguồn luật.** `AGENTS.md` giữ luật cứng, `CLAUDE.md` rút còn dòng `@AGENTS.md`
  cộng phần riêng của Claude Code. Bỏ yêu cầu giữ hai file mirror-identical: hai bản luật
  phải đồng bộ bằng tay chính là lỗi parallel versions mà skill này đi cấm.
- **Khối Trạng thái chuẩn hoá một dạng** trong cả template Outline lẫn Obsidian, gồm
  Trạng thái, Owner, Cập nhật lần cuối, Revision khi checkpoint, Tình trạng, Việc tiếp
  theo, Kế hoạch đang chạy, và dòng nghi thức chạy checkpoint khi đóng phiên. Trước đó
  PC17 dùng dòng inline còn tecotec.tech dùng bảng, hai kiểu cho cùng một việc.
- **Findability tiếng Việt.** Điểm tái nhập bắt buộc chứa "điểm tái nhập", "trạng thái
  hiện tại", "việc tiếp theo" có dấu, và Phase 5 kiểm tra điều đó. PC17 tìm được chỉ vì
  body có cụm tiếng Việt; tecotec.tech không tìm được vì dòng tương ứng viết tiếng Anh.
- **Nhánh template chết.** Phase 3 tách hai đường: có `templateId` thì dùng, rỗng thì
  `fetch` bản nháp trong `~Template` và truyền body qua `text`, bắt buộc bỏ H1 đầu tiên vì
  `Tổng quan dự án` mở đầu bằng `# [Tên dự án]`.
- **R11** thành "decisions are append-only, and the brain stays readable": thêm ngưỡng
  tách log quyết định ở khoảng 20 mục và giới hạn điểm tái nhập trong một màn hình.
  Append-only không có ngưỡng thì sau vài tháng không ai đọc nữa.
- **Trigger của project-checkpoint** bắt thêm những câu nói tự nhiên khi xong việc: "xong
  rồi", "chốt lại", "bàn giao", "mai làm tiếp"... Trên Cowork không có hook nên đây là thứ
  gần nhất với một cơ chế tự kích hoạt.
- **Cấu trúc repo** chuyển sang layout plugin: skill nằm ở `plugin/skills/<tên>/`. Cách
  cài cũ bằng `git clone` vào `~/.claude/skills/` không còn dùng; `INSTALL.md` viết lại
  theo hai bề mặt, Cowork tải ZIP còn Claude Code cài qua marketplace và tự cập nhật.

Còn nợ, cố ý để ngoài phạm vi bản này:

- Đổi title `00 - Project Overview` và `03 - Implementation Status` sang tiếng Việt cho
  các nhánh đang có (mới chỉ chữa cho tài liệu tạo mới, chưa di trú bản cũ).
- Templatize 13 bản nháp trong `~Template` để `list_templates` hoạt động thật.
- Gộp hai bản PC17 đang song song ở collection 40 và 60, hiện không link với nhau.
- `permission: null` cấp gì cho thành viên không phải admin, chưa xác định được vì phiên
  khảo sát chạy bằng quyền admin.

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
