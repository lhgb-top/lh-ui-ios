# Picker

A declarative bottom wheel picker. `@Binding var visible` controls visibility and `@Binding var value` is the selected index;
the wheel is self-drawn (`DragGesture` + snap on release), with no dependency on system controls.

> Spec source: `lh-ui-core/specs/picker.json` ·
> Golden cases: `lh-ui-core/cases/picker.json` (8 entries, translated into XCTest, runnable on the macOS host)

## Basic usage

It pops up from the bottom: a top toolbar (cancel / title / confirm), with the wheel and two indicator lines in the middle.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Picker basic</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">Picker</button></div>
  </div>
  <div class="sim-picker-mask"></div>
  <div class="sim-picker">
    <div class="sim-picker__toolbar">
      <span class="sim-picker__btn">Cancel</span>
      <span class="sim-picker__title">Select</span>
      <span class="sim-picker__btn sim-picker__btn--confirm">Confirm</span>
    </div>
    <div class="sim-picker__wheel">
      <div class="sim-picker__indicator"></div>
      <div class="sim-picker__item">Option one</div>
      <div class="sim-picker__item sim-picker__item--selected">Option two</div>
      <div class="sim-picker__item">Option three</div>
    </div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

```swift
@State private var visible = false
@State private var index = 1
let options = ["Option one", "Option two", "Option three"]

LhPicker(
  visible: $visible,
  options: options,
  value: $index,
  title: "Select"
)
```

## Wheel interaction

- Dragging changes the overall offset; on release it snaps to the nearest candidate (animation duration `motion.duration.base`),
  and when the selected index changes `onValueChange` fires (golden case `scroll-emits-onvaluechange`).
- The gap between the indicator lines equals `picker.itemHeight`, and the selected item always lands exactly between them.

## Callbacks and boundaries

- "Confirm" fires `onConfirm` (payload is the current index) and `onClose` (`confirm-also-emits-onclose`).
- "Cancel" fires `onCancel`.
- When `value` is out of range, the end clamps it: negatives go to zero (`clamp-negative-value-to-zero`), overflows go to the last item
  (`clamp-overflow-value-to-last`); with an empty options list the index is always 0.
- When `visible = false`, no draw commands are emitted at all (`hidden-not-rendered`).

```swift
LhPicker(
  visible: $visible,
  options: options,
  value: $index,
  title: "Select",
  confirmText: "Confirm",
  cancelText: "Cancel",
  onValueChange: { newIndex in
    // Scroll snap callback
  },
  onConfirm: { newIndex in
    // Confirm callback (payload is the current index)
  },
  onCancel: {
    // Cancel callback
  }
)
```

## API

### Props

| Prop | Description | Type | Default |
| --- | --- | --- | --- |
| `visible` | Whether visible (controlled two-way binding) | `Bool` | — |
| `options` | Array of candidate texts (a single column) | `[String]` | — |
| `value` | Selected index (controlled two-way binding; clamped when out of range) | `Int` | — |
| `title` | Toolbar title | `String` | `""` |
| `confirmText` | Confirm button text; `nil` (default) uses the language pack | `String?` | Language pack (Simplified Chinese `"确认"`) |
| `cancelText` | Cancel button text; `nil` (default) uses the language pack | `String?` | Language pack (Simplified Chinese `"取消"`) |
| `onValueChange` | Scroll snap callback; the payload is the new index | `((Int) -> Void)?` | `nil` |
| `onConfirm` | Confirm callback; the payload is the current index | `((Int) -> Void)?` | `nil` |
| `onCancel` | Cancel callback | `(() -> Void)?` | `nil` |
| `onClose` | Close callback (fired by both confirm and cancel) | `(() -> Void)?` | `nil` |

### Colors

| Area | Color |
| --- | --- |
| Panel background | `color.background.default` |
| Backdrop | `color.background.overlay` |
| Cancel button / candidate texts | `color.text.primary` |
| Title / confirm button | `color.primary.default` |
| Indicator lines | `color.border.lighter` (width from `cell.borderWidth`) |

## Token Reference

| Token | Purpose |
| --- | --- |
| `picker.height` | Panel height (260pt) |
| `picker.toolbarHeight` | Toolbar height (44pt) |
| `picker.itemHeight` | Per-item height (determines the wheel and the indicator gap) |
| `picker.itemFontSize` | Candidate and toolbar font size |
| `picker.borderRadius` | Top corner radius |
| `color.background.overlay` / `color.background.default` | Backdrop and panel background |
| `color.border.lighter` / `cell.borderWidth` | Indicator line color and width |
| `color.primary.default` | Confirm button and selected item text color |
| `zIndex.{modalBackdrop,modal}` | Backdrop and panel stacking order |
| `motion.duration.base` | Snap animation duration (seconds on the iOS end) |

## Golden Case Mapping

| case id | Assertion | Local test |
| --- | --- | --- |
| `confirm-emits-onconfirm-with-value` | Confirming fires `onConfirm(1)` | `testConfirmUsesPrimaryToken` |
| `confirm-also-emits-onclose` | Confirming also fires onClose | `testConfirmUsesPrimaryToken` |
| `cancel-emits-oncancel` | Canceling fires onCancel | `testCancelUsesNeutralColor` |
| `scroll-emits-onvaluechange` | A scroll snap fires `onValueChange(2)` | View layer `DragGesture.onEnded` (gesture assertions need a simulator) |
| `clamp-negative-value-to-zero` | A negative index clamps to 0 | `testClampNegativeValueToZero` |
| `clamp-overflow-value-to-last` | An overflowing index clamps to the last item | `testClampOverflowValueToLast` |
| `title-renders-text` | The title renders correctly | `testTitleAndTextsAreExposed` |
| `hidden-not-rendered` | When hidden, nothing is rendered | `testHiddenNotRendered` |

Plus dedicated tests: `testVisibleRendersAppearance` / `testClampedValueIsExposed` /
`testLayoutUsesPickerTokens` / `testEmptyOptionsClampsToZero` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testPickerViewInitAcceptsConstant`.

```bash
swift test --filter LhPickerTests    # Runs on the macOS host, no simulator required
```
