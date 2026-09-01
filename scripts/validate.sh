#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILL_ROOT="$REPO_ROOT/skills/react-native-runtime-debugging"

test -f "$SKILL_ROOT/SKILL.md"
test -f "$SKILL_ROOT/agents/openai.yaml"
test -f "$SKILL_ROOT/references/metro-endpoints.md"

bash -n "$SKILL_ROOT/scripts/metro.sh"
bash -n "$SKILL_ROOT/scripts/logs.sh"
bash -n "$SKILL_ROOT/scripts/hmr.sh"
node --check "$SKILL_ROOT/scripts/cdp-bridge.js"

if rg -n 'CLAUDE_SKILL_DIR|\.claude-plugin|\.\./_shared|model: haiku' "$SKILL_ROOT"; then
  echo "Found a non-portable skill dependency." >&2
  exit 1
fi

if [[ -n "${SKILL_VALIDATOR:-}" ]]; then
  python3 "$SKILL_VALIDATOR" "$SKILL_ROOT"
fi

echo "React Native Foundations validation passed."
