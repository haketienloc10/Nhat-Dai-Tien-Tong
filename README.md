# Nhất Đại Tiên Tông

Game quản lý/simulation chủ đề tu tiên, phát triển theo workflow agent-first với `agent-knowledge-harness`.

## Stack

- Godot 4.x
- GDScript
- Data-driven content
- Event-driven boundaries
- State machine cho Tu sĩ
- Headless verification để agent có thể kiểm chứng thay đổi

## Chạy project

```bash
godot --editor --path .
```

Nếu executable là `godot4`:

```bash
GODOT_BIN=godot4 bash scripts/verify.sh
```

## Verification

```bash
bash scripts/verify.sh
```

Chi tiết: [`docs/VERIFY.md`](docs/VERIFY.md).

## Tài liệu chính

- [`AGENTS.md`](AGENTS.md): execution policy cho child agent.
- [`ARCHITECTURE.md`](ARCHITECTURE.md): live repository architecture.
- [`docs/specs/GAME_DESIGN.md`](docs/specs/GAME_DESIGN.md): product/game-design baseline đã chốt.
- [`docs/specs/MVP.md`](docs/specs/MVP.md): milestone roadmap.
- [`docs/REPO_SETUP.md`](docs/REPO_SETUP.md): boundary với QiQi/TaskPacket/Knowledge.

## Nguyên tắc agent workflow

Task gameplay phải đến child agent dưới dạng TaskPacket đủ `objective`, `scope[]`, `acceptance_criteria[]`. Child dùng live repo source/test làm implementation truth và không tự reconstruct product requirement từ Work Item hoặc hidden orchestration state.
