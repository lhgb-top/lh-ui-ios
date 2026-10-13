# Textarea 多行输入框

受控多行输入框。`@Binding var value` 双向绑定，叠加占位提示与字数计数。

> 契约源：`lh-ui-core/specs/textarea.json` ·
> 黄金用例：`lh-ui-core/cases/textarea.json`（6 条，已翻译为 XCTest，macOS 宿主即可运行）

## 基本形态

最小高度取 `textarea.minHeight`，内边距取 `textarea.paddingHorizontal` / `paddingVertical`，
聚焦时描边换 `color.focus`。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Textarea 基本</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-textarea"><textarea class="sim-textarea__field" placeholder="请输入内容"></textarea></span>
    </div>
    <div class="sim-row">
      <span class="sim-textarea sim-textarea--focus"><textarea class="sim-textarea__field">青花瓷</textarea></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

```swift
@State private var text = ""

LhTextarea(value: $text, placeholder: "请输入内容") { newValue in
  // onValueChange
}
```

## 字数计数

`showCount = true` 时右下角显示计数：设了 `maxlength` 显示 `当前/上限`（黄金用例
`showcount-renders-count`），未设则只显示当前长度（`showcount-without-maxlength-renders-length-only`）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Textarea 计数</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-textarea">
        <textarea class="sim-textarea__field">青花瓷</textarea>
        <span class="sim-textarea__count">3/10</span>
      </span>
    </div>
    <div class="sim-row">
      <span class="sim-textarea sim-textarea--disabled">
        <textarea class="sim-textarea__field" disabled>禁用态</textarea>
      </span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

```swift
LhTextarea(value: $text, showCount: true, maxlength: 10)
```

## API

### Props

| 属性 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `value` | 输入内容（受控双向绑定） | `String` | — |
| `placeholder` | 占位提示文字 | `String` | `""` |
| `rows` | 期望行数（影响最小高度） | `Int` | `3` |
| `disabled` | 是否禁用（不触发任何回调） | `Bool` | `false` |
| `readonly` | 是否只读（不触发 onValueChange，保留聚焦样式） | `Bool` | `false` |
| `showCount` | 是否显示字数计数 | `Bool` | `false` |
| `maxlength` | 最大字数（超出截断） | `Int?` | `nil` |
| `onValueChange` | 内容变化回调，payload 为新值 | `((String) -> Void)?` | `nil` |
| `onFocus` | 聚焦回调 | `(() -> Void)?` | `nil` |
| `onBlur` | 失焦回调 | `(() -> Void)?` | `nil` |

### 颜色

| 状态 | 描边 | 文字 / 占位 |
| --- | --- | --- |
| 默认 | `color.border.base`（`textarea.borderWidth`） | `color.text.primary` / `color.text.placeholder` |
| 聚焦 | `color.focus`（`textarea.focusRingWidth`） | 同上 |
| 禁用 | `color.disabled.border` | `color.disabled.text` |

## 令牌对照

| 令牌 | 用途 |
| --- | --- |
| `textarea.minHeight` | 最小高度 |
| `textarea.paddingHorizontal` / `textarea.paddingVertical` | 内边距 |
| `textarea.fontSize` | 字号 |
| `textarea.countFontSize` | 计数文字字号 |
| `textarea.borderRadius` / `textarea.borderWidth` | 圆角与描边宽度 |
| `textarea.focusRingWidth` | 聚焦环宽度 |
| `color.focus` | 聚焦描边色 |
| `color.text.{primary,placeholder,disabled}` | 文字与占位色 |
| `color.border.base` / `color.disabled.border` | 描边色 |
| `color.background.default` / `color.disabled.bg` | 底色 |

## 黄金用例对照

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `input-emits-onvaluechange` | 输入触发 `onValueChange("青花瓷")` | `testDefaultIsEditable` |
| `disabled-blocks-input` | 禁用态不触发 onValueChange | `testDisabledBlocksInput` |
| `showcount-renders-count` | 计数显示 `3/10` 并消费计数字号令牌 | `testShowCountRendersCount` |
| `showcount-without-maxlength-renders-length-only` | 无上限时只显示 `3` | `testShowCountWithoutMaxlengthRendersLengthOnly` |
| `focus-uses-focus-token` | 聚焦消费 focus 令牌并触发 onFocus | `testFocusUsesFocusToken` |
| `maxlength-truncates-input` | 超出字数截断 | `testMaxlengthTruncatesInput` |

另有专项：`testLayoutUsesTextareaTokens` / `testReadonlyBlocksInputButKeepsFocusStyle` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testTextareaViewInitAcceptsConstant`。

```bash
swift test --filter LhTextareaTests    # macOS 宿主即可跑，无需模拟器
```
