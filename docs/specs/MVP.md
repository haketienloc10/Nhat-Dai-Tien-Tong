# MVP Master Plan — Nhất Đại Tiên Tông

Tài liệu này là **file tổng quát** của MVP. Mỗi phase execution chi tiết nằm trong [`docs/specs/mvp/`](mvp/README.md).

Mục tiêu MVP không phải tạo nhiều content. Mục tiêu là chứng minh **core loop + system boundaries + data model** đủ rõ để sau MVP có thể thêm content mà không phá architecture.

## 1. Bối cảnh MVP

Người chơi là **Tông Chủ** của một Tông Môn mới thành lập. Khu vực ban đầu rất nhỏ, tài nguyên ít, chỉ có một Tu sĩ đại diện và một số hệ thống tối thiểu.

Tu sĩ có thể ghé/sinh hoạt trong Tông Môn, sử dụng một công trình, mua/trang bị vật phẩm, nhận nhiệm vụ, rời Tông Môn để chiến đấu với yêu thú rồi quay về. Thành công của Tu sĩ tạo lợi ích cho Tông Môn và làm Tông Môn tăng Reputation/Rank.

MVP chưa mở rộng lore, phe phái, thế giới tu tiên, cảnh giới, công pháp hay nhiều nhân vật. Các phần đó chỉ được phát triển sau khi vertical slice nền hoạt động ổn định.

## 2. Core fantasy và cơ chế chính

Người chơi **xây môi trường và hệ thống**, còn Tu sĩ có hành vi tự động theo lifecycle/state machine.

Core loop MVP:

```text
Tông Môn mới thành lập
→ đặt 1 công trình
→ 1 Tu sĩ xuất hiện
→ Tu sĩ tìm và sử dụng công trình
→ mua/equip 1 trang bị
→ nhận 1 quest
→ rời Tông Môn
→ đi tới 1 khu vực bên ngoài
→ chiến đấu với 1 quái
→ hoàn thành quest
→ quay về
→ nhận reward
→ Tông Môn tăng Reputation
→ Tông Môn Rank tăng
→ save/load giữ đúng state
```

Đây là vertical slice phải chạy end-to-end ở P12.

## 3. Nguyên tắc “1 object đại diện”

Mỗi domain chỉ tạo **một content instance đại diện**, trừ progression cần hai rank để chứng minh transition.

| Domain | MVP |
|---|---:|
| Tông Môn | 1 |
| Map | 1 map nhỏ |
| Tu sĩ | 1 |
| Công trình | 1 loại |
| Trang bị | 1 món |
| Equipment slot | 1 (`weapon`) |
| Quái vật | 1 loại |
| Quest | 1 template |
| Destination | 1 |
| Currency | 1 (`Linh Thạch`) |
| Progression resource | 1 (`Reputation`) |
| Tông Môn Rank | 2 rank |
| Save slot | 1 |

Working seed content có thể dùng tên như `Lâm Phong`, `Tông Môn Đại Điện`, `Thanh Mộc Kiếm`, `Thanh Lang`, `Thanh Lang Sơn`. Đây chỉ là **data mẫu**, không phải tên bắt buộc của architecture.

### Rule quan trọng

Không được viết generic system theo kiểu:

```gdscript
if cultivator.name == "Lâm Phong":
    cultivator.weapon = "Thanh Mộc Kiếm"
```

Phải thiết kế system theo id/data/catalog/API chung dù catalog hiện chỉ có một phần tử.

## 4. Architecture mục tiêu MVP

```text
src/
├── core/
│   ├── game_state
│   ├── event_bus
│   └── save_system
├── world/
│   ├── world
│   ├── grid
│   └── building_manager
├── entities/
│   ├── building
│   ├── cultivator
│   └── monster
├── ai/
│   ├── cultivator_state_machine
│   └── states/
├── systems/
│   ├── economy
│   ├── quest
│   ├── combat
│   ├── travel
│   └── progression
├── data/
│   ├── building_data
│   ├── cultivator_data
│   ├── item_data
│   ├── equipment_data
│   ├── monster_data
│   ├── quest_data
│   ├── location_data
│   └── sect_rank_data
└── ui/
```

Tên/path thực tế có thể thay đổi khi implementation cần, nhưng boundary phải giữ các nguyên tắc:

