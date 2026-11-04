# Text 文本

文本展示原语：消费全局排版令牌，支持字号级别、字重、色调与对齐。

> 契约源：`lh-ui-core/specs/text.json` ·
> 黄金用例：`lh-ui-core/cases/text.json`（5 条，已翻译为 XCTest，macOS 宿主即可运行）

## 字号级别

`level` 映射到 `typography.fontSize.<level>` 令牌，默认 `base`。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text 字号</span></div>
  <div class="sim-screen">
    <p class="sim-text sim-text--extraLarge">特大 extraLarge</p>
    <p class="sim-text sim-text--large">大 large</p>
    <p class="sim-text sim-text--medium">中 medium</p>
    <p class="sim-text">基准 base（默认）</p>
    <p class="sim-text sim-text--small">小 small</p>
    <p class="sim-text sim-text--extraSmall">特小 extraSmall</p>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

```swift
LhText("标题文字", level: .large)
```

## 字重

`weight` 映射到 `typography.fontWeight.<weight>` 令牌（primary 400 / bold 600）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text 字重</span></div>
  <div class="sim-screen">
    <p class="sim-text">常规 primary（默认）</p>
    <p class="sim-text sim-text--bold">加粗 bold</p>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

## 色调

`tone` 映射到 `color.text.<tone>` 令牌；`selected` 取 `color.selected`。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text 色调</span></div>
  <div class="sim-screen">
    <p class="sim-text">主要 primary（默认）</p>
    <p class="sim-text sim-text--regular">常规 regular</p>
    <p class="sim-text sim-text--secondary">次要 secondary</p>
    <p class="sim-text sim-text--placeholder">占位 placeholder</p>
    <p class="sim-text sim-text--disabled">禁用 disabled</p>
    <p class="sim-text sim-text--selected">选中 selected</p>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

## 对齐与行高

`lhAlign` 在行盒宽度内对齐；行高始终取 `typography.lineHeight.primary`（字号 × 1.8）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text 对齐</span></div>
  <div class="sim-screen">
    <p class="sim-text sim-text--align-center">居中 center</p>
    <p class="sim-text sim-text--align-end">右对齐 end</p>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

```swift
LhText("居中", lhAlign: .center)
```

## API

| 属性 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `content` | 文本内容（构造器第一个参数，spec 的 default 插槽） | `String` | `""` |
| `level` | 字号级别 | `LhTextLevel` | `.base` |
| `weight` | 字重 | `LhTextWeight` | `.primary` |
| `tone` | 文字色调 | `LhTextTone` | `.primary` |
| `lhAlign` | 水平对齐方式 | `LhTextAlign` | `.start` |

### LhTextLevel

| 值 | fontSize 令牌 |
| --- | --- |
| `.extraLarge` | `typography.fontSize.extraLarge`（20pt） |
| `.large` | `typography.fontSize.large`（18pt） |
| `.medium` | `typography.fontSize.medium`（16pt） |
| `.base` | `typography.fontSize.base`（14pt，默认） |
| `.small` | `typography.fontSize.small`（13pt） |
| `.extraSmall` | `typography.fontSize.extraSmall`（12pt） |

### LhTextTone

| 值 | 文字色令牌 |
| --- | --- |
| `.primary` | `color.text.primary` |
| `.regular` | `color.text.regular` |
| `.secondary` | `color.text.secondary` |
| `.placeholder` | `color.text.placeholder` |
| `.disabled` | `color.text.disabled` |
| `.selected` | `color.selected` |

## 令牌对照

| 令牌 | 用途 |
| --- | --- |
| `typography.fontSize.<level>` | 六档字号 |
| `typography.fontWeight.{primary,bold}` | 两档字重 |
| `typography.lineHeight.primary` | 行高（字号 × 1.8） |
| `color.text.<tone>` / `color.selected` | 文字色调 |

## 黄金用例对照

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `default-level-uses-base-tokens` | 默认级别消费 base 排版令牌 | `LhTextTests.testDefaultLevelUsesBaseTokens` |
| `large-level-uses-large-token` | 大级别消费 large 字号令牌 | `LhTextTests.testLargeLevelUsesLargeToken` |
| `bold-weight-uses-bold-token` | 粗体消费 bold 字重令牌 | `LhTextTests.testBoldWeightUsesBoldToken` |
| `secondary-tone-uses-text-secondary` | 次要色调取次要文字色令牌 | `LhTextTests.testSecondaryToneUsesTextSecondary` |
| `render-emits-single-text-command` | 渲染发出一条 TEXT 指令 | `LhTextTests.testAllLevelsUseTheirTokens`（令牌映射覆盖率） |

```bash
swift test --filter LhTextTests
```
