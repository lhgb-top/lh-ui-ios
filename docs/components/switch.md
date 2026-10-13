# Switch 开关

受控开关。`@Binding var checked` 双向绑定，轨道 2:1，圆点直径 = 高度 − 2 × `switch.gap`。

> 契约源：`lh-ui-core/specs/switch.json` ·
> 黄金用例：`lh-ui-core/cases/switch.json`（6 条，已翻译为 XCTest，macOS 宿主即可运行）

## 状态

开启时轨道为主色、圆点右移；关闭时轨道为描边色。`loading` 态在轨道内显示小型指示器且不响应切换。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Switch 状态</span></div>
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
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

```swift
@State private var on = true

LhSwitch(checked: $on) { newValue in
  // onChange
}
```

## 尺寸

三档尺寸映射到 `switch.width` / `switch.height` 令牌，圆角随高度自动为轨道半径。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Switch 尺寸</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-switch sim-switch--small sim-switch--on"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--on"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--large sim-switch--on"><span class="sim-switch__thumb"></span></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

## 加载态

`loading = true` 时轨道内置 `LhLoading(size: .small, tone: .primary)`，且点击被 gate 拦截
（黄金用例 `loading-blocks-change`）。

```swift
LhSwitch(checked: $submitting, loading: submitting) { _ in }
```

## API

### Props

| 属性 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `checked` | 开关状态（受控双向绑定） | `Bool` | — |
| `disabled` | 是否禁用（不触发 onChange） | `Bool` | `false` |
| `loading` | 是否加载中（内置指示器，不触发 onChange） | `Bool` | `false` |
| `size` | 开关尺寸，映射到尺寸令牌 | `LhSwitchSize` | `.medium` |
| `onChange` | 状态变化回调，payload 为新值 | `((Bool) -> Void)?` | `nil` |

### LhSwitchSize

| 值 | width | height | 圆点直径 |
| --- | --- | --- | --- |
| `.small` | `switch.width.small`（36pt） | `switch.height.small`（20pt） | height − 2 × `switch.gap`（16pt） |
| `.medium` | `switch.width.medium`（44pt） | `switch.height.medium`（24pt） | height − 2 × `switch.gap`（20pt） |
| `.large` | `switch.width.large`（52pt） | `switch.height.large`（28pt） | height − 2 × `switch.gap`（24pt） |

### 颜色

| 状态 | 轨道 | 圆点 |
| --- | --- | --- |
| 关闭 | `color.border.base` | `color.onPrimary` |
| 开启 | `color.primary.default` | `color.onPrimary` |
| 禁用 | `color.disabled.bg` | `color.disabled.text` |

## 令牌对照

| 令牌 | 用途 |
| --- | --- |
| `switch.width.{small,medium,large}` | 三档轨道宽度 |
| `switch.height.{small,medium,large}` | 三档轨道高度 |
| `switch.gap` | 圆点与轨道的内间距（决定圆点直径） |
| `color.primary.default` | 开启轨道色 |
| `color.border.base` | 关闭轨道色 |
| `color.onPrimary` | 圆点色 |
| `color.disabled.{bg,text}` | 禁用态两色 |
| `motion.duration.base` | 圆点滑动动画时长（iOS 端为秒） |

## 黄金用例对照

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `tap-toggles-and-emits-onchange` | 点击开启并回调 `onChange(true)` | `testDefaultIsInteractive` |
| `tap-checked-turns-off` | 开启态点击变关闭 | `testCheckedUsesPrimaryTrack` |
| `disabled-blocks-change` | 禁用态不触发 onChange | `testDisabledBlocksChange` |
| `loading-blocks-change` | 加载态不触发 onChange | `testLoadingBlocksChange` |
| `checked-uses-primary-token` | 开启消费主色令牌、不消费描边令牌 | `testCheckedUsesPrimaryToken` |
| `unchecked-uses-border-token` | 关闭消费描边令牌 | `testUncheckedUsesBorderToken` |

另有专项：`testSizeUsesSwitchTokens` / `testThumbDiameterIsHeightMinusTwoGaps` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testSwitchViewInitAcceptsConstant`。

```bash
swift test --filter LhSwitchTests    # macOS 宿主即可跑，无需模拟器
```
