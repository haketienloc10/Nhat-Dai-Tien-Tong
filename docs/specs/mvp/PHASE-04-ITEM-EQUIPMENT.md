# P4 — Item & Equipment

## Mục tiêu

Chứng minh inventory/equipment model bằng đúng **một món trang bị** và một equipment slot.

## Object đại diện

- 1 trang bị: `Thanh Mộc Kiếm`.
- 1 slot: `weapon`.
- Hiệu ứng seed: cộng attack.

## Scope

- `ItemData`: id, display name, type, base price.
- `EquipmentData` hoặc contract tương đương mở rộng item với slot và stat modifiers.
- Inventory runtime chứa item instance/reference theo id.
- Equipment runtime có `weapon` slot.
- Derived stat tính từ base stat + equipment modifier.
- Equip/unequip API thuộc domain gameplay, không thuộc UI.

## Không làm

- armor/helmet/ring;
- rarity;
- random affix;
- durability;
- enhancement;
- crafting;
- item stack phức tạp.

## Task breakdown

### P4.T1 — Item data hierarchy

Định nghĩa contract chung cho item và equipment. Tránh switch theo display name.

### P4.T2 — Inventory model

Add/remove/contains/get item bằng stable id/reference. MVP chỉ cần capacity đơn giản hoặc unlimited.

### P4.T3 — Equipment model

Equip weapon hợp lệ, reject sai slot, thay thế/unequip deterministic.

### P4.T4 — Derived stats

Ví dụ base attack `5`, kiếm `+3`, effective attack `8`. Derived stat không mutate mất base stat.

### P4.T5 — Tests

Test add item, equip, effective stat, duplicate policy và invalid equipment operation.

## Architecture contract

- Item content mới sau MVP chủ yếu bằng Resource/data mới.
- Combat chỉ đọc effective stats; không biết item cụ thể.
- Economy đọc price từ item data; không sở hữu inventory.
- UI không tự sửa inventory/equipment arrays.

## Acceptance

- Tu sĩ có inventory runtime.
- Thanh Mộc Kiếm có thể add và equip.
- Effective attack thay đổi đúng modifier.
- Invalid equip không corrupt state.
- Không có hard-code `Thanh Mộc Kiếm` trong Cultivator/Combat system.
- Full verify PASS.

## Exit

P4 hoàn thành khi P5 có thể thực hiện purchase transaction rồi gọi inventory/equipment API chung để Tu sĩ nhận và dùng item.
