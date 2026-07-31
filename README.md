# project-init

Bộ skill cho Claude Code / Cowork giúp dự án làm việc với AI không bị rớt não qua các
phiên. Dẫn xuất từ convention thực chiến của `mkt-tecotec/marcom-workspace`:
CLAUDE.md + AGENTS.md mang các luật cứng, một bộ não duy nhất làm source of truth.

Repo chứa hai skill bổ trợ nhau:

- **project-init** (thư mục gốc): chạy đầu tiên khi mở dự án mới. Phát hiện backend
  nào dùng được rồi hỏi chọn, phỏng vấn mục đích và luật cứng, scaffold CLAUDE.md +
  AGENTS.md + repo docs, dựng bộ não dự án, rồi sang implementation plan. Đây là 20%:
  dựng não.
- **project-checkpoint** (`project-checkpoint/`): chạy cuối mỗi phiên hoặc sau mỗi đơn vị
  công việc. Ép vòng write-back: cập nhật bộ não (status, quyết định, gotcha, next
  action), xuất handoff cho phiên sau. Đây là 80%: giữ não sống.

## Vấn đề: rớt não

Context sống trong chat: cửa sổ đầy thì bị nén, phiên mới thì trắng bảng, quyết định nói
miệng không ghi ra file nên AI về sau tự mâu thuẫn. Chat là RAM, file là ổ cứng. Cách
chữa không phải "thêm nhiều thư mục" mà là ba thứ đi cùng nhau: một điểm tái nhập, các
tài liệu context bền, và kỷ luật write-back sau mỗi đơn vị công việc. project-init dựng
hai thứ đầu, project-checkpoint giữ thứ ba.

## Bộ não đặt ở đâu: skill hỏi, không tự quyết

Skill hỗ trợ ba backend và **bắt chọn có ý thức cho từng dự án**, không mặc định ngầm:

| Backend | Khi nào chọn | Đánh đổi |
|---------|--------------|-----------|
| KDB Outline (doc.tecotec.top) | Có người khác cần đọc dự án | Phải tuân 3 vùng quyền, chậm hơn Obsidian |
| Obsidian vault | Không gian làm việc riêng của một người | Đồng nghiệp không đọc được, không dùng làm canonical cho việc chung |
| Repo `docs/` | Không với được hai cái trên | Yếu nhất, không search được toàn công ty |

Dùng cả hai cũng được, nhưng **chỉ một cái là canonical** và chiều đồng bộ là một chiều,
ghi thẳng vào luật cứng. Hai bộ não cùng canonical chính là lỗi parallel versions mà
skill này sinh ra để chặn.

## Dùng ngoài phòng MarCom

Phần riêng của TECOTEC MarCom nằm gọn trong một file: `references/tecotec-kdb.md`
(bản đồ collection, ba vùng quyền, quy ước đặt tên, ranh giới KDB với Fibery). Phòng
ban có knowledge base khác chỉ cần thay file đó, phần còn lại giữ nguyên.

Lưu ý về quyền: skill kiểm tra quyền ghi trước khi scaffold. Ghi hỏng thì dừng và báo,
không tự chuyển sang collection khác, vì chỗ chuyển sang thường là chỗ nội dung không
được phép nằm.

## Cài đặt

Claude Code (cả hai skill), symlink để checkpoint được nhận diện như skill riêng và
`git pull` cập nhật cả hai:

```bash
git clone https://github.com/mkt-tecotec/project-init.git ~/.claude/skills/project-init
ln -s ~/.claude/skills/project-init/project-checkpoint ~/.claude/skills/project-checkpoint
```

Gọi `/project-init` khi mở dự án, `/project-checkpoint` khi đóng phiên.

Cowork (không cần biết git): xem `INSTALL.md`.

## Cấu trúc

```text
project-init/                (repo root = skill project-init)
├── SKILL.md
├── INSTALL.md
├── README.md
├── CHANGELOG.md
├── references/
│   ├── brain-backends.md        (lõi generic: detect + hỏi chọn backend)
│   ├── tecotec-kdb.md           (preset TECOTEC, thay file này khi dùng nơi khác)
│   └── hard-rules-library.md
├── templates/
│   ├── CLAUDE.md.template
│   ├── AGENTS.md.template
│   ├── AGENT_BOOTSTRAP.md.template
│   ├── kdb-README.md.template
│   ├── kdb-00-overview.md.template
│   ├── kdb-implementation-plan.md.template
│   ├── vault-README.md.template
│   ├── vault-00-overview.md.template
│   └── vault-implementation-plan.md.template
└── project-checkpoint/      (skill project-checkpoint)
    ├── SKILL.md
    └── references/
        └── checkpoint-checklist.md
```

## Nguyên tắc cốt lõi

Một bộ não canonical, chọn có ý thức từng dự án và ghi vào luật cứng. Integrate chứ
không tạo parallel versions. Trong knowledge base dùng chung, quyền quyết định chỗ đặt,
không phải chủ đề. KDB giữ kiến thức, Fibery giữ số liệu vận hành, không copy qua
lại. Scaffold tối thiểu, không empty-folder graveyard. CLAUDE.md và AGENTS.md mirror
luật cứng cho đa agent. Idempotent: phát hiện não cũ thì update, không đè. Luôn có một
điểm tái nhập cho phiên nguội.
