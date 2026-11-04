# Text 텍스트

텍스트 표시 원시 컴포넌트: 전역 타이포그래피 토큰을 소비하며 크기 레벨, 자중, 색조, 정렬을 지원.

> 계약 원본: `lh-ui-core/specs/text.json` · 골든 케이스: `lh-ui-core/cases/text.json`(5건, XCTest로 번역됨, macOS 호스트에서 실행 가능)

## 크기 레벨

`level`은 `typography.fontSize.<level>` 토큰에 매핑되며 기본값은 `base`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text</span></div>
  <div class="sim-screen">
    <p class="sim-text sim-text--extraLarge">extraLarge</p>
    <p class="sim-text sim-text--large">large</p>
    <p class="sim-text sim-text--medium">medium</p>
    <p class="sim-text">base</p>
    <p class="sim-text sim-text--small">small</p>
    <p class="sim-text sim-text--extraSmall">extraSmall</p>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

```swift
LhText("Title text", level: .large)
```

## 자중

`weight`는 `typography.fontWeight.<weight>` 토큰에 매핑(primary 400 / bold 600).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text</span></div>
  <div class="sim-screen">
    <p class="sim-text">primary</p>
    <p class="sim-text sim-text--bold">bold</p>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

## 색조

`tone`은 `color.text.<tone>` 토큰에 매핑. `selected`는 `color.selected` 사용.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text</span></div>
  <div class="sim-screen">
    <p class="sim-text">primary</p>
    <p class="sim-text sim-text--regular">regular</p>
    <p class="sim-text sim-text--secondary">secondary</p>
    <p class="sim-text sim-text--placeholder">placeholder</p>
    <p class="sim-text sim-text--disabled">disabled</p>
    <p class="sim-text sim-text--selected">selected</p>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

## 정렬과 행 높이

`lhAlign`은 행 박스 안에서 정렬. 행 높이는 항상 `typography.lineHeight.primary`(크기 × 1.8).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text</span></div>
  <div class="sim-screen">
    <p class="sim-text sim-text--align-center">center</p>
    <p class="sim-text sim-text--align-end">end</p>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

```swift
LhText("Centered", lhAlign: .center)
```

## API

| 속성 | 설명 | 타입 | 기본값 |
| --- | --- | --- | --- |
| `content` | 텍스트 내용(이니셜라이저 첫 번째 인자, spec의 default 슬롯) | `String` | `""` |
| `level` | 크기 레벨 | `LhTextLevel` | `.base` |
| `weight` | 자중 | `LhTextWeight` | `.primary` |
| `tone` | 색조 | `LhTextTone` | `.primary` |
| `lhAlign` | 정렬과 행 높이 | `LhTextAlign` | `.start` |

### LhTextLevel

| 속성 | fontSize token |
| --- | --- |
| `.extraLarge` | `typography.fontSize.extraLarge` (20pt) |
| `.large` | `typography.fontSize.large` (18pt) |
| `.medium` | `typography.fontSize.medium` (16pt) |
| `.base` | `typography.fontSize.base` (14pt, default) |
| `.small` | `typography.fontSize.small` (13pt) |
| `.extraSmall` | `typography.fontSize.extraSmall` (12pt) |

### LhTextTone

| 속성 | text color token |
| --- | --- |
| `.primary` | `color.text.primary` |
| `.regular` | `color.text.regular` |
| `.secondary` | `color.text.secondary` |
| `.placeholder` | `color.text.placeholder` |
| `.disabled` | `color.text.disabled` |
| `.selected` | `color.selected` |

## 토큰 참조

| Token | Usage |
| --- | --- |
| `typography.fontSize.<level>` | six size levels |
| `typography.fontWeight.{primary,bold}` | two weights |
| `typography.lineHeight.primary` | line height (font size × 1.8) |
| `color.text.<tone>` / `color.selected` | text tones |

## 골든 케이스 참조

| case id | 어설션 | 로컬 테스트 |
| --- | --- | --- |
| `default-level-uses-base-tokens` | default level consumes the base typography tokens | `LhTextTests.testDefaultLevelUsesBaseTokens` |
| `large-level-uses-large-token` | large level consumes the large size token | `LhTextTests.testLargeLevelUsesLargeToken` |
| `bold-weight-uses-bold-token` | bold consumes the bold weight token | `LhTextTests.testBoldWeightUsesBoldToken` |
| `secondary-tone-uses-text-secondary` | secondary tone takes the secondary text color token | `LhTextTests.testSecondaryToneUsesTextSecondary` |
| `render-emits-single-text-command` | render emits a single TEXT command | `LhTextTests.testAllLevelsUseTheirTokens` |

```bash
swift test --filter LhTextTests
```
