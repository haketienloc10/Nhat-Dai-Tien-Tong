# P5 — Economy

## Mục tiêu

Chứng minh shop economy bằng một currency và một transaction type: Tu sĩ mua một trang bị từ dịch vụ của Tông Môn.

## Object đại diện

- Currency duy nhất: `Linh Thạch`.
- 1 buyer: Tu sĩ seed.
- 1 seller/account: Tông Môn.
- 1 item có giá: Thanh Mộc Kiếm.

## Scope

- Balance của Tông Môn và Tu sĩ.
- `EconomySystem` hoặc service tương đương là nơi duy nhất resolve transaction rule.
- Purchase flow kiểm tra item, price, buyer funds, seller/service availability.
- Success: chuyển currency + chuyển item chính xác một lần.
- Failure: không có side effect một phần.
- Transaction result có success/failure reason để AI/UI đọc.

## Không làm

- nhiều currency;
- dynamic pricing;
- tax;
- auction;
- crafting economy;
- market simulation;
- contribution points.

## Task breakdown

### P5.T1 — Currency/account model

Định nghĩa balance operations qua API rõ; tránh `money +=/-=` rải rác ở UI/entity.

### P5.T2 — Purchase transaction

Validate trước khi mutate. Transaction hoặc thành công toàn bộ hoặc không thay đổi state.

### P5.T3 — Building service integration

Building seed expose item/service qua capability; Tu sĩ trong `USE_BUILDING` có thể yêu cầu purchase.

### P5.T4 — Autonomous purchase decision tối thiểu

Nếu Tu sĩ chưa có weapon và đủ tiền, AI chọn mua item seed. Không xây utility-AI/general scoring ở MVP.

### P5.T5 — Tests

Test đủ tiền, thiếu tiền, item unavailable, duplicate purchase policy và currency conservation.

## Architecture contract

- Economy không trực tiếp equip item; nó hoàn tất transaction rồi domain inventory xử lý nhận item theo contract.
- UI chỉ gửi intent/hiển thị result.
- Price nằm trong data hoặc pricing service, không nằm trong button/UI.
- System phải support item/catalog nhiều phần tử về mặt API dù MVP có một item.

## Acceptance

- Tu sĩ tới building và có thể mua Thanh Mộc Kiếm.
- Buyer balance giảm đúng giá; Tông Môn tăng đúng giá.
- Item vào inventory đúng một lần.
- Không đủ tiền → balances và inventory không đổi.
- Transaction result inspect được.
- Full verify PASS.

## Exit

P5 hoàn thành khi core loop trong Tông Môn đã có `Tu sĩ → building → purchase/equip`, sẵn sàng nối quest ở P6.
