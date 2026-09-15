# P9 — Sect Progression

## Mục tiêu

Chứng minh progression của Tông Môn bằng Reputation và đúng hai rank để có một lần rank-up quan sát được.

## Object đại diện

- Resource progression: `Reputation`.
- Rank 1.
- Rank 2.
- Quest reward tăng Reputation.

## Scope

- `SectRankData`: rank id/name, required reputation, optional unlock metadata để dành cho tương lai.
- `ProgressionSystem` hoặc service tương đương quản lý reputation và rank evaluation.
- Rank-up event phát đúng một lần khi vượt threshold.
- Quest reward gọi progression boundary thay vì tự mutate rank.
- UI/debug layer có thể đọc current reputation/rank nhưng không sở hữu logic.

## Không làm

- 9 phẩm đầy đủ;
- unlock tree;
- building unlock thực tế;
- prestige;
- faction reputation;
- character cultivation realm progression.

## Task breakdown

### P9.T1 — Rank data contract

Tạo hai rank seed bằng data. Threshold là data, không hard-code trong UI/system branch theo rank name.

### P9.T2 — Reputation mutation API

Có API tăng/giảm nếu cần, với invariants rõ. MVP chủ yếu tăng qua quest reward.

### P9.T3 — Rank evaluation

Khi reputation thay đổi, evaluate current rank theo catalog. Transition idempotent và event chỉ phát khi rank thực sự đổi.

### P9.T4 — Quest reward integration

Quest completed/rewarded cộng reputation qua ProgressionSystem. Duplicate reward không tạo duplicate rank-up.

### P9.T5 — Tests

Test dưới threshold, đúng threshold, vượt threshold, duplicate evaluation và reward-once.

## Architecture contract

- Progression không biết combat hay travel.
- Rank content mới sau MVP là data mới nếu rule threshold tuyến tính vẫn phù hợp.
- Unlock metadata chưa cần activate nhưng data model không được buộc code chỉ có hai rank.

## Acceptance

- Reputation bắt đầu ở giá trị seed.
- Quest reward tăng reputation đúng lượng.
- Đạt threshold chuyển Rank 1 → Rank 2.
- Rank-up event không duplicate.
- Current rank có thể query từ GameState/system.
- Full verify PASS.

## Exit

P9 hoàn thành khi vòng lặp quest có tác động lâu dài lên Tông Môn và rank-up được chứng minh mà không cần thêm content.
