# Radio

A controlled radio. `@Binding var checked` expresses "whether this item is selected"; it is usually used inside a group, where only one item in the same group can be `true`.

> Spec source: `lh-ui-core/specs/radio.json` ·
> Golden cases: `lh-ui-core/cases/radio.json` (6 entries, translated into XCTest, runnable on the macOS host)

## States

The selected state is an outlined primary-colored ring with a solid primary-colored dot; the unselected state is an empty outlined ring. The dot diameter is the size times `radio.dotScale` (50%).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Radio states</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-radio"><span class="sim-radio__ring"></span>Unselected</span>
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>Selected</span>
    </div>
    <div class="sim-row">
      <span class="sim-radio sim-radio--checked sim-radio--disabled"><span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>Disabled selected</span>
      <span class="sim-radio sim-radio--disabled"><span class="sim-radio__ring"></span>Disabled unselected</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

```swift
@State private var picked = "blue"

LhRadio(checked: Binding(get: { picked == "blue" }, set: { _ in }), value: "blue", label: "青花瓷 (ceramic blue)") { _ in
  picked = "blue"
}
```

## Sizes

Three sizes map to the `radio.size` tokens; the ring stroke comes from `radio.ringWidth`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Radio sizes</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring sim-radio__ring--small"><span class="sim-radio__dot sim-radio__dot--small"></span></span>Small</span>
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>Medium</span>
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring sim-radio__ring--large"><span class="sim-radio__dot sim-radio__dot--large"></span></span>Large</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

## Tap gate

Tapping an already-selected item keeps it selected and does not fire `onChange` (golden case `tap-checked-keeps-checked`);
the disabled state does not fire either (`disabled-blocks-change`). A group container is left for a later release.

## API

### Props

| Prop | Description | Type | Default |
| --- | --- | --- | --- |
| `checked` | Whether this item is selected (controlled two-way binding) | `Bool` | — |
| `value` | The value this item represents (paired with `checked` to build a radio group) | `String` | `""` |
| `disabled` | Whether disabled (does not fire onChange) | `Bool` | `false` |
| `lhSize` | Radio size, mapped to the size tokens | `LhRadioSize` | `.medium` |
| `label` | Text label | `String` | `""` |
| `onChange` | Selection-change callback; the payload is the new value | `((Bool) -> Void)?` | `nil` |

### LhRadioSize

| Value | Ring size | Dot diameter |
| --- | --- | --- |
| `.small` | `radio.size.small` (16pt) | size × `radio.dotScale` (8pt) |
| `.medium` | `radio.size.medium` (20pt) | size × `radio.dotScale` (10pt) |
| `.large` | `radio.size.large` (24pt) | size × `radio.dotScale` (12pt) |

### Colors

| State | Ring border | Dot |
| --- | --- | --- |
| Unselected | `color.border.base` (`radio.ringWidth`) | — |
| Selected | `color.primary.default` | `color.primary.default` |
| Disabled | `color.disabled.border` | `color.disabled.text` |

## Token Reference

| Token | Purpose |
| --- | --- |
| `radio.size.{small,medium,large}` | Three ring sizes |
| `radio.dotScale` | Ratio of the dot to the ring size (50%) |
| `radio.ringWidth` | Ring border width |
| `radio.gap` | Gap between the ring and the text (follows `spacing.sm`) |
| `color.primary.default` | Selected border and dot color |
| `color.border.base` | Unselected border color |
| `color.disabled.{border,text}` | Disabled border and dot color |
| `color.text.{primary,disabled}` | Label text colors |

## Golden Case Mapping

| case id | Assertion | Local test |
| --- | --- | --- |
| `tap-unchecked-emits-onchange` | Tapping an unselected item fires `onChange(true)` | `testUncheckedIsInteractive` |
| `tap-checked-keeps-checked` | Tapping a selected item keeps it selected with no callback | `testCheckedShowsDot` |
| `disabled-blocks-change` | The disabled state does not fire onChange | `testDisabledBlocksChange` |
| `checked-uses-primary-tokens` | The selected state consumes the primary token | `testCheckedUsesPrimaryTokens` |
| `unchecked-uses-border-token` | The unselected state consumes the border token | `testUncheckedUsesBorderToken` |
| `small-size-uses-small-token` | The small size consumes the small size token | `testSmallSizeUsesSmallToken` |

Plus dedicated tests: `testStrokeUsesRadioTokens` / `testDarkColorsComeFromDarkTokens` /
`testDisabledInDarkUsesDarkDisabledTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testRadioViewInitAcceptsConstant`.

```bash
swift test --filter LhRadioTests    # Runs on the macOS host, no simulator required
```
