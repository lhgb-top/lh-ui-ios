# Checkbox

A controlled checkbox. `@Binding var checked` provides two-way binding; it supports three states (checked / unchecked / indeterminate).

> Spec source: `lh-ui-core/specs/checkbox.json` ·
> Golden cases: `lh-ui-core/cases/checkbox.json` (6 entries, translated into XCTest, runnable on the macOS host)

## States

The checked state is a solid primary-colored square with a white check mark; the indeterminate state is a solid primary-colored square with a white dash; the unchecked state is an empty outlined box.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Checkbox states</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-checkbox"><span class="sim-checkbox__box"></span>Unchecked</span>
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>Checked</span>
    </div>
    <div class="sim-row">
      <span class="sim-checkbox sim-checkbox--indeterminate"><span class="sim-checkbox__box"><span class="sim-checkbox__dash"></span></span>Indeterminate</span>
      <span class="sim-checkbox sim-checkbox--checked sim-checkbox--disabled"><span class="sim-checkbox__box"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>Disabled</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

```swift
@State private var checked = false

LhCheckbox(checked: $checked, label: "Checked") { newValue in
  // onChange
}
```

## Sizes

Three sizes map to the `checkbox.size` tokens; the check stroke width comes from `checkbox.checkWidth`,
and the indeterminate dash width is the box size times `checkbox.dashScale` (50%).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Checkbox sizes</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box sim-checkbox__box--small"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>Small</span>
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>Medium</span>
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box sim-checkbox__box--large"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>Large</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

## Indeterminate state

When `indeterminate = true`, a dash is shown instead of a check mark; a tap always flips it to **checked** (golden case
`indeterminate-becomes-checked`), rather than toggling.

```swift
@State private var checked = false

LhCheckbox(checked: $checked, label: "Select all", indeterminate: somePartial) { _ in }
```

## API

### Props

| Prop | Description | Type | Default |
| --- | --- | --- | --- |
| `checked` | Checked state (controlled two-way binding) | `Bool` | — |
| `indeterminate` | Whether indeterminate (shows a dash; a tap turns it checked) | `Bool` | `false` |
| `disabled` | Whether disabled (does not fire onChange) | `Bool` | `false` |
| `lhSize` | Checkbox size, mapped to the size tokens | `LhCheckboxSize` | `.medium` |
| `label` | Text label | `String` | `""` |
| `onChange` | State-change callback; the payload is the new value | `((Bool) -> Void)?` | `nil` |

### LhCheckboxSize

| Value | Size |
| --- | --- |
| `.small` | `checkbox.size.small` (16pt) |
| `.medium` | `checkbox.size.medium` (20pt) |
| `.large` | `checkbox.size.large` (24pt) |

### Colors

| State | Box background | Mark color |
| --- | --- | --- |
| Unchecked | Transparent + `color.border.base` border (`checkbox.borderWidth`) | — |
| Checked / indeterminate | `color.primary.default` | `color.onPrimary` |
| Disabled | `color.disabled.bg` + `color.disabled.border` border | `color.disabled.text` |

## Token Reference

| Token | Purpose |
| --- | --- |
| `checkbox.size.{small,medium,large}` | Three sizes |
| `checkbox.borderRadius` / `checkbox.borderWidth` | Corner radius (follows `radius.small`) and border width |
| `checkbox.checkWidth` | Check-mark stroke width |
| `checkbox.dashScale` | Ratio of the indeterminate dash to the box (50%) |
| `checkbox.gap` | Gap between the box and the text (follows `spacing.sm`) |
| `color.primary.default` / `color.onPrimary` | Checked background / mark color |
| `color.border.base` | Unchecked border color |
| `color.disabled.{bg,border,text}` | Three disabled colors |

## Golden Case Mapping

| case id | Assertion | Local test |
| --- | --- | --- |
| `tap-toggles-and-emits-onchange` | A tap flips the state and fires `onChange(true)` | `testTapTogglesAndEmitsOnChange` |
| `tap-checked-unchecks` | Tapping a checked box unchecks it | `testTapCheckedUnchecks` |
| `disabled-blocks-change` | The disabled state does not fire onChange | `testDisabledBlocksChange` |
| `checked-uses-primary-tokens` | The checked state consumes primary and onPrimary | `testCheckedUsesPrimaryTokens` |
| `unchecked-uses-border-token` | The unchecked state consumes the border token | `testUncheckedUsesBorderToken` |
| `indeterminate-becomes-checked` | Tapping the indeterminate state always yields checked | `testIndeterminateBecomesChecked` |

Plus dedicated tests: `testSizeUsesSizeTokens` / `testStrokeUsesCheckboxTokens` /
`testDarkColorsComeFromDarkTokens` / `testDisabledInDarkUsesDarkDisabledTokens` /
`testDimensionsAreIdenticalInDarkMode` / `testCheckboxViewInitAcceptsConstant`.

```bash
swift test --filter LhCheckboxTests    # Runs on the macOS host, no simulator required
```
