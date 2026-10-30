# 소개

**lh-ui-ios**는 lh-ui 패밀리 **네이티브 혈통**의 iOS 단 구현입니다. **Swift + SwiftUI** 기반의 UI 컴포넌트 라이브러리입니다.

## 패밀리 내 위치

```
                        ┌── Web 혈통: share(TS core + SCSS) → plus / vue2 / react / uniapp
lh-ui 패밀리(동일 브랜드)─────┤
                        └── 네이티브 혈통: core(JSON 토큰 + 계약 + codegen) → android / ios / harmony / windows
                                                                    ↑ 이 저장소
```

- **빌드 시점 중심**: `lh-ui-core`는 네이티브 혈통의 토큰 원본(`tokens/*.json`), 컴포넌트 계약(`specs/`), 골든 케이스(`cases/`)와 codegen 도구입니다. Swift 토큰 골격(`LhTokens` / `LhDarkTokens` / `LhShadow`)을 생성하지만, **UI 구현은 생성하지 않습니다**.
- **이 저장소의 역할**: SwiftUI View를 손으로 작성하고, 테마 연결(Environment 주입), props 열거형과 기본값 바인딩, 골든 케이스의 XCTest 번역을 담당합니다.
- **web 혈통과 서로 독립**: `@lh-ui/share`에 의존하지 않으며, 릴리스 순서도 서로 제약하지 않습니다. 시각적 일관성은 *디자인 언어 베이스라인*을 수동으로 맞춰 유지합니다.

## 디자인 언어

중국풍 테마: 青花瓷(청화자) 블루 주색(`#2B4C7C`), 宣纸(선지) 화이트 배경(`#FAF6F0`), 松花绿(송화록) 성공, 藤黄(등황) 경고, 朱砂(진사) 위험, 세리프 폰트 스택(Noto Serif SC → STSong → SimSun). 모든 시각적 값이 토큰이며, 컴포넌트에는 어떤 리터럴도 등장하지 않습니다.

## SwiftUI인 이유

- 플랫폼 일등 시민인 선언형 UI로, Compose / ArkUI와 사고 구조가 같아 크로스 단 계약 정렬이 쉽습니다
- SPM 한 번 연결, JS 런타임 없음, 브리지 계층 없음
- `#Preview`가 곧 문서, `View`가 곧 컴포넌트로, web 혈통의 SFC 개발 경험과 대칭입니다

## 현재 상태

- **button 풀체인 시범 완료**(토큰 소비 + resolveAppearance 외관 해석 + SwiftUI View + XCTest + `#Preview` + 문서 사이트)
- P0 나머지 13개 컴포넌트(icon / input / textarea / cell / checkbox / radio / switch / tag / dialog / toast / loading / picker / navbar)는 같은 패러다임으로 이어서 채웁니다
