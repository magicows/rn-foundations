---
name: ios-simulator-control
description: Control and inspect a booted iOS Simulator with deterministic wrappers around xcrun simctl and AXe. Use for simulator screenshots, recordings, accessibility inspection, taps, typing, swipes, app installation, and app launching on macOS.
---

# iOS Simulator Control

Resolve `<skill-root>` to the absolute directory containing this file, then run the bundled scripts from `<skill-root>/scripts`.

## Preflight

Confirm that Xcode can see a booted simulator:

```bash
<skill-root>/scripts/device.sh booted
```

Commands that inspect or manipulate UI elements also require AXe:

```bash
command -v axe
```

If either check fails, read [references/troubleshooting.md](references/troubleshooting.md).

## Choose the smallest useful command

| Need | Command |
| --- | --- |
| Identify the booted simulator | `<skill-root>/scripts/device.sh booted` |
| Capture an image for visual inspection | `<skill-root>/scripts/capture.sh view` |
| Save a screenshot | `<skill-root>/scripts/capture.sh screenshot <path>` |
| Start or stop a recording | `<skill-root>/scripts/capture.sh record <path>` / `<skill-root>/scripts/capture.sh stop` |
| List visible labeled elements | `<skill-root>/scripts/ui.sh list` |
| Read the accessibility tree | `<skill-root>/scripts/ui.sh describe-all` |
| Inspect one screen point | `<skill-root>/scripts/ui.sh describe-point <x> <y>` |
| Tap by label or identifier | `<skill-root>/scripts/ui.sh tap-label <label>` / `<skill-root>/scripts/ui.sh tap-id <id>` |
| Tap or long-press a point | `<skill-root>/scripts/ui.sh tap <x> <y> [--duration <seconds>]` |
| Type into the focused control | `<skill-root>/scripts/ui.sh type <text>` |
| Swipe | `<skill-root>/scripts/ui.sh swipe <x1> <y1> <x2> <y2>` |
| Navigate back | `<skill-root>/scripts/ui.sh back` |
| Scroll to an edge | `<skill-root>/scripts/ui.sh scroll top\|bottom` |
| Install an app bundle | `<skill-root>/scripts/app.sh install <path-to-app>` |
| Launch an app | `<skill-root>/scripts/app.sh launch <bundle-id>` |

Pass `--udid <UUID>` to target a specific simulator when more than one is booted.

## Interaction workflow

For multi-step interaction:

1. Inspect the current state with `ui.sh list`, `ui.sh describe-all`, or `capture.sh view`.
2. Prefer label or accessibility-identifier taps over coordinates.
3. Use point coordinates from the accessibility tree for coordinate taps and swipes. Screenshot pixels may use a different scale.
4. Perform only the actions requested by the user.
5. Inspect the resulting state and report what was observed.

Use the available image viewer when visual interpretation is needed. Keep large accessibility-tree output out of the final response; summarize the relevant elements instead.

## Scope and safety

- Treat screenshots, element listing, and accessibility inspection as read-only.
- Install, launch, tap, type, swipe, scroll, and recording commands change simulator state; use them only when the request includes that interaction.
- Do not shut down, erase, or reset simulators unless the user explicitly requests it.
- Never infer successful interaction from a command's exit status alone; verify the resulting UI state.
- `ui.sh type` accepts printable ASCII text up to 500 characters.
