# P11 — Minimal UI

## Mục tiêu

Tạo UI tối thiểu đủ để quan sát và điều khiển vertical slice mà không đưa gameplay logic vào UI.

## Object đại diện

- 1 HUD.
- 1 build button.
- 1 Cultivator debug/detail panel.
- 1 quest/progression status area tối giản.

## Scope

HUD hiển thị tối thiểu:

- Linh Thạch của Tông Môn;
- Reputation;
- current Tông Môn Rank.

Build UI:

- một nút chọn building seed;
- placement mode/cancel signal rõ.

Cultivator panel:

- display name;
- HP;
- effective attack;
- currency;
- current state;
- equipped weapon;
- current quest/progress.

UI được phép gửi intent như `request_place_building`, `select_cultivator`, `save`, `load`; system/domain layer quyết định state change.

## Không làm

- final visual design;
- animation polish;
- responsive layout đa nền tảng;
- accessibility pass đầy đủ;
- tooltip system;
- localization;
- production icons/art.

## Task breakdown

### P11.T1 — HUD read model/binding

UI đọc state qua query/read model/signals phù hợp. Không poll node internals rải rác nếu có thể tránh.

### P11.T2 — Build controls

Nút build chỉ chọn content và gửi placement intent; cost validation vẫn ở gameplay layer.

### P11.T3 — Cultivator panel

Click/select Tu sĩ seed và hiển thị current runtime state để debug core loop.

### P11.T4 — Quest/progression visibility

Hiển thị quest state/progress và sect rank/reputation đủ để user thấy loop đang vận hành.

### P11.T5 — UI smoke/integration checks

Scene instantiate được headless; gameplay tests không cần UI scene để chạy.

## Architecture contract

- UI không mutate currency, inventory, quest, combat result hay rank trực tiếp.
- Domain systems không import/reference UI implementation.
- UI placeholder có thể bị thay hoàn toàn sau MVP mà không làm thay đổi core simulation.

## Acceptance

- Người chơi có thể khởi tạo building placement từ UI.
- HUD phản ánh economy/progression đúng.
- Cultivator panel phản ánh state/equipment/quest đúng.
- Core simulation tests vẫn chạy không cần viewport/UI interaction.
- Full verify PASS.

## Exit

P11 hoàn thành khi một người chạy game có thể nhìn thấy và theo dõi toàn bộ vertical slice mà không cần đọc console log cho các state chính.
