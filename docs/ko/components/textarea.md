# Textarea 여러 줄 입력

제어형 여러 줄 입력 상자입니다. `@Binding var value`로 양방향 바인딩하며, 자리표시 도움말과 글자 수 카운트를 겹쳐 표시합니다.

> 계약 원본: `lh-ui-core/specs/textarea.json` ·
> 골든 케이스: `lh-ui-core/cases/textarea.json`(6건, XCTest로 번역됨, macOS 호스트에서 실행 가능)

## 기본 형태

최소 높이는 `textarea.minHeight`, 안쪽 여백은 `textarea.paddingHorizontal` / `paddingVertical`를 사용하며,
포커스 시 테두리가 `color.focus`로 바뀝니다.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Textarea 기본</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-textarea"><textarea class="sim-textarea__field" placeholder="내용을 입력해 주세요"></textarea></span>
    </div>
    <div class="sim-row">
      <span class="sim-textarea sim-textarea--focus"><textarea class="sim-textarea__field">青花瓷</textarea></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

```swift
@State private var text = ""

LhTextarea(value: $text, placeholder: "내용을 입력해 주세요") { newValue in
  // onValueChange
}
```

## 글자 수 카운트

`showCount = true`일 때 우측 하단에 카운트를 표시합니다. `maxlength`를 설정하면 `현재/상한`을 표시하고(골든 케이스
`showcount-renders-count`), 설정하지 않으면 현재 길이만 표시합니다(`showcount-without-maxlength-renders-length-only`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Textarea 카운트</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-textarea">
        <textarea class="sim-textarea__field">青花瓷</textarea>
        <span class="sim-textarea__count">3/10</span>
      </span>
    </div>
    <div class="sim-row">
      <span class="sim-textarea sim-textarea--disabled">
        <textarea class="sim-textarea__field" disabled>비활성화 상태</textarea>
      </span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

```swift
LhTextarea(value: $text, showCount: true, maxlength: 10)
```

## API

### Props

| 속성 | 설명 | 타입 | 기본값 |
| --- | --- | --- | --- |
| `value` | 입력 내용(제어형 양방향 바인딩) | `String` | — |
| `placeholder` | 자리표시 도움말 글자 | `String` | `""` |
| `rows` | 예상 줄 수(최소 높이에 영향) | `Int` | `3` |
| `disabled` | 비활성화 여부(어떤 콜백도 발생 안 함) | `Bool` | `false` |
| `readonly` | 읽기 전용 여부(onValueChange 발생 안 함, 포커스 스타일은 유지) | `Bool` | `false` |
| `showCount` | 글자 수 카운트 표시 여부 | `Bool` | `false` |
| `maxlength` | 최대 글자 수(초과 시 잘림) | `Int?` | `nil` |
| `onValueChange` | 내용 변화 콜백, payload는 새 값 | `((String) -> Void)?` | `nil` |
| `lhOnFocus` | 포커스 콜백 | `(() -> Void)?` | `nil` |
| `lhOnBlur` | 포커스 해제 콜백 | `(() -> Void)?` | `nil` |

### 색상

| 상태 | 테두리 | 글자 / 자리표시 |
| --- | --- | --- |
| 기본 | `color.border.base`(`textarea.borderWidth`) | `color.text.primary` / `color.text.placeholder` |
| 포커스 | `color.focus`(`textarea.focusRingWidth`) | 동일 |
| 비활성화 | `color.disabled.border` | `color.disabled.text` |

## 토큰 매핑

| 토큰 | 용도 |
| --- | --- |
| `textarea.minHeight` | 최소 높이 |
| `textarea.paddingHorizontal` / `textarea.paddingVertical` | 안쪽 여백 |
| `textarea.fontSize` | 글자 크기 |
| `textarea.countFontSize` | 카운트 글자 크기 |
| `textarea.borderRadius` / `textarea.borderWidth` | 모서리 둥글기와 테두리 두께 |
| `textarea.focusRingWidth` | 포커스 링 두께 |
| `color.focus` | 포커스 테두리색 |
| `color.text.{primary,placeholder,disabled}` | 글자와 자리표시색 |
| `color.border.base` / `color.disabled.border` | 테두리색 |
| `color.background.default` / `color.disabled.bg` | 배경색 |

## 골든 케이스 매핑

| case id | 단언 | 로컬 테스트 |
| --- | --- | --- |
| `input-emits-onvaluechange` | 입력 시 `onValueChange("青花瓷")` 발생 | `testDefaultIsEditable` |
| `disabled-blocks-input` | 비활성화 상태는 onValueChange 발생 안 함 | `testDisabledBlocksInput` |
| `showcount-renders-count` | 카운트가 `3/10`을 표시하고 카운트 글자 크기 토큰 소비 | `testShowCountRendersCount` |
| `showcount-without-maxlength-renders-length-only` | 상한이 없을 때는 `3`만 표시 | `testShowCountWithoutMaxlengthRendersLengthOnly` |
| `focus-uses-focus-token` | 포커스 시 focus 토큰 소비 및 lhOnFocus 발생 | `testFocusUsesFocusToken` |
| `maxlength-truncates-input` | 글자 수 초과 시 잘림 | `testMaxlengthTruncatesInput` |

추가 항목: `testLayoutUsesTextareaTokens` / `testReadonlyBlocksInputButKeepsFocusStyle` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testTextareaViewInitAcceptsConstant`.

```bash
swift test --filter LhTextareaTests    # macOS 호스트에서 실행 가능, 시뮬레이터 불필요
```
