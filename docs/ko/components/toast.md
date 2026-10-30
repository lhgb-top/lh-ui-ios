# Toast 알림

선언형 가벼운 알림입니다. `@Binding var visible`이 표시/숨김을 제어하고, 설정 시간이 지나면 자동으로 사라지며, 어두운 배경은 `color.ink` 토큰을 사용합니다.

> 계약 원본: `lh-ui-core/specs/toast.json` ·
> 골든 케이스: `lh-ui-core/cases/toast.json`(6건, XCTest로 번역됨, macOS 호스트에서 실행 가능)

## 유형

기본 유형은 아이콘이 없고, 나머지 유형은 글자 좌측에 시맨틱 색상 점을 표시합니다. 어두운 배경 + 흰 글자이며, 대비도는 `color.ink`가 보장합니다.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Toast 유형</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">기본</button></div>
  </div>
  <div class="sim-toast">저장됨</div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Toast 시맨틱</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--success">성공</button></div>
  </div>
  <div class="sim-toast"><span class="sim-toast__dot sim-toast__dot--success"></span>작업 성공</div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

```swift
@State private var visible = false

LhToast(visible: $visible, text: "저장됨", type: .success)
```

## 위치

3가지 위치: `top`(상단), `center`(중앙, 기본), `bottom`(하단).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Toast 위치</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">bottom 위치</button></div>
  </div>
  <div class="sim-toast sim-toast--bottom"><span class="sim-toast__dot sim-toast__dot--warning"></span>하단 알림</div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

## 자동으로 사라지기

`visible`이 `true`가 되면 `.task` 타이머를 시작하고, `duration` 밀리초 후 자동으로 `false`로 되돌리며 `onClose`를 발생시킵니다
(골든 케이스 `auto-hides-after-duration`). 시간이 채 되지 않았으면 계속 표시하고 콜백을 발생시키지 않으며
(`tick-before-duration-keeps-visible`), 외부에서 수동으로 `false`로 바꿀 때는 콜백을 발생시키지 않습니다(`hide-is-silent`).

::: tip 시간 단위
토큰 `toast.duration`은 밀리초(2000)이고 SwiftUI의 `Task.sleep`은 초가 필요하므로, 단 측에서
`Double(duration) / 1000`로 변환합니다(`LhToastStyle` 참조).
:::

```swift
LhToast(visible: $visible, text: "작업 성공", type: .success, duration: 2000) {
  // onClose(자동으로 사라질 때만 발생)
}
```

## API

### Props

| 속성 | 설명 | 타입 | 기본값 |
| --- | --- | --- | --- |
| `visible` | 표시 여부(제어형 양방향 바인딩, 설정 시간 경과 시 자동으로 false로 되돌림) | `Bool` | — |
| `text` | 알림 글자 | `String` | — |
| `type` | 알림 유형, 점 표시 여부와 점 색상을 결정 | `LhToastType` | `.default` |
| `lhPosition` | 표시 위치 | `LhToastPosition` | `.center` |
| `duration` | 표시 시간(밀리초) | `Int` | `2000`(`toast.duration` 토큰에서 가져옴) |
| `onClose` | 자동 사라짐 콜백(외부 수동 숨김에는 발생 안 함) | `(() -> Void)?` | `nil` |

### LhToastType

| 값 | 점 색상 |
| --- | --- |
| `.default` | 점 없음 |
| `.success` | `color.success.default` |
| `.warning` | `color.warning.default` |
| `.danger` | `color.danger.default` |
| `.info` | `color.info.default` |

### LhToastPosition

| 값 | 위치 |
| --- | --- |
| `.top` | 상단(여백 `spacing.xl`) |
| `.center` | 중앙 |
| `.bottom` | 하단(여백 `spacing.xl`) |

## 토큰 매핑

| 토큰 | 용도 |
| --- | --- |
| `toast.paddingHorizontal` / `toast.paddingVertical` | 안쪽 여백 |
| `toast.fontSize` | 알림 글자 크기 |
| `toast.borderRadius` | 모서리 둥글기(`radius.small` 따름) |
| `toast.gap` | 점과 글자 사이 간격 |
| `toast.duration` | 기본 표시 시간(밀리초) |
| `color.ink` | 어두운 배경(다크 모드에서 전용 덮어쓰기가 있어 페이지 배경과 층위를 구분) |
| `color.onPrimary` | 흰 글자 |
| `color.{success,warning,danger,info}.default` | 점 시맨틱 색상 |
| `zIndex.toast` | 쌓임 순서 |
| `spacing.xl` | 상/하단 위치 여백 |

## 골든 케이스 매핑

| case id | 단언 | 로컬 테스트 |
| --- | --- | --- |
| `show-makes-visible` | 표시하면 렌더링됨 | `testShowMakesVisible` |
| `auto-hides-after-duration` | 설정 시간 경과 후 자동 숨김 및 onClose 발생 | `testDurationConvertsToSeconds` |
| `tick-before-duration-keeps-visible` | 시간이 채 되지 않았으면 계속 표시 | `testVisibleDuringDuration` |
| `hide-is-silent` | 외부 수동 숨김 시 콜백 발생 안 함 | `testHideIsSilent` |
| `success-type-uses-success-token` | 성공 유형은 성공색과 ink 토큰 소비 | `testSuccessTypeUsesSuccessToken` / `testInkBackgroundUsesInkToken` |
| `hidden-emits-no-commands` | 숨김 상태에서 그리기 명령이 비어 있음 | `testHiddenNotRendered` |

추가 항목: `testDefaultTypeHasNoDot` / `testLayoutUsesToastTokens` /
`testDarkColorsComeFromDarkTokens` / `testDarkInkDiffersFromLightInk` /
`testDimensionsAreIdenticalInDarkMode` / `testToastViewInitAcceptsConstant`.

```bash
swift test --filter LhToastTests    # macOS 호스트에서 실행 가능, 시뮬레이터 불필요
```
