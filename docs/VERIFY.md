# Verification

Tài liệu này là source of truth cho cách bootstrap và xác minh repository. Chỉ ghi command đã được kiểm tra từ code, manifest, CI hoặc lần chạy thực tế.

## Prerequisites

- Runtime chuẩn của project: **Godot 4.7.2 stable**.
- Ngôn ngữ: GDScript, không cần .NET build.
- Dependency ngoài cho repo check: `git`, `rg` (ripgrep), Bash.
- Dependency ngoài cho local Godot installer: `unzip`, `sha256sum`, và `curl` hoặc `wget`.
- `GODOT_BIN` là tùy chọn. Nếu đặt, `scripts/verify.sh` ưu tiên executable đó.

## Bootstrap

Cách khuyến nghị trên Linux là cài Godot vào `.tools/` của repo để máy dev/agent/CI dùng cùng một version:

```bash
bash scripts/install-godot.sh
```

Script tải official Godot `4.7.2-stable`, xác minh SHA-256 rồi cài executable tại:

```text
.tools/godot/godot
```

`.tools/` không được commit.

Nếu máy đã có Godot 4 trong `PATH`, `scripts/verify.sh` tự dò lần lượt `godot4` rồi `godot`. Có thể override trực tiếp:

```bash
GODOT_BIN=/absolute/path/to/godot bash scripts/verify.sh
```

Kiểm tra version local đã pin:

```bash
.tools/godot/godot --version
```

Mở editor:

```bash
.tools/godot/godot --editor --path .
```

## Kiểm tra nhanh

Kiểm tra policy/template của agent harness và cú pháp shell:

```bash
bash scripts/repo-check.sh
```

Kiểm tra Godot import/parse project ở chế độ headless bằng executable local đã pin:

```bash
.tools/godot/godot --headless --path . --editor --quit
```

## Test liên quan

Smoke test hiện tại xác nhận `scenes/main/main.tscn` load và instantiate được:

```bash
.tools/godot/godot --headless --path . --script res://tests/smoke.gd
```

Khi feature có test chuyên biệt, chạy test nhỏ nhất bao phủ acceptance trước, rồi chạy full verify nếu thay đổi chạm shared gameplay boundary.

## Build hoặc kiểm tra đầy đủ

```bash
bash scripts/verify.sh
```

`verify.sh` chạy tuần tự:

1. `scripts/repo-check.sh`;
2. resolve Godot theo thứ tự `GODOT_BIN` → `.tools/godot/godot` → `godot4` → `godot`;
3. xác nhận executable là Godot 4.x;
4. Godot headless editor parse/import;
5. `tests/smoke.gd`.

Export executable chưa nằm trong bootstrap acceptance và sẽ được bổ sung khi có export preset/CI chính thức.

## Side effects

- Database hoặc dữ liệu: không có.
- Network hoặc service ngoài: `scripts/install-godot.sh` tải official release từ `godotengine/godot-builds`; verification sau khi đã cài không cần network.
- File hoặc generated output: installer tạo `.tools/`; Godot có thể tạo `.godot/`; cả hai bị ignore khỏi Git.
- Thời gian chạy dự kiến: verification vài giây trên máy đã cài Godot; lần import đầu có thể lâu hơn.

## Known baseline failures

- Nếu `repo-check: PASS` nhưng báo `Godot 4 executable not found`, chạy `bash scripts/install-godot.sh` rồi chạy lại `bash scripts/verify.sh`.

## Khi không thể chạy verification

Báo rõ command chưa chạy, lý do cụ thể, evidence thay thế đã dùng và rủi ro còn lại. Không ghi `pass` khi command bắt buộc chưa chạy.
