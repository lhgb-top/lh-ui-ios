# Switch 스위치

제어형 스위치입니다. `@Binding var checked`로 양방향 바인딩하며, 트랙 비율은 2:1, 점의 지름은 높이 − 2 × `switch.gap`입니다.

> 계약 원본: `lh-ui-core/specs/switch.json` ·
> 골든 케이스: `lh-ui-core/cases/switch.json`(6건, XCTest로 번역됨, macOS 호스트에서 실행 가능)

## 상태

켜짐일 때 트랙은 주색이고 점이 우측으로 이동하며, 꺼짐일 때 트랙은 테두리색입니다. `loading` 상태에서는 트랙 안에 작은 인디케이터를 표시하고 전환에 반응하지 않습니다.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Switch 상태</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-switch"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--on"><span class="sim-switch__thumb"></span></span>
    </div>
    <div class="sim-row">
      <span class="sim-switch sim-switch--on sim-switch--disabled"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--disabled"><span class="sim-switch__thumb"></span></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

```swift
@State private var on = true

LhSwitch(checked: $on) { newValue in
  // onChange
}
```

## 크기

3단 크기가 `switch.width` / `switch.height` 토큰으로 매핑되며, 모서리 둥글기는 높이에 맞춰 자동으로 트랙 반지름이 됩니다.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Switch 크기</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-switch sim-switch--small sim-switch--on"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--on"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--large sim-switch--on"><span class="sim-switch__thumb"></span></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

## 로딩 상태

`loading = true`일 때 트랙 안에 `LhLoading(lhSize: .small, tone: .primary)`를 내장하고, 탭은 gate에 의해 차단됩니다
(골든 케이스 `loading-blocks-change`).

```swift
LhSwitch(checked: $submitting, loading: submitting) { _ in }
```

## API

### Props

| 속성 | 설명 | 타입 | 기본값 |
| --- | --- | --- | --- |
| `checked` | 스위치 상태(제어형 양방향 바인딩) | `Bool` | — |
| `disabled` | 비활성화 여부(onChange 발생 안 함) | `Bool` | `false` |
| `loading` | 로딩 중 여부(인디케이터 내장, onChange 발생 안 함) | `Bool` | `false` |
| `lhSize` | 스위치 크기, 크기 토큰으로 매핑 | `LhSwitchSize` | `.medium` |
| `onChange` | 상태 변화 콜백, payload는 새 값 | `((Bool) -> Void)?` | `nil` |

### LhSwitchSize

| 값 | width | height | 점 지름 |
| --- | --- | --- | --- |
| `.small` | `switch.width.small`(36pt) | `switch.height.small`(20pt) | height − 2 × `switch.gap`(16pt) |
| `.medium` | `switch.width.medium`(44pt) | `switch.height.medium`(24pt) | height − 2 × `switch.gap`(20pt) |
| `.large` | `switch.width.large`(52pt) | `switch.height.large`(28pt) | height − 2 × `switch.gap`(24pt) |

### 색상

| 상태 | 트랙 | 점 |
| --- | --- | --- |
| 꺼짐 | `color.border.base` | `color.onPrimary` |
| 켜짐 | `color.primary.default` | `color.onPrimary` |
| 비활성화 | `color.disabled.bg` | `color.disabled.text` |

## 토큰 매핑

| 토큰 | 용도 |
| --- | --- |
| `switch.width.{small,medium,large}` | 3단 트랙 너비 |
| `switch.height.{small,medium,large}` | 3단 트랙 높이 |
| `switch.gap` | 점과 트랙 사이 안쪽 여백(점 지름을 결정) |
| `color.primary.default` | 켜짐 트랙색 |
| `color.border.base` | 꺼짐 트랙색 |
| `color.onPrimary` | 점 색상 |
| `color.disabled.{bg,text}` | 비활성화 상태 2색 |
| `motion.duration.base` | 점 슬라이드 애니메이션 시간(iOS 단에서는 초) |

## 골든 케이스 매핑

| case id | 단언 | 로컬 테스트 |
| --- | --- | --- |
| `tap-toggles-and-emits-onchange` | 탭 시 켜지며 `onChange(true)` 콜백 | `testDefaultIsInteractive` |
| `tap-checked-turns-off` | 켜짐 상태에서 탭하면 꺼짐으로 변경 | `testCheckedUsesPrimaryTrack` |
| `disabled-blocks-change` | 비활성화 상태는 onChange 발생 안 함 | `testDisabledBlocksChange` |
| `loading-blocks-change` | 로딩 상태는 onChange 발생 안 함 | `testLoadingBlocksChange` |
| `checked-uses-primary-token` | 켜짐은 주색 토큰 소비, 테두리 토큰은 소비 안 함 | `testCheckedUsesPrimaryToken` |
| `unchecked-uses-border-token` | 꺼짐은 테두리 토큰 소비 | `testUncheckedUsesBorderToken` |

추가 항목: `testSizeUsesSwitchTokens` / `testThumbDiameterIsHeightMinusTwoGaps` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testSwitchViewInitAcceptsConstant`.

```bash
swift test --filter LhSwitchTests    # macOS 호스트에서 실행 가능, 시뮬레이터 불필요
```
