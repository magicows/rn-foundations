# React Native Foundations

Portable Agent Skills for diagnosing and improving React Native applications. Each skill is independently installable and contains its own scripts and references—no Claude plugin manifest, machine-global helper files, or copied React Native documentation is required.

## Included skill

### `react-native-runtime-debugging`

Inspect Metro health, JavaScript and native logs, CDP targets, React component trees, network activity, bundle responses, stack symbolication, and HMR events for running React Native and Expo development builds.

This repository is intended to complement, not replace:

- [Callstack Agent Skills](https://github.com/callstackincubator/agent-skills), which provides a broad collection covering performance, testing, navigation, upgrades, libraries, devices, and delivery workflows.
- [React Native Community Skills](https://github.com/react-native-community/skills), which currently focuses on React Native upgrades and Strict TypeScript API migration.

## Install

No package registry publication is required. Once this repository is pushed to GitHub, install directly from it:

```bash
npx skills@latest add <github-owner>/react-native-foundations \
  --skill react-native-runtime-debugging \
  --agent codex \
  --yes
```

To install it globally for Codex:

```bash
npx skills@latest add <github-owner>/react-native-foundations \
  --skill react-native-runtime-debugging \
  --agent codex \
  --global \
  --copy \
  --yes
```

A private GitHub repository also works when Git on the installing machine is already authenticated for that repository.

Test a local checkout before pushing:

```bash
npx skills@latest add . \
  --skill react-native-runtime-debugging \
  --agent codex \
  --copy \
  --yes
```

## Requirements

- Node.js 22 or later for CDP inspection
- Metro running for Metro/CDP probes
- Xcode command-line tools for iOS Simulator logs
- Android platform tools for Android logs

## Validate changes

```bash
bash scripts/validate.sh
```

Set `SKILL_VALIDATOR` to a compatible `quick_validate.py` path to include Agent Skill schema validation.

## Attribution

The runtime helper scripts and Metro endpoint reference were adapted from `react-native-foundations.skill`. See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
