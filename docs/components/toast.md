# Toast 轻提示

声明式轻提示。`@Binding var visible` 控制显隐，到时自动消失，深色底取 `color.ink` 令牌。

> 契约源：`lh-ui-core/specs/toast.json` ·
> 黄金用例：`lh-ui-core/cases/toast.json`（6 条，已翻译为 XCTest，macOS 宿主即可运行）

## 类型

默认类型无图标；其余类型在文字左侧显示一个语义色圆点。深色底 + 白字，对比度由 `color.ink` 保证。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Toast 类型</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">默认</button></div>
  </div>
  <div class="sim-toast">已保存</div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Toast 语义</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--success">成功</button></div>
  </div>
  <div class="sim-toast"><span class="sim-toast__dot sim-toast__dot--success"></span>操作成功</div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

```swift
@State private var visible = false

LhToast(visible: $visible, text: "已保存", type: .success)
```

## 定位

三种定位：`top`（顶部）、`center`（居中，默认）、`bottom`（底部）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Toast 定位</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">bottom 定位</button></div>
  </div>
  <div class="sim-toast sim-toast--bottom"><span class="sim-toast__dot sim-toast__dot--warning"></span>底部提示</div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

## 自动消失

`visible` 变为 `true` 时启动 `.task` 计时，`duration` 毫秒后自动置回 `false` 并触发 `onClose`
（黄金用例 `auto-hides-after-duration`）；计时未到时保持显示且不触发回调
（`tick-before-duration-keeps-visible`）；外部手动置 `false` 不触发回调（`hide-is-silent`）。

::: tip 时长单位
令牌 `toast.duration` 是毫秒（2000），SwiftUI 的 `Task.sleep` 需要秒，端侧做
`Double(duration) / 1000` 换算（见 `LhToastStyle`）。
:::

```swift
LhToast(visible: $visible, text: "操作成功", type: .success, duration: 2000) {
  // onClose（仅自动消失时触发）
}
```

## API

### Props

| 属性 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `visible` | 是否显示（受控双向绑定，到时自动置回 false） | `Bool` | — |
| `text` | 提示文字 | `String` | — |
| `type` | 提示类型，决定是否显示圆点及圆点颜色 | `LhToastType` | `.default` |
| `position` | 显示位置 | `LhToastPosition` | `.center` |
| `duration` | 显示时长（毫秒） | `Int` | `2000`（取 `toast.duration` 令牌） |
| `onClose` | 自动消失回调（外部手动隐藏不触发） | `(() -> Void)?` | `nil` |

### LhToastType

| 值 | 圆点色 |
| --- | --- |
| `.default` | 无圆点 |
| `.success` | `color.success.default` |
| `.warning` | `color.warning.default` |
| `.danger` | `color.danger.default` |
| `.info` | `color.info.default` |

### LhToastPosition

| 值 | 定位 |
| --- | --- |
| `.top` | 顶部（边距 `spacing.xl`） |
| `.center` | 居中 |
| `.bottom` | 底部（边距 `spacing.xl`） |

## 令牌对照

| 令牌 | 用途 |
| --- | --- |
| `toast.paddingHorizontal` / `toast.paddingVertical` | 内边距 |
| `toast.fontSize` | 提示文字字号 |
| `toast.borderRadius` | 圆角（跟随 `radius.small`） |
| `toast.gap` | 圆点与文字间距 |
| `toast.duration` | 默认显示时长（毫秒） |
| `color.ink` | 深色底（暗色下有专用覆盖，与页面底拉开层次） |
| `color.onPrimary` | 白字 |
| `color.{success,warning,danger,info}.default` | 圆点语义色 |
| `zIndex.toast` | 层级 |
| `spacing.xl` | 顶/底定位边距 |

## 黄金用例对照

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `show-makes-visible` | 显示即渲染 | `testShowMakesVisible` |
| `auto-hides-after-duration` | 到时自动隐藏并触发 onClose | `testDurationConvertsToSeconds` |
| `tick-before-duration-keeps-visible` | 计时未到保持显示 | `testVisibleDuringDuration` |
| `hide-is-silent` | 外部手动隐藏不触发回调 | `testHideIsSilent` |
| `success-type-uses-success-token` | 成功类型消费成功色与 ink 令牌 | `testSuccessTypeUsesSuccessToken` / `testInkBackgroundUsesInkToken` |
| `hidden-emits-no-commands` | 隐藏时绘制指令为空 | `testHiddenNotRendered` |

另有专项：`testDefaultTypeHasNoDot` / `testLayoutUsesToastTokens` /
`testDarkColorsComeFromDarkTokens` / `testDarkInkDiffersFromLightInk` /
`testDimensionsAreIdenticalInDarkMode` / `testToastViewInitAcceptsConstant`。

```bash
swift test --filter LhToastTests    # macOS 宿主即可跑，无需模拟器
```
