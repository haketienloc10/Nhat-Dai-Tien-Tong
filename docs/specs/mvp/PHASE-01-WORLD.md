# P1 — World Foundation

## Mục tiêu

Tạo một world 2D tối thiểu làm nền cho toàn bộ gameplay về sau: grid, camera, coordinate conversion và container cho entity. Chưa có building hay NPC thật.

## Object đại diện

- 1 map nhỏ, đề xuất `20 x 20` cell.
- 1 loại cell mặc định.
- 1 camera.

## Scope

- `World` scene/root.
- Grid coordinate `Vector2i` tách khỏi world coordinate `Vector2`.
- Hàm `grid_to_world()` và `world_to_grid()`.
- Camera pan/zoom cơ bản đủ cho desktop test.
- World bounds.
- Container/node rõ cho Buildings, Cultivators và transient entities dù còn rỗng.
- Debug visualization đơn giản cho grid.

## Không làm

- terrain type;
- road;
- procedural generation;
- decoration;
- pathfinding phức tạp;
- building placement;
- final art.

## Task breakdown

### P1.T1 — Grid model

Tạo grid model thuần logic, có width/height/cell size, bounds check và coordinate conversion. Logic phải test được headless, không phụ thuộc render.

### P1.T2 — World scene

Tạo world scene chứa grid renderer/debug layer và entity containers. Main scene load world đúng một lần.

### P1.T3 — Camera controller

Pan và zoom trong giới hạn hợp lý. Camera không sở hữu gameplay state.

### P1.T4 — Verification

Test bounds và round-trip coordinate conversion. Smoke test xác nhận world scene instantiate được.

## Architecture contract

- Grid model là source of truth cho cell coordinate.
- Render layer chỉ hiển thị grid, không sở hữu occupancy.
- World không biết logic economy/quest/combat.
- API coordinate phải dùng được về sau bởi BuildingManager và navigation.

## Acceptance

- Game mở thấy map/grid placeholder.
- Camera pan/zoom được.
- `grid_to_world(Vector2i)` rồi `world_to_grid()` trả về cell tương đương tại vị trí chuẩn.
- Out-of-bounds được reject rõ ràng.
- Headless tests cho grid PASS.
- `bash scripts/verify.sh` PASS.

## Exit

P1 hoàn thành khi P2 có thể dùng grid API để validate và đặt một building mà không cần sửa cách world/grid vận hành.
