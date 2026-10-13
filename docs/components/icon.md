# Icon 图标

矢量图标。通过逻辑名映射到平台的系统符号（iOS 端为 SF Symbol），尺寸与色调全部走令牌。

> 契约源：`lh-ui-core/specs/icon.json` ·
> 黄金用例：`lh-ui-core/cases/icon.json`（5 条，已翻译为 XCTest，macOS 宿主即可运行）

## 色调

`tone` 决定图标颜色。`default` 跟随主要文字色，`regular` / `secondary` 取对应层级文字色，其余取语义色。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Icon 色调</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-icon"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--success"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 12.5l5 5L20 6.5"/></svg></span>
    </div>
    <div class="sim-row">
      <span class="sim-icon sim-icon--warning"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 3l10 18H2z"/><path d="M12 10v5"/></svg></span>
      <span class="sim-icon sim-icon--danger"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 8v5M12 16.5v.5"/></svg></span>
      <span class="sim-icon sim-icon--regular"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="8"/></svg></span>
      <span class="sim-icon sim-icon--secondary"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="8"/></svg></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染；真机绘制的是 SF Symbol 矢量</p>

```swift
LhIcon(name: "star", tone: .primary)
```

## 尺寸

三档尺寸映射到 `icon.size` 令牌。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Icon 尺寸</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-icon sim-icon--small sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--large sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

## 图标名映射

`name` 是与 web 血脉对齐的逻辑名，端侧经 `LhIconMap.symbol(for:)` 映射到 SF Symbol：

| 逻辑名 | SF Symbol |
| --- | --- |
| `star` / `search` / `check` / `close` | `star` / `magnifyingglass` / `checkmark` / `xmark` |
| `arrow-up` / `arrow-down` / `arrow-left` / `arrow-right` | `arrow.up` / `arrow.down` / `arrow.left` / `arrow.right` |
| `refresh` / `plus` / `minus` / `eye` / `link` | `arrow.clockwise` / `plus` / `minus` / `eye` / `link` |

未登记的名称不绘制（返回 `nil`），不会崩溃。

```swift
LhIcon(name: "search", size: .large, tone: .secondary) {
  // onClick
}
```

## API

### Props

| 属性 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `name` | 图标逻辑名（经 `LhIconMap` 映射 SF Symbol） | `String` | — |
| `size` | 图标尺寸，映射到尺寸令牌 | `LhIconSize` | `.medium` |
| `tone` | 图标色调，映射到文字/语义色令牌 | `LhIconTone` | `.default` |
| `onClick` | 点击回调；未传则不响应点击 | `(() -> Void)?` | `nil` |

### LhIconSize

| 值 | 尺寸 |
| --- | --- |
| `.small` | `icon.size.small`（16pt） |
| `.medium` | `icon.size.medium`（20pt） |
| `.large` | `icon.size.large`（24pt） |

### LhIconTone

| 值 | 颜色 |
| --- | --- |
| `.default` | `color.text.primary` |
| `.primary` | `color.primary.default` |
| `.success` | `color.success.default` |
| `.warning` | `color.warning.default` |
| `.danger` | `color.danger.default` |
| `.info` | `color.info.default` |
| `.regular` | `color.text.regular` |
| `.secondary` | `color.text.secondary` |

## 令牌对照

| 令牌 | 用途 |
| --- | --- |
| `icon.size.{small,medium,large}` | 三档尺寸 |
| `color.text.{primary,regular,secondary}` | 文字色调 |
| `color.{primary,success,warning,danger,info}.default` | 语义色调 |

## 黄金用例对照

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `click-emits-onclick` | 点击触发 `onClick` 一次 | View 层 `onTapGesture`（手势断言需模拟器，见 #Preview） |
| `default-tone-uses-text-primary` | 默认色调取主要文字色 | `testDefaultToneUsesTextPrimary` |
| `primary-tone-uses-primary-token` | 主色调取主色令牌 | `testPrimaryToneUsesPrimaryToken` |
| `small-size-uses-small-token` | 小号取 small 尺寸令牌 | `testSmallSizeUsesSmallToken` |
| `render-emits-icon-command` | 仅绘制一条图标指令 | `testRegisteredIconResolvesToSymbol` / `testUnknownIconReturnsNilSymbol` |

另有暗色专项：`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode`。

```bash
swift test --filter LhIconTests    # macOS 宿主即可跑，无需模拟器
```
