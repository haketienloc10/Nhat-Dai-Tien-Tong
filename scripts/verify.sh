#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

bash "$repo_root/scripts/repo-check.sh"

resolve_godot() {
  if [[ -n "${GODOT_BIN:-}" ]]; then
    if [[ "$GODOT_BIN" == */* ]]; then
      [[ -x "$GODOT_BIN" ]] && { printf '%s\n' "$GODOT_BIN"; return 0; }
    elif command -v "$GODOT_BIN" >/dev/null 2>&1; then
      command -v "$GODOT_BIN"
      return 0
    fi

    printf 'FAIL: GODOT_BIN is set but not executable: %s\n' "$GODOT_BIN" >&2
    return 1
  fi

  if [[ -x "$repo_root/.tools/godot/godot" ]]; then
    printf '%s\n' "$repo_root/.tools/godot/godot"
    return 0
  fi

  local candidate
  for candidate in godot4 godot; do
    if command -v "$candidate" >/dev/null 2>&1; then
      command -v "$candidate"
      return 0
    fi
  done

  printf 'FAIL: Godot 4 executable not found.\n' >&2
  printf 'Run: bash scripts/install-godot.sh\n' >&2
  printf 'Or set GODOT_BIN=/absolute/path/to/godot and retry.\n' >&2
  return 1
}

godot_bin="$(resolve_godot)"
godot_version="$($godot_bin --version)"

if [[ "$godot_version" != 4.* ]]; then
  printf 'FAIL: expected Godot 4.x, got: %s\n' "$godot_version" >&2
  exit 1
fi

printf 'Using Godot: %s (%s)\n' "$godot_bin" "$godot_version"

"$godot_bin" --headless --path "$repo_root" --editor --quit
"$godot_bin" --headless --path "$repo_root" --script res://tests/smoke.gd

printf 'verify: PASS\n'
