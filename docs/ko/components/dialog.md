# Dialog 대화상자

선언형 모달 대화상자입니다. `@Binding var visible`이 표시/숨김을 제어하고, 마스크 + 중앙 패널에 버튼은 `LhButton`을 재사용합니다.

> 계약 원본: `lh-ui-core/specs/dialog.json` ·
> 골든 케이스: `lh-ui-core/cases/dialog.json`(8건, XCTest로 번역됨, macOS 호스트에서 실행 가능)

## 유형

6가지 유형이 확인 버튼의 시맨틱 색상을 결정합니다(`buttonType(for:)`가 `LhButtonType`로 매핑).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Dialog 유형</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary">기본 대화상자</button>
      <button class="sim-btn sim-btn--danger">위험 대화상자</button>
    </div>
  </div>
  <div class="sim-dialog-mask"></div>
  <div class="sim-dialog">
    <div class="sim-dialog__title">삭제 확인</div>
    <div class="sim-dialog__content">이 작업은 해당 항목을 영구적으로 삭제합니다. 계속하시겠습니까?</div>
    <div class="sim-dialog__actions">
      <button class="sim-btn">취소</button>
      <button class="sim-btn sim-btn--danger">확인</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

```swift
@State private var visible = false

LhDialog(
  visible: $visible,
  title: "삭제 확인",
  content: "이 작업은 해당 항목을 영구적으로 삭제합니다. 계속하시겠습니까?",
  type: .danger,
  confirmText: "확인",
  cancelText: "취소"
)
```

## 표시/숨김과 콜백

- `visible = true`이면 마스크와 패널을 렌더링하고, `visible = false`일 때는 그리기 명령을 전혀 발생시키지 않습니다(골든 케이스 `hidden-not-rendered`).
- "확인"을 탭하면 `onConfirm`과 `onClose`가 차례로 발생합니다(`confirm-also-emits-onclose`).
- "취소"를 탭하면 `onCancel`이 발생합니다. `onClose`는 컴포넌트 내부에서 `visible`을 `false`로 되돌리는 역할을 합니다(`withAnimation`으로 감싸짐).
- `closable = true`일 때 마스크를 탭해도 `onClose`가 발생합니다(`closable-overlay-emits-onclose`). 기본값은 닫지 않습니다(`not-closable-blocks-overlay-close`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Dialog 마스크로 닫기</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">closable = true</button></div>
  </div>
  <div class="sim-dialog-mask"></div>
  <div class="sim-dialog">
    <div class="sim-dialog__title">알림</div>
    <div class="sim-dialog__content">마스크를 탭하면 닫힙니다</div>
    <div class="sim-dialog__actions">
      <button class="sim-btn">취소</button>
      <button class="sim-btn sim-btn--primary">확인</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

## API

### Props

| 속성 | 설명 | 타입 | 기본값 |
| --- | --- | --- | --- |
| `visible` | 표시 여부(제어형 양방향 바인딩) | `Bool` | — |
| `title` | 제목 | `String` | `""` |
| `content` | 본문 내용 | `String` | `""` |
| `type` | 대화상자 유형, 확인 버튼의 시맨틱 색상을 결정 | `LhDialogType` | `.default` |
| `confirmText` | 확인 버튼 글자. `nil`(기본값)은 언어 팩을 사용, `""`는 버튼 숨김 | `String?` | 언어 팩(간체 중국어 `"确认"`) |
| `cancelText` | 취소 버튼 글자. `nil`(기본값)은 언어 팩을 사용, `""`는 버튼 숨김 | `String?` | 언어 팩(간체 중국어 `"取消"`) |
| `closable` | 마스크 탭으로 닫기 가능 여부 | `Bool` | `false` |
| `onConfirm` | 확인 콜백 | `(() -> Void)?` | `nil` |
| `onCancel` | 취소 콜백 | `(() -> Void)?` | `nil` |
| `onClose` | 닫기 콜백(마스크 탭 / 버튼·취소 / 버튼·확인 모두 발생) | `(() -> Void)?` | `nil` |

### LhDialogType

| 값 | 확인 버튼 유형 | 배경색 |
| --- | --- | --- |
| `.default` | `.default` | `color.background.default` + 테두리 |
| `.primary` | `.primary` | `color.primary.default` |
| `.success` | `.success` | `color.success.default` |
| `.warning` | `.warning` | `color.warning.default` |
| `.danger` | `.danger` | `color.danger.default` |
| `.info` | `.info` | `color.info.default` |

## 토큰 매핑

| 토큰 | 용도 |
| --- | --- |
| `dialog.width` | 패널 너비(320pt) |
| `dialog.paddingHorizontal` / `dialog.paddingVertical` | 패널 안쪽 여백 |
| `dialog.borderRadius` | 패널 모서리 둥글기 |
| `dialog.titleFontSize` / `dialog.contentFontSize` | 제목과 본문 글자 크기 |
| `dialog.gap` | 각 영역의 세로 간격 |
| `color.background.overlay` | 마스크색 |
| `color.background.default` | 패널 배경색 |
| `color.text.{primary,regular}` | 제목과 본문 색상 |
| `shadow.base` | 패널 섀도(LhShadow 운반) |
| `zIndex.{modalBackdrop,modal}` | 마스크와 패널의 쌓임 순서 |

## 골든 케이스 매핑

| case id | 단언 | 로컬 테스트 |
| --- | --- | --- |
| `confirm-emits-onconfirm` | 확인 시 onConfirm 발생 | `testConfirmUsesTypeColor` |
| `cancel-emits-oncancel` | 취소 시 onCancel 발생 | `testCancelUsesNeutralColor` |
| `confirm-also-emits-onclose` | 확인 시 onClose도 발생 | `testConfirmUsesTypeColor` |
| `closable-overlay-emits-onclose` | 마스크 탭 시 onClose 발생 | `testClosableFlagIsExposed` |
| `not-closable-blocks-overlay-close` | 기본값은 마스크로 닫지 않음 | `testNotClosableBlocksOverlay` |
| `hidden-not-rendered` | 숨김 상태에서 렌더링 안 함 | `testHiddenNotRendered` |
| `title-renders-text` | 제목이 올바르게 렌더링됨 | `testTitleUsesTitleTokens` |
| `danger-type-uses-danger-token` | 위험 유형은 위험색 토큰 소비 | `testDangerTypeUsesDangerToken` |

추가 항목: `testVisibleRendersAppearance` / `testLayoutUsesDialogTokens` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testDialogViewInitAcceptsConstant`.

```bash
swift test --filter LhDialogTests    # macOS 호스트에서 실행 가능, 시뮬레이터 불필요
```
