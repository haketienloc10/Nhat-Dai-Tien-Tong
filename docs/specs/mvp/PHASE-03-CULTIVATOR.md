# P3 — Cultivator Foundation

## Mục tiêu

Tạo một Tu sĩ autonomous đầu tiên và chứng minh lifecycle/state machine có thể mở rộng mà không gắn với UI hay seed content cụ thể.

## Object đại diện

- 1 Tu sĩ seed, working name `Lâm Phong`.
- 1 runtime instance trên map.

## Scope

- `CultivatorData`: id, display name, move speed, base HP, base attack.
- `CultivatorState`: trạng thái runtime tối thiểu.
- State machine cơ bản:

```text
SPAWN
→ IDLE
→ FIND_BUILDING
→ MOVE_TO_BUILDING
→ USE_BUILDING
→ READY_FOR_QUEST
```

Các state quest/travel/combat được nối ở phase sau.

- Movement tới target building/service theo world/grid API.
- Debug state observable qua log hoặc minimal overlay.

## Không làm

- linh căn;
- cảnh giới sâu;
- personality;
- relationship;
- loyalty;
- skill tree;
- nhiều NPC;
- crowd avoidance phức tạp.

## Task breakdown

### P3.T1 — Cultivator data/runtime split

Static data tách khỏi runtime state. Runtime giữ position, current state, target và stats cần thiết.

### P3.T2 — State machine framework

Transition có điều kiện rõ, tránh một `_process()` chứa toàn bộ AI branching. State transition phải inspect/debug được.

### P3.T3 — Building discovery

Tu sĩ query service/building qua abstraction chung; không tham chiếu trực tiếp node path của Đại Điện.

### P3.T4 — Movement

Movement đơn giản tới target; MVP có thể dùng direct movement hoặc path tối giản nếu map không có obstacle phức tạp.

### P3.T5 — Tests

Test state transition logic thuần và việc không có building target không gây crash/invalid loop.

## Architecture contract

- Tu sĩ không gọi UI.
- AI quyết định target dựa trên capability/service, không dựa vào display name.
- `CultivatorData` có thể có nhiều resource sau này mà không sửa state machine core.
- Movement implementation có thể thay bằng navigation/pathfinding sau này mà state contract giữ nguyên.

## Acceptance

- 1 Tu sĩ spawn được.
- Từ IDLE, Tu sĩ tìm được building seed và di chuyển tới đó.
- Khi building không tồn tại, NPC ở state hợp lệ và retry/fallback theo rule rõ.
- Transition được test/quan sát được.
- Full verify PASS.

## Exit

P3 hoàn thành khi P4/P5 có thể gắn inventory/economy interaction vào `USE_BUILDING` mà không cần viết lại lifecycle cơ bản.
