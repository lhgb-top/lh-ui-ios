# Button 버튼

기본 조작 버튼입니다. 즉시 실행하는 동작을 트리거하며, 유형, 크기, 로딩, 비활성화, 아이콘, 중국풍 패턴 배경을 지원합니다.

> 계약 원본: `lh-ui-core/specs/button.json` ·
> 골든 케이스: `lh-ui-core/cases/button.json`(8건, XCTest로 번역됨, macOS 호스트에서 실행 가능)

## 유형

6가지 유형이 배경색과 글자색을 결정합니다.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Button 유형</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn">기본 버튼</button>
      <button class="sim-btn sim-btn--primary">주요 버튼</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--success">성공 버튼</button>
      <button class="sim-btn sim-btn--warning">경고 버튼</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--danger">위험 버튼</button>
      <button class="sim-btn sim-btn--info">정보 버튼</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

```swift
LhButton(lhOnClick: {}, type: .primary, text: "주요 버튼")
```

## 크기

3단 크기가 `button.height` / `paddingHorizontal` / `fontSize` / `iconSize` 토큰으로 매핑됩니다.
iOS 형태는 캡슐형 모서리 둥글기(`radius.round` 토큰)입니다.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Button 크기</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--small">소형 버튼</button>
      <button class="sim-btn">중형 버튼</button>
      <button class="sim-btn sim-btn--large">대형 버튼</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

## 상태

