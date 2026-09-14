#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
godot_bin="${GODOT_BIN:-godot}"

bash "$repo_root/scripts/repo-check.sh"

if ! command -v "$godot_bin" >/dev/null 2>&1; then
  printf 'FAIL: Godot executable not found: %s\n' "$godot_bin" >&2
  printf 'Set GODOT_BIN=godot4 (or another Godot 4 executable) and retry.\n' >&2
  exit 1
fi

"$godot_bin" --headless --path "$repo_root" --editor --quit
"$godot_bin" --headless --path "$repo_root" --script res://tests/smoke.gd

printf 'verify: PASS\n'
