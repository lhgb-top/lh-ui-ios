# Dialog

A declarative modal dialog. `@Binding var visible` controls visibility; it renders a backdrop plus a centered panel, and its buttons reuse `LhButton`.

> Spec source: `lh-ui-core/specs/dialog.json` ·
> Golden cases: `lh-ui-core/cases/dialog.json` (8 entries, translated into XCTest, runnable on the macOS host)

## Types

Six types determine the semantic color of the confirm button (`buttonType(for:)` maps to `LhButtonType`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Dialog types</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary">Default dialog</button>
      <button class="sim-btn sim-btn--danger">Danger dialog</button>
    </div>
  </div>
  <div class="sim-dialog-mask"></div>
  <div class="sim-dialog">
    <div class="sim-dialog__title">Confirm deletion</div>
    <div class="sim-dialog__content">This action will permanently delete the item. Continue?</div>
    <div class="sim-dialog__actions">
      <button class="sim-btn">Cancel</button>
      <button class="sim-btn sim-btn--danger">Confirm</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

```swift
@State private var visible = false

LhDialog(
  visible: $visible,
  title: "Confirm deletion",
  content: "This action will permanently delete the item. Continue?",
  type: .danger,
  confirmText: "Confirm",
  cancelText: "Cancel"
)
```

## Visibility and callbacks

- `visible = true` renders the backdrop and the panel; `visible = false` emits no draw commands at all (golden case `hidden-not-rendered`).
- Tapping "Confirm" fires `onConfirm` and then `onClose` in order (`confirm-also-emits-onclose`).
- Tapping "Cancel" fires `onCancel`; `onClose` is responsible for setting `visible` back to `false` inside the component (wrapped in `withAnimation`).
- When `closable = true`, tapping the backdrop also fires `onClose` (`closable-overlay-emits-onclose`); by default it does not close (`not-closable-blocks-overlay-close`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Dialog backdrop closable</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">closable = true</button></div>
  </div>
  <div class="sim-dialog-mask"></div>
  <div class="sim-dialog">
    <div class="sim-dialog__title">Notice</div>
    <div class="sim-dialog__content">Tap the backdrop to close</div>
    <div class="sim-dialog__actions">
      <button class="sim-btn">Cancel</button>
      <button class="sim-btn sim-btn--primary">Confirm</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

## API

### Props

| Prop | Description | Type | Default |
| --- | --- | --- | --- |
| `visible` | Whether visible (controlled two-way binding) | `Bool` | — |
| `title` | Title | `String` | `""` |
| `content` | Body content | `String` | `""` |
| `type` | Dialog type, determines the confirm button's semantic color | `LhDialogType` | `.default` |
| `confirmText` | Confirm button text | `String` | `"确认"` |
| `cancelText` | Cancel button text | `String` | `"取消"` |
| `closable` | Whether a backdrop tap can close it | `Bool` | `false` |
| `onConfirm` | Confirm callback | `(() -> Void)?` | `nil` |
| `onCancel` | Cancel callback | `(() -> Void)?` | `nil` |
| `onClose` | Close callback (fired by a backdrop tap, the Cancel button, and the Confirm button) | `(() -> Void)?` | `nil` |

### LhDialogType

| Value | Confirm button type | Background |
| --- | --- | --- |
| `.default` | `.default` | `color.background.default` + border |
| `.primary` | `.primary` | `color.primary.default` |
| `.success` | `.success` | `color.success.default` |
| `.warning` | `.warning` | `color.warning.default` |
| `.danger` | `.danger` | `color.danger.default` |
| `.info` | `.info` | `color.info.default` |

## Token Reference

| Token | Purpose |
| --- | --- |
| `dialog.width` | Panel width (320pt) |
| `dialog.paddingHorizontal` / `dialog.paddingVertical` | Panel padding |
| `dialog.borderRadius` | Panel corner radius |
| `dialog.titleFontSize` / `dialog.contentFontSize` | Title and body font sizes |
| `dialog.gap` | Vertical gap between sections |
| `color.background.overlay` | Backdrop color |
| `color.background.default` | Panel background |
| `color.text.{primary,regular}` | Title and body colors |
| `shadow.base` | Panel shadow (LhShadow carrier) |
| `zIndex.{modalBackdrop,modal}` | Backdrop and panel stacking order |

## Golden Case Mapping

| case id | Assertion | Local test |
| --- | --- | --- |
| `confirm-emits-onconfirm` | Confirming fires onConfirm | `testConfirmUsesTypeColor` |
| `cancel-emits-oncancel` | Canceling fires onCancel | `testCancelUsesNeutralColor` |
| `confirm-also-emits-onclose` | Confirming also fires onClose | `testConfirmUsesTypeColor` |
| `closable-overlay-emits-onclose` | A backdrop tap fires onClose | `testClosableFlagIsExposed` |
| `not-closable-blocks-overlay-close` | By default the backdrop does not close it | `testNotClosableBlocksOverlay` |
| `hidden-not-rendered` | When hidden, nothing is rendered | `testHiddenNotRendered` |
| `title-renders-text` | The title renders correctly | `testTitleUsesTitleTokens` |
| `danger-type-uses-danger-token` | The danger type consumes the danger token | `testDangerTypeUsesDangerToken` |

Plus dedicated tests: `testVisibleRendersAppearance` / `testLayoutUsesDialogTokens` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testDialogViewInitAcceptsConstant`.

```bash
swift test --filter LhDialogTests    # Runs on the macOS host, no simulator required
```
