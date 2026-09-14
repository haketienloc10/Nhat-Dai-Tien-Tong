# Nhất Đại Tiên Tông

Game quản lý/simulation chủ đề tu tiên, phát triển theo workflow agent-first với `agent-knowledge-harness`.

## Stack

- Godot **4.7.2 stable**
- GDScript
- Data-driven content
- Event-driven boundaries
- State machine cho Tu sĩ
- Headless verification để agent có thể kiểm chứng thay đổi

## Bootstrap trên Linux

Cài bản Godot đã pin vào `.tools/` của repo:

```bash
bash scripts/install-godot.sh
```

Sau đó xác minh toàn bộ bootstrap:

```bash
bash scripts/verify.sh
```

`verify.sh` cũng tự dùng Godot 4 đã có trong `PATH` (`godot4` hoặc `godot`) nếu không có bản local. Có thể override bằng:

```bash
GODOT_BIN=/absolute/path/to/godot bash scripts/verify.sh
```

## Chạy project

Với bản local đã pin:

```bash
.tools/godot/godot --editor --path .
```

Chi tiết verification: [`docs/VERIFY.md`](docs/VERIFY.md).

## Tài liệu chính

- [`AGENTS.md`](AGENTS.md): execution policy cho child agent.
- [`ARCHITECTURE.md`](ARCHITECTURE.md): live repository architecture.
- [`docs/specs/GAME_DESIGN.md`](docs/specs/GAME_DESIGN.md): product/game-design baseline đã chốt.
- [`docs/specs/MVP.md`](docs/specs/MVP.md): milestone roadmap.
- [`docs/REPO_SETUP.md`](docs/REPO_SETUP.md): boundary với QiQi/TaskPacket/Knowledge.

## Nguyên tắc agent workflow

Task gameplay phải đến child agent dưới dạng TaskPacket đủ `objective`, `scope[]`, `acceptance_criteria[]`. Child dùng live repo source/test làm implementation truth và không tự reconstruct product requirement từ Work Item hoặc hidden orchestration state.
