# project-init - cài đặt

Skill khởi tạo "não" cho dự án mới để không bị rớt não qua các phiên làm việc. Chạy đầu
tiên khi mở một dự án mới (code hoặc MarCom): phát hiện backend nào dùng được rồi hỏi
chọn, phỏng vấn mục đích và luật cứng, scaffold CLAUDE.md + AGENTS.md + repo docs, dựng
bộ não dự án, rồi mới sang implementation plan.

## Cách chạy

Kích hoạt bằng `/project-init`, hoặc nói "khởi tạo dự án" trong thư mục dự án. Skill sẽ
hỏi lại từng bước trước khi ghi bất cứ thứ gì.

Đóng phiên thì gọi `/project-checkpoint`. Bỏ bước này thì phần init trước đó mất tác
dụng sau vài tuần.

## Chuẩn bị trước khi chạy

Skill sẽ tự dò nhưng nên kết nối sẵn:

- **Outline MCP** trỏ tới `doc.tecotec.top` nếu dự án cần người khác đọc được.
- **Obsidian MCP** nếu anh/chị có vault riêng và muốn dùng làm lớp nháp.
- **Fibery MCP** nếu muốn link tới project/task đang có.

Không có cái nào cũng chạy được, skill sẽ rơi về phương án repo-only và nói rõ đó là
phương án yếu nhất.

**Quyền ghi:** nếu chọn KDB, phải có quyền ghi vào collection đích. Không có thì skill
dừng và báo ai cấp được, chứ không tự ghi sang chỗ khác.

## Cài như Claude Code skill

```bash
git clone https://github.com/mkt-tecotec/project-init.git ~/.claude/skills/project-init
ln -s ~/.claude/skills/project-init/project-checkpoint ~/.claude/skills/project-checkpoint
```

Dùng cho một dự án cụ thể thì đặt tại `<dự-án>/.claude/skills/project-init/`. Mở lại
Claude Code để nạp skill. Yêu cầu: có `SKILL.md` ở gốc thư mục skill.

## Cài như Cowork skill (không cần biết git)

Tải file `.skill` từ tab Releases của repo rồi bấm "Save skill", hoặc thêm qua
Settings > Capabilities. Không cắm nóng được trong phiên đang chạy; skill có hiệu lực
ở phiên sau.

Hai skill là hai file riêng, cần thêm cả hai.

## Sửa skill

Sửa trên GitHub, không sửa bản cache local (bản cache bị ghi đè khi cập nhật). Mọi
thay đổi đi qua pull request để cả team thấy được đã đổi gì.

Phòng ban ngoài MarCom: thay `references/tecotec-kdb.md` bằng bản đồ knowledge base của
mình, giữ nguyên các file còn lại.
