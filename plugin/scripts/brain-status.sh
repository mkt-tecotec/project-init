#!/bin/sh
# Nạp con trỏ tới bộ não dự án vào context lúc mở phiên và trước khi nén.
# Im lặng hoàn toàn ở thư mục không dùng convention này, để không làm phiền dự án khác.
set -u

event="${1:-SessionStart}"
root="$(pwd)"
rules=""

for f in AGENTS.md CLAUDE.md docs/AGENT_BOOTSTRAP.md; do
  if [ -f "$root/$f" ] && grep -q "Brain backend" "$root/$f" 2>/dev/null; then
    rules="$root/$f"
    break
  fi
done

# Không có khối Brain backend thì đây không phải dự án có bộ não. Thoát im lặng.
[ -z "$rules" ] && exit 0

echo "## Bộ não dự án ($event)"
echo
echo "Trích khối Brain backend từ $(basename "$rules"):"
echo
awk '/^## Brain backend/{f=1; next} f && /^## /{exit} f' "$rules"
echo
echo "Trước khi làm việc thật: đọc điểm tái nhập ở trên, rồi nói ra tín hiệu stale (bộ não cập nhật lần cuối bao giờ, ai sửa)."
echo "Xong một đơn vị công việc hoặc kết thúc phiên: chạy /project-checkpoint."

if command -v git >/dev/null 2>&1 && git -C "$root" rev-parse --git-dir >/dev/null 2>&1; then
  last="$(git -C "$root" log -1 --format=%cd --date=short 2>/dev/null || true)"
  if [ -n "$last" ]; then
    echo
    echo "Commit gần nhất của repo: $last. Đối chiếu với ngày cập nhật của bộ não để biết bộ não có đang trễ so với code không."
  fi
fi

exit 0
