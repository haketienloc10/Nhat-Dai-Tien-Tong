# MVP Roadmap

Roadmap này giữ milestone theo capability có thể verify. Product detail chưa được chốt phải quay lại TaskPacket/decision thay vì agent tự mở scope.

## M0 — Repository bootstrap

Mục tiêu: project Godot 4 có thể parse và boot tối thiểu trong headless verification.

Acceptance:

- `project.godot` tồn tại và trỏ tới main scene;
- main scene load/instantiate được;
- `scripts/repo-check.sh` pass;
- Godot headless parse/import pass;
- smoke test pass;
- `ARCHITECTURE.md` và `docs/VERIFY.md` phản ánh live repo, không còn placeholder.

## M1 — World foundation

Mục tiêu dự kiến: camera + world/grid foundation đủ cho building placement đầu tiên.

Không triển khai cho tới khi TaskPacket chốt observable behavior và acceptance.

## M2 — Building placement

Mục tiêu dự kiến: người chơi có thể chọn và đặt một công trình hợp lệ lên world.

## M3 — Tu sĩ simulation seed

Mục tiêu dự kiến: ít nhất một Tu sĩ có lifecycle/state quan sát được và di chuyển trong world theo rule đã chốt.

## M4 — Kinh tế Tông Môn seed

Mục tiêu dự kiến: Tu sĩ có thể tương tác với một dịch vụ/shop và tạo transaction có thể verify.

## M5 — Activity/quest loop

Mục tiêu dự kiến: Tu sĩ nhận hoạt động, rời Tông Môn, resolve kết quả và quay lại.

## M6 — Progression seed

Mục tiêu dự kiến: Tu sĩ và Tông Môn có progression tối thiểu liên kết với core loop.

## Quy tắc milestone

- Không coi mô tả dự kiến là specification triển khai.
- Mỗi milestone phải có TaskPacket với `objective`, `scope[]`, `acceptance_criteria[]` trước khi child agent code.
- Acceptance ưu tiên behavior quan sát được; implementation detail do repo source/policy quyết định nếu không phải product requirement.
- Feature mới không được phá headless verification của milestone trước.
