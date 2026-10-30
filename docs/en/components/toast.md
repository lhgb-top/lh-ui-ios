# Toast

A declarative lightweight toast. `@Binding var visible` controls visibility; it disappears automatically after a duration, and its dark background takes the `color.ink` token.

> Spec source: `lh-ui-core/specs/toast.json` ·
> Golden cases: `lh-ui-core/cases/toast.json` (6 entries, translated into XCTest, runnable on the macOS host)

## Types

The default type has no icon; the other types show a semantic-colored dot to the left of the text. A dark background with white text, with contrast guaranteed by `color.ink`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Toast types</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">Default</button></div>
  </div>
  <div class="sim-toast">Saved</div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Toast semantic</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--success">Success</button></div>
  </div>
  <div class="sim-toast"><span class="sim-toast__dot sim-toast__dot--success"></span>Operation succeeded</div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

```swift
@State private var visible = false

LhToast(visible: $visible, text: "Saved", type: .success)
```

## Position

Three positions: `top` (top), `center` (centered, the default), `bottom` (bottom).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Toast position</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">bottom position</button></div>
  </div>
  <div class="sim-toast sim-toast--bottom"><span class="sim-toast__dot sim-toast__dot--warning"></span>Bottom toast</div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

## Auto-dismiss

When `visible` becomes `true`, a `.task` timer starts; after `duration` milliseconds it sets `visible` back to `false` and fires `onClose`
(golden case `auto-hides-after-duration`); while the timer has not elapsed it stays visible without firing any callback
(`tick-before-duration-keeps-visible`); setting it to `false` manually from the outside fires no callback (`hide-is-silent`).

::: tip Duration unit
The `toast.duration` token is in milliseconds (2000), while SwiftUI's `Task.sleep` needs seconds, so the end converts with
`Double(duration) / 1000` (see `LhToastStyle`).
:::

```swift
LhToast(visible: $visible, text: "Operation succeeded", type: .success, duration: 2000) {
  // onClose (fired only on auto-dismiss)
}
```

## API

### Props

| Prop | Description | Type | Default |
| --- | --- | --- | --- |
| `visible` | Whether visible (controlled two-way binding; set back to false automatically when the duration elapses) | `Bool` | — |
| `text` | Toast text | `String` | — |
| `type` | Toast type, decides whether a dot is shown and its color | `LhToastType` | `.default` |
| `lhPosition` | Display position | `LhToastPosition` | `.center` |
| `duration` | Display duration (milliseconds) | `Int` | `2000` (from the `toast.duration` token) |
| `onClose` | Auto-dismiss callback (not fired when hidden manually from the outside) | `(() -> Void)?` | `nil` |

### LhToastType

| Value | Dot color |
| --- | --- |
| `.default` | No dot |
| `.success` | `color.success.default` |
| `.warning` | `color.warning.default` |
| `.danger` | `color.danger.default` |
| `.info` | `color.info.default` |

### LhToastPosition

| Value | Position |
| --- | --- |
| `.top` | Top (offset `spacing.xl`) |
| `.center` | Centered |
| `.bottom` | Bottom (offset `spacing.xl`) |

## Token Reference

| Token | Purpose |
| --- | --- |
| `toast.paddingHorizontal` / `toast.paddingVertical` | Padding |
| `toast.fontSize` | Toast text font size |
| `toast.borderRadius` | Corner radius (follows `radius.small`) |
| `toast.gap` | Gap between the dot and the text |
| `toast.duration` | Default display duration (milliseconds) |
| `color.ink` | Dark background (with a dedicated dark override, to separate it from the page background) |
| `color.onPrimary` | White text |
| `color.{success,warning,danger,info}.default` | Dot semantic colors |
| `zIndex.toast` | Stacking order |
| `spacing.xl` | Top / bottom position offset |

## Golden Case Mapping

| case id | Assertion | Local test |
| --- | --- | --- |
| `show-makes-visible` | Shown means rendered | `testShowMakesVisible` |
| `auto-hides-after-duration` | Hides automatically when the duration elapses and fires onClose | `testDurationConvertsToSeconds` |
| `tick-before-duration-keeps-visible` | Stays visible while the timer has not elapsed | `testVisibleDuringDuration` |
| `hide-is-silent` | A manual hide from the outside fires no callback | `testHideIsSilent` |
| `success-type-uses-success-token` | The success type consumes the success color and the ink token | `testSuccessTypeUsesSuccessToken` / `testInkBackgroundUsesInkToken` |
| `hidden-emits-no-commands` | When hidden, the draw commands are empty | `testHiddenNotRendered` |

Plus dedicated tests: `testDefaultTypeHasNoDot` / `testLayoutUsesToastTokens` /
`testDarkColorsComeFromDarkTokens` / `testDarkInkDiffersFromLightInk` /
`testDimensionsAreIdenticalInDarkMode` / `testToastViewInitAcceptsConstant`.

```bash
swift test --filter LhToastTests    # Runs on the macOS host, no simulator required
```
