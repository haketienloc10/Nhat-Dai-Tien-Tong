# ADR 0001 — Pin Godot 4.7.2 cho bootstrap

## Trạng thái

Accepted.

## Bối cảnh

Repository được phát triển theo workflow agent-first và cần cùng một runtime giữa máy dev, child agent và CI. Dựa riêng vào executable `godot` có sẵn trong `PATH` làm verification phụ thuộc môi trường và khó tái lập.

## Quyết định

- Runtime chuẩn của bootstrap là Godot `4.7.2-stable` standard build, GDScript.
- `scripts/install-godot.sh` cài official Linux binary vào `.tools/godot/godot` và kiểm tra SHA-256.
- `scripts/verify.sh` ưu tiên `GODOT_BIN`, sau đó local pinned binary, rồi mới fallback `godot4`/`godot` trong `PATH`.
- `.tools/` không được commit.

## Hệ quả

- Verification trên Linux có thể tự bootstrap mà không cần cài Godot system-wide.
- Upgrade Godot trở thành thay đổi có chủ ý: cập nhật version, checksum, docs và chạy full verification trước khi chấp nhận.
- Installer hiện chỉ hỗ trợ Linux x86_64 và arm64; platform khác phải dùng executable riêng qua `GODOT_BIN` hoặc mở rộng installer sau.
