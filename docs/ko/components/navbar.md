# Navbar 내비게이션 바

페이지 상단의 내비게이션 바입니다. 중앙 제목 + 양쪽 콘텐츠, 하단 구분선으로 구성되며, 쌓임 순서는 `zIndex.sticky`를 사용합니다.

> 계약 원본: `lh-ui-core/specs/navbar.json` ·
> 골든 케이스: `lh-ui-core/cases/navbar.json`(6건, XCTest로 번역됨, macOS 호스트에서 실행 가능)

## 기본 형태

`title`이 중앙에 표시됩니다(절대 배치로 양쪽 콘텐츠와 겹치지 않음). `leftText` / `rightText`는 각각 좌우 양끝에 붙습니다.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Navbar 기본</span></div>
  <div class="sim-navbar sim-navbar--bordered">
    <span class="sim-navbar__side">뒤로</span>
    <span class="sim-navbar__title">青花瓷</span>
    <span class="sim-navbar__side">더 보기</span>
  </div>
  <div class="sim-screen">
    <div class="sim-row"><span class="sim-tag sim-tag--primary">페이지 내용</span></div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

```swift
LhNavbar(
  title: "青花瓷",
  leftText: "뒤로",
  rightText: "더 보기",
  onLeftClick: { /* 뒤로 */ },
  onRightClick: { /* 더 보기 */ }
)
```

## 아이콘과 테두리

`leftIcon` / `rightIcon`은 `LhIconMap`으로 매핑되어 글자와 나란히 표시됩니다. `bordered = false`면 하단 구분선을 제거합니다.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Navbar 아이콘</span></div>
  <div class="sim-navbar">
    <span class="sim-navbar__side">
      <span class="sim-navbar__icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M15 5l-7 7 7 7"/></svg></span>
      <span>뒤로</span>
    </span>
    <span class="sim-navbar__title">제목</span>
    <span class="sim-navbar__side">
      <span>설정</span>
      <span class="sim-navbar__icon"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="8"/></svg></span>
    </span>
  </div>
  <div class="sim-screen">
    <div class="sim-row"><span class="sim-tag">테두리 없는 내비게이션 바</span></div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

## 탭 gate

`leftText` / `leftIcon`을 제공하지 않으면 좌측은 탭에 반응하지 않으며(골든 케이스 `no-left-content-no-onleftclick`),
우측도 같습니다. 플로팅 배치는 호출하는 쪽에서 `.overlay`로 장착합니다(SwiftUI 관례). 컴포넌트 자체는 `zIndex.sticky` 쌓임 순서만 제공합니다.

```swift
ZStack {
  contentView
    .padding(.top, LhTokens.Navbar.height)
  LhNavbar(title: "青花瓷", leftText: "뒤로", onLeftClick: { dismiss() })
    .overlay(alignment: .top) { ... }
}
```

## API

### Props

| 속성 | 설명 | 타입 | 기본값 |
| --- | --- | --- | --- |
| `title` | 중앙 제목 | `String` | `""` |
| `leftText` | 좌측 글자(비어 있고 leftIcon도 없으면 탭에 반응 안 함) | `String` | `""` |
| `leftIcon` | 좌측 아이콘 논리 이름(`LhIconMap` 매핑) | `String?` | `nil` |
| `rightText` | 우측 글자(비어 있고 rightIcon도 없으면 탭에 반응 안 함) | `String` | `""` |
| `rightIcon` | 우측 아이콘 논리 이름 | `String?` | `nil` |
| `bordered` | 하단 구분선 표시 여부 | `Bool` | `true` |
| `onLeftClick` | 좌측 탭 콜백 | `(() -> Void)?` | `nil` |
| `onRightClick` | 우측 탭 콜백 | `(() -> Void)?` | `nil` |

### 색상

| 영역 | 색상 |
| --- | --- |
| 배경색 | `color.background.default` |
| 제목 / 양쪽 글자 / 아이콘 | `color.text.primary` |
| 구분선 | `color.border.lighter`(두께는 `navbar.borderWidth`) |

## 토큰 매핑

| 토큰 | 용도 |
| --- | --- |
| `navbar.height` | 내비게이션 바 높이(44pt) |
| `navbar.paddingHorizontal` | 양쪽 가로 안쪽 여백(12pt) |
| `navbar.titleFontSize` | 제목과 양쪽 글자 크기(16pt) |
| `navbar.iconSize` | 양쪽 아이콘 크기(20pt) |
| `navbar.borderWidth` | 하단 구분선 두께 |
| `color.border.lighter` | 구분선 색상 |
| `color.text.primary` | 제목과 양쪽 콘텐츠 색상 |
| `color.background.default` | 배경색 |
| `zIndex.sticky` | 플로팅 쌓임 순서 |

## 골든 케이스 매핑

| case id | 단언 | 로컬 테스트 |
| --- | --- | --- |
| `title-renders-text` | 제목이 올바르게 렌더링됨 | `testTitleUsesNavbarTokens` |
| `leftclick-emits-onleftclick` | 좌측 탭 시 onLeftClick 발생 | `testLeftContentIsClickable` |
| `rightclick-emits-onrightclick` | 우측 탭 시 onRightClick 발생 | `testRightContentIsClickable` |
| `no-left-content-no-onleftclick` | 좌측 콘텐츠가 없으면 발생 안 함 | `testNoLeftContentIsNotClickable` |
| `bordered-uses-border-token` | 구분선은 border.lighter 토큰 소비 | `testBorderedUsesBorderToken` |
| `height-uses-navbar-height-token` | 높이는 navbar.height 토큰 소비 | `testHeightUsesNavbarHeightToken` |

추가 항목: `testContainerUsesBackgroundToken` / `testDarkColorsComeFromDarkTokens` /
`testDimensionsAreIdenticalInDarkMode` / `testNavbarInitAndRender`.

```bash
swift test --filter LhNavbarTests    # macOS 호스트에서 실행 가능, 시뮬레이터 불필요
```
