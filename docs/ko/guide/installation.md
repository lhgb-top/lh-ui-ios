# 설치

## 환경 요구 사항

- Xcode 15+, Swift 5.9+
- iOS 15.0+(macOS 12+는 XCTest를 호스트에서 실행할 때만 사용)
- 빌드 시점 툴체인: Node.js >= 20 + pnpm(토큰 연결과 문서 사이트에만 사용, **런타임에 포함되지 않음**)

## SPM 연결

Xcode: File → Add Package Dependencies…에서 이 저장소 주소를 입력하거나, `Package.swift`를 직접 편집합니다.

```swift
dependencies: [
  .package(url: "https://github.com/lhgb-top/lh-ui-ios", from: "0.0.1")
],
targets: [
  .target(name: "MyApp", dependencies: [.product(name: "LhUI", from: "lh-ui-ios")])
]
```

토큰 타깃 `LhUITokens`는 `LhUI` 의존성으로 자동으로 연결됩니다(SPM 패키지 내 타깃이라 별도 선언이 필요 없습니다).

## 토큰 동기화(이 저장소를 소스로 개발할 때)

토큰은 생성물이므로 `lh-ui-core`에서 동기화해야 합니다(유일한 원본, 수동 수정 금지).

```bash
cd ../lh-ui-core && pnpm codegen   # dist/ios 토큰 산출물 생성
cd ../lh-ui-ios
pnpm install                        # 빌드 시점 툴체인 설치
pnpm link:tokens                    # Sources/LhUITokens/로 토큰 동기화
```

`pnpm link:tokens`는 3단계 존재성 가드를 갖추고 있습니다: 로컬 `../lh-ui-core/dist/ios` → npm `@lh-ui/core` 산출물 → 에러.

## 설치 확인

```bash
swift build        # 컴파일
swift test         # 골든 케이스(macOS 호스트에서 실행 가능, 시뮬레이터 불필요)
```
