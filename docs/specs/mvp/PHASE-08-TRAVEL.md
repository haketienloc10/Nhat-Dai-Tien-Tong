# P8 — Travel / Outside World

## Mục tiêu

Nối quest trong Tông Môn với combat bên ngoài bằng một travel lifecycle tối thiểu. MVP không render world map ngoài Tông Môn.

## Object đại diện

- 1 destination: `Thanh Lang Sơn`.
- 1 outward travel timer.
- 1 combat encounter.
- 1 return travel timer.

## Scope

Mở rộng Tu sĩ lifecycle:

```text
READY_FOR_QUEST
→ LEAVE_SECT
→ TRAVEL_OUT
→ QUESTING / COMBAT
→ TRAVEL_BACK
→ RETURNING
→ IDLE
```

- `WorldLocationData` hoặc contract tương đương: id, display name, travel duration, encounter/quest capability.
- `TravelSystem` quản lý time/progress và transition, không resolve combat rule.
- Khi Tu sĩ rời Tông Môn, world map không còn render/active character node như NPC nội khu nhưng GameState vẫn track runtime state.
- Khi combat xong, outcome quyết định return flow.

## Không làm

- overworld map;
- nhiều destination;
- path ngoài map;
- random encounter;
- party travel;
- resource gathering;
- fog of war.

## Task breakdown

### P8.T1 — Destination data

Định nghĩa location data seed bằng stable id. API phải support catalog dù chỉ có một location.

### P8.T2 — Travel lifecycle

Implement departure, timer/progress và arrival transitions. Time source dùng simulation/game time abstraction phù hợp, tránh UI timer làm source of truth.

### P8.T3 — Combat handoff

Arrival gọi combat domain qua boundary; TravelSystem chỉ nhận outcome.

### P8.T4 — Return/re-entry

Sau encounter, Tu sĩ trở lại sect world ở spawn/entry point hợp lệ và tiếp tục lifecycle.

### P8.T5 — Tests

Test full state sequence, missing destination, combat win/lose outcome và duplicate return guard.

## Architecture contract

- Travel không chứa monster combat math.
- World renderer không phải owner của Tu sĩ runtime state.
- Location content mới sau MVP chủ yếu là data mới nếu dùng cùng flow.
- Travel duration phải có cách test nhanh/deterministic mà không bắt test chờ real seconds.

## Acceptance

- Tu sĩ có quest có thể rời Tông Môn.
- Runtime state vẫn tồn tại khi NPC không hiện trên sect map.
- Arrival trigger đúng một encounter.
- Sau encounter, Tu sĩ quay về map đúng một lần.
- Quest progress/outcome được giữ nguyên qua travel.
- Full verify PASS.

## Exit

P8 hoàn thành khi core loop `nhận quest → rời Tông Môn → combat → quay về` chạy end-to-end ở domain level.
