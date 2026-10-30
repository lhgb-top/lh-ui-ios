# Textarea 多行輸入框

受控多行輸入框。`@Binding var value` 雙向綁定，疊加佔位提示與字數計數。

> 契約源：`lh-ui-core/specs/textarea.json` ·
> 黃金用例：`lh-ui-core/cases/textarea.json`（6 條，已翻譯為 XCTest，macOS 宿主即可執行）

## 基本形態

最小高度取 `textarea.minHeight`，內邊距取 `textarea.paddingHorizontal` / `paddingVertical`，
聚焦時描邊換 `color.focus`。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Textarea 基本</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-textarea"><textarea class="sim-textarea__field" placeholder="請輸入內容"></textarea></span>
    </div>
    <div class="sim-row">
      <span class="sim-textarea sim-textarea--focus"><textarea class="sim-textarea__field">青花瓷</textarea></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

```swift
@State private var text = ""

LhTextarea(value: $text, placeholder: "請輸入內容") { newValue in
  // onValueChange
}
```

## 字數計數

`showCount = true` 時右下角顯示計數：設了 `maxlength` 顯示 `目前/上限`（黃金用例
`showcount-renders-count`），未設則只顯示目前長度（`showcount-without-maxlength-renders-length-only`）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Textarea 計數</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-textarea">
        <textarea class="sim-textarea__field">青花瓷</textarea>
        <span class="sim-textarea__count">3/10</span>
      </span>
    </div>
    <div class="sim-row">
      <span class="sim-textarea sim-textarea--disabled">
        <textarea class="sim-textarea__field" disabled>停用態</textarea>
      </span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

```swift
LhTextarea(value: $text, showCount: true, maxlength: 10)
```

## API

### Props

| 屬性 | 說明 | 類型 | 預設值 |
| --- | --- | --- | --- |
| `value` | 輸入內容（受控雙向綁定） | `String` | — |
| `placeholder` | 佔位提示文字 | `String` | `""` |
| `rows` | 期望行數（影響最小高度） | `Int` | `3` |
| `disabled` | 是否停用（不觸發任何回呼） | `Bool` | `false` |
| `readonly` | 是否唯讀（不觸發 onValueChange，保留聚焦樣式） | `Bool` | `false` |
| `showCount` | 是否顯示字數計數 | `Bool` | `false` |
| `maxlength` | 最大字數（超出截斷） | `Int?` | `nil` |
| `onValueChange` | 內容變化回呼，payload 為新值 | `((String) -> Void)?` | `nil` |
| `lhOnFocus` | 聚焦回呼 | `(() -> Void)?` | `nil` |
| `lhOnBlur` | 失焦回呼 | `(() -> Void)?` | `nil` |

### 顏色

| 狀態 | 描邊 | 文字 / 佔位 |
| --- | --- | --- |
| 預設 | `color.border.base`（`textarea.borderWidth`） | `color.text.primary` / `color.text.placeholder` |
| 聚焦 | `color.focus`（`textarea.focusRingWidth`） | 同上 |
| 停用 | `color.disabled.border` | `color.disabled.text` |

## 令牌對照

| 令牌 | 用途 |
| --- | --- |
| `textarea.minHeight` | 最小高度 |
| `textarea.paddingHorizontal` / `textarea.paddingVertical` | 內邊距 |
| `textarea.fontSize` | 字號 |
| `textarea.countFontSize` | 計數文字字號 |
| `textarea.borderRadius` / `textarea.borderWidth` | 圓角與描邊寬度 |
| `textarea.focusRingWidth` | 聚焦環寬度 |
| `color.focus` | 聚焦描邊色 |
| `color.text.{primary,placeholder,disabled}` | 文字與佔位色 |
| `color.border.base` / `color.disabled.border` | 描邊色 |
| `color.background.default` / `color.disabled.bg` | 底色 |

## 黃金用例對照

| case id | 斷言 | 本地測試 |
| --- | --- | --- |
| `input-emits-onvaluechange` | 輸入觸發 `onValueChange("青花瓷")` | `testDefaultIsEditable` |
| `disabled-blocks-input` | 停用態不觸發 onValueChange | `testDisabledBlocksInput` |
| `showcount-renders-count` | 計數顯示 `3/10` 並消費計數字號令牌 | `testShowCountRendersCount` |
| `showcount-without-maxlength-renders-length-only` | 無上限時只顯示 `3` | `testShowCountWithoutMaxlengthRendersLengthOnly` |
| `focus-uses-focus-token` | 聚焦消費 focus 令牌並觸發 lhOnFocus | `testFocusUsesFocusToken` |
| `maxlength-truncates-input` | 超出字數截斷 | `testMaxlengthTruncatesInput` |

另有專項：`testLayoutUsesTextareaTokens` / `testReadonlyBlocksInputButKeepsFocusStyle` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testTextareaViewInitAcceptsConstant`。

```bash
swift test --filter LhTextareaTests    # macOS 宿主即可執行，無需模擬器
```
