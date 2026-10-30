# インストール

## 環境要件

- Xcode 15+、Swift 5.9+
- iOS 15.0+（macOS 12+ はホストで XCTest を実行する場合のみ使用）
- ビルド時ツールチェーン：Node.js >= 20 + pnpm（トークンのリンクとドキュメントサイトでのみ使用、**ランタイムには含まれない**）

## SPM での導入

Xcode で File → Add Package Dependencies… を選び、本リポジトリのアドレスを入力するか、`Package.swift` を直接編集します：

```swift
dependencies: [
  .package(url: "https://github.com/lhgb-top/lh-ui-ios", from: "0.0.1")
],
targets: [
  .target(name: "MyApp", dependencies: [.product(name: "LhUI", from: "lh-ui-ios")])
]
```

トークンターゲット `LhUITokens` は `LhUI` の依存に含まれて自動的に導入されます（SPM パッケージ内の target なので、個別の宣言は不要）。

## トークンの同期（本リポジトリをソースから開発する場合）

トークンは生成物であり、`lh-ui-core` から同期する必要があります（唯一の真源、手書き変更は禁止）：

```bash
cd ../lh-ui-core && pnpm codegen   # dist/ios のトークン成果物を生成
cd ../lh-ui-ios
pnpm install                        # ビルド時ツールチェーンをインストール
pnpm link:tokens                    # トークンを Sources/LhUITokens/ に同期
```

`pnpm link:tokens` は 3 段階の存在性ガード付きです：ローカルの `../lh-ui-core/dist/ios` → npm の `@lh-ui/core` 成果物 → エラー。

## インストールの検証

```bash
swift build        # コンパイル
swift test         # ゴールデンケース（macOS ホストだけで実行可能、シミュレーター不要）
```