- UI không sở hữu gameplay state.
- Simulation/domain logic phải chạy được headless.
- Static content tách khỏi runtime state.
- Generic systems không hard-code seed content.
- Save/load persist semantic state, không dump trực tiếp scene tree.
- System chỉ sở hữu responsibility của mình; quest không làm combat, combat không trao rank, travel không tính damage.

## 5. Phase roadmap

| Phase | Mục tiêu | Chi tiết |
|---|---|---|
| P0 | Repository/Godot foundation | [PHASE-00](mvp/PHASE-00-FOUNDATION.md) |
| P1 | World, grid, camera | [PHASE-01](mvp/PHASE-01-WORLD.md) |
| P2 | 1 building data + placement | [PHASE-02](mvp/PHASE-02-BUILDING.md) |
| P3 | 1 autonomous Tu sĩ | [PHASE-03](mvp/PHASE-03-CULTIVATOR.md) |
| P4 | 1 item/equipment | [PHASE-04](mvp/PHASE-04-ITEM-EQUIPMENT.md) |
| P5 | 1-currency shop transaction | [PHASE-05](mvp/PHASE-05-ECONOMY.md) |
| P6 | 1 quest lifecycle | [PHASE-06](mvp/PHASE-06-QUEST.md) |
| P7 | 1-monster combat simulation | [PHASE-07](mvp/PHASE-07-COMBAT.md) |
| P8 | 1 destination + travel/return | [PHASE-08](mvp/PHASE-08-TRAVEL.md) |
| P9 | Reputation + Rank 1 → Rank 2 | [PHASE-09](mvp/PHASE-09-SECT-PROGRESSION.md) |
| P10 | Save/load semantic state | [PHASE-10](mvp/PHASE-10-SAVE-LOAD.md) |
| P11 | Minimal UI/read-control layer | [PHASE-11](mvp/PHASE-11-MINIMAL-UI.md) |
| P12 | End-to-end MVP integration | [PHASE-12](mvp/PHASE-12-INTEGRATION.md) |

Dependency chính:

```text
P0 ✅
↓
P1 World
↓
P2 Building
↓
P3 Cultivator
↓
P4 Item/Equipment
↓
P5 Economy
↓
P6 Quest
↓
P7 Combat
↓
P8 Travel
↓
P9 Sect Progression
↓
P10 Save/Load
↓
P11 Minimal UI
↓
P12 Integration
```

Một số debug UI có thể xuất hiện sớm để quan sát state, nhưng player-facing minimal UI vẫn được coi là P11. Không dùng việc cần debug làm lý do đưa gameplay logic vào UI.

## 6. MVP không làm

MVP cố tình không mở rộng:

- nhiều Tu sĩ;
- nhiều building/item/monster/quest/map;
- cảnh giới tu luyện;
- linh căn;
- công pháp/pháp thuật;
- crafting/luyện đan/luyện khí sâu;
- rarity/random affix;
- relationship/personality/faction;
- boss/dungeon/bí cảnh phức tạp;
- rival sect/world politics;
- multiplayer;
- final art/animation/audio;
- localization/polish production.

Feature trên chỉ được bắt đầu khi MVP vertical slice và expansion audit đã đạt.

## 7. Definition of Done toàn MVP

MVP đạt khi:

1. Một người chơi có thể chạy core loop từ đặt building tới quest/combat/return/rank-up.
2. Mỗi domain có ít nhất một behavior thật được chứng minh bằng content đại diện.
3. Save/load giữ được state quan trọng của vertical slice.
4. Core simulation chạy/test được headless, không bắt buộc UI.
5. `bash scripts/verify.sh` PASS.
6. Không có generic system phụ thuộc tên/ID cụ thể của seed content bằng special-case logic.
7. Expansion audit ở P12 cho thấy thêm object thứ hai cùng loại chủ yếu là thêm data hoặc implementation domain riêng, không phải phá/refactor core architecture.

## 8. Rule triển khai với agent-knowledge-harness

Mỗi phase có thể tiếp tục chia thành nhiều TaskPacket. TaskPacket phải giữ tối thiểu:

```text
objective
scope[]
acceptance_criteria[]
```

Agent chỉ làm scope của delegated turn, tự discover implementation detail trong repo, chạy focused verification và giữ full verification PASS khi phase hoàn thành.

File phase là product/architecture plan, **không thay thế live source/test**. Khi implementation đã thay đổi hợp lý, `ARCHITECTURE.md` và tài liệu phase phải được reconcile với live repo truth.
