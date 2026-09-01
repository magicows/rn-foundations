---
name: react-native-runtime-debugging
description: Diagnose live React Native and Expo development builds through Metro health checks, JavaScript and native logs, CDP evaluation, React component-tree inspection, network monitoring, bundle checks, stack symbolication, and HMR events. Use for runtime failures and observable app behaviour; do not use for native build failures that occur before the app launches.
---

# React Native Runtime Debugging

Use the scripts bundled with this skill to inspect a running development build. Resolve `<skill-root>` to the absolute directory containing this file. Do not assume this skill lives in Claude, a plugin, another skill repository, or a global installation.

## Start with a preflight

Run these checks before choosing a debugging path:

```bash
<skill-root>/scripts/metro.sh status
xcrun simctl list devices booted
<skill-root>/scripts/metro.sh targets
```

For Android, also run `adb devices`.

- If Metro, a device, and a CDP target are available, use CDP inspection.
- If Metro and a device are available but no target appears, launch the development build and recheck.
- If Metro is unavailable but the app is running, use native OS logs.
- If no device is available, report the missing prerequisite instead of guessing.

## Choose the smallest useful probe

| Need | Command |
| --- | --- |
| Metro health | `<skill-root>/scripts/metro.sh status` |
| Project/runtime metadata | `<skill-root>/scripts/metro.sh env` |
| CDP targets | `<skill-root>/scripts/metro.sh targets` |
| iOS logs | `<skill-root>/scripts/logs.sh ios --last 2m` |
| Android logs | `<skill-root>/scripts/logs.sh android --last 2m` |
| Recent JS console | `node <skill-root>/scripts/cdp-bridge.js console --duration 10` |
| Read-only JS expression | `node <skill-root>/scripts/cdp-bridge.js eval '<expression>'` |
| React tree | `node <skill-root>/scripts/cdp-bridge.js tree --depth 5` |
| Network activity | `node <skill-root>/scripts/cdp-bridge.js network --duration 15` |
| HMR events | `<skill-root>/scripts/hmr.sh watch --duration 30` |
| Bundle availability | `<skill-root>/scripts/metro.sh bundle-check ios` |
| Stack symbolication | `<skill-root>/scripts/metro.sh symbolicate <stack-file>` |

Read [references/metro-endpoints.md](references/metro-endpoints.md) only when direct Metro endpoints or troubleshooting details are needed.

## Safety and scope

- Use Node.js 22 or later for the CDP bridge.
- Keep evaluations read-only unless the user explicitly authorizes state mutation.
- Bound log, network, HMR, and tree capture duration and depth.
- Redact access tokens, cookies, authorization headers, and user secrets from reports.
- Do not start or stop Metro, clean caches, rebuild native projects, or relaunch apps unless those actions are within the user's request.
- Prefer source inspection when runtime evidence is unnecessary.
- If parallel agents are available and the investigation has independent probes, delegate bounded probes and combine their evidence.

## Report the result

State the observed failure, the evidence that supports it, the affected platform, and what is confirmed versus inferred. Recommend the narrowest next action. Implement a fix only when the request includes implementation.
