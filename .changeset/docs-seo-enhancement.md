---
'@lh-ui/ios': patch
---

文档站 SEO 增强：补齐此前缺失的 head SEO 与 sitemap（家族统一整改，机制见家族 docs/SEO提交与曝光指南.md）：

- head 补齐中文 description / keywords、Open Graph（og:title / og:description / og:type）、Twitter 卡片与 JSON-LD SoftwareApplication 结构化数据（operatingSystem=iOS, programmingLanguage=Swift）。
- 新增 `sitemap` 配置（产物输出 sitemap.xml）；robots.txt 由批量构建统一生成注入。
- 首页 `<title>` 描述化为「lh-ui-ios · iOS 国风组件库（Swift + SwiftUI）」（SEO 用），导航栏品牌标走 `themeConfig.siteTitle` 短名，视觉不变。
