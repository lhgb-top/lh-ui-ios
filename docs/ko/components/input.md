# Input 입력 상자

제어형 한 줄 입력 상자입니다. `@Binding var value`로 양방향 바인딩하며, 평문/비밀번호, 지우기 버튼, 글자 수 제한, 포커스 링을 지원합니다.

> 계약 원본: `lh-ui-core/specs/input.json` ·
> 골든 케이스: `lh-ui-core/cases/input.json`(8건, XCTest로 번역됨, macOS 호스트에서 실행 가능)

## 기본 형태

높이는 Button과 정렬됩니다(3단 `input.height` 토큰). 포커스 시 테두리가 `color.focus`로 바뀌고 포커스 링으로 두꺼워집니다.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Input 기본</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-input"><input class="sim-input__field" placeholder="내용을 입력해 주세요" /></span>
    </div>
    <div class="sim-row">
      <span class="sim-input sim-input--focus"><input class="sim-input__field" value="青花瓷" /></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

```swift
@State private var text = ""

LhInput(value: $text, placeholder: "내용을 입력해 주세요") { newValue in
  // onValueChange
}
```

## 크기

3단 크기가 `input.height` / `paddingHorizontal` / `fontSize` 토큰으로 매핑됩니다.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Input 크기</span></div>
  <div class="sim-screen">
    <div class="sim-row"><span class="sim-input sim-input--small"><input class="sim-input__field" placeholder="소형" /></span></div>
    <div class="sim-row"><span class="sim-input"><input class="sim-input__field" placeholder="중형" /></span></div>
    <div class="sim-row"><span class="sim-input sim-input--large"><input class="sim-input__field" placeholder="대형" /></span></div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

## 비밀번호와 지우기

`type: .password`는 `SecureField`로 구현됩니다(테스트 `testPasswordTypeIsSecure`).
`clearable`은 값이 있을 때 지우기 버튼을 표시하고, 탭하면 `onValueChange("")`를 발생시킵니다(골든 케이스 `clearable-emits-empty-value`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Input 확장</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-input"><input class="sim-input__field" type="password" value="secret" /><svg class="sim-input__clear" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 100 20 10 10 0 000-20zm1 15h-2v-2h2zm0-4h-2V7h2z"/></svg></span>
    </div>
    <div class="sim-row">
      <span class="sim-input sim-input--disabled"><input class="sim-input__field" value="비활성화 상태" disabled /></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

```swift
LhInput(value: $pwd, type: .password, clearable: true)
```

## API

### Props

| 속성 | 설명 | 타입 | 기본값 |
| --- | --- | --- | --- |
| `value` | 입력 내용(제어형 양방향 바인딩) | `String` | — |
| `placeholder` | 자리표시 도움말 글자 | `String` | `""` |
| `type` | 입력 유형(평문 / 비밀번호) | `LhInputType` | `.text` |
| `lhSize` | 입력 상자 크기, 크기 토큰으로 매핑 | `LhInputSize` | `.medium` |
| `disabled` | 비활성화 여부(어떤 콜백도 발생 안 함) | `Bool` | `false` |
| `readonly` | 읽기 전용 여부(onValueChange 발생 안 함, 포커스 스타일은 유지) | `Bool` | `false` |
| `clearable` | 지우기 버튼 표시 여부 | `Bool` | `false` |
| `maxlength` | 최대 글자 수(초과 시 잘림, 골든 케이스 `maxlength-truncates-input`) | `Int?` | `nil` |
| `onValueChange` | 내용 변화 콜백, payload는 새 값 | `((String) -> Void)?` | `nil` |
| `lhOnFocus` | 포커스 콜백 | `(() -> Void)?` | `nil` |
| `lhOnBlur` | 포커스 해제 콜백 | `(() -> Void)?` | `nil` |

### LhInputSize

| 값 | height | paddingHorizontal | fontSize |
| --- | --- | --- | --- |
| `.small` | `input.height.small`(32pt) | `input.paddingHorizontal.small`(12pt) | `input.fontSize.small`(13pt) |
| `.medium` | `input.height.medium`(40pt) | `input.paddingHorizontal.medium`(16pt) | `input.fontSize.medium`(14pt) |
| `.large` | `input.height.large`(48pt) | `input.paddingHorizontal.large`(20pt) | `input.fontSize.large`(16pt) |

### LhInputType

| 값 | 구현 |
| --- | --- |
| `.text` | `TextField` |
| `.password` | `SecureField` |

### 색상

| 상태 | 테두리 | 글자 / 자리표시 |
| --- | --- | --- |
| 기본 | `color.border.base`(`input.borderWidth`) | `color.text.primary` / `color.text.placeholder` |
| 포커스 | `color.focus`(`input.focusRingWidth`) | 동일 |
| 비활성화 | `color.disabled.border` | `color.disabled.text` |

## 토큰 매핑

| 토큰 | 용도 |
| --- | --- |
| `input.height.{small,medium,large}` | 3단 높이 |
| `input.paddingHorizontal.{small,medium,large}` | 3단 가로 안쪽 여백 |
| `input.fontSize.{small,medium,large}` | 3단 글자 크기 |
| `input.borderRadius` / `input.borderWidth` | 모서리 둥글기(`radius.small` 따름)와 테두리 두께 |
| `input.focusRingWidth` | 포커스 링 두께 |
| `input.clearIconSize` | 지우기 버튼 아이콘 크기 |
| `color.focus` | 포커스 테두리색 |
| `color.text.{primary,placeholder,disabled}` | 글자와 자리표시색 |
| `color.border.base` / `color.disabled.border` | 테두리색 |
| `color.background.default` / `color.disabled.bg` | 배경색 |

## 골든 케이스 매핑

| case id | 단언 | 로컬 테스트 |
| --- | --- | --- |
| `input-emits-onvaluechange` | 입력 시 `onValueChange("青花瓷")` 발생 | `testDefaultIsEditable` |
| `clearable-emits-empty-value` | 지우기 시 `onValueChange("")` 발생 | `testClearableShowsClearButtonWhenHasValue` |
| `disabled-blocks-input` | 비활성화 상태는 onValueChange 발생 안 함 | `testDisabledBlocksInput` |
| `readonly-blocks-input` | 읽기 전용 상태는 onValueChange 발생 안 함 | `testReadonlyBlocksInput` |
| `placeholder-uses-placeholder-token` | 자리표시 글자는 자리표시색 토큰 사용 | `testPlaceholderUsesPlaceholderToken` |
| `focus-uses-focus-token` | 포커스 시 focus 토큰 소비 및 lhOnFocus 발생 | `testFocusUsesFocusToken` |
| `small-size-uses-small-tokens` | 소형은 small 크기 토큰 소비 | `testSmallSizeUsesSmallTokens` |
| `maxlength-truncates-input` | 글자 수 초과 시 잘림 | `testMaxlengthTruncatesInput` |

추가 항목: `testPasswordTypeIsSecure` / `testDarkColorsComeFromDarkTokens` /
`testDimensionsAreIdenticalInDarkMode` / `testInputViewInitAcceptsConstant`.

```bash
swift test --filter LhInputTests    # macOS 호스트에서 실행 가능, 시뮬레이터 불필요
```
