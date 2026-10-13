# Navbar 导航栏

页面顶部导航栏。居中标题 + 两侧内容，底部分隔线，层级取 `zIndex.sticky`。

> 契约源：`lh-ui-core/specs/navbar.json` ·
> 黄金用例：`lh-ui-core/cases/navbar.json`（6 条，已翻译为 XCTest，macOS 宿主即可运行）

## 基本形态

`title` 居中显示（绝对定位，不与两侧内容重叠）；`leftText` / `rightText` 分别贴左右两侧。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Navbar 基本</span></div>
  <div class="sim-navbar sim-navbar--bordered">
    <span class="sim-navbar__side">返回</span>
    <span class="sim-navbar__title">青花瓷</span>
    <span class="sim-navbar__side">更多</span>
  </div>
  <div class="sim-screen">
    <div class="sim-row"><span class="sim-tag sim-tag--primary">页面内容</span></div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

```swift
LhNavbar(
  title: "青花瓷",
  leftText: "返回",
  rightText: "更多",
  onLeftClick: { /* 返回 */ },
  onRightClick: { /* 更多 */ }
)
```

## 图标与边框

`leftIcon` / `rightIcon` 走 `LhIconMap` 映射，与文字并排显示；`bordered = false` 去掉底部分隔线。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Navbar 图标</span></div>
  <div class="sim-navbar">
    <span class="sim-navbar__side">
      <span class="sim-navbar__icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M15 5l-7 7 7 7"/></svg></span>
      <span>返回</span>
    </span>
    <span class="sim-navbar__title">标题</span>
    <span class="sim-navbar__side">
      <span>设置</span>
      <span class="sim-navbar__icon"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="8"/></svg></span>
    </span>
  </div>
  <div class="sim-screen">
    <div class="sim-row"><span class="sim-tag">无边框导航栏</span></div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

## 点击 gate

未提供 `leftText` / `leftIcon` 时左侧不响应点击（黄金用例 `no-left-content-no-onleftclick`），
右侧同理。悬浮定位由调用方用 `.overlay` 挂载（SwiftUI 惯例），组件自身提供 `zIndex.sticky` 层级。

```swift
ZStack {
  contentView
    .padding(.top, LhTokens.Navbar.height)
  LhNavbar(title: "青花瓷", leftText: "返回", onLeftClick: { dismiss() })
    .overlay(alignment: .top) { ... }
}
```

## API

### Props

| 属性 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `title` | 居中标题 | `String` | `""` |
| `leftText` | 左侧文字（为空且无 leftIcon 时不响应点击） | `String` | `""` |
| `leftIcon` | 左侧图标逻辑名（`LhIconMap` 映射） | `String?` | `nil` |
| `rightText` | 右侧文字（为空且无 rightIcon 时不响应点击） | `String` | `""` |
| `rightIcon` | 右侧图标逻辑名 | `String?` | `nil` |
| `bordered` | 是否显示底部分隔线 | `Bool` | `true` |
| `onLeftClick` | 左侧点击回调 | `(() -> Void)?` | `nil` |
| `onRightClick` | 右侧点击回调 | `(() -> Void)?` | `nil` |

### 颜色

| 区域 | 颜色 |
| --- | --- |
| 底色 | `color.background.default` |
| 标题 / 两侧文字 / 图标 | `color.text.primary` |
| 分隔线 | `color.border.lighter`（宽度取 `navbar.borderWidth`） |

## 令牌对照

| 令牌 | 用途 |
| --- | --- |
| `navbar.height` | 导航栏高度（44pt） |
| `navbar.paddingHorizontal` | 两侧横向内边距（12pt） |
| `navbar.titleFontSize` | 标题与两侧文字字号（16pt） |
| `navbar.iconSize` | 两侧图标尺寸（20pt） |
| `navbar.borderWidth` | 底部分隔线宽度 |
| `color.border.lighter` | 分隔线颜色 |
| `color.text.primary` | 标题与两侧内容颜色 |
| `color.background.default` | 底色 |
| `zIndex.sticky` | 悬浮层级 |

## 黄金用例对照

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `title-renders-text` | 标题正确渲染 | `testTitleUsesNavbarTokens` |
| `leftclick-emits-onleftclick` | 左侧点击触发 onLeftClick | `testLeftContentIsClickable` |
| `rightclick-emits-onrightclick` | 右侧点击触发 onRightClick | `testRightContentIsClickable` |
| `no-left-content-no-onleftclick` | 无左侧内容时不触发 | `testNoLeftContentIsNotClickable` |
| `bordered-uses-border-token` | 分隔线消费 border.lighter 令牌 | `testBorderedUsesBorderToken` |
| `height-uses-navbar-height-token` | 高度消费 navbar.height 令牌 | `testHeightUsesNavbarHeightToken` |

另有专项：`testContainerUsesBackgroundToken` / `testDarkColorsComeFromDarkTokens` /
`testDimensionsAreIdenticalInDarkMode` / `testNavbarInitAndRender`。

```bash
swift test --filter LhNavbarTests    # macOS 宿主即可跑，无需模拟器
```
