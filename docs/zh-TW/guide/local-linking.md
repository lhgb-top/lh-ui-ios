# 本地聯調

## 家族佈局約定

```
lh-ui/                        # 家族父目錄（非倉庫）
├── lh-ui-core/               # 令牌真源 + codegen
├── lh-ui-android/            # 兄弟倉
├── lh-ui-ios/                # 本倉
├── lh-ui-harmony/
└── lh-ui-windows/
```

各倉同父目錄時，令牌**本地直連**；兄弟倉不存在（CI 單倉 clone）時**自動回退 npm 包**。
這與 web 血脈的 vite alias 守衛機制同構（總綱 D18）。

## 三級守衛

`scripts/link-tokens.mjs` 按優先級查找令牌產物：

| 優先級 | 來源 | 說明 |
| --- | --- | --- |
| 1 | `../lh-ui-core/dist/ios` | 本地直連：改令牌即時生效 |
| 2 | `node_modules/@lh-ui/core/dist/ios` | npm 回退：`@lh-ui/core` 的 `files:["dist"]` 含四端產物 |
| 3 | — | 報錯退出，缺令牌無法構建 |

## 日常流程

```bash
# 1. 改令牌（在 core 倉）
cd ../lh-ui-core
vim tokens/color.json           # 或 spacing / typography / ...

# 2. 重新生成 + 驗證
pnpm codegen                    # 生成 dist/ 四端產物
pnpm verify                     # schema + 引用 + WCAG 對比度 + 契約一致性

# 3. 回本倉同步
cd ../lh-ui-ios
pnpm link:tokens                # 覆蓋 Sources/LhUITokens/

# 4. 回歸
swift test
```

## CI 門禁

```bash
pnpm link:tokens:check          # 偵測令牌是否已同步（檔案數比對，未同步則退出碼 1）
```

## 禁止事項

- ❌ 手改 `Sources/LhUITokens/`（生成物，gitignore）
- ❌ 把生成的令牌檔案提交入庫
- ❌ 在元件裡寫色值/間距字面量（如 `Color(red: 0.169, ...)`、`CGFloat(40)`、`14` 號字）
- ❌ 繞過 `link:tokens` 手動拷貝產物

## 排查

| 症狀 | 原因 | 解決 |
| --- | --- | --- |
| 編譯報 `cannot find 'LhTokens' in scope` | 令牌未同步 | `pnpm link:tokens` |
| 令牌值與預期不符 | core 倉未重新 codegen | core 倉 `pnpm codegen` 後重新 link |
| `link:tokens` 報「未找到令牌產物」 | 兄弟倉不在且未裝 npm 包 | 檢查家族佈局或 `pnpm i -D @lh-ui/core` |
| 暗色顏色不對 | 改了明色主色但沒更新暗色預計算 | 更新 `color-dark.json` 並重跑（R-n6） |
| `default` 相關編譯錯 | 生成產物成員名關鍵字未轉義 | 升級 core（已修復：成員名帶反引號 `` `default` ``） |
