# iOS Simulator Troubleshooting

## Prerequisites

- **macOS only** — these scripts use `xcrun simctl` and `AXe` which are macOS-specific
- **Xcode** installed with iOS simulators
- **AXe** installed for UI interactions (tap, type, swipe, describe)

## Installing AXe

```sh
brew install cameroncooke/axe/axe
axe --version  # verify
```

## Common Issues

### "No booted simulator found"
- Open Xcode and boot a simulator, or run: `xcrun simctl boot <device-name>`
- Verify with: `xcrun simctl list devices | grep Booted`

### "AXe is not installed"
- Install AXe using the steps above
- Check PATH: `which axe` or `echo $PATH`
- Set custom path: `export IOS_SIMULATOR_AXE_PATH=/path/to/axe`

### Taps/swipes hitting wrong location
- Screenshots may use a different pixel scale from accessibility coordinates
- The accessibility tree reports **point** coordinates
- Always use point coordinates (from `describe-all`) for tap/swipe targets
- Prefer accessibility-tree point coordinates over estimating from screenshots

### Permission or file errors
- Check write permissions on the output directory
- Default output goes to `~/Downloads` (override with `IOS_SIMULATOR_OUTPUT_DIR`)

### Simulator UI not responding
- Re-inspect the accessibility tree after transitions or keyboard changes
- If the user requested a simulator restart, use `xcrun simctl shutdown <udid>` and then boot that same explicit device

## Environment Variables

| Variable | Default | Purpose |
|----------|---------|---------|
| `IOS_SIMULATOR_AXE_PATH` | `axe` | Custom path to AXe executable |
| `IOS_SIMULATOR_OUTPUT_DIR` | `~/Downloads` | Default directory for screenshots/recordings |
