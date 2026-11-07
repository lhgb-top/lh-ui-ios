# Picker 피커

선언형 하단 휠 피커입니다. `@Binding var visible`이 표시/숨김을 제어하고, `@Binding var value`는 선택 항목의 인덱스입니다.
휠은 직접 그립니다(`DragGesture` + 놓을 때 스냅). 시스템 컨트롤 의존이 없습니다.

> 계약 원본: `lh-ui-core/specs/picker.json` ·
> 골든 케이스: `lh-ui-core/cases/picker.json`(8건, XCTest로 번역됨, macOS 호스트에서 실행 가능)

## 기본 형태

하단에서 올라옵니다. 상단에 툴바(취소 / 제목 / 확인), 중앙에 휠과 두 개의 인디케이터 선이 있습니다.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Picker 기본</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">선택기</button></div>
  </div>
  <div class="sim-picker-mask"></div>
  <div class="sim-picker">
    <div class="sim-picker__toolbar">
      <span class="sim-picker__btn">취소</span>
      <span class="sim-picker__title">선택</span>
      <span class="sim-picker__btn sim-picker__btn--confirm">확인</span>
    </div>
    <div class="sim-picker__wheel">
      <div class="sim-picker__indicator"></div>
      <div class="sim-picker__item">옵션 1</div>
      <div class="sim-picker__item sim-picker__item--selected">옵션 2</div>
      <div class="sim-picker__item">옵션 3</div>
    </div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

```swift
@State private var visible = false
@State private var index = 1
let options = ["옵션 1", "옵션 2", "옵션 3"]

LhPicker(
  visible: $visible,
  options: options,
  value: $index,
  title: "선택"
)
```

## 휠 인터랙션

- 드래그하여 전체 오프셋을 바꾸고, 손을 놓으면 가장 가까운 후보로 스냅합니다(애니메이션 시간 `motion.duration.base`).
  선택 인덱스가 바뀔 때 `onValueChange`를 발생시킵니다(골든 케이스 `scroll-emits-onvaluechange`).
- 인디케이터 선 사이 간격 = `picker.itemHeight`이며, 선택 항목이 항상 두 선의 정중앙에 옵니다.

## 콜백과 경계 처리

- "확인"이 `onConfirm`(payload는 현재 인덱스)과 `onClose`를 발생시킵니다(`confirm-also-emits-onclose`).
- "취소"가 `onCancel`을 발생시킵니다.
- `value`가 범위를 벗어나면 단 측에서 clamp합니다. 음수는 0으로(`clamp-negative-value-to-zero`), 초과는 마지막 항목으로
  (`clamp-overflow-value-to-last`). 옵션 목록이 비어 있을 때 인덱스는 항상 0입니다.
- `visible = false`일 때는 그리기 명령을 전혀 발생시키지 않습니다(`hidden-not-rendered`).

```swift
LhPicker(
  visible: $visible,
  options: options,
  value: $index,
  title: "선택",
  confirmText: "확인",
  cancelText: "취소",
  onValueChange: { newIndex in
    // 스크롤 스냅 콜백
  },
  onConfirm: { newIndex in
    // 확인 콜백(payload는 현재 인덱스)
  },
  onCancel: {
    // 취소 콜백
  }
)
```

## API

### Props

| 속성 | 설명 | 타입 | 기본값 |
| --- | --- | --- | --- |
| `visible` | 표시 여부(제어형 양방향 바인딩) | `Bool` | — |
| `options` | 후보 항목 글자 배열(단일 열) | `[String]` | — |
| `value` | 선택 항목 인덱스(제어형 양방향 바인딩, 범위 초과 시 자동 clamp) | `Int` | — |
| `title` | 툴바 제목 | `String` | `""` |
| `confirmText` | 확인 버튼 글자. `nil`(기본값)은 언어 팩을 사용 | `String?` | 언어 팩(간체 중국어 `"确认"`) |
| `cancelText` | 취소 버튼 글자. `nil`(기본값)은 언어 팩을 사용 | `String?` | 언어 팩(간체 중국어 `"取消"`) |
| `onValueChange` | 스크롤 스냅 콜백, payload는 새 인덱스 | `((Int) -> Void)?` | `nil` |
| `onConfirm` | 확인 콜백, payload는 현재 인덱스 | `((Int) -> Void)?` | `nil` |
| `onCancel` | 취소 콜백 | `(() -> Void)?` | `nil` |
| `onClose` | 닫기 콜백(확인 / 취소 모두 발생) | `(() -> Void)?` | `nil` |

### 색상

| 영역 | 색상 |
| --- | --- |
| 패널 배경 | `color.background.default` |
| 마스크 | `color.background.overlay` |
| 취소 버튼 / 후보 항목 글자 | `color.text.primary` |
| 제목 / 확인 버튼 | `color.primary.default` |
| 인디케이터 선 | `color.border.lighter`(두께는 `cell.borderWidth`) |

## 토큰 매핑

| 토큰 | 용도 |
| --- | --- |
| `picker.height` | 패널 높이(260pt) |
| `picker.toolbarHeight` | 툴바 높이(44pt) |
| `picker.itemHeight` | 항목별 높이(휠과 인디케이터 선 간격을 결정) |
| `picker.itemFontSize` | 후보 항목과 툴바 글자 크기 |
| `picker.borderRadius` | 상단 모서리 둥글기 |
| `color.background.overlay` / `color.background.default` | 마스크와 패널 배경색 |
| `color.border.lighter` / `cell.borderWidth` | 인디케이터 선 색상과 두께 |
| `color.primary.default` | 확인 버튼과 선택 항목 글자색 |
| `zIndex.{modalBackdrop,modal}` | 마스크와 패널의 쌓임 순서 |
| `motion.duration.base` | 스냅 애니메이션 시간(iOS 단에서는 초) |

## 골든 케이스 매핑

| case id | 단언 | 로컬 테스트 |
| --- | --- | --- |
| `confirm-emits-onconfirm-with-value` | 확인 시 `onConfirm(1)` 발생 | `testConfirmUsesPrimaryToken` |
| `confirm-also-emits-onclose` | 확인 시 onClose도 발생 | `testConfirmUsesPrimaryToken` |
| `cancel-emits-oncancel` | 취소 시 onCancel 발생 | `testCancelUsesNeutralColor` |
| `scroll-emits-onvaluechange` | 스크롤 스냅 시 `onValueChange(2)` 발생 | View 계층 `DragGesture.onEnded`(제스처 단언은 시뮬레이터 필요) |
| `clamp-negative-value-to-zero` | 음수 인덱스는 0으로 clamp | `testClampNegativeValueToZero` |
| `clamp-overflow-value-to-last` | 초과 인덱스는 마지막 항목으로 clamp | `testClampOverflowValueToLast` |
| `title-renders-text` | 제목이 올바르게 렌더링됨 | `testTitleAndTextsAreExposed` |
| `hidden-not-rendered` | 숨김 상태에서 렌더링 안 함 | `testHiddenNotRendered` |

추가 항목: `testVisibleRendersAppearance` / `testClampedValueIsExposed` /
`testLayoutUsesPickerTokens` / `testEmptyOptionsClampsToZero` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testPickerViewInitAcceptsConstant`.

```bash
swift test --filter LhPickerTests    # macOS 호스트에서 실행 가능, 시뮬레이터 불필요
```
