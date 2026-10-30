# Switch

A controlled switch. `@Binding var checked` provides two-way binding; the track has a 2:1 ratio and the thumb diameter is height − 2 × `switch.gap`.

> Spec source: `lh-ui-core/specs/switch.json` ·
> Golden cases: `lh-ui-core/cases/switch.json` (6 entries, translated into XCTest, runnable on the macOS host)

## States

When on, the track is primary-colored and the thumb moves right; when off, the track takes the border color. The `loading` state shows a small indicator inside the track and does not respond to toggles.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Switch states</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-switch"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--on"><span class="sim-switch__thumb"></span></span>
    </div>
    <div class="sim-row">
      <span class="sim-switch sim-switch--on sim-switch--disabled"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--disabled"><span class="sim-switch__thumb"></span></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

```swift
@State private var on = true

LhSwitch(checked: $on) { newValue in
  // onChange
}
```

## Sizes

Three sizes map to the `switch.width` / `switch.height` tokens; the corner radius automatically becomes the track radius from the height.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Switch sizes</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-switch sim-switch--small sim-switch--on"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--on"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--large sim-switch--on"><span class="sim-switch__thumb"></span></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

## Loading state

When `loading = true`, an `LhLoading(lhSize: .small, tone: .primary)` is embedded in the track and taps are blocked by the gate
(golden case `loading-blocks-change`).

```swift
LhSwitch(checked: $submitting, loading: submitting) { _ in }
```

## API

### Props

| Prop | Description | Type | Default |
| --- | --- | --- | --- |
| `checked` | Switch state (controlled two-way binding) | `Bool` | — |
| `disabled` | Whether disabled (does not fire onChange) | `Bool` | `false` |
| `loading` | Whether loading (embeds an indicator, does not fire onChange) | `Bool` | `false` |
| `lhSize` | Switch size, mapped to the size tokens | `LhSwitchSize` | `.medium` |
| `onChange` | State-change callback; the payload is the new value | `((Bool) -> Void)?` | `nil` |

### LhSwitchSize

| Value | width | height | Thumb diameter |
| --- | --- | --- | --- |
| `.small` | `switch.width.small` (36pt) | `switch.height.small` (20pt) | height − 2 × `switch.gap` (16pt) |
| `.medium` | `switch.width.medium` (44pt) | `switch.height.medium` (24pt) | height − 2 × `switch.gap` (20pt) |
| `.large` | `switch.width.large` (52pt) | `switch.height.large` (28pt) | height − 2 × `switch.gap` (24pt) |

### Colors

| State | Track | Thumb |
| --- | --- | --- |
| Off | `color.border.base` | `color.onPrimary` |
| On | `color.primary.default` | `color.onPrimary` |
| Disabled | `color.disabled.bg` | `color.disabled.text` |

## Token Reference

| Token | Purpose |
| --- | --- |
| `switch.width.{small,medium,large}` | Three track widths |
| `switch.height.{small,medium,large}` | Three track heights |
| `switch.gap` | Inner gap between the thumb and the track (determines the thumb diameter) |
| `color.primary.default` | On track color |
| `color.border.base` | Off track color |
| `color.onPrimary` | Thumb color |
| `color.disabled.{bg,text}` | Two disabled colors |
| `motion.duration.base` | Thumb slide animation duration (seconds on the iOS end) |

## Golden Case Mapping

| case id | Assertion | Local test |
| --- | --- | --- |
| `tap-toggles-and-emits-onchange` | A tap turns it on and fires `onChange(true)` | `testDefaultIsInteractive` |
| `tap-checked-turns-off` | Tapping the on state turns it off | `testCheckedUsesPrimaryTrack` |
| `disabled-blocks-change` | The disabled state does not fire onChange | `testDisabledBlocksChange` |
| `loading-blocks-change` | The loading state does not fire onChange | `testLoadingBlocksChange` |
| `checked-uses-primary-token` | The on state consumes the primary token, not the border token | `testCheckedUsesPrimaryToken` |
| `unchecked-uses-border-token` | The off state consumes the border token | `testUncheckedUsesBorderToken` |

Plus dedicated tests: `testSizeUsesSwitchTokens` / `testThumbDiameterIsHeightMinusTwoGaps` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testSwitchViewInitAcceptsConstant`.

```bash
swift test --filter LhSwitchTests    # Runs on the macOS host, no simulator required
```
