# Godot bootstrap trên máy mới

## Triệu chứng

`scripts/repo-check.sh` PASS nhưng `scripts/verify.sh` dừng vì không tìm thấy executable `godot`.

## Nguyên nhân

Repo policy/harness hợp lệ, nhưng Godot là runtime ngoài repository và chưa có trong `PATH` của máy.

## Cách xử lý chuẩn

Project pin Godot `4.7.2-stable` cho bootstrap reproducible trên Linux:

```bash
bash scripts/install-godot.sh
bash scripts/verify.sh
```

Installer đặt binary tại `.tools/godot/godot`, xác minh SHA-256 của official release trước khi cài, và `.tools/` bị ignore khỏi Git.

`verify.sh` resolve executable theo thứ tự:

1. `GODOT_BIN` nếu được đặt;
2. `.tools/godot/godot`;
3. `godot4` trong `PATH`;
4. `godot` trong `PATH`.

Không coi thiếu runtime là regression của game source nếu `repo-check.sh` vẫn PASS.
