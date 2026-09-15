# P10 — Save / Load

## Mục tiêu

Chứng minh toàn bộ simulation state quan trọng có thể persist và restore mà không serialize trực tiếp Godot node tree.

## Object đại diện

- 1 save slot: `user://save.json` hoặc format tương đương.
- 1 world state.
- 1 building.
- 1 Tu sĩ.
- 1 equipment.
- 1 quest runtime.
- Sect economy/progression state.

## Scope

Persist tối thiểu:

- Sect: currency, reputation, current rank.
- Building: data id + grid position + runtime state cần thiết.
- Cultivator: data id, position/location, lifecycle state, currency, HP nếu material, inventory/equipment ids, active quest reference.
- Quest: template id, status, progress, reward state.
- Travel state nếu save giữa chuyến được support; nếu MVP chỉ save ở safe point thì phải ghi rõ constraint.

## Không làm

- cloud save;
- multiple slots;
- encryption;
- compression;
- backward migration phức tạp;
- autosave policy hoàn chỉnh.

## Task breakdown

### P10.T1 — Save DTO/schema

Định nghĩa JSON/dictionary schema độc lập với Node references. Static Resource chỉ lưu stable id khi có thể.

### P10.T2 — Serialize

GameState/systems xuất state qua explicit methods. Không dùng một object graph dump khó kiểm soát.

### P10.T3 — Deserialize/rebuild

Load static data catalog trước, sau đó reconstruct runtime instances và relationships theo stable ids.

### P10.T4 — Corruption/version guard tối thiểu

Có `save_version`; invalid/missing required field fail rõ thay vì crash ngầm.

### P10.T5 — Round-trip tests

Tạo state representative → save → reset → load → assert semantic equivalence.

## Architecture contract

- Save schema là persistence contract, không phải mirror 1:1 của scene tree.
- Runtime Node path không được lưu làm identity chính.
- Data id phải stable.
- Feature phase sau thêm state phải cập nhật save contract/tests nếu state đó cần persistence.

## Acceptance

- Save file được tạo thành công.
- Quit/reset/load phục hồi building position, Tu sĩ state/equipment, balances, quest progress và Sect progression theo scope đã chốt.
- Load không tạo duplicate entity/reward.
- Invalid save được báo rõ.
- Round-trip test PASS.
- Full verify PASS.

## Exit

P10 hoàn thành khi P12 có thể chạy vertical slice, save ở trạng thái có ý nghĩa, reload và tiếp tục mà không mất/corrupt core state.
