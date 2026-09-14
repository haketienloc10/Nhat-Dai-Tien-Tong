# Game Design Baseline — Nhất Đại Tiên Tông

## Product fantasy

Người chơi phát triển một **Tông Môn** trong thế giới tu tiên. Trọng tâm là quản lý/xây dựng và quan sát các **Tu sĩ** tự hoạt động trong hệ thống, thay vì điều khiển trực tiếp từng nhân vật như game action RPG.

Game dùng vòng lặp quản lý kiểu village/adventurer simulation làm tham chiếu học tập, nhưng không sao chép asset, nội dung, tên riêng, map, UI, dialogue hoặc data của sản phẩm khác.

## Thuật ngữ đã chốt

| Khái niệm tham chiếu | Thuật ngữ trong game |
|---|---|
| Tiên Trấn | **Tông Môn** |
| Trấn Chủ | **Tông Chủ** |
| Tu sĩ ghé thăm | **Tu sĩ ghé Tông Môn** |
| Village Rank | **Tông Môn Rank** |
| Adventurer | **Tu sĩ** |
| Shop economy | **Kinh tế Tông Môn** |

Các hệ thống khác chưa mặc định đổi semantics chỉ vì đổi chủ đề; thay đổi gameplay phải được quyết định/task hóa riêng.

## Core loop hiện tại

```text
Xây/phát triển Tông Môn
        ↓
Tu sĩ ghé Tông Môn
        ↓
Tu sĩ sử dụng dịch vụ / mua bán
        ↓
Tu sĩ nhận hoạt động hoặc nhiệm vụ
        ↓
Tu sĩ rời Tông Môn để chiến đấu/thám hiểm
        ↓
Tu sĩ mạnh lên và mang giá trị quay về
        ↓
Kinh tế Tông Môn phát triển
        ↓
Tông Môn Rank tăng và mở progression mới
```

Đây là product direction, không phải specification chi tiết cho từng subsystem.

## Design principles

- **Simulation trước micromanagement:** người chơi tạo điều kiện; Tu sĩ nên có hành vi tự chủ ở mức phù hợp.
- **Quan sát được:** state/decision quan trọng của Tu sĩ phải có cách debug và về sau có thể trình bày cho người chơi.
- **Data-driven content:** building/item/monster/quest content ưu tiên Resource/data thay vì hard-code branching logic.
- **Progression hai chiều:** Tu sĩ mạnh hơn giúp Tông Môn phát triển; Tông Môn phát triển tạo điều kiện cho Tu sĩ mạnh hơn.
- **Scope nhỏ trước:** feature chỉ được mở rộng khi core loop hiện tại đã verify được.

## Chưa chốt

Các mục sau không được agent tự coi là product truth nếu TaskPacket không nêu:

- hệ thống cảnh giới chi tiết;
- linh căn/công pháp/thiên kiếp;
- danh sách công trình;
- số loại tiền/tài nguyên;
- combat model;
- procedural generation;
- art direction cuối cùng;
- monetization hoặc nền tảng phát hành.
