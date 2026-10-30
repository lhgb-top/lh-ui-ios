---
'@lh-ui/ios': patch
---

修复文档站构建失败：`docs/ar/index.md` 与 `docs/es/index.md` 首页 frontmatter 的 `details` 明文标量包含「冒号+空格」（如 `core: دون`、`componentes: todos`），YAML 解析报 `incomplete explicit mapping pair`；按 fr/ru 语言的既有写法给这三处值加上双引号。
