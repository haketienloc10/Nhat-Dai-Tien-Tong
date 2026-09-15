# P7 — Combat Simulation

## Mục tiêu

Chứng minh combat domain bằng một trận simulation deterministic giữa một Tu sĩ và một loại quái. MVP chưa cần combat scene riêng hay animation.

## Object đại diện

- 1 monster: `Thanh Lang`.
- 1 Tu sĩ seed với effective stats từ P4.
- 1 combat encounter.

## Scope

- `MonsterData`: id, display name, max HP, attack.
- Runtime combatant state tối thiểu: current HP, effective attack, alive/dead.
- `CombatSystem.resolve()` hoặc simulation loop tương đương.
- Turn/step rule đơn giản và deterministic.
- Outcome: `WIN`, `LOSE` hoặc explicit failure nếu input invalid.
- Khi monster bị defeat, phát domain outcome để QuestSystem consume.

## Không làm

- real-time combat scene;
- animation;
- skills;
- elemental damage;
- critical hit;
- status effect;
- party combat;
- boss AI;
- random loot table.

## Task breakdown

### P7.T1 — Monster data/runtime

Tách static monster data khỏi combat runtime state. Monster thứ hai sau này phải thêm được bằng data nếu cùng combat rule.

### P7.T2 — Combat resolver

Implement combat step rõ ràng, có max-step guard chống infinite loop. Combat resolver không truy cập UI.

### P7.T3 — Equipment stat integration

Resolver đọc effective attack của Tu sĩ; không biết Thanh Mộc Kiếm là gì.

### P7.T4 — Outcome event/contract

Defeat outcome chứa target/monster id để quest progress cập nhật qua boundary rõ.

### P7.T5 — Tests

Test deterministic win, lose, zero/invalid HP guard, max-step guard và quest-compatible defeat outcome.

## Architecture contract

- Combat domain không trao quest reward, không tăng Sect Rank và không điều khiển travel.
- UI có thể render combat sau này từ state/events mà không đổi core resolver contract.
- Randomness nếu thêm sau này phải injectable/seedable cho test; MVP ưu tiên deterministic.

## Acceptance

- Tu sĩ và Thanh Lang resolve combat không cần render scene.
- Effective equipment stats ảnh hưởng kết quả đúng.
- Combat luôn kết thúc trong bounded steps.
- Monster defeat tạo outcome đủ để P6 cập nhật quest.
- Headless combat tests PASS.
- Full verify PASS.

## Exit

P7 hoàn thành khi có thể gọi combat như một domain operation độc lập từ Travel/Quest flow mà không cần game world đang render.
