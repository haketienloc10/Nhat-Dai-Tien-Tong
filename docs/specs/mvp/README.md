# MVP Phase Index

Thư mục này chia `docs/specs/MVP.md` thành các phase execution nhỏ. `MVP.md` là master plan; file phase là scope/acceptance chi tiết để QiQi distill thành TaskPacket.

## Nguyên tắc MVP

Mỗi domain chỉ có **một object/content đại diện** trừ khi cần hai trạng thái để chứng minh progression. Mục tiêu là chứng minh architecture và core loop, không phải mở rộng content.

Ví dụ seed content có thể đổi tên mà không được làm thay đổi architecture:

- 1 Tu sĩ;
- 1 công trình;
- 1 trang bị;
- 1 loại quái;
- 1 quest;
- 1 điểm đến;
- 1 currency;
- 2 Tông Môn Rank để chứng minh rank-up.

## Phase

| Phase | File | Trạng thái |
|---|---|---|
| P0 | [Foundation](PHASE-00-FOUNDATION.md) | Hoàn thành bootstrap |
| P1 | [World Foundation](PHASE-01-WORLD.md) | Chưa triển khai |
| P2 | [Building Foundation](PHASE-02-BUILDING.md) | Chưa triển khai |
| P3 | [Cultivator Foundation](PHASE-03-CULTIVATOR.md) | Chưa triển khai |
| P4 | [Item & Equipment](PHASE-04-ITEM-EQUIPMENT.md) | Chưa triển khai |
| P5 | [Economy](PHASE-05-ECONOMY.md) | Chưa triển khai |
| P6 | [Quest](PHASE-06-QUEST.md) | Chưa triển khai |
| P7 | [Combat](PHASE-07-COMBAT.md) | Chưa triển khai |
| P8 | [Travel / Outside World](PHASE-08-TRAVEL.md) | Chưa triển khai |
| P9 | [Sect Progression](PHASE-09-SECT-PROGRESSION.md) | Chưa triển khai |
| P10 | [Save / Load](PHASE-10-SAVE-LOAD.md) | Chưa triển khai |
| P11 | [Minimal UI](PHASE-11-MINIMAL-UI.md) | Chưa triển khai |
| P12 | [MVP Integration](PHASE-12-INTEGRATION.md) | Chưa triển khai |

## Rule dùng với agent

- File phase định nghĩa **WHAT** và acceptance.
- TaskPacket có thể chia một phase thành nhiều delegated turn nhỏ hơn.
- Child agent không tự mở scope sang phase kế tiếp.
- Content thứ hai cùng loại không được thêm chỉ để “test scale”; test scale bằng data model/catalog và unit/simulation tests trước.
- Mọi phase phải giữ `bash scripts/verify.sh` PASS trước khi được coi là hoàn thành.
