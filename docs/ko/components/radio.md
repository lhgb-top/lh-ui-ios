# Radio 라디오 버튼

제어형 라디오 버튼입니다. `@Binding var checked`는 "이 항목의 선택 여부"를 나타내며, 보통 그룹과 함께 사용합니다. 같은 그룹 안에서는 한 항목만 `true`일 수 있습니다.

> 계약 원본: `lh-ui-core/specs/radio.json` ·
> 골든 케이스: `lh-ui-core/cases/radio.json`(6건, XCTest로 번역됨, macOS 호스트에서 실행 가능)

## 상태

선택된 상태는 테두리 주색 원환 + 채워진 주색 점이고, 선택되지 않은 상태는 테두리만 있는 빈 원환입니다. 점의 지름은 크기에 `radio.dotScale`(50%)을 곱한 값입니다.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Radio 상태</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-radio"><span class="sim-radio__ring"></span>선택 안 됨</span>
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>선택됨</span>
    </div>
    <div class="sim-row">
      <span class="sim-radio sim-radio--checked sim-radio--disabled"><span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>비활성화된 선택</span>
      <span class="sim-radio sim-radio--disabled"><span class="sim-radio__ring"></span>비활성화된 미선택</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

```swift
@State private var picked = "blue"

LhRadio(checked: Binding(get: { picked == "blue" }, set: { _ in }), value: "blue", label: "青花瓷") { _ in
  picked = "blue"
}
```

## 크기

3단 크기가 `radio.size` 토큰으로 매핑되며, 원환 테두리는 `radio.ringWidth`를 사용합니다.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Radio 크기</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring sim-radio__ring--small"><span class="sim-radio__dot sim-radio__dot--small"></span></span>소형</span>
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>중형</span>
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring sim-radio__ring--large"><span class="sim-radio__dot sim-radio__dot--large"></span></span>대형</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

## 탭 gate

이미 선택된 상태에서 다시 탭하면 선택을 유지하고 `onChange`를 발생시키지 않습니다(골든 케이스 `tap-checked-keeps-checked`).
비활성화 상태도 발생하지 않습니다(`disabled-blocks-change`). 그룹 컨테이너는 이후 버전에 추가될 예정입니다.

## API

### Props

| 속성 | 설명 | 타입 | 기본값 |
| --- | --- | --- | --- |
| `checked` | 이 항목의 선택 여부(제어형 양방향 바인딩) | `Bool` | — |
| `value` | 이 항목이 나타내는 값(`checked`와 함께 라디오 그룹 구현) | `String` | `""` |
| `disabled` | 비활성화 여부(onChange 발생 안 함) | `Bool` | `false` |
| `lhSize` | 라디오 버튼 크기, 크기 토큰으로 매핑 | `LhRadioSize` | `.medium` |
| `label` | 글자 라벨 | `String` | `""` |
| `onChange` | 선택 변화 콜백, payload는 새 값 | `((Bool) -> Void)?` | `nil` |

### LhRadioSize

| 값 | 원환 크기 | 점 지름 |
| --- | --- | --- |
| `.small` | `radio.size.small`(16pt) | 크기 × `radio.dotScale`(8pt) |
| `.medium` | `radio.size.medium`(20pt) | 크기 × `radio.dotScale`(10pt) |
| `.large` | `radio.size.large`(24pt) | 크기 × `radio.dotScale`(12pt) |

### 색상

| 상태 | 원환 테두리 | 점 |
| --- | --- | --- |
| 선택 안 됨 | `color.border.base`(`radio.ringWidth`) | — |
| 선택됨 | `color.primary.default` | `color.primary.default` |
| 비활성화 | `color.disabled.border` | `color.disabled.text` |

## 토큰 매핑

| 토큰 | 용도 |
| --- | --- |
| `radio.size.{small,medium,large}` | 3단 원환 크기 |
| `radio.dotScale` | 점의 원환 크기 대비 비율(50%) |
| `radio.ringWidth` | 원환 테두리 두께 |
| `radio.gap` | 원환과 글자 사이 간격(`spacing.sm` 따름) |
| `color.primary.default` | 선택 상태 테두리와 점 색상 |
| `color.border.base` | 선택 안 됨 테두리색 |
| `color.disabled.{border,text}` | 비활성화 상태 테두리와 점 색상 |
| `color.text.{primary,disabled}` | 라벨 글자색 |

## 골든 케이스 매핑

| case id | 단언 | 로컬 테스트 |
| --- | --- | --- |
| `tap-unchecked-emits-onchange` | 선택 안 됨에서 탭 시 `onChange(true)` 발생 | `testUncheckedIsInteractive` |
| `tap-checked-keeps-checked` | 선택된 상태에서 탭해도 선택 유지, 콜백 없음 | `testCheckedShowsDot` |
| `disabled-blocks-change` | 비활성화 상태는 onChange 발생 안 함 | `testDisabledBlocksChange` |
| `checked-uses-primary-tokens` | 선택 상태는 주색 토큰 소비 | `testCheckedUsesPrimaryTokens` |
| `unchecked-uses-border-token` | 선택 안 됨은 테두리 토큰 소비 | `testUncheckedUsesBorderToken` |
| `small-size-uses-small-token` | 소형은 small 크기 토큰 소비 | `testSmallSizeUsesSmallToken` |

추가 항목: `testStrokeUsesRadioTokens` / `testDarkColorsComeFromDarkTokens` /
`testDisabledInDarkUsesDarkDisabledTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testRadioViewInitAcceptsConstant`.

```bash
swift test --filter LhRadioTests    # macOS 호스트에서 실행 가능, 시뮬레이터 불필요
```
