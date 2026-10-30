# Tag 태그

표시와 선택에 사용하는 컴팩트한 태그입니다. 버튼보다 작으며, 시맨틱 유형, 테두리, 둥근 캡슐 모서리, 닫기 버튼을 지원합니다.

> 계약 원본: `lh-ui-core/specs/tag.json` ·
> 골든 케이스: `lh-ui-core/cases/tag.json`(6건, XCTest로 번역됨, macOS 호스트에서 실행 가능)

## 유형

6가지 유형이 배경색과 글자색을 결정합니다. `plain`은 테두리 + 얕은 배경 형태입니다(시맨틱 얕은 배경 + 시맨틱 테두리).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tag 유형</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag">기본</span>
      <span class="sim-tag sim-tag--primary">주요</span>
      <span class="sim-tag sim-tag--success">성공</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--warning">경고</span>
      <span class="sim-tag sim-tag--danger">위험</span>
      <span class="sim-tag sim-tag--info">정보</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--plain sim-tag--primary">테두리 주요</span>
      <span class="sim-tag sim-tag--plain sim-tag--success">테두리 성공</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

```swift
LhTag(text: "주요", type: .primary)
LhTag(text: "테두리 성공", type: .success, plain: true)
```

## 크기와 모서리 둥글기

3단 크기가 `tag.height` / `paddingHorizontal` / `fontSize` 토큰으로 매핑됩니다. `round`는 모서리 둥글기를 높이의 절반(캡슐)으로 바꿉니다.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tag 크기</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag sim-tag--small sim-tag--primary">소형</span>
      <span class="sim-tag sim-tag--primary">중형</span>
      <span class="sim-tag sim-tag--large sim-tag--primary">대형</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--primary">각진 모서리</span>
      <span class="sim-tag sim-tag--primary sim-tag--round">둥근 모서리</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

## 닫기 가능

`closable`은 우측에 닫기 버튼을 표시하고, 탭하면 `onClose`를 발생시킵니다(골든 케이스 `closable-tap-emits-onclose`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tag 닫기</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag sim-tag--primary">닫기 가능<svg class="sim-tag__close" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M6 6l12 12M18 6L6 18"/></svg></span>
      <span class="sim-tag">닫기 가능<svg class="sim-tag__close" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M6 6l12 12M18 6L6 18"/></svg></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

```swift
LhTag(text: "닫기 가능", type: .primary, closable: true) {
  // onClose
}
```

## API

### Props

| 속성 | 설명 | 타입 | 기본값 |
| --- | --- | --- | --- |
| `text` | 태그 글자 | `String` | — |
| `type` | 태그 유형, 배경색과 글자색을 결정 | `LhTagType` | `.default` |
| `lhSize` | 태그 크기, 크기 토큰으로 매핑 | `LhTagSize` | `.medium` |
| `plain` | 테두리 + 얕은 배경 형태 여부 | `Bool` | `false` |
| `round` | 캡슐형 모서리 둥글기 여부(반지름 = 높이 / 2) | `Bool` | `false` |
| `closable` | 닫기 버튼 표시 여부 | `Bool` | `false` |
| `onClose` | 닫기 버튼 탭 콜백 | `(() -> Void)?` | `nil` |

### LhTagType

| 값 | 배경색 | 글자색 |
| --- | --- | --- |
| `.default` | `color.background.default` + `color.border.base` 테두리 | `color.text.primary` |
| `.primary` | `color.primary.default` | `color.onPrimary` |
| `.success` | `color.success.default` | `color.onPrimary` |
| `.warning` | `color.warning.default` | `color.onPrimary` |
| `.danger` | `color.danger.default` | `color.onPrimary` |
| `.info` | `color.info.default` | `color.onPrimary` |

`plain = true`일 때: 배경색은 `color.<type>.bg`, 테두리와 글자는 `color.<type>.default`를 사용합니다(`.default` 유형은 `plain`을 무시합니다. 골든 케이스 `default-type-renders-text`).

### LhTagSize

| 값 | height | paddingHorizontal | fontSize |
| --- | --- | --- | --- |
| `.small` | `tag.height.small`(20pt) | `tag.paddingHorizontal.small`(8pt) | `tag.fontSize.small`(12pt) |
| `.medium` | `tag.height.medium`(24pt) | `tag.paddingHorizontal.medium`(12pt) | `tag.fontSize.medium`(13pt) |
| `.large` | `tag.height.large`(28pt) | `tag.paddingHorizontal.large`(16pt) | `tag.fontSize.large`(14pt) |

## 토큰 매핑

| 토큰 | 용도 |
| --- | --- |
| `tag.height.{small,medium,large}` | 3단 높이 |
| `tag.paddingHorizontal.{small,medium,large}` | 3단 가로 안쪽 여백 |
| `tag.fontSize.{small,medium,large}` | 3단 글자 크기 |
| `tag.borderRadius` / `tag.borderWidth` | 기본 모서리 둥글기(`radius.small` 따름)와 테두리 두께 |
| `tag.gap` | 글자와 닫기 버튼 사이 간격(`spacing.xs` 따름) |
| `color.{primary,success,warning,danger,info}.{default,bg}` | 시맨틱 유형 배경색과 테두리 얕은 배경 |
| `color.onPrimary` | 시맨틱 유형 글자색 |
| `color.background.default` / `color.text.primary` / `color.border.base` | 기본 유형 3색 |

## 골든 케이스 매핑

| case id | 단언 | 로컬 테스트 |
| --- | --- | --- |
| `default-type-renders-text` | 기본 유형은 중성 배경/글자, plain 무시 | `testDefaultTypeUsesNeutralTokens` / `testDefaultTypeIgnoresPlain` |
| `primary-type-uses-primary-tokens` | 주색 유형은 주색과 onPrimary 소비 | `testPrimaryTypeUsesPrimaryTokens` |
| `plain-uses-bg-tokens` | plain은 시맨틱 bg와 시맨틱 테두리 소비 | `testPlainUsesBgTokens` |
| `small-size-uses-small-tokens` | 소형은 small 크기 토큰 소비 | `testSmallSizeUsesSmallTokens` |
| `round-makes-radius-half-height` | round 모서리 둥글기 == 높이 / 2 | `testRoundMakesRadiusHalfHeight` |
| `closable-tap-emits-onclose` | 닫기 버튼이 onClose 발생 | `testClosableTagInitAndRender`(제스처 단언은 시뮬레이터 필요) |

추가로 다크 전용 항목: `testDarkColorsComeFromDarkTokens` / `testPlainInDarkUsesDarkBgTokens` /
`testDimensionsAreIdenticalInDarkMode`.

```bash
swift test --filter LhTagTests    # macOS 호스트에서 실행 가능, 시뮬레이터 불필요
```
