# Tag 标签

用于标记和选择的紧凑标签。比按钮更小，支持语义类型、描边、圆角胶囊与关闭按钮。

> 契约源：`lh-ui-core/specs/tag.json` ·
> 黄金用例：`lh-ui-core/cases/tag.json`（6 条，已翻译为 XCTest，macOS 宿主即可运行）

## 类型

六种类型决定底色与文字色。`plain` 为描边浅底形态（语义浅底 + 语义描边）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tag 类型</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag">默认</span>
      <span class="sim-tag sim-tag--primary">主要</span>
      <span class="sim-tag sim-tag--success">成功</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--warning">警告</span>
      <span class="sim-tag sim-tag--danger">危险</span>
      <span class="sim-tag sim-tag--info">信息</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--plain sim-tag--primary">描边主要</span>
      <span class="sim-tag sim-tag--plain sim-tag--success">描边成功</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

```swift
LhTag(text: "主要", type: .primary)
LhTag(text: "描边成功", type: .success, plain: true)
```

## 尺寸与圆角

三档尺寸映射到 `tag.height` / `paddingHorizontal` / `fontSize` 令牌；`round` 把圆角换成高度的一半（胶囊）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tag 尺寸</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag sim-tag--small sim-tag--primary">小号</span>
      <span class="sim-tag sim-tag--primary">中号</span>
      <span class="sim-tag sim-tag--large sim-tag--primary">大号</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--primary">方角</span>
      <span class="sim-tag sim-tag--primary sim-tag--round">圆角</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

## 可关闭

`closable` 在右侧显示关闭按钮，点击触发 `onClose`（黄金用例 `closable-tap-emits-onclose`）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tag 关闭</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag sim-tag--primary">可关闭<svg class="sim-tag__close" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M6 6l12 12M18 6L6 18"/></svg></span>
      <span class="sim-tag">可关闭<svg class="sim-tag__close" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M6 6l12 12M18 6L6 18"/></svg></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

```swift
LhTag(text: "可关闭", type: .primary, closable: true) {
  // onClose
}
```

## API

### Props

| 属性 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `text` | 标签文字 | `String` | — |
| `type` | 标签类型，决定底色与文字色 | `LhTagType` | `.default` |
| `size` | 标签尺寸，映射到尺寸令牌 | `LhTagSize` | `.medium` |
| `plain` | 是否为描边浅底形态 | `Bool` | `false` |
| `round` | 是否为胶囊圆角（半径 = 高度 / 2） | `Bool` | `false` |
| `closable` | 是否显示关闭按钮 | `Bool` | `false` |
| `onClose` | 关闭按钮点击回调 | `(() -> Void)?` | `nil` |

### LhTagType

| 值 | 底色 | 文字色 |
| --- | --- | --- |
| `.default` | `color.background.default` + `color.border.base` 描边 | `color.text.primary` |
| `.primary` | `color.primary.default` | `color.onPrimary` |
| `.success` | `color.success.default` | `color.onPrimary` |
| `.warning` | `color.warning.default` | `color.onPrimary` |
| `.danger` | `color.danger.default` | `color.onPrimary` |
| `.info` | `color.info.default` | `color.onPrimary` |

`plain = true` 时：底色取 `color.<type>.bg`、描边与文字取 `color.<type>.default`（`.default` 类型忽略 `plain`，黄金用例 `default-type-renders-text`）。

### LhTagSize

| 值 | height | paddingHorizontal | fontSize |
| --- | --- | --- | --- |
| `.small` | `tag.height.small`（20pt） | `tag.paddingHorizontal.small`（8pt） | `tag.fontSize.small`（12pt） |
| `.medium` | `tag.height.medium`（24pt） | `tag.paddingHorizontal.medium`（12pt） | `tag.fontSize.medium`（13pt） |
| `.large` | `tag.height.large`（28pt） | `tag.paddingHorizontal.large`（16pt） | `tag.fontSize.large`（14pt） |

## 令牌对照

| 令牌 | 用途 |
| --- | --- |
| `tag.height.{small,medium,large}` | 三档高度 |
| `tag.paddingHorizontal.{small,medium,large}` | 三档横向内边距 |
| `tag.fontSize.{small,medium,large}` | 三档字号 |
| `tag.borderRadius` / `tag.borderWidth` | 默认圆角（跟随 `radius.small`）与描边宽度 |
| `tag.gap` | 文字与关闭按钮间距（跟随 `spacing.xs`） |
| `color.{primary,success,warning,danger,info}.{default,bg}` | 语义类型底色与描边浅底 |
| `color.onPrimary` | 语义类型文字色 |
| `color.background.default` / `color.text.primary` / `color.border.base` | 默认类型三色 |

## 黄金用例对照

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `default-type-renders-text` | 默认类型中性底/文字，忽略 plain | `testDefaultTypeUsesNeutralTokens` / `testDefaultTypeIgnoresPlain` |
| `primary-type-uses-primary-tokens` | 主色类型消费主色与 onPrimary | `testPrimaryTypeUsesPrimaryTokens` |
| `plain-uses-bg-tokens` | plain 消费语义 bg 与语义描边 | `testPlainUsesBgTokens` |
| `small-size-uses-small-tokens` | 小号消费 small 尺寸令牌 | `testSmallSizeUsesSmallTokens` |
| `round-makes-radius-half-height` | round 圆角 == 高度 / 2 | `testRoundMakesRadiusHalfHeight` |
| `closable-tap-emits-onclose` | 关闭按钮触发 onClose | `testClosableTagInitAndRender`（手势断言需模拟器） |

另有暗色专项：`testDarkColorsComeFromDarkTokens` / `testPlainInDarkUsesDarkBgTokens` /
`testDimensionsAreIdenticalInDarkMode`。

```bash
swift test --filter LhTagTests    # macOS 宿主即可跑，无需模拟器
```
