# P2 — Building Foundation

## Mục tiêu

Chứng minh hệ thống công trình hoạt động theo data-driven architecture với đúng **một loại building đại diện**.

## Object đại diện

- 1 building: `Tông Môn Đại Điện` (working content).
- 1 footprint, đề xuất `2 x 2` cell.
- 1 build cost bằng Linh Thạch.

## Scope

- `BuildingData` mô tả content tĩnh: id, display name, footprint, build cost, service/capability id.
- `Building` runtime instance: data reference/id, grid position, runtime state tối thiểu.
- `BuildingManager` quản lý placement và occupancy.
- Build preview placeholder.
- Placement validation: bounds, occupancy, đủ resource nếu economy seed đã có ở GameState.
- Building instance được tạo từ data, không từ hard-coded tên.

## Không làm

- nhiều building type;
- upgrade;
- rotation;
- production chain;
- road requirement;
- decoration;
- worker assignment.

## Task breakdown

### P2.T1 — Building data contract

Định nghĩa `BuildingData` và một resource seed. Code phải chấp nhận catalog/array dù hiện chỉ có một resource.

### P2.T2 — Occupancy model

Thêm occupancy vào grid/world service theo boundary rõ. Không để renderer trở thành source of truth.

### P2.T3 — Placement flow

Select data → preview → validate → place/cancel. Placement tạo runtime instance và đánh dấu cell occupied.

### P2.T4 — Removal/reset support tối thiểu cho test

Có API cleanup/reset để test deterministic; chưa cần player-facing demolish feature.

### P2.T5 — Tests

Test valid placement, out-of-bounds, overlap và footprint occupancy.

## Architecture contract

- Thêm building thứ hai sau MVP chủ yếu bằng thêm `BuildingData`.
- `BuildingManager` không branch theo `building.id` cho logic placement chung.
- UI gửi placement intent; manager quyết định hợp lệ hay không.
- Runtime instance không copy toàn bộ static data vào save state.

## Acceptance

- Player/debug input đặt được đúng 1 Đại Điện.
- Không đặt overlap hoặc ngoài map.
- Occupancy phản ánh đúng footprint.
- Building tồn tại dưới Buildings container của World.
- Seed data nằm trong `resources/buildings/` hoặc cấu trúc data tương đương đã ghi trong architecture.
- Tests + full verify PASS.

## Exit

P2 hoàn thành khi P3 có thể query building/service bằng API chung mà không cần biết scene path hay hard-code Đại Điện.
