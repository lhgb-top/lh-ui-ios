# Icon 아이콘

벡터 아이콘입니다. 논리 이름을 플랫폼의 시스템 심볼(iOS 단에서는 SF Symbol)에 매핑하며, 크기와 색조는 모두 토큰을 따릅니다.

> 계약 원본: `lh-ui-core/specs/icon.json` ·
> 골든 케이스: `lh-ui-core/cases/icon.json`(5건, XCTest로 번역됨, macOS 호스트에서 실행 가능)

## 색조

`tone`이 아이콘 색상을 결정합니다. `default`는 주요 글자색을 따르고, `regular` / `secondary`는 대응하는 계층의 글자색을, 나머지는 시맨틱 색상을 사용합니다.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Icon 색조</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-icon"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--success"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 12.5l5 5L20 6.5"/></svg></span>
    </div>
    <div class="sim-row">
      <span class="sim-icon sim-icon--warning"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 3l10 18H2z"/><path d="M12 10v5"/></svg></span>
      <span class="sim-icon sim-icon--danger"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 8v5M12 16.5v.5"/></svg></span>
      <span class="sim-icon sim-icon--regular"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="8"/></svg></span>
      <span class="sim-icon sim-icon--secondary"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="8"/></svg></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님. 실기기에서는 SF Symbol 벡터를 그림</p>

```swift
LhIcon(name: "star", tone: .primary)
```

## 크기

3단 크기가 `icon.size` 토큰으로 매핑됩니다.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Icon 크기</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-icon sim-icon--small sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--large sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

## 아이콘 이름 매핑

`name`은 web 혈통과 정렬된 논리 이름이며, 단 측에서 `LhIconMap.symbol(for:)`을 거쳐 SF Symbol에 매핑됩니다.

| 논리 이름 | SF Symbol |
| --- | --- |
| `star` / `search` / `check` / `close` | `star` / `magnifyingglass` / `checkmark` / `xmark` |
| `arrow-up` / `arrow-down` / `arrow-left` / `arrow-right` | `arrow.up` / `arrow.down` / `arrow.left` / `arrow.right` |
| `refresh` / `plus` / `minus` / `eye` / `link` | `arrow.clockwise` / `plus` / `minus` / `eye` / `link` |

등록되지 않은 이름은 그리지 않고(`nil` 반환), 크래시가 발생하지 않습니다.

```swift
LhIcon(name: "search", lhSize: .large, tone: .secondary) {
  // lhOnClick
}
```

## API

### Props

| 속성 | 설명 | 타입 | 기본값 |
| --- | --- | --- | --- |
| `name` | 아이콘 논리 이름(`LhIconMap`으로 SF Symbol에 매핑) | `String` | — |
| `lhSize` | 아이콘 크기, 크기 토큰으로 매핑 | `LhIconSize` | `.medium` |
| `tone` | 아이콘 색조, 글자/시맨틱 색상 토큰으로 매핑 | `LhIconTone` | `.default` |
| `lhOnClick` | 탭 콜백. 전달하지 않으면 탭에 반응하지 않음 | `(() -> Void)?` | `nil` |

### LhIconSize

| 값 | 크기 |
| --- | --- |
| `.small` | `icon.size.small`(16pt) |
| `.medium` | `icon.size.medium`(20pt) |
| `.large` | `icon.size.large`(24pt) |

### LhIconTone

| 값 | 색상 |
| --- | --- |
| `.default` | `color.text.primary` |
| `.primary` | `color.primary.default` |
| `.success` | `color.success.default` |
| `.warning` | `color.warning.default` |
| `.danger` | `color.danger.default` |
| `.info` | `color.info.default` |
| `.regular` | `color.text.regular` |
| `.secondary` | `color.text.secondary` |

## 토큰 매핑

| 토큰 | 용도 |
| --- | --- |
| `icon.size.{small,medium,large}` | 3단 크기 |
| `color.text.{primary,regular,secondary}` | 글자 색조 |
| `color.{primary,success,warning,danger,info}.default` | 시맨틱 색조 |

## 골든 케이스 매핑

| case id | 단언 | 로컬 테스트 |
| --- | --- | --- |
| `click-emits-onclick` | 탭 시 `lhOnClick` 한 번 발생 | View 계층 `onTapGesture`(제스처 단언은 시뮬레이터 필요, #Preview 참조) |
| `default-tone-uses-text-primary` | 기본 색조는 주요 글자색 사용 | `testDefaultToneUsesTextPrimary` |
| `primary-tone-uses-primary-token` | 주요 색조는 주색 토큰 사용 | `testPrimaryToneUsesPrimaryToken` |
| `small-size-uses-small-token` | 소형은 small 크기 토큰 사용 | `testSmallSizeUsesSmallToken` |
| `render-emits-icon-command` | 아이콘 명령을 한 번만 그림 | `testRegisteredIconResolvesToSymbol` / `testUnknownIconReturnsNilSymbol` |

추가로 다크 전용 항목: `testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode`.

```bash
swift test --filter LhIconTests    # macOS 호스트에서 실행 가능, 시뮬레이터 불필요
```
