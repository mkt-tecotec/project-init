# project-init - cài đặt

Skill khởi tạo "não" cho dự án mới để không bị rớt não qua các phiên làm việc. Chạy đầu
tiên khi mở một dự án mới (code hoặc MarCom): phát hiện backend nào dùng được rồi hỏi
chọn, phỏng vấn mục đích và luật cứng, scaffold `AGENTS.md` + repo docs, dựng bộ não dự
án, rồi mới sang implementation plan.

Chọn đúng một mục bên dưới theo thứ anh/chị đang dùng.

## Nếu dùng Cowork (đa số team MarCom)

1. Vào [Releases](https://github.com/mkt-tecotec/project-init/releases), tải hai file
   ZIP của bản mới nhất: `project-init.zip` và `project-checkpoint.zip`.
2. Trong Claude: **Customize > Skills > upload**, tải lần lượt cả hai.
3. Gõ `/` ở thanh bên để thấy skill, hoặc gọi thẳng `/project-init`.

**Cowork không tự cập nhật skill.** Mỗi lần repo ra bản mới là phải tải ZIP mới và
upload đè. Để biết mình đang chạy bản nào, skill nói ra số phiên bản ở dòng đầu khi
chạy; đối chiếu với số bản mới nhất ở trang Releases.

Không cần biết git, không cần cài gì thêm.

## Nếu dùng Claude Code (team kỹ thuật)

```bash
/plugin marketplace add mkt-tecotec/project-init
/plugin install project-brain@mkt-tecotec
```

Cài một lần, sau đó **tự cập nhật** khi repo có bản mới, không phải `git pull` tay. Đây
là điểm khác quan trọng nhất so với Cowork.

Bản plugin gồm cả hook, thứ Cowork không có:

| Hook | Làm gì |
|------|--------|
| `SessionStart` | Nạp khối Brain backend và điểm tái nhập vào context ngay khi mở phiên |
| `PreCompact` | Giữ trạng thái và việc tiếp theo qua lần nén context |
| `Stop` | Nhắc chạy checkpoint khi có việc đã làm mà chưa write-back |

Hook chỉ chạy ở thư mục có `AGENTS.md` chứa khối `## Brain backend`. Ở dự án khác nó im
lặng hoàn toàn, không làm phiền.

`Stop` được viết theo hướng **mặc định cho đóng phiên**, chỉ giữ lại khi có bằng chứng rõ
là có việc chưa ghi, và phân vân thì cho qua. Muốn thoát ngay thì nói "bỏ qua checkpoint".
Chọn như vậy có chủ đích: một cái gate chặn nhầm ở cuối phiên còn khó chịu hơn một lần
quên checkpoint, và nó sẽ khiến người ta gỡ luôn plugin.

Trong Claude Code, skill của plugin gọi theo dạng `/project-brain:project-init` và
`/project-brain:project-checkpoint`. Trên Cowork vẫn là `/project-init` và
`/project-checkpoint`.

## Cách chạy

Gọi `/project-init`, hoặc nói "khởi tạo dự án" trong thư mục dự án. Skill hỏi lại từng
bước trước khi ghi bất cứ thứ gì.

Đóng phiên thì gọi `/project-checkpoint`. Bỏ bước này thì phần init trước đó mất tác dụng
sau vài tuần: bộ não cũ đi và bắt đầu nói sai, còn tệ hơn không có.

## Chuẩn bị trước khi chạy

Skill sẽ tự dò nhưng nên kết nối sẵn:

- **Outline MCP** trỏ tới `doc.tecotec.top` nếu dự án cần người khác đọc được.
- **Obsidian MCP** nếu anh/chị có vault riêng và muốn dùng làm lớp nháp.
- **Fibery MCP** nếu muốn link tới project/task đang có.

Không có cái nào cũng chạy được, skill sẽ rơi về phương án repo-only và nói rõ đó là
phương án yếu nhất.

**Quyền ghi:** nếu chọn KDB, phải có quyền ghi vào collection đích. Không có thì skill
dừng và báo ai cấp được, chứ không tự ghi sang chỗ khác.

## Sửa skill

Sửa trên GitHub, không sửa bản cache local (bản cache bị ghi đè khi cập nhật). Mọi thay
đổi đi qua pull request để cả team thấy được đã đổi gì. Mỗi lần lên `main` phải có mục
trong `CHANGELOG.md`, tag, và release kèm ZIP mới cho người dùng Cowork, đúng luật cứng
R6 mà chính skill này đi áp cho dự án khác.

Phòng ban ngoài MarCom: thay `plugin/skills/project-init/references/tecotec-kdb.md` bằng
bản đồ knowledge base của mình, giữ nguyên các file còn lại.
