# project-init

Bộ skill cho Claude Code / Cowork giúp dự án làm việc với AI không bị rớt não qua các
phiên. Dẫn xuất từ convention thực chiến của `mkt-tecotec/marcom-workspace`, với một thay
đổi: luật cứng nằm ở đúng một file `AGENTS.md` thay vì hai bản phải giữ giống nhau bằng
tay. Một bộ não duy nhất làm source of truth.

Repo chứa hai skill bổ trợ nhau:

- **project-init**: chạy đầu tiên khi mở dự án mới. Phát hiện backend nào dùng được rồi
  hỏi chọn, phỏng vấn mục đích và luật cứng, scaffold `AGENTS.md` + repo docs, dựng bộ
  não dự án, rồi sang implementation plan. Đây là 20%: dựng não.
- **project-checkpoint**: chạy cuối mỗi phiên hoặc sau mỗi đơn vị công việc. Ép vòng
  write-back: cập nhật bộ não (status, quyết định, gotcha, next action), xuất handoff cho
  phiên sau. Đây là 80%: giữ não sống.

## Vấn đề: rớt não

Context sống trong chat: cửa sổ đầy thì bị nén, phiên mới thì trắng bảng, quyết định nói
miệng không ghi ra file nên AI về sau tự mâu thuẫn. Chat là RAM, file là ổ cứng. Cách
chữa không phải "thêm nhiều thư mục" mà là ba thứ đi cùng nhau: một điểm tái nhập, các
tài liệu context bền, và kỷ luật write-back sau mỗi đơn vị công việc. project-init dựng
hai thứ đầu, project-checkpoint giữ thứ ba.

## Kỷ luật đặt ở đâu để không phụ thuộc trí nhớ

Vòng write-back mà phải nhớ mới chạy thì sẽ hỏng đúng lúc cần nhất. Nên nó được đặt ở ba
chỗ chạy được trên cả Cowork lẫn Claude Code:

1. **Trong skill.** Đọc tín hiệu stale và chạy cold-start test là bước bắt buộc trong
   SKILL.md, không phải lời khuyên.
2. **Trong chính tài liệu.** Điểm tái nhập mang sẵn khối Trạng thái và dòng nghi thức
   "kết thúc phiên thì chạy `/project-checkpoint`". Trên Cowork, tài liệu chính là cái hook.
3. **Trong trigger của skill.** `description` của project-checkpoint bắt cả những câu nói
   tự nhiên khi xong việc ("xong rồi", "chốt lại", "mai làm tiếp").

Riêng Claude Code có thêm một lớp cứng: hook `SessionStart` nạp điểm tái nhập vào context
lúc mở phiên, hook `Stop` chặn đóng phiên khi có delta chưa ghi, hook `PreCompact` giữ
trạng thái qua lần nén. Cowork không có hook, nên đó là lớp bổ sung chứ không phải nền
móng.

## Nghiệm thu: cold-start test

Guardrail hình thức (frontmatter, đủ dấu, đặt đúng collection) không chứng minh được bộ
não hoạt động. Phép thử chứng minh được là:

> Mở một phiên mới không biết gì về cuộc trò chuyện trước. Đưa cho nó đúng một thứ: trang
> điểm tái nhập. Hỏi: **"việc tiếp theo là gì, và tại sao lại là nó?"**

Trả lời cụ thể và khớp thực tế thì bộ não đạt. Trả lời mơ hồ hoặc phải đoán thì bộ não
hỏng, dù mọi checklist đều xanh. Đây là tiêu chí nghiệm thu của cả bộ skill.

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

Phần riêng của TECOTEC MarCom nằm gọn trong một file:
`plugin/skills/project-init/references/tecotec-kdb.md` (bản đồ collection, ba vùng quyền,
quy ước đặt tên, ranh giới KDB với Fibery). Phòng ban có knowledge base khác chỉ cần thay
file đó, phần còn lại giữ nguyên.

Lưu ý về quyền: skill kiểm tra quyền ghi trước khi scaffold. Ghi hỏng thì dừng và báo,
không tự chuyển sang collection khác, vì chỗ chuyển sang thường là chỗ nội dung không
được phép nằm.

## Cài đặt

Chi tiết từng bề mặt nằm trong `INSTALL.md`. Tóm tắt:

Claude Code, cài một lần rồi tự cập nhật:

```bash
/plugin marketplace add mkt-tecotec/project-init
/plugin install project-brain@mkt-tecotec
```

Cowork: tải ZIP ở
[Releases](https://github.com/mkt-tecotec/project-init/releases), rồi Customize > Skills
> upload. Cowork không tự cập nhật, mỗi bản mới phải tải lại.

## Cấu trúc

```text
project-init/                        (repo = marketplace mkt-tecotec)
├── .claude-plugin/
│   └── marketplace.json
├── plugin/                          (plugin project-brain)
│   ├── .claude-plugin/plugin.json
│   ├── hooks/hooks.json             (SessionStart, PreCompact, Stop)
│   ├── scripts/brain-status.sh
│   └── skills/
│       ├── project-init/
│       │   ├── SKILL.md
│       │   ├── references/
│       │   │   ├── brain-backends.md    (detect + hỏi chọn backend + tín hiệu stale)
│       │   │   ├── tecotec-kdb.md       (preset TECOTEC, thay file này khi dùng nơi khác)
│       │   │   └── hard-rules-library.md
│       │   └── templates/
│       │       ├── AGENTS.md.template        (nguồn duy nhất của luật cứng)
│       │       ├── CLAUDE.md.template        (chỉ @AGENTS.md + phần riêng Claude Code)
│       │       ├── AGENT_BOOTSTRAP.md.template
│       │       ├── settings.json.template
│       │       ├── kdb-*.template
│       │       └── vault-*.template
│       └── project-checkpoint/
│           ├── SKILL.md
│           └── references/checkpoint-checklist.md
├── README.md
├── INSTALL.md
└── CHANGELOG.md
```

## Nguyên tắc cốt lõi

Một bộ não canonical, chọn có ý thức từng dự án và ghi vào luật cứng. Integrate chứ không
tạo parallel versions. Trong knowledge base dùng chung, quyền quyết định chỗ đặt, không
phải chủ đề. KDB giữ kiến thức, Fibery giữ số liệu vận hành, không copy qua lại. Scaffold
tối thiểu, không empty-folder graveyard. Luật cứng nằm ở đúng một file `AGENTS.md`,
`CLAUDE.md` chỉ import nó. Idempotent: phát hiện não cũ thì update, không đè. Đọc tín
hiệu stale trước khi tin bộ não. Luôn có một điểm tái nhập cho phiên nguội, và nó phải
qua được cold-start test.
