# Checkbox 核取方塊

受控核取方塊。`@Binding var checked` 雙向綁定，支援三態（勾選 / 未勾選 / 不確定）。

> 契約源：`lh-ui-core/specs/checkbox.json` ·
> 黃金用例：`lh-ui-core/cases/checkbox.json`（6 條，已翻譯為 XCTest，macOS 宿主即可執行）

## 狀態

勾選態為實心主色方塊 + 白色勾形；不確定態為實心主色方塊 + 白色橫槓；未勾選為描邊空框。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Checkbox 狀態</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-checkbox"><span class="sim-checkbox__box"></span>未勾選</span>
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>已勾選</span>
    </div>
    <div class="sim-row">
      <span class="sim-checkbox sim-checkbox--indeterminate"><span class="sim-checkbox__box"><span class="sim-checkbox__dash"></span></span>不確定</span>
      <span class="sim-checkbox sim-checkbox--checked sim-checkbox--disabled"><span class="sim-checkbox__box"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>停用</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

```swift
@State private var checked = false

LhCheckbox(checked: $checked, label: "已勾選") { newValue in
  // onChange
}
```

## 尺寸

三檔尺寸對應到 `checkbox.size` 令牌；勾形描邊寬度取 `checkbox.checkWidth`，
不確定態橫槓寬度為方塊尺寸乘 `checkbox.dashScale`（50%）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Checkbox 尺寸</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box sim-checkbox__box--small"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>小號</span>
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>中號</span>
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box sim-checkbox__box--large"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>大號</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

## 不確定態

`indeterminate = true` 時不顯示勾形而顯示橫槓；點選後必定變為**勾選**（黃金用例
`indeterminate-becomes-checked`），而非切換。

```swift
@State private var checked = false

LhCheckbox(checked: $checked, label: "全選", indeterminate: somePartial) { _ in }
```

## API

### Props

| 屬性 | 說明 | 類型 | 預設值 |
| --- | --- | --- | --- |
| `checked` | 勾選狀態（受控雙向綁定） | `Bool` | — |
| `indeterminate` | 是否不確定態（顯示橫槓，點選後變勾選） | `Bool` | `false` |
| `disabled` | 是否停用（不觸發 onChange） | `Bool` | `false` |
| `lhSize` | 核取方塊尺寸，對應到尺寸令牌 | `LhCheckboxSize` | `.medium` |
| `label` | 文字標籤 | `String` | `""` |
| `onChange` | 狀態變化回呼，payload 為新值 | `((Bool) -> Void)?` | `nil` |

### LhCheckboxSize

| 值 | 尺寸 |
| --- | --- |
| `.small` | `checkbox.size.small`（16pt） |
| `.medium` | `checkbox.size.medium`（20pt） |
| `.large` | `checkbox.size.large`（24pt） |

### 顏色

| 狀態 | 方塊底色 | 標記色 |
| --- | --- | --- |
| 未勾選 | 透明 + `color.border.base` 描邊（`checkbox.borderWidth`） | — |
| 勾選 / 不確定 | `color.primary.default` | `color.onPrimary` |
| 停用 | `color.disabled.bg` + `color.disabled.border` 描邊 | `color.disabled.text` |

## 令牌對照

| 令牌 | 用途 |
| --- | --- |
| `checkbox.size.{small,medium,large}` | 三檔尺寸 |
| `checkbox.borderRadius` / `checkbox.borderWidth` | 圓角（跟隨 `radius.small`）與描邊寬度 |
| `checkbox.checkWidth` | 勾形描邊寬度 |
| `checkbox.dashScale` | 不確定態橫槓相對方塊的比例（50%） |
| `checkbox.gap` | 方塊與文字間距（跟隨 `spacing.sm`） |
| `color.primary.default` / `color.onPrimary` | 勾選態底/標記色 |
| `color.border.base` | 未勾選描邊色 |
| `color.disabled.{bg,border,text}` | 停用態三色 |

## 黃金用例對照

| case id | 斷言 | 本地測試 |
| --- | --- | --- |
| `tap-toggles-and-emits-onchange` | 點選翻轉並回呼 `onChange(true)` | `testTapTogglesAndEmitsOnChange` |
| `tap-checked-unchecks` | 已勾選點選變未勾選 | `testTapCheckedUnchecks` |
| `disabled-blocks-change` | 停用態不觸發 onChange | `testDisabledBlocksChange` |
| `checked-uses-primary-tokens` | 勾選態消費主色與 onPrimary | `testCheckedUsesPrimaryTokens` |
| `unchecked-uses-border-token` | 未勾選消費描邊令牌 | `testUncheckedUsesBorderToken` |
| `indeterminate-becomes-checked` | 不確定態點選後必為勾選 | `testIndeterminateBecomesChecked` |

另有專項：`testSizeUsesSizeTokens` / `testStrokeUsesCheckboxTokens` /
`testDarkColorsComeFromDarkTokens` / `testDisabledInDarkUsesDarkDisabledTokens` /
`testDimensionsAreIdenticalInDarkMode` / `testCheckboxViewInitAcceptsConstant`。

```bash
swift test --filter LhCheckboxTests    # macOS 宿主即可執行，無需模擬器
```
