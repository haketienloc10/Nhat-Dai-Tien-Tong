# Verification

Tài liệu này là source of truth cho cách bootstrap và xác minh repository. Chỉ ghi command đã được kiểm tra từ code, manifest, CI hoặc lần chạy thực tế.

## Prerequisites

- Runtime: Godot 4.x.
- Dependency ngoài: `git`, `rg` (ripgrep), Bash.
- Environment variable bắt buộc: không có. Nếu executable không tên `godot`, đặt `GODOT_BIN=godot4` hoặc path phù hợp.

## Bootstrap

Repository không có dependency package ngoài Godot. Sau khi clone:

```bash
git status --short
${GODOT_BIN:-godot} --version
```

Mở editor khi cần phát triển tương tác:

```bash
${GODOT_BIN:-godot} --editor --path .
```

## Kiểm tra nhanh

Kiểm tra policy/template của agent harness và cú pháp shell:

```bash
bash scripts/repo-check.sh
```

Kiểm tra Godot import/parse project ở chế độ headless:

```bash
${GODOT_BIN:-godot} --headless --path . --editor --quit
```

## Test liên quan

Smoke test hiện tại xác nhận `scenes/main/main.tscn` load và instantiate được:

```bash
${GODOT_BIN:-godot} --headless --path . --script res://tests/smoke.gd
```

Khi feature có test chuyên biệt, chạy test nhỏ nhất bao phủ acceptance trước, rồi chạy full verify nếu thay đổi chạm shared gameplay boundary.

## Build hoặc kiểm tra đầy đủ

```bash
bash scripts/verify.sh
```

`verify.sh` chạy tuần tự:

1. `scripts/repo-check.sh`;
2. Godot headless editor parse/import;
3. `tests/smoke.gd`.

Export executable chưa nằm trong bootstrap acceptance và sẽ được bổ sung khi có export preset/CI chính thức.

## Side effects

- Database hoặc dữ liệu: không có.
- Network hoặc service ngoài: không có trong verification hiện tại.
- File hoặc generated output: Godot có thể tạo `.godot/`; thư mục này bị ignore khỏi Git.
- Thời gian chạy dự kiến: vài giây trên máy đã cài Godot 4; lần import đầu có thể lâu hơn.

## Known baseline failures

- Chưa ghi nhận baseline failure. Nếu máy không tìm thấy executable `godot`, đây là thiếu prerequisite; đặt `GODOT_BIN` đúng rồi chạy lại.

## Khi không thể chạy verification

Báo rõ command chưa chạy, lý do cụ thể, evidence thay thế đã dùng và rủi ro còn lại. Không ghi `pass` khi command bắt buộc chưa chạy.
