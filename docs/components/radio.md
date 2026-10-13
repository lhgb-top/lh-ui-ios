# Radio 单选框

受控单选框。`@Binding var checked` 表示「该项是否选中」，通常配合分组使用；同一组内只能有一项为 `true`。

> 契约源：`lh-ui-core/specs/radio.json` ·
> 黄金用例：`lh-ui-core/cases/radio.json`（6 条，已翻译为 XCTest，macOS 宿主即可运行）

## 状态

选中态为描边主色圆环 + 实心主色圆点；未选中为描边空环。圆点直径为尺寸乘 `radio.dotScale`（50%）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Radio 状态</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-radio"><span class="sim-radio__ring"></span>未选中</span>
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>已选中</span>
    </div>
    <div class="sim-row">
      <span class="sim-radio sim-radio--checked sim-radio--disabled"><span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>禁用选中</span>
      <span class="sim-radio sim-radio--disabled"><span class="sim-radio__ring"></span>禁用未选中</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

```swift
@State private var picked = "blue"

LhRadio(checked: Binding(get: { picked == "blue" }, set: { _ in }), value: "blue", label: "青花瓷") { _ in
  picked = "blue"
}
```

## 尺寸

三档尺寸映射到 `radio.size` 令牌；圆环描边取 `radio.ringWidth`。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Radio 尺寸</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring sim-radio__ring--small"><span class="sim-radio__dot sim-radio__dot--small"></span></span>小号</span>
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>中号</span>
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring sim-radio__ring--large"><span class="sim-radio__dot sim-radio__dot--large"></span></span>大号</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

## 点击 gate

已选中再点击保持选中且不触发 `onChange`（黄金用例 `tap-checked-keeps-checked`）；
禁用态不触发（`disabled-blocks-change`）。分组容器留待后续版本。

## API

### Props

| 属性 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `checked` | 该项是否选中（受控双向绑定） | `Bool` | — |
| `value` | 该项代表的值（与 `checked` 配合实现单选组） | `String` | `""` |
| `disabled` | 是否禁用（不触发 onChange） | `Bool` | `false` |
| `size` | 单选框尺寸，映射到尺寸令牌 | `LhRadioSize` | `.medium` |
| `label` | 文字标签 | `String` | `""` |
| `onChange` | 选中变化回调，payload 为新值 | `((Bool) -> Void)?` | `nil` |

### LhRadioSize

| 值 | 环尺寸 | 圆点直径 |
| --- | --- | --- |
| `.small` | `radio.size.small`（16pt） | 尺寸 × `radio.dotScale`（8pt） |
| `.medium` | `radio.size.medium`（20pt） | 尺寸 × `radio.dotScale`（10pt） |
| `.large` | `radio.size.large`（24pt） | 尺寸 × `radio.dotScale`（12pt） |

### 颜色

| 状态 | 环描边 | 圆点 |
| --- | --- | --- |
| 未选中 | `color.border.base`（`radio.ringWidth`） | — |
| 选中 | `color.primary.default` | `color.primary.default` |
| 禁用 | `color.disabled.border` | `color.disabled.text` |

## 令牌对照

| 令牌 | 用途 |
| --- | --- |
| `radio.size.{small,medium,large}` | 三档环尺寸 |
| `radio.dotScale` | 圆点相对环尺寸的比例（50%） |
| `radio.ringWidth` | 环描边宽度 |
| `radio.gap` | 环与文字间距（跟随 `spacing.sm`） |
| `color.primary.default` | 选中态描边与圆点色 |
| `color.border.base` | 未选中描边色 |
| `color.disabled.{border,text}` | 禁用态描边与圆点色 |
| `color.text.{primary,disabled}` | 标签文字色 |

## 黄金用例对照

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `tap-unchecked-emits-onchange` | 未选中点击触发 `onChange(true)` | `testUncheckedIsInteractive` |
| `tap-checked-keeps-checked` | 已选中点击保持选中且不回调 | `testCheckedShowsDot` |
| `disabled-blocks-change` | 禁用态不触发 onChange | `testDisabledBlocksChange` |
| `checked-uses-primary-tokens` | 选中态消费主色令牌 | `testCheckedUsesPrimaryTokens` |
| `unchecked-uses-border-token` | 未选中消费描边令牌 | `testUncheckedUsesBorderToken` |
| `small-size-uses-small-token` | 小号消费 small 尺寸令牌 | `testSmallSizeUsesSmallToken` |

另有专项：`testStrokeUsesRadioTokens` / `testDarkColorsComeFromDarkTokens` /
`testDisabledInDarkUsesDarkDisabledTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testRadioViewInitAcceptsConstant`。

```bash
swift test --filter LhRadioTests    # macOS 宿主即可跑，无需模拟器
```
