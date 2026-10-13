# Checkbox 复选框

受控复选框。`@Binding var checked` 双向绑定，支持三态（勾选 / 未勾选 / 不确定）。

> 契约源：`lh-ui-core/specs/checkbox.json` ·
> 黄金用例：`lh-ui-core/cases/checkbox.json`（6 条，已翻译为 XCTest，macOS 宿主即可运行）

## 状态

勾选态为实心主色方块 + 白色勾形；不确定态为实心主色方块 + 白色横杠；未勾选为描边空框。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Checkbox 状态</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-checkbox"><span class="sim-checkbox__box"></span>未勾选</span>
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>已勾选</span>
    </div>
    <div class="sim-row">
      <span class="sim-checkbox sim-checkbox--indeterminate"><span class="sim-checkbox__box"><span class="sim-checkbox__dash"></span></span>不确定</span>
      <span class="sim-checkbox sim-checkbox--checked sim-checkbox--disabled"><span class="sim-checkbox__box"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>禁用</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

```swift
@State private var checked = false

LhCheckbox(checked: $checked, label: "已勾选") { newValue in
  // onChange
}
```

## 尺寸

三档尺寸映射到 `checkbox.size` 令牌；勾形描边宽度取 `checkbox.checkWidth`，
不确定态横杠宽度为方框尺寸乘 `checkbox.dashScale`（50%）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Checkbox 尺寸</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box sim-checkbox__box--small"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>小号</span>
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>中号</span>
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box sim-checkbox__box--large"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>大号</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

## 不确定态

`indeterminate = true` 时不显示勾形而显示横杠；点击后必定变为**勾选**（黄金用例
`indeterminate-becomes-checked`），而非切换。

```swift
@State private var checked = false

LhCheckbox(checked: $checked, label: "全选", indeterminate: somePartial) { _ in }
```

## API

### Props

| 属性 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `checked` | 勾选状态（受控双向绑定） | `Bool` | — |
| `indeterminate` | 是否不确定态（显示横杠，点击后变勾选） | `Bool` | `false` |
| `disabled` | 是否禁用（不触发 onChange） | `Bool` | `false` |
| `size` | 复选框尺寸，映射到尺寸令牌 | `LhCheckboxSize` | `.medium` |
| `label` | 文字标签 | `String` | `""` |
| `onChange` | 状态变化回调，payload 为新值 | `((Bool) -> Void)?` | `nil` |

### LhCheckboxSize

| 值 | 尺寸 |
| --- | --- |
| `.small` | `checkbox.size.small`（16pt） |
| `.medium` | `checkbox.size.medium`（20pt） |
| `.large` | `checkbox.size.large`（24pt） |

### 颜色

| 状态 | 方块底色 | 标记色 |
| --- | --- | --- |
| 未勾选 | 透明 + `color.border.base` 描边（`checkbox.borderWidth`） | — |
| 勾选 / 不确定 | `color.primary.default` | `color.onPrimary` |
| 禁用 | `color.disabled.bg` + `color.disabled.border` 描边 | `color.disabled.text` |

## 令牌对照

| 令牌 | 用途 |
| --- | --- |
| `checkbox.size.{small,medium,large}` | 三档尺寸 |
| `checkbox.borderRadius` / `checkbox.borderWidth` | 圆角（跟随 `radius.small`）与描边宽度 |
| `checkbox.checkWidth` | 勾形描边宽度 |
| `checkbox.dashScale` | 不确定态横杠相对方框的比例（50%） |
| `checkbox.gap` | 方框与文字间距（跟随 `spacing.sm`） |
| `color.primary.default` / `color.onPrimary` | 勾选态底/标记色 |
| `color.border.base` | 未勾选描边色 |
| `color.disabled.{bg,border,text}` | 禁用态三色 |

## 黄金用例对照

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `tap-toggles-and-emits-onchange` | 点击翻转并回调 `onChange(true)` | `testTapTogglesAndEmitsOnChange` |
| `tap-checked-unchecks` | 已勾选点击变未勾选 | `testTapCheckedUnchecks` |
| `disabled-blocks-change` | 禁用态不触发 onChange | `testDisabledBlocksChange` |
| `checked-uses-primary-tokens` | 勾选态消费主色与 onPrimary | `testCheckedUsesPrimaryTokens` |
| `unchecked-uses-border-token` | 未勾选消费描边令牌 | `testUncheckedUsesBorderToken` |
| `indeterminate-becomes-checked` | 不确定态点击后必为勾选 | `testIndeterminateBecomesChecked` |

另有专项：`testSizeUsesSizeTokens` / `testStrokeUsesCheckboxTokens` /
`testDarkColorsComeFromDarkTokens` / `testDisabledInDarkUsesDarkDisabledTokens` /
`testDimensionsAreIdenticalInDarkMode` / `testCheckboxViewInitAcceptsConstant`。

```bash
swift test --filter LhCheckboxTests    # macOS 宿主即可跑，无需模拟器
```