비활성화와 로딩 중 모두 `lhOnClick`을 발생시키지 않으며, 둘이 공존할 때는 **비활성화 우선**으로 처리합니다(골든 케이스 `disabled-precedes-loading`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Button 상태</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary">정상</button>
      <button class="sim-btn sim-btn--primary sim-btn--disabled">비활성화</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary sim-btn--loading">
        <span class="sim-btn__spinner"></span>로딩 중
      </button>
      <button class="sim-btn sim-btn--primary sim-btn--disabled">비활성화 우선</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

## 아이콘과 패턴 배경

아이콘 이름은 로컬 아이콘 체계로 해석합니다(`LhButtonStyle.icon(for:)`가 SF Symbol에 매핑: search → magnifyingglass,
refresh → arrow.clockwise, check → checkmark, close → xmark. 등록되지 않은 이름은 그리지 않습니다).
패턴 배경은 `color.decoration` 토큰을 소비하고, Canvas로 45° 사선 무늬를 그려 배경색 위, 글자 아래에 겹치되 대비도에는 영향을 주지 않습니다.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>아이콘과 패턴</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary"><span class="sim-btn__icon"></span>검색</button>
      <button class="sim-btn"><span class="sim-btn__icon"></span>기본</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary sim-btn--pattern">주요 패턴 배경</button>
      <button class="sim-btn sim-btn--pattern">기본 패턴 배경</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

## 라이트/다크 테마

사이트 우측 상단에서 테마를 전환하면 시뮬레이터 폰 프레임 내부의 버튼 색상이 바뀝니다. 실기기에서는 `LhTheme(isDark: true)`로 전환합니다.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>다크 버튼</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary">주요 버튼</button>
      <button class="sim-btn">기본 버튼</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary sim-btn--disabled">비활성화</button>
      <button class="sim-btn sim-btn--success">성공</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님. 라이트/다크 값은 모두 core 토큰 스냅샷에서 가져옴</p>

## API

### Props

| 속성 | 설명 | 타입 | 기본값 |
| --- | --- | --- | --- |
| `lhOnClick` | 탭 콜백. `disabled` 또는 `loading`이 true일 때 발생하지 않음 | `() -> Void` | — |
| `type` | 버튼 유형, 배경색과 글자색을 결정 | `LhButtonType` | `.default` |
| `lhSize` | 버튼 크기, 크기 토큰으로 매핑 | `LhButtonSize` | `.medium` |
| `disabled` | 비활성화 여부 | `Bool` | `false` |
| `loading` | 로딩 중 여부(인디케이터 표시, lhOnClick 발생 안 함) | `Bool` | `false` |
| `icon` | 아이콘 이름(SF Symbol 매핑으로 해석) | `String?` | `nil` |
| `bgPattern` | 중국풍 패턴 무늬 그리기 여부 | `Bool` | `false` |
| `label` / `text` | 버튼 글자 내용(spec의 default 슬롯) | `Text` / 문자열 | — |

### LhButtonType

| 값 | 배경색 | 글자색 |
| --- | --- | --- |
| `.default` | `color.background.default` | `color.text.primary` |
| `.primary` | `color.primary.default` | `color.onPrimary` |
| `.success` | `color.success.default` | `color.onPrimary` |
| `.warning` | `color.warning.default` | `color.onPrimary` |
| `.danger` | `color.danger.default` | `color.onPrimary` |
| `.info` | `color.info.default` | `color.onPrimary` |

### LhButtonSize

| 값 | height | paddingHorizontal | fontSize | iconSize |
| --- | --- | --- | --- | --- |
| `.small` | `button.height.small`(32pt) | `button.paddingHorizontal.small`(16pt) | `button.fontSize.small`(13pt) | `button.iconSize.small`(16pt) |
| `.medium` | `button.height.medium`(40pt) | `button.paddingHorizontal.medium`(20pt) | `button.fontSize.medium`(14pt) | `button.iconSize.medium`(18pt) |
| `.large` | `button.height.large`(48pt) | `button.paddingHorizontal.large`(24pt) | `button.fontSize.large`(16pt) | `button.iconSize.large`(20pt) |

비활성화 상태 덮어쓰기: 배경 `color.disabled.bg`, 글자 `color.disabled.text`, 테두리 `color.disabled.border`.

## 토큰 매핑

버튼이 소비하는 토큰(`specs/button.json`의 `tokenRefs`와 한 줄씩 정렬됨):

| 토큰 | 용도 |
| --- | --- |
| `button.height.{small,medium,large}` | 3단 높이 |
| `button.paddingHorizontal.{small,medium,large}` | 3단 가로 안쪽 여백 |
| `button.fontSize.{small,medium,large}` | 3단 글자 크기 |
| `button.iconSize.{small,medium,large}` | 3단 아이콘 크기 |
| `button.borderRadius` / `button.borderWidth` | 모서리 둥글기(`radius.base` 따름)와 테두리 두께 |
| `button.fontWeight` | 글자 굵기(`typography.fontWeight.primary` 따름, 단 측에서 Font.Weight로 매핑) |
| `color.primary.default` / `color.onPrimary` | 주색 유형 배경/글자 |
| `color.{success,warning,danger,info}.default` | 시맨틱 유형 배경색 |
| `color.background.default` / `color.text.primary` / `color.border.base` | 기본 유형 배경/글자/테두리 |
| `color.disabled.{bg,text,border}` | 비활성화 상태 3색 |
| `color.decoration` | 패턴 무늬 색상 |
| `shadow.lighter` | 기본 elevation(LhShadow 운반) |
| `spacing.xs` | 아이콘과 글자 사이 간격 |

## 골든 케이스 매핑

`cases/button.json`의 8건 단언과 XCTest의 대응 관계:

| case id | 단언 | 로컬 테스트 |
| --- | --- | --- |
| `click-emits-onclick` | gate 통과(상호작용 가능) | `LhButtonTests.testEnabledButtonIsInteractive` |
| `disabled-blocks-click` | 비활성화 상태는 상호작용 불가 | `testDisabledIsNotInteractive` |
| `loading-blocks-click` | 로딩 상태는 상호작용 불가 | `testLoadingIsNotInteractive` |
| `disabled-precedes-loading` | 비활성화 우선 + 비활성화 스타일 | `testDisabledPrecedesLoading` |
| `default-type-renders-text` | 기본 유형은 중성 배경/글자 | `testDefaultTypeUsesNeutralTokens` |
| `primary-type-uses-primary-tokens` | 주색 유형은 주색 토큰 소비 | `testPrimaryTypeUsesPrimaryTokens` |
| `small-size-uses-small-tokens` | 소형은 small 크기 토큰 소비 | `testSmallSizeUsesSmallTokens` |
| `bgpattern-uses-decoration-token` | 패턴 배경은 장식색 소비 | `testBgPatternUsesDecorationToken` |

추가로 다크 전용 항목: `testDarkColorsComeFromDarkTokens` / `testDisabledInDarkUsesDarkDisabledTokens` /
`testDimensionsAreIdenticalInDarkMode`.

```bash
swift test    # macOS 호스트에서 실행 가능, 시뮬레이터 불필요
```
