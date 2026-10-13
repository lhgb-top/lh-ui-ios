# Cell 单元格

列表单元格。左侧图标 + 标题（含必填红星与副标题），右侧值与箭头，底部分隔线。

> 契约源：`lh-ui-core/specs/cell.json` ·
> 黄金用例：`lh-ui-core/cases/cell.json`（6 条，已翻译为 XCTest，macOS 宿主即可运行）

## 基本形态

`title` 必填，`value` / `label` / `icon` 可选。`bordered` 控制底部分隔线（默认开）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Cell 基本</span></div>
  <div class="sim-screen" style="padding: 0;">
    <div class="sim-cell">
      <div class="sim-cell__main"><div class="sim-cell__title">标题文字</div></div>
      <div class="sim-cell__value">右侧值</div>
      <div class="sim-cell__arrow">›</div>
    </div>
    <div class="sim-cell">
      <div class="sim-cell__main">
        <div class="sim-cell__title">带副标题</div>
        <div class="sim-cell__label">这是副标题说明文字</div>
      </div>
      <div class="sim-cell__arrow">›</div>
    </div>
    <div class="sim-cell">
      <div class="sim-cell__main"><div class="sim-cell__title">无分隔线</div></div>
      <div class="sim-cell__value">值</div>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

```swift
LhCell(title: "标题文字", value: "右侧值", clickable: true) {
  // onClick
}
```

## 图标 / 必填 / 不可点击

`icon` 走 `LhIconMap` 映射；`required` 在标题前显示红色星号；
`clickable = false`（默认）时不响应点击（黄金用例 `not-clickable-no-onclick`）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Cell 扩展</span></div>
  <div class="sim-screen" style="padding: 0;">
    <div class="sim-cell">
      <span class="sim-cell__icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="width:100%;height:100%"><circle cx="11" cy="11" r="7"/><path d="M21 21l-4.3-4.3"/></svg></span>
      <div class="sim-cell__main"><div class="sim-cell__title">左侧图标</div></div>
      <div class="sim-cell__arrow">›</div>
    </div>
    <div class="sim-cell">
      <div class="sim-cell__main"><div class="sim-cell__title"><span class="sim-cell__required">*</span>必填项</div></div>
      <div class="sim-cell__value">请选择</div>
      <div class="sim-cell__arrow">›</div>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

## API

### Props

| 属性 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `title` | 标题（必填） | `String` | — |
| `value` | 右侧值 | `String` | `""` |
| `label` | 标题下方副标题 | `String` | `""` |
| `icon` | 左侧图标逻辑名（`LhIconMap` 映射） | `String?` | `nil` |
| `bordered` | 是否显示底部分隔线 | `Bool` | `true` |
| `clickable` | 是否可点击（控制箭头与点击 gate） | `Bool` | `false` |
| `required` | 标题前是否显示红色必填星号 | `Bool` | `false` |
| `onClick` | 点击回调；`clickable = false` 时不触发 | `(() -> Void)?` | `nil` |

### 文字层级

| 区域 | 字号 | 颜色 |
| --- | --- | --- |
| 标题 | `cell.fontSizeTitle`（14pt） | `color.text.primary` |
| 副标题 | `cell.fontSizeLabel`（13pt） | `color.text.secondary` |
| 右侧值 | `cell.fontSizeValue`（14pt） | `color.text.secondary` |
| 必填星号 | `cell.fontSizeTitle` | `color.danger.default` |

## 令牌对照

| 令牌 | 用途 |
| --- | --- |
| `cell.paddingHorizontal` / `cell.paddingVertical` | 内边距（跟随 `spacing.base` / `spacing.sm`） |
| `cell.fontSizeTitle` / `cell.fontSizeLabel` / `cell.fontSizeValue` | 三级文字字号 |
| `cell.iconSize` | 左侧图标尺寸 |
| `cell.gap` | 各区块间距（跟随 `spacing.sm`） |
| `cell.borderWidth` | 底部分隔线宽度 |
| `color.border.lighter` | 底部分隔线颜色 |
| `color.text.{primary,secondary}` | 标题与值/副标题颜色 |
| `color.danger.default` | 必填星号颜色 |
| `color.background.default` | 单元格底色 |

## 黄金用例对照

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `title-and-value-render` | 同时绘制标题与值 | `testTitleAndValueUseFontTokens` |
| `label-renders-secondary-tone` | 副标题取次要文字色 | `testLabelRendersSecondaryTone` |
| `required-uses-danger-token` | 必填星号取危险色令牌 | `testRequiredUsesDangerToken` |
| `bordered-emits-line-command` | 分隔线消费 border.lighter 令牌 | `testBorderedUsesBorderTokens` |
| `clickable-emits-onclick` | 可点击时触发 onClick | `testClickableIsInteractive` |
| `not-clickable-no-onclick` | 不可点击时不触发 onClick | `testNotClickableIsNotInteractive` |

另有暗色专项：`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testCellInitAndRender` / `testLayoutUsesCellTokens`。

```bash
swift test --filter LhCellTests    # macOS 宿主即可跑，无需模拟器
```
