import { defineConfig } from 'vitepress'
import { loadEnv } from 'vite'
import { resolve } from 'node:path'

// DOCS_BASE 必须显式 loadEnv：Vite 内置 env 加载在用户 config 求值之后，
// 直接读 process.env.DOCS_BASE 生产构建拿不到 .env.production 的值。
const mode = process.env.NODE_ENV === 'production' ? 'production' : 'development'
const env = loadEnv(mode, resolve(__dirname, '..'), 'DOCS_')

const base = env.DOCS_BASE || '/'
const hostname = (env.DOCS_HOSTNAME || 'https://www.lhgb.top').replace(/\/$/, '')

// 数据驱动侧边栏：新增组件只需在此加一条
const componentGroups = [
  {
    text: '基础组件',
    items: [
      { text: 'Button 按钮', slug: 'button' },
      { text: 'Icon 图标', slug: 'icon' },
      { text: 'Tag 标签', slug: 'tag' },
      { text: 'Loading 加载', slug: 'loading' },
      { text: 'Cell 单元格', slug: 'cell' },
    ],
  },
  {
    text: '表单组件',
    items: [
      { text: 'Checkbox 复选框', slug: 'checkbox' },
      { text: 'Radio 单选框', slug: 'radio' },
      { text: 'Switch 开关', slug: 'switch' },
      { text: 'Input 输入框', slug: 'input' },
      { text: 'Textarea 多行输入框', slug: 'textarea' },
    ],
  },
  {
    text: '反馈组件',
    items: [
      { text: 'Dialog 对话框', slug: 'dialog' },
      { text: 'Toast 轻提示', slug: 'toast' },
      { text: 'Picker 选择器', slug: 'picker' },
    ],
  },
  {
    text: '导航组件',
    items: [{ text: 'Navbar 导航栏', slug: 'navbar' }],
  },
]

const guideGroups = [
  { text: '介绍', slug: 'introduction' },
  { text: '安装', slug: 'installation' },
  { text: '快速开始', slug: 'quickstart' },
  { text: '主题与暗色', slug: 'theming' },
  { text: '本地联调', slug: 'local-linking' },
]

function buildSidebar(prefix, entries) {
  return entries.map((group) => {
    if (group.items) {
      return {
        text: group.text,
        items: group.items.map((item) => ({ text: item.text, link: `${prefix}/${item.slug}` })),
      }
    }
    return { text: group.text, link: `${prefix}/${group.slug}` }
  })
}

export default defineConfig({
  lang: 'zh-CN',
  title: 'lh-ui-ios',
  description: 'lh-ui 原生血脉 iOS 端 —— Swift + SwiftUI 组件库',
  base,
  cleanUrls: true,
  lastUpdated: true,

  head: [
    ['link', { rel: 'icon', href: `${base}logo.svg` }],
    ['meta', { property: 'og:url', content: hostname + base }],
    ['meta', { property: 'og:site_name', content: 'lh-ui-ios' }],
  ],

  // search 必须放在顶层 themeConfig：VitePress 的 __VP_LOCAL_SEARCH__ 构建期常量
  // 只读 site.themeConfig（= userConfig.themeConfig），不合并 locales[*].themeConfig，
  // 放在 locales 里会被求值为 false，导航栏搜索框渲染成空壳。
  themeConfig: {
    search: { provider: 'local' },
  },

  locales: {
    root: {
      label: '简体中文',
      lang: 'zh-CN',
      themeConfig: {
        nav: [
          { text: '指南', link: '/guide/introduction' },
          { text: '组件', link: '/components/button' },
          { text: '家族', items: [
            { text: 'lh-ui（总览）', link: 'https://www.lhgb.top' },
            { text: 'lh-ui-plus（Vue3）', link: 'https://www.lhgb.top/lhui/plus/' },
          ] },
        ],
        sidebar: {
          '/guide/': buildSidebar('/guide', guideGroups),
          '/components/': buildSidebar('/components', componentGroups),
        },
        outline: { level: [2, 3], label: '本页目录' },
        socialLinks: [{ icon: 'github', link: 'https://github.com/lhgb-top/lh-ui-ios' }],
        footer: {
          message: 'lh-ui 原生血脉 · iOS 端（Swift + SwiftUI）',
          copyright: 'Apache-2.0 License',
        },
      },
    },
  },

  vite: {
    // 模拟器令牌 CSS 由 scripts/gen-sim-tokens.mjs 生成（docs:dev / docs:build 前自动跑）
    // 站点主题只引静态 CSS，无运行时框架依赖（D19）
  },
})
