#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RUNTIME_SKILL_ROOT="$REPO_ROOT/skills/react-native-runtime-debugging"
SIMULATOR_SKILL_ROOT="$REPO_ROOT/skills/ios-simulator-control"

for skill_root in "$RUNTIME_SKILL_ROOT" "$SIMULATOR_SKILL_ROOT"; do
  test -f "$skill_root/SKILL.md"
  test -f "$skill_root/agents/openai.yaml"
done

test -f "$RUNTIME_SKILL_ROOT/references/metro-endpoints.md"
test -f "$SIMULATOR_SKILL_ROOT/references/troubleshooting.md"

for script in "$RUNTIME_SKILL_ROOT"/scripts/*.sh "$SIMULATOR_SKILL_ROOT"/scripts/*.sh; do
  bash -n "$script"
done
node --check "$RUNTIME_SKILL_ROOT/scripts/cdp-bridge.js"

if rg -n 'CLAUDE_SKILL_DIR|\.claude-plugin|\.\./_shared|model: haiku|allowed-tools:' "$REPO_ROOT/skills"; then
  echo "Found a non-portable skill dependency." >&2
  exit 1
fi

if [[ -n "${SKILL_VALIDATOR:-}" ]]; then
  python3 "$SKILL_VALIDATOR" "$RUNTIME_SKILL_ROOT"
  python3 "$SKILL_VALIDATOR" "$SIMULATOR_SKILL_ROOT"
fi

echo "React Native Foundations validation passed."
