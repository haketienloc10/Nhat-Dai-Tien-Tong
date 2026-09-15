# P6 — Quest

## Mục tiêu

Chứng minh quest lifecycle với đúng một quest template và một target type.

## Object đại diện

- Quest: `Diệt Thanh Lang`.
- Target: `Thanh Lang x1`.
- Reward: Linh Thạch + Reputation seed.

## Scope

- `QuestData`: id, display name, objective type, target id, target count, rewards.
- Runtime quest state:

```text
AVAILABLE
→ ACCEPTED
→ IN_PROGRESS
→ COMPLETED
→ REWARDED
```

- `QuestSystem` quản lý acceptance, progress, completion và reward-once semantics.
- Tu sĩ seed có `current_quest` hoặc assignment tương đương.
- Quest progress nhận domain event/result từ combat về sau, không đọc trực tiếp animation/UI.

## Không làm

- nhiều quest type;
- quest chain;
- dialogue;
- branching choice;
- daily quest;
- procedural quest generation;
- quest board UI hoàn chỉnh.

## Task breakdown

### P6.T1 — Quest data/runtime split

Static template tách khỏi runtime progress. Stable quest id dùng cho save.

### P6.T2 — Assignment lifecycle

Assign đúng một active quest cho Tu sĩ MVP; duplicate acceptance được reject rõ.

### P6.T3 — Progress API/event

Có API như `report_target_defeated(target_id)` hoặc event contract tương đương. Không hard-code Thanh Lang trong QuestSystem.

### P6.T4 — Completion/reward guard

Quest đủ progress chuyển COMPLETED; reward chỉ được claim/apply một lần.

### P6.T5 — Tests

Test target đúng/sai, count boundary, duplicate event, duplicate reward.

## Architecture contract

- Quest template mới sau MVP là data mới nếu objective type đã support.
- Combat không gọi UI và không tự cộng reward quest.
- QuestSystem không spawn monster hay điều khiển travel.
- Reward application đi qua domain systems tương ứng (economy/progression).

## Acceptance

- Tu sĩ nhận được quest seed.
- Target sai không tăng progress.
- Thanh Lang bị defeat làm progress `0/1 → 1/1`.
- Quest hoàn thành và reward chỉ apply một lần.
- Runtime state inspect/test được headless.
- Full verify PASS.

## Exit

P6 hoàn thành khi quest có thể tồn tại độc lập với combat implementation và P7 chỉ cần phát outcome/event đúng contract để hoàn tất objective.
