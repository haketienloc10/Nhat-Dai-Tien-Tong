# P12 — MVP Integration

## Mục tiêu

Chứng minh toàn bộ vertical slice chạy end-to-end với **mỗi domain chỉ một object đại diện**, đồng thời xác nhận architecture đủ rõ để mở rộng content sau MVP.

## Vertical slice bắt buộc

```text
New Game
→ Tông Môn có resource seed
→ người chơi đặt 1 Tông Môn Đại Điện
→ 1 Tu sĩ spawn
→ Tu sĩ tìm và đi tới building
→ Tu sĩ mua/equip 1 Thanh Mộc Kiếm
→ Tu sĩ nhận 1 quest Diệt Thanh Lang
→ Tu sĩ rời Tông Môn
→ travel tới 1 destination
→ combat 1 Thanh Lang
→ quest progress/completion
→ Tu sĩ quay về
→ reward được apply
→ Reputation tăng
→ lặp flow đủ để Rank 1 → Rank 2
→ save
→ reset/quit-load
→ restored state đúng
```

## Scope

- Nối các system bằng public/domain contracts đã tạo ở P1–P11.
- Sửa integration bug và boundary mismatch.
- Bổ sung một end-to-end simulation test hoặc deterministic scenario test.
- Bổ sung runtime debug evidence cần thiết để trace state transition.
- Rà lại architecture/docs nếu implementation truth đã khác plan.

## Không làm

- thêm content thứ hai chỉ để demo;
- polish art/audio;
- mở rộng cultivation system;
- thêm feature ngoài core loop;
- tối ưu performance chưa có evidence cần thiết.

## Task breakdown

### P12.T1 — Seed scenario assembly

Tạo một scenario/config tập hợp đúng seed content của MVP. Content vẫn load qua data/catalog, không tạo special-case code path `if mvp`.

### P12.T2 — End-to-end state flow

Chạy flow từ placement đến return/reward. Mỗi handoff phải dùng boundary public đã định nghĩa; tránh truy cập internals để “nối tạm”.

### P12.T3 — Rank-up loop

Cho phép lặp quest hoặc thiết lập reward/threshold để chứng minh đúng một rank transition trong thời gian test/play hợp lý.

### P12.T4 — Persistence checkpoint

Save sau một trạng thái có ý nghĩa, load và chứng minh semantic state tương đương.

### P12.T5 — Expansion audit

Kiểm tra giả định thêm object thứ hai:

- Tu sĩ thứ hai;
- building thứ hai;
- item thứ hai;
- monster thứ hai;
- quest thứ hai;
- location thứ hai.

Không cần tạo content thật. Audit phải chỉ ra object nào chỉ cần data mới, object nào cần objective/rule type mới, và nơi nào còn hard-code cần loại bỏ.

### P12.T6 — Final verification

Chạy focused tests + full verification. Cập nhật `ARCHITECTURE.md` và docs nếu live source đã thay đổi.

## Acceptance

- Vertical slice bắt buộc chạy từ đầu tới cuối mà không cần manual state mutation/debug cheat ngoài setup seed hợp lệ.
- Mỗi reward/transaction/combat/return/rank-up xảy ra đúng số lần.
- Save/load giữ được semantic state.
- Không có gameplay logic bắt buộc phụ thuộc UI.
- Seed content không bị hard-code trong generic systems.
- Expansion audit không phát hiện blocker kiến trúc nghiêm trọng cho việc thêm object thứ hai cùng loại.
- `bash scripts/verify.sh` PASS.

## Definition of Done MVP

MVP được coi là hoàn thành khi người chơi có thể quan sát một vòng đời hoàn chỉnh của một Tu sĩ trong một Tông Môn tối giản và codebase chứng minh được các system boundary chính: World, Building, Cultivator AI, Item/Equipment, Economy, Quest, Combat, Travel, Sect Progression, Save/Load và UI read/control layer.

Mục tiêu không phải “có nhiều content”; mục tiêu là **thêm content tiếp theo không buộc phá core architecture**.
