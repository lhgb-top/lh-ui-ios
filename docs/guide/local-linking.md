# 本地联调

## 家族布局约定

```
lh-ui/                        # 家族父目录（非仓库）
├── lh-ui-core/               # 令牌真源 + codegen
├── lh-ui-android/            # 兄弟仓
├── lh-ui-ios/                # 本仓
├── lh-ui-harmony/
└── lh-ui-windows/
```

各仓同父目录时，令牌**本地直连**；兄弟仓不存在（CI 单仓 clone）时**自动回退 npm 包**。
这与 web 血脉的 vite alias 守卫机制同构（总纲 D18）。

## 三级守卫

`scripts/link-tokens.mjs` 按优先级查找令牌产物：

| 优先级 | 来源 | 说明 |
| --- | --- | --- |
| 1 | `../lh-ui-core/dist/ios` | 本地直连：改令牌即时生效 |
| 2 | `node_modules/@lh-ui/core/dist/ios` | npm 回退：`@lh-ui/core` 的 `files:["dist"]` 含四端产物 |
| 3 | — | 报错退出，缺令牌无法构建 |

## 日常流程

```bash
# 1. 改令牌（在 core 仓）
cd ../lh-ui-core
vim tokens/color.json           # 或 spacing / typography / ...

# 2. 重新生成 + 校验
pnpm codegen                    # 生成 dist/ 四端产物
pnpm verify                     # schema + 引用 + WCAG 对比度 + 契约一致性

# 3. 回本仓同步
cd ../lh-ui-ios
pnpm link:tokens                # 覆盖 Sources/LhUITokens/

# 4. 回归
swift test
```

## CI 门禁

```bash
pnpm link:tokens:check          # 检测令牌是否已同步（文件数比对，未同步则退出码 1）
```

## 禁止事项

- ❌ 手改 `Sources/LhUITokens/`（生成物，gitignore）
- ❌ 把生成的令牌文件提交入库
- ❌ 在组件里写色值/间距字面量（如 `Color(red: 0.169, ...)`、`CGFloat(40)`、`14` 号字）
- ❌ 绕过 `link:tokens` 手动拷贝产物

## 排查

| 症状 | 原因 | 解决 |
| --- | --- | --- |
| 编译报 `cannot find 'LhTokens' in scope` | 令牌未同步 | `pnpm link:tokens` |
| 令牌值与预期不符 | core 仓未重新 codegen | core 仓 `pnpm codegen` 后重新 link |
| `link:tokens` 报「未找到令牌产物」 | 兄弟仓不在且未装 npm 包 | 检查家族布局或 `pnpm i -D @lh-ui/core` |
| 暗色颜色不对 | 改了明色主色但没更新暗色预计算 | 更新 `color-dark.json` 并重跑（R-n6） |
| `default` 相关编译错 | 生成产物成员名关键字未转义 | 升级 core（已修复：成员名带反引号 `` `default` ``） |
