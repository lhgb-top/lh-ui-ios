# Checkbox 체크박스

제어형 체크박스입니다. `@Binding var checked`로 양방향 바인딩하며, 3상태(체크됨 / 체크 안 됨 / 중간)를 지원합니다.

> 계약 원본: `lh-ui-core/specs/checkbox.json` ·
> 골든 케이스: `lh-ui-core/cases/checkbox.json`(6건, XCTest로 번역됨, macOS 호스트에서 실행 가능)

## 상태

체크된 상태는 채워진 주색 사각형 + 흰색 체크 표시이고, 중간 상태는 채워진 주색 사각형 + 흰색 가로 막대이며, 체크되지 않은 상태는 테두리만 있는 빈 사각형입니다.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Checkbox 상태</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-checkbox"><span class="sim-checkbox__box"></span>체크 안 됨</span>
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>체크됨</span>
    </div>
    <div class="sim-row">
      <span class="sim-checkbox sim-checkbox--indeterminate"><span class="sim-checkbox__box"><span class="sim-checkbox__dash"></span></span>중간 상태</span>
      <span class="sim-checkbox sim-checkbox--checked sim-checkbox--disabled"><span class="sim-checkbox__box"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>비활성화</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

```swift
@State private var checked = false

LhCheckbox(checked: $checked, label: "체크됨") { newValue in
  // onChange
}
```

## 크기

3단 크기가 `checkbox.size` 토큰으로 매핑됩니다. 체크 표시의 테두리 두께는 `checkbox.checkWidth`를,
중간 상태 가로 막대의 두께는 사각형 크기에 `checkbox.dashScale`(50%)을 곱한 값입니다.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Checkbox 크기</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box sim-checkbox__box--small"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>소형</span>
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>중형</span>
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box sim-checkbox__box--large"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>대형</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

## 중간 상태

`indeterminate = true`일 때 체크 표시 대신 가로 막대를 표시합니다. 탭하면 반드시 **체크됨**으로 바뀌고(골든 케이스
`indeterminate-becomes-checked`), 토글하지 않습니다.

```swift
@State private var checked = false

LhCheckbox(checked: $checked, label: "모두 선택", indeterminate: somePartial) { _ in }
```

## API

### Props

| 속성 | 설명 | 타입 | 기본값 |
| --- | --- | --- | --- |
| `checked` | 체크 상태(제어형 양방향 바인딩) | `Bool` | — |
| `indeterminate` | 중간 상태 여부(가로 막대 표시, 탭하면 체크됨) | `Bool` | `false` |
| `disabled` | 비활성화 여부(onChange 발생 안 함) | `Bool` | `false` |
| `lhSize` | 체크박스 크기, 크기 토큰으로 매핑 | `LhCheckboxSize` | `.medium` |
| `label` | 글자 라벨 | `String` | `""` |
| `onChange` | 상태 변화 콜백, payload는 새 값 | `((Bool) -> Void)?` | `nil` |

### LhCheckboxSize

| 값 | 크기 |
| --- | --- |
| `.small` | `checkbox.size.small`(16pt) |
| `.medium` | `checkbox.size.medium`(20pt) |
| `.large` | `checkbox.size.large`(24pt) |

### 색상

| 상태 | 사각형 배경색 | 표시색 |
| --- | --- | --- |
| 체크 안 됨 | 투명 + `color.border.base` 테두리(`checkbox.borderWidth`) | — |
| 체크됨 / 중간 | `color.primary.default` | `color.onPrimary` |
| 비활성화 | `color.disabled.bg` + `color.disabled.border` 테두리 | `color.disabled.text` |

## 토큰 매핑

| 토큰 | 용도 |
| --- | --- |
| `checkbox.size.{small,medium,large}` | 3단 크기 |
| `checkbox.borderRadius` / `checkbox.borderWidth` | 모서리 둥글기(`radius.small` 따름)와 테두리 두께 |
| `checkbox.checkWidth` | 체크 표시 테두리 두께 |
| `checkbox.dashScale` | 중간 상태 가로 막대의 사각형 대비 비율(50%) |
| `checkbox.gap` | 사각형과 글자 사이 간격(`spacing.sm` 따름) |
| `color.primary.default` / `color.onPrimary` | 체크 상태 배경/표시색 |
| `color.border.base` | 체크 안 됨 테두리색 |
| `color.disabled.{bg,border,text}` | 비활성화 상태 3색 |

## 골든 케이스 매핑

| case id | 단언 | 로컬 테스트 |
| --- | --- | --- |
| `tap-toggles-and-emits-onchange` | 탭 시 반전하고 `onChange(true)` 콜백 | `testTapTogglesAndEmitsOnChange` |
| `tap-checked-unchecks` | 체크된 상태에서 탭하면 체크 안 됨으로 변경 | `testTapCheckedUnchecks` |
| `disabled-blocks-change` | 비활성화 상태는 onChange 발생 안 함 | `testDisabledBlocksChange` |
| `checked-uses-primary-tokens` | 체크 상태는 주색과 onPrimary 소비 | `testCheckedUsesPrimaryTokens` |
| `unchecked-uses-border-token` | 체크 안 됨은 테두리 토큰 소비 | `testUncheckedUsesBorderToken` |
| `indeterminate-becomes-checked` | 중간 상태에서 탭하면 반드시 체크됨 | `testIndeterminateBecomesChecked` |

추가 항목: `testSizeUsesSizeTokens` / `testStrokeUsesCheckboxTokens` /
`testDarkColorsComeFromDarkTokens` / `testDisabledInDarkUsesDarkDisabledTokens` /
`testDimensionsAreIdenticalInDarkMode` / `testCheckboxViewInitAcceptsConstant`.

```bash
swift test --filter LhCheckboxTests    # macOS 호스트에서 실행 가능, 시뮬레이터 불필요
```
