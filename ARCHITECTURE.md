# Architecture

Tài liệu này mô tả **live architecture nội bộ** của repository. Repository registry và dependency topology cơ bản thuộc workspace `repos.yaml`; cross-repo contracts, ownership boundaries và integration semantics thuộc workspace `SYSTEM_MAP.md`. Durable reusable conclusion được distill qua Shared Knowledge MCP; không copy Shared Knowledge Store vào file này.

## Repository responsibility

- Sở hữu: Godot 4 game client, simulation gameplay, game content definitions, UI, save/load và verification của **Nhất Đại Tiên Tông**.
- Không sở hữu: QiQi orchestration state, Global Work Item state, Shared Knowledge physical store hoặc source của sibling repositories.

## Entrypoints

| Entrypoint | Vai trò | Source |
|---|---|---|
| Godot project | Engine/project configuration | `project.godot` |
| Main scene | Runtime scene gốc của game | `scenes/main/main.tscn` |
| Main script | Runtime bootstrap tối thiểu | `src/main.gd` |
| Smoke test | Xác nhận main scene load và instantiate được | `tests/smoke.gd` |
| Full verification | Repo policy check + Godot headless checks | `scripts/verify.sh` |

## Module map

| Module | Trách nhiệm | Phụ thuộc nội bộ |
|---|---|---|
| `src/core/` | Game state, event boundaries, time/save infrastructure khi được triển khai | Không phụ thuộc UI |
| `src/world/` | Map, grid, navigation và world/building placement khi được triển khai | Core, data definitions |
| `src/entities/` | Runtime entities như Tu sĩ, quái, công trình | Core, systems qua explicit APIs/events |
| `src/systems/` | Economy, quest, combat, progression và simulation rules | Core, data definitions; không phụ thuộc UI |
| `src/ai/` | State machine/decision logic của Tu sĩ | Entities, world, systems contracts |
| `src/ui/` | Presentation và input adapter | Đọc state/gọi command; không sở hữu gameplay state |
| `resources/` | Data-driven content definitions | Được đọc bởi systems/entities |
| `scenes/` | Godot scene composition | Scripts trong `src/` |
| `tests/` | Headless smoke/unit/simulation verification | Live source và scenes |

Các thư mục module chưa cần tồn tại vật lý cho đến khi có implementation đầu tiên; bảng này là boundary định hướng, không phải lý do tạo placeholder code.

## Internal data flow

Luồng mục tiêu cho gameplay systems:

```text
UI/Input
  ↓ command/request
Gameplay system / entity boundary
  ↓ state transition
Game state + domain events
  ↓
AI / economy / progression consumers
  ↓ read model / event
UI presentation
```

Content gameplay ưu tiên data-driven:

```text
Resource definition
  ↓
System loads/validates data
  ↓
Runtime entity/state
```

UI không trực tiếp thay đổi economy, combat, progression hoặc AI state.

## External boundaries

Hiện repository chưa có runtime integration với repository khác.

| Boundary | Direction | Contract owner | Local source |
|---|---|---|---|
| QiQi delegated TaskPacket | inbound process boundary | QiQi workspace | `AGENTS.md` |
| Native final agent response | outbound process boundary | Repository execution agent | `AGENTS.md` |

Nếu sau này game dùng content tooling hoặc headless simulator ở repo riêng, contract liên repository phải được khai báo tại workspace `SYSTEM_MAP.md` trước khi child agent dựa vào nó.

## Data ownership

| Dữ liệu hoặc resource | Owner | Cách repo này truy cập |
|---|---|---|
| Runtime game state | Game repository | Local Godot code |
| Game content definitions | Game repository | `resources/` / Resource APIs |
| Task semantics | QiQi TaskPacket | Read-only execution premise theo `AGENTS.md` |
| Reusable implementation/domain knowledge | Shared Knowledge MCP | Progressive disclosure theo `AGENTS.md` |

## Constraints

- Engine: Godot 4.x; implementation language mặc định: GDScript.
- Architecture ưu tiên data-driven content, event-driven boundaries, state machine cho Tu sĩ và system-oriented gameplay logic.
- UI không sở hữu hoặc mutate gameplay state ngoài command/API được định nghĩa.
- Gameplay systems không phụ thuộc scene/UI cụ thể nếu có thể tránh; simulation logic nên có khả năng verify headless.
- Không thêm AutoLoad singleton chỉ để truy cập tiện; chỉ dùng khi ownership/lifecycle toàn cục thật sự cần và phải cập nhật tài liệu này.
- Không hard-code content catalog (item/building/monster/quest) vào UI hoặc branching gameplay khi Resource/data definition phù hợp hơn.
- Mỗi feature phải chọn verification nhỏ nhất đủ chứng minh acceptance và báo actual result.
- Repo source/test là implementation truth hiện tại; Shared Knowledge không override live source/test.

## Evidence

- `project.godot`
- `scenes/main/main.tscn`
- `src/main.gd`
- `tests/smoke.gd`
- `scripts/verify.sh`
- `docs/VERIFY.md`
