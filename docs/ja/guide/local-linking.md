# ローカル連携

## ファミリーのレイアウト

```
lh-ui/                        # ファミリーの親ディレクトリ（リポジトリではない）
├── lh-ui-core/               # トークン真源 + codegen
├── lh-ui-android/            # 兄弟リポジトリ
├── lh-ui-ios/                # 本リポジトリ
├── lh-ui-harmony/
└── lh-ui-windows/
```

各リポジトリが同じ親ディレクトリにある場合、トークンは**ローカル直結**します。兄弟リポジトリが存在しない（CI の単一リポジトリ clone）場合は、**自動的に npm パッケージにフォールバック**します。
これは Web 血脈の vite alias ガード機構と同構です（マスタープラン D18）。

## 3 段階のガード

`scripts/link-tokens.mjs` が優先度順にトークン成果物を探します：

| 優先度 | ソース | 説明 |
| --- | --- | --- |
| 1 | `../lh-ui-core/dist/ios` | ローカル直結：トークン変更が即座に反映 |
| 2 | `node_modules/@lh-ui/core/dist/ios` | npm フォールバック：`@lh-ui/core` の `files:["dist"]` に 4 端の成果物を同梱 |
| 3 | — | エラーで終了、トークンがないとビルド不可 |

## 日々のフロー

```bash
# 1. トークンを変更（core リポジトリで）
cd ../lh-ui-core
vim tokens/color.json           # または spacing / typography / ...

# 2. 再生成 + 検証
pnpm codegen                    # dist/ に 4 端の成果物を生成
pnpm verify                     # スキーマ + 参照 + WCAG コントラスト + 契約の整合性

# 3. 本リポジトリに戻って同期
cd ../lh-ui-ios
pnpm link:tokens                # Sources/LhUITokens/ を上書き

# 4. リグレッション
swift test
```

## CI ゲート

```bash
pnpm link:tokens:check          # トークンが同期済みか検出（ファイル数の比較、未同期なら終了コード 1）
```

## 禁止事項

- ❌ `Sources/LhUITokens/` の手書き変更（生成物、gitignore 対象）
- ❌ 生成されたトークンファイルをリポジトリにコミットする
- ❌ コンポーネントに色値/間隔のリテラルを書く（例：`Color(red: 0.169, ...)`、`CGFloat(40)`、`14` のフォントサイズ）
- ❌ `link:tokens` を経由せずに成果物を手動でコピーする

## トラブルシューティング

| 症状 | 原因 | 解決 |
| --- | --- | --- |
| コンパイルエラー `cannot find 'LhTokens' in scope` | トークンが未同期 | `pnpm link:tokens` |
| トークン値が想定と異なる | core リポジトリで codegen し直していない | core リポジトリで `pnpm codegen` 後、再度 link |
| `link:tokens` が「トークン成果物が見つかりません」と報告 | 兄弟リポジトリが存在せず、npm パッケージも未導入 | ファミリーのレイアウトを確認するか `pnpm i -D @lh-ui/core` |
| ダークの色がおかしい | ライトのメインカラーを変更したがダークの事前計算を更新していない | `color-dark.json` を更新して再実行（R-n6） |
| `default` に関するコンパイルエラー | 生成成果物のメンバ名のキーワードエスケープ | core をアップグレード（修正済み：メンバ名にバッククォート `` `default` `` 付き） |
