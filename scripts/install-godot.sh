#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
version="${GODOT_VERSION:-4.7.2-stable}"
install_dir="$repo_root/.tools/godot"
install_bin="$install_dir/godot"

case "$(uname -m)" in
  x86_64|amd64)
    asset_arch="x86_64"
    expected_sha256="cadd3204e728a35d3f13adb7fd0d7902636b79f6b95c40c265eb73b6c35329e4"
    ;;
  aarch64|arm64)
    asset_arch="arm64"
    expected_sha256="5dd0d86405cf7e8adf79fb6377b38ba682a2846cb378ffe5364f38c01ad29b9d"
    ;;
  *)
    printf 'FAIL: unsupported Linux architecture: %s\n' "$(uname -m)" >&2
    exit 1
    ;;
esac

if [[ "$(uname -s)" != "Linux" ]]; then
  printf 'FAIL: scripts/install-godot.sh currently supports Linux only.\n' >&2
  exit 1
fi

for command_name in unzip sha256sum; do
  if ! command -v "$command_name" >/dev/null 2>&1; then
    printf 'FAIL: missing required command: %s\n' "$command_name" >&2
    exit 1
  fi
done

if [[ -x "$install_bin" ]]; then
  current_version="$($install_bin --version || true)"
  if [[ "$current_version" == 4.7.2.* ]]; then
    printf 'Godot already installed: %s (%s)\n' "$install_bin" "$current_version"
    exit 0
  fi
fi

asset_name="Godot_v${version}_linux.${asset_arch}.zip"
url="https://github.com/godotengine/godot-builds/releases/download/${version}/${asset_name}"

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT
archive="$tmp_dir/$asset_name"

printf 'Downloading Godot %s for %s...\n' "$version" "$asset_arch"
if command -v curl >/dev/null 2>&1; then
  curl --fail --location --retry 3 --output "$archive" "$url"
elif command -v wget >/dev/null 2>&1; then
  wget --output-document="$archive" "$url"
else
  printf 'FAIL: curl or wget is required to download Godot.\n' >&2
  exit 1
fi

printf '%s  %s\n' "$expected_sha256" "$archive" | sha256sum --check --status || {
  printf 'FAIL: Godot archive checksum mismatch.\n' >&2
  exit 1
}

unzip -q "$archive" -d "$tmp_dir/extracted"
extracted_bin="$tmp_dir/extracted/Godot_v${version}_linux.${asset_arch}"

if [[ ! -f "$extracted_bin" ]]; then
  printf 'FAIL: expected binary missing after extraction: %s\n' "$extracted_bin" >&2
  exit 1
fi

mkdir -p "$install_dir"
install -m 0755 "$extracted_bin" "$install_bin"
printf '%s\n' "$version" > "$install_dir/VERSION"

printf 'Installed Godot: %s\n' "$install_bin"
"$install_bin" --version
printf 'Next: bash scripts/verify.sh\n'
