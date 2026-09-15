# P0 — Foundation

## Trạng thái

**Hoàn thành.** Phase này thiết lập nền repository và verification; không chứa gameplay.

## Mục tiêu

Đảm bảo mọi agent bắt đầu từ một Godot 4 project boot được, có architecture boundary rõ, có smoke test và có một lệnh verification thống nhất.

## Scope đã đạt

- Godot 4.7.2 stable + GDScript.
- `project.godot` và main scene tối thiểu.
- `AGENTS.md`, `ARCHITECTURE.md`, `docs/VERIFY.md`.
- `scripts/repo-check.sh`, `scripts/install-godot.sh`, `scripts/verify.sh`.
- Headless import/parse và smoke test.
- Quy tắc agent-knowledge-harness: TaskPacket là task semantics; live repo là implementation truth.

## Không thuộc phase

- map/grid;
- gameplay entity;
- economy/quest/combat;
- content production;
- final UI/art/audio.

## Acceptance

```text
bash scripts/verify.sh
→ repo-check: PASS
→ Godot headless parse/import PASS
→ smoke: PASS
→ verify: PASS
```

## Contract giữ cho các phase sau

1. Mọi phase phải giữ full verification PASS.
2. Simulation/domain logic không phụ thuộc UI.
3. Content gameplay ưu tiên data-driven.
4. Không hard-code seed content vào system nếu dữ liệu đó thuộc domain content.
5. Phase mới không tự mở scope sang phase kế tiếp.

## Exit

P0 hoàn thành khi repository mới clone có thể bootstrap Godot và chạy verification theo `docs/VERIFY.md`. Điều kiện này đã đạt trước khi bắt đầu P1.
