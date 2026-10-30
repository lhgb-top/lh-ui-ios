# Cell 셀

리스트 셀입니다. 좌측 아이콘 + 제목(필수 표시 빨간 별과 부제목 포함), 우측 값과 화살표, 하단 구분선으로 구성됩니다.

> 계약 원본: `lh-ui-core/specs/cell.json` ·
> 골든 케이스: `lh-ui-core/cases/cell.json`(6건, XCTest로 번역됨, macOS 호스트에서 실행 가능)

## 기본 형태

`title`은 필수이고, `value` / `label` / `icon`은 선택입니다. `bordered`가 하단 구분선을 제어합니다(기본 켜짐).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Cell 기본</span></div>
  <div class="sim-screen" style="padding: 0;">
    <div class="sim-cell">
      <div class="sim-cell__main"><div class="sim-cell__title">제목 텍스트</div></div>
      <div class="sim-cell__value">우측 값</div>
      <div class="sim-cell__arrow">›</div>
    </div>
    <div class="sim-cell">
      <div class="sim-cell__main">
        <div class="sim-cell__title">부제목 포함</div>
        <div class="sim-cell__label">이것은 부제목 설명 텍스트입니다</div>
      </div>
      <div class="sim-cell__arrow">›</div>
    </div>
    <div class="sim-cell">
      <div class="sim-cell__main"><div class="sim-cell__title">구분선 없음</div></div>
      <div class="sim-cell__value">값</div>
    </div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

```swift
LhCell(title: "제목 텍스트", value: "우측 값", clickable: true) {
  // lhOnClick
}
```

## 아이콘 / 필수 / 클릭 불가

`icon`은 `LhIconMap`으로 매핑됩니다. `required`는 제목 앞에 빨간 별표를 표시합니다.
`clickable = false`(기본)일 때는 탭에 반응하지 않습니다(골든 케이스 `not-clickable-no-onclick`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Cell 확장</span></div>
  <div class="sim-screen" style="padding: 0;">
    <div class="sim-cell">
      <span class="sim-cell__icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="width:100%;height:100%"><circle cx="11" cy="11" r="7"/><path d="M21 21l-4.3-4.3"/></svg></span>
      <div class="sim-cell__main"><div class="sim-cell__title">좌측 아이콘</div></div>
      <div class="sim-cell__arrow">›</div>
    </div>
    <div class="sim-cell">
      <div class="sim-cell__main"><div class="sim-cell__title"><span class="sim-cell__required">*</span>필수 항목</div></div>
      <div class="sim-cell__value">선택해 주세요</div>
      <div class="sim-cell__arrow">›</div>
    </div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

## API

### Props

| 속성 | 설명 | 타입 | 기본값 |
| --- | --- | --- | --- |
| `title` | 제목(필수) | `String` | — |
| `value` | 우측 값 | `String` | `""` |
| `label` | 제목 아래 부제목 | `String` | `""` |
| `icon` | 좌측 아이콘 논리 이름(`LhIconMap` 매핑) | `String?` | `nil` |
| `bordered` | 하단 구분선 표시 여부 | `Bool` | `true` |
| `clickable` | 클릭 가능 여부(화살표와 탭 gate 제어) | `Bool` | `false` |
| `required` | 제목 앞에 빨간 필수 별표 표시 여부 | `Bool` | `false` |
| `lhOnClick` | 탭 콜백. `clickable = false`일 때 발생하지 않음 | `(() -> Void)?` | `nil` |

### 텍스트 계층

| 영역 | 글자 크기 | 색상 |
| --- | --- | --- |
| 제목 | `cell.fontSizeTitle`(14pt) | `color.text.primary` |
| 부제목 | `cell.fontSizeLabel`(13pt) | `color.text.secondary` |
| 우측 값 | `cell.fontSizeValue`(14pt) | `color.text.secondary` |
| 필수 별표 | `cell.fontSizeTitle` | `color.danger.default` |

## 토큰 매핑

| 토큰 | 용도 |
| --- | --- |
| `cell.paddingHorizontal` / `cell.paddingVertical` | 안쪽 여백(`spacing.base` / `spacing.sm` 따름) |
| `cell.fontSizeTitle` / `cell.fontSizeLabel` / `cell.fontSizeValue` | 3단 텍스트 글자 크기 |
| `cell.iconSize` | 좌측 아이콘 크기 |
| `cell.gap` | 각 영역 사이 간격(`spacing.sm` 따름) |
| `cell.borderWidth` | 하단 구분선 두께 |
| `color.border.lighter` | 하단 구분선 색상 |
| `color.text.{primary,secondary}` | 제목과 값/부제목 색상 |
| `color.danger.default` | 필수 별표 색상 |
| `color.background.default` | 셀 배경색 |

## 골든 케이스 매핑

| case id | 단언 | 로컬 테스트 |
| --- | --- | --- |
| `title-and-value-render` | 제목과 값을 함께 그림 | `testTitleAndValueUseFontTokens` |
| `label-renders-secondary-tone` | 부제목은 보조 글자색 사용 | `testLabelRendersSecondaryTone` |
| `required-uses-danger-token` | 필수 별표는 위험색 토큰 사용 | `testRequiredUsesDangerToken` |
| `bordered-emits-line-command` | 구분선은 border.lighter 토큰 소비 | `testBorderedUsesBorderTokens` |
| `clickable-emits-onclick` | 클릭 가능할 때 lhOnClick 발생 | `testClickableIsInteractive` |
| `not-clickable-no-onclick` | 클릭 불가일 때 lhOnClick 발생 안 함 | `testNotClickableIsNotInteractive` |

추가로 다크 전용 항목: `testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testCellInitAndRender` / `testLayoutUsesCellTokens`.

```bash
swift test --filter LhCellTests    # macOS 호스트에서 실행 가능, 시뮬레이터 불필요
```
