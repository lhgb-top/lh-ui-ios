---
layout: home

hero:
  image:
    src: /logo-banner.png
    alt: lh-ui 品牌横幅
  name: lh-ui-ios
  text: ネイティブ血脈 · iOS 端
  tagline: Swift + SwiftUI コンポーネントライブラリ、トークンドリブン・契約アライン・ゴールデンケースで保護
  actions:
    - theme: brand
      text: クイックスタート
      link: /ja/guide/quickstart
    - theme: alt
      text: コンポーネント一覧
      link: /ja/components/button

features:
  - title: トークンドリブン
    details: コンポーネントは色値も間隔もハードコードせず、すべて core の codegen が生成した LhTokens / LhDarkTokens を消費します。トークンを変更すれば全端で即座に反映されます。
  - title: 契約の一致
    details: props の命名は lh-ui-core/specs と文字通り一致し、Android / HarmonyOS / Windows および Web 血脈と振る舞いを共有します。
  - title: ゴールデンケースによる保護
    details: cases/button.json の振る舞いアサーションを XCTest に翻訳しており、macOS ホストだけで実行できます（シミュレーター不要）。
  - title: ライト・ダーク両テーマ
    details: LhTheme で 1 行切り替え。ダークトークンは core が事前計算するため、ランタイムでの調色がなく、フラッシュもしません。
  - title: 中華風デザイン言語
    details: メインカラーは青花瓷ブルー、背景は宣紙白、藤黄と朱砂のアクセント、セリフフォントスタック。Web 血脈と同じソース・同じ値です。
  - title: SwiftUI ネイティブ
    details: 純粋な Swift + SwiftUI でハンドライトした UI、JS ランタイムなし、プラットフォーム第一級の宣言的 UI、SPM でワンステップ導入。
---
