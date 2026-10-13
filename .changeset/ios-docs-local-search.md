---
'@lh-ui/ios': patch
---

修复文档站本地搜索框空壳问题：`search: { provider: 'local' }` 从 `locales.root.themeConfig`
移到**顶层** `themeConfig`。

VitePress 的 `__VP_LOCAL_SEARCH__` 构建期常量只读 `site.themeConfig`
（= `userConfig.themeConfig`），不合并 `locales[*].themeConfig`；放在 locales 内会被求值为
false，导航栏搜索框渲染成空壳。与 android / harmony 仓的既有正确范式对齐。
