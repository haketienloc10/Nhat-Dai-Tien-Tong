# Xianxia MVP Pre-production Assets

Bộ asset này được chuẩn bị sớm cho **Nhất Đại Tiên Tông** để thử pipeline nhân vật/animation trong MVP.

## Trạng thái

- AI-assisted pre-production / placeholder assets.
- PNG có **background trong suốt**.
- Bản commit hiện tại là working preview đã giảm xuống `240x160` mỗi sheet để dùng nhẹ trong giai đoạn chuẩn bị.
- Chưa phải production spritesheet có frame grid/pivot chuẩn cuối cùng.
- Không phải asset lấy từ LPC và không kế thừa license/credit của LPC.

## Files

- `cultivator_sword_sheet.png`: nhân vật Tu sĩ mặc pháp bào, mang kiếm; concept chuyển động/đánh.
- `robe_layer_sheet.png`: layer pháp bào/trang phục.
- `armor_layer_sheet.png`: layer giáp tu tiên.
- `sword_layer_sheet.png`: layer kiếm/vỏ kiếm theo nhiều pose.

## Quy tắc sử dụng trong MVP

Các sheet này dùng để xác nhận art direction và thử import/render trước khi P3/P4 tích hợp nhân vật và trang bị.

Không coi layout hiện tại là animation contract. Trước khi dùng làm spritesheet runtime chính thức phải chuẩn hóa:

1. frame size thống nhất;
2. row/column mapping thống nhất;
3. pivot/chân nhân vật thống nhất giữa mọi frame;
4. các layer body/robe/armor/weapon phải cùng tọa độ;
5. Godot texture import dùng nearest-neighbor/pixel-art settings phù hợp;
6. animation names và frame ranges phải được ghi thành manifest/data thay vì hard-code theo tên file.

## Mục tiêu dài hạn

Pipeline mong muốn là compositing modular:

```text
body
+ hair/headgear
+ robe
+ armor
+ weapon
+ accessory/effect
= Cultivator appearance
```

MVP chỉ cần một nhân vật và một trang bị đại diện. Asset thứ hai cùng loại chỉ nên được thêm khi cần chứng minh expansion sau khi core pipeline đã ổn định.
