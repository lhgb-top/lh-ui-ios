# 빠른 시작

## 최소 예제

```swift
import SwiftUI
import LhUI

struct Demo: View {
  var body: some View {
    LhTheme {
      LhButton(
        lhOnClick: { /* 탭 처리 */ },
        type: .primary,
        text: "주요 버튼"
      )
    }
  }
}
```

`LhTheme`는 테마 컨테이너로, 내부의 모든 Lh 컴포넌트가 Environment를 통해 자동으로 토큰을 소비합니다. 감싸지 않으면 라이트 팔레트로 폴백합니다.

## 유형과 크기

```swift
// 6가지 유형
LhButton(lhOnClick: {}, text: "기본")                      // .default
LhButton(lhOnClick: {}, type: .primary, text: "주요")
LhButton(lhOnClick: {}, type: .success, text: "성공")
LhButton(lhOnClick: {}, type: .warning, text: "경고")
LhButton(lhOnClick: {}, type: .danger, text: "위험")
LhButton(lhOnClick: {}, type: .info, text: "정보")

// 3가지 크기
LhButton(lhOnClick: {}, lhSize: .small, text: "소형")
LhButton(lhOnClick: {}, lhSize: .medium, text: "중형")
LhButton(lhOnClick: {}, lhSize: .large, text: "대형")
```

## 상태

```swift
// 비활성화: 탭에 반응하지 않고 비활성화 스타일을 표시
LhButton(lhOnClick: {}, disabled: true, text: "비활성화")

// 로딩 중: 인디케이터를 표시하고 lhOnClick을 발생시키지 않음
LhButton(lhOnClick: {}, loading: true, text: "로딩 중")

// 둘 다: 비활성화를 우선 처리(골든 케이스 disabled-precedes-loading)
LhButton(lhOnClick: {}, disabled: true, loading: true, text: "비활성화 우선")
```

## 아이콘과 패턴 배경

```swift
// 아이콘 이름은 로컬 아이콘 체계로 해석(SF Symbol 매핑은 LhButtonStyle.icon(for:), 등록되지 않은 이름은 그리지 않음)
LhButton(lhOnClick: {}, type: .primary, icon: "search", text: "검색")

// 중국풍 패턴 배경(color.decoration 토큰 소비)
LhButton(lhOnClick: {}, type: .primary, bgPattern: true, text: "패턴 배경")
```

## 라이트/다크 테마

```swift
LhTheme(isDark: isDark) {
  // 내부의 모든 컴포넌트가 자동으로 다크 토큰으로 전환(core에서 미리 계산한 값, 런타임 조색 없음)
}
```

## 컴포넌트 예제 미리보기

네이티브 UI는 브라우저에서 실시간 렌더링할 수 없어, 이 사이트는 **인라인 정적 HTML 폰 시뮬레이터**로 외관을 보여줍니다.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>lh-ui-ios</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn">기본 버튼</button>
      <button class="sim-btn sim-btn--primary">주요 버튼</button>
      <button class="sim-btn sim-btn--success">성공</button>
      <button class="sim-btn sim-btn--warning">경고</button>
      <button class="sim-btn sim-btn--danger">위험</button>
      <button class="sim-btn sim-btn--info">정보</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--small">소형</button>
      <button class="sim-btn sim-btn--primary sim-btn--large">대형</button>
      <button class="sim-btn sim-btn--primary sim-btn--disabled">비활성화</button>
      <button class="sim-btn sim-btn--primary sim-btn--loading">
        <span class="sim-btn__spinner"></span>로딩 중
      </button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary"><span class="sim-btn__icon"></span>검색</button>
      <button class="sim-btn sim-btn--primary sim-btn--pattern">패턴 배경</button>
    </div>
  </div>
</div>
<p class="sim-note">iOS(SwiftUI) 외관의 HTML 시뮬레이터 미리보기로, 실기기 렌더링이 아닙니다. 스타일 값은 모두 core 토큰 스냅샷에서 가져왔으며, 실기기와 같은 원본, 같은 값을 사용합니다. 실기기 외관은 <code>#Preview</code>와 기기 스크린샷을 기준으로 합니다.</p>

> 시뮬레이터의 다크 모드는 사이트와 연동됩니다. 우측 상단에서 테마를 전환하면 폰 프레임 내부의 색상이 바뀝니다(다크 토큰은 core에서 미리 계산됨).
