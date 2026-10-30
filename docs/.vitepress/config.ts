import { defineConfig } from 'vitepress'
import { loadEnv } from 'vite'
import { existsSync } from 'node:fs'
import { resolve } from 'node:path'
import { beianCopyright } from './beian'

// DOCS_BASE 必须显式 loadEnv：Vite 内置 env 加载在用户 config 求值之后，
// 直接读 process.env.DOCS_BASE 生产构建拿不到 .env.production 的值。
const mode = process.env.NODE_ENV === 'production' ? 'production' : 'development'
const env = loadEnv(mode, resolve(__dirname, '..'), 'DOCS_')

const base = env.DOCS_BASE || '/'
const hostname = (env.DOCS_HOSTNAME || 'https://www.lhgb.top').replace(/\/$/, '')

// ── locale 清单 ──────────────────────────────────────────────
// key  = URL 前缀与 docs/ 下的内容目录名（root 除外，root 是中文真源）
// lang = <html lang> 值，同时是 @lh-ui/share 语言包名（demo 文案切换用）
// label= 右上角语言切换器的显示名（一律用各语言的自称）
// dir  = 仅 ar 填 'rtl'，由 VitePress 注入 <html dir="rtl">
//
// 新增语言：在此加一行 + 把所有 labels 结构补齐该 lang + 建 docs/<key>/ 内容目录
const LOCALES = [
  { key: 'root', lang: 'zh-CN', label: '简体中文' },
  { key: 'en', lang: 'en-US', label: 'English' },
  { key: 'zh-TW', lang: 'zh-TW', label: '繁體中文' },
  { key: 'ja', lang: 'ja-JP', label: '日本語' },
  { key: 'ko', lang: 'ko-KR', label: '한국어' },
  { key: 'es', lang: 'es', label: 'Español' },
  { key: 'ar', lang: 'ar', label: 'العربية', dir: 'rtl' },
  { key: 'fr', lang: 'fr-FR', label: 'Français' },
  { key: 'ru', lang: 'ru', label: 'Русский' },
] as const

type Lang = (typeof LOCALES)[number]['lang']

// ── UI 文案（每语言一份，翻译按 docs/i18n/glossary.md 术语表）──────────────
const UI = {
  nav: {
    guide: { 'zh-CN': '指南', 'en-US': 'Guide', 'zh-TW': '指南', 'ja-JP': 'ガイド', 'ko-KR': '가이드', es: 'Guía', ar: 'دليل', 'fr-FR': 'Guide', ru: 'Руководство' },
    components: { 'zh-CN': '组件', 'en-US': 'Components', 'zh-TW': '元件', 'ja-JP': 'コンポーネント', 'ko-KR': '컴포넌트', es: 'Componentes', ar: 'المكوّنات', 'fr-FR': 'Composants', ru: 'Компоненты' },
    family: { 'zh-CN': '家族', 'en-US': 'Family', 'zh-TW': '家族', 'ja-JP': 'ファミリー', 'ko-KR': '패밀리', es: 'Familia', ar: 'العائلة', 'fr-FR': 'Famille', ru: 'Семейство' },
    overview: { 'zh-CN': 'lh-ui（总览）', 'en-US': 'lh-ui (Overview)', 'zh-TW': 'lh-ui（總覽）', 'ja-JP': 'lh-ui（概要）', 'ko-KR': 'lh-ui（개요）', es: 'lh-ui (Descripción general)', ar: 'lh-ui (نظرة عامة)', 'fr-FR': 'lh-ui (Présentation)', ru: 'lh-ui (Обзор)' },
    // 品牌名 lh-ui-plus 与 Vue3 标签在所有语言下保持不变
    vue3: { 'zh-CN': 'lh-ui-plus（Vue3）', 'en-US': 'lh-ui-plus (Vue3)', 'zh-TW': 'lh-ui-plus（Vue3）', 'ja-JP': 'lh-ui-plus（Vue3）', 'ko-KR': 'lh-ui-plus(Vue3)', es: 'lh-ui-plus (Vue3)', ar: 'lh-ui-plus (Vue3)', 'fr-FR': 'lh-ui-plus (Vue3)', ru: 'lh-ui-plus (Vue3)' },
  },
  outline: {
    'zh-CN': '本页目录',
    'en-US': 'On this page',
    'zh-TW': '本頁目錄',
    'ja-JP': 'このページの内容',
    'ko-KR': '이 페이지 목차',
    es: 'En esta página',
    ar: 'في هذه الصفحة',
    'fr-FR': 'Sur cette page',
    ru: 'Содержание страницы',
  },
  footerMessage: {
    'zh-CN': 'lh-ui 原生血脉 · iOS 端（Swift + SwiftUI）',
    'en-US': 'lh-ui native bloodline · iOS (Swift + SwiftUI)',
    'zh-TW': 'lh-ui 原生血脈 · iOS 端（Swift + SwiftUI）',
    'ja-JP': 'lh-ui ネイティブ血脈 · iOS 端（Swift + SwiftUI）',
    'ko-KR': 'lh-ui 네이티브 혈통 · iOS(Swift + SwiftUI)',
    es: 'Linaje nativo de lh-ui · iOS (Swift + SwiftUI)',
    ar: 'سلالة lh-ui الأصلية · iOS (Swift + SwiftUI)',
    'fr-FR': 'Lignée native de lh-ui · iOS (Swift + SwiftUI)',
    ru: 'Нативное направление lh-ui · iOS (Swift + SwiftUI)',
  },
  description: {
    'zh-CN': 'lh-ui 原生血脉 iOS 端 —— Swift + SwiftUI 组件库',
    'en-US': 'lh-ui native bloodline — iOS: Swift + SwiftUI component library',
    'zh-TW': 'lh-ui 原生血脈 iOS 端 —— Swift + SwiftUI 元件庫',
    'ja-JP': 'lh-ui ネイティブ血脈 iOS 端 —— Swift + SwiftUI コンポーネントライブラリ',
    'ko-KR': 'lh-ui 네이티브 혈통 iOS —— Swift + SwiftUI 컴포넌트 라이브러리',
    es: 'Linaje nativo de lh-ui — iOS: biblioteca de componentes en Swift + SwiftUI',
    ar: 'سلالة lh-ui الأصلية — iOS: مكتبة مكوّنات بلغة Swift و SwiftUI',
    'fr-FR': 'Lignée native de lh-ui — iOS : bibliothèque de composants en Swift + SwiftUI',
    ru: 'Нативное направление lh-ui — iOS: библиотека компонентов на Swift + SwiftUI',
  },
  // 站点标题（SEO <title> 用描述性文案，利于搜索「lh ui」「国风组件库」等；导航栏短品牌名
  // 走 themeConfig.siteTitle）。文案与 docs/部署/seo-meta.json 保持一致
  siteTitle: {
    'zh-CN': 'lh-ui-ios · iOS 国风组件库（Swift + SwiftUI）',
    'en-US': 'lh-ui-ios · Chinese-style UI Library for iOS (Swift + SwiftUI)',
    'zh-TW': 'lh-ui-ios · iOS 國風元件庫（Swift + SwiftUI）',
    'ja-JP': 'lh-ui-ios · iOS 向け中国風 UI ライブラリ（Swift + SwiftUI）',
    'ko-KR': 'lh-ui-ios · iOS 용 중국풍 UI 라이브러리(Swift + SwiftUI)',
    es: 'lh-ui-ios · Biblioteca de UI de estilo chino para iOS (Swift + SwiftUI)',
    ar: 'lh-ui-ios · مكتبة واجهة صينية الطراز لـ iOS (Swift + SwiftUI)',
    'fr-FR': 'lh-ui-ios · Bibliothèque d\'UI au style chinois pour iOS (Swift + SwiftUI)',
    ru: 'lh-ui-ios · Библиотека UI в китайском стиле для iOS (Swift + SwiftUI)',
  },
}

// ── 数据驱动侧边栏：新增组件只需在此加一条 ─────────────────────
// labels 按 LOCALES 的 lang 一一填写；slug 决定所有语言下的 URL（不译）
type Labels = Record<Lang, string>
type Entry = { slug: string; labels: Labels }
type Group = { labels: Labels; items: Entry[] }

const componentGroups: Group[] = [
  {
    labels: {
      'zh-CN': '基础组件',
      'en-US': 'Basic',
      'zh-TW': '基礎元件',
      'ja-JP': '基本コンポーネント',
      'ko-KR': '기본 컴포넌트',
      es: 'Componentes básicos',
      ar: 'المكوّنات الأساسية',
      'fr-FR': 'Composants de base',
      ru: 'Базовые компоненты',
    },
    items: [
      {
        slug: 'button',
        labels: { 'zh-CN': 'Button 按钮', 'en-US': 'Button', 'zh-TW': 'Button 按鈕', 'ja-JP': 'Button ボタン', 'ko-KR': 'Button 버튼', es: 'Botón', ar: 'زر Button', 'fr-FR': 'Bouton', ru: 'Кнопка' },
      },
      {
        slug: 'icon',
        labels: { 'zh-CN': 'Icon 图标', 'en-US': 'Icon', 'zh-TW': 'Icon 圖示', 'ja-JP': 'Icon アイコン', 'ko-KR': 'Icon 아이콘', es: 'Icono', ar: 'أيقونة Icon', 'fr-FR': 'Icône', ru: 'Значок' },
      },
      {
        slug: 'tag',
        labels: { 'zh-CN': 'Tag 标签', 'en-US': 'Tag', 'zh-TW': 'Tag 標籤', 'ja-JP': 'Tag タグ', 'ko-KR': 'Tag 태그', es: 'Etiqueta', ar: 'وسم Tag', 'fr-FR': 'Étiquette', ru: 'Тег' },
      },
      {
        slug: 'loading',
        labels: { 'zh-CN': 'Loading 加载', 'en-US': 'Loading', 'zh-TW': 'Loading 載入', 'ja-JP': 'Loading ローディング', 'ko-KR': 'Loading 로딩', es: 'Cargando', ar: 'تحميل Loading', 'fr-FR': 'Chargement', ru: 'Загрузка' },
      },
      {
        slug: 'cell',
        labels: { 'zh-CN': 'Cell 单元格', 'en-US': 'Cell', 'zh-TW': 'Cell 儲存格', 'ja-JP': 'Cell セル', 'ko-KR': 'Cell 셀', es: 'Celda', ar: 'خلية Cell', 'fr-FR': 'Cellule', ru: 'Ячейка' },
      },
    ],
  },
  {
    labels: {
      'zh-CN': '表单组件',
      'en-US': 'Form',
      'zh-TW': '表單元件',
      'ja-JP': 'フォームコンポーネント',
      'ko-KR': '폼 컴포넌트',
      es: 'Componentes de formulario',
      ar: 'مكوّنات النموذج',
      'fr-FR': 'Composants de formulaire',
      ru: 'Компоненты форм',
    },
    items: [
      {
        slug: 'checkbox',
        labels: { 'zh-CN': 'Checkbox 复选框', 'en-US': 'Checkbox', 'zh-TW': 'Checkbox 核取方塊', 'ja-JP': 'Checkbox チェックボックス', 'ko-KR': 'Checkbox 체크박스', es: 'Casilla de verificación', ar: 'مربع اختيار Checkbox', 'fr-FR': 'Case à cocher', ru: 'Флажок' },
      },
      {
        slug: 'radio',
        labels: { 'zh-CN': 'Radio 单选框', 'en-US': 'Radio', 'zh-TW': 'Radio 單選鈕', 'ja-JP': 'Radio ラジオボタン', 'ko-KR': 'Radio 라디오 버튼', es: 'Botón de radio', ar: 'زر اختيار Radio', 'fr-FR': 'Bouton radio', ru: 'Радиокнопка' },
      },
      {
        slug: 'switch',
        labels: { 'zh-CN': 'Switch 开关', 'en-US': 'Switch', 'zh-TW': 'Switch 開關', 'ja-JP': 'Switch スイッチ', 'ko-KR': 'Switch 스위치', es: 'Interruptor', ar: 'مفتاح Switch', 'fr-FR': 'Interrupteur', ru: 'Переключатель' },
      },
      {
        slug: 'input',
        labels: { 'zh-CN': 'Input 输入框', 'en-US': 'Input', 'zh-TW': 'Input 輸入框', 'ja-JP': 'Input 入力フィールド', 'ko-KR': 'Input 입력 상자', es: 'Campo de entrada', ar: 'حقل إدخال Input', 'fr-FR': 'Champ de saisie', ru: 'Поле ввода' },
      },
      {
        slug: 'textarea',
        labels: { 'zh-CN': 'Textarea 多行输入框', 'en-US': 'Textarea', 'zh-TW': 'Textarea 多行輸入框', 'ja-JP': 'Textarea テキストエリア', 'ko-KR': 'Textarea 여러 줄 입력', es: 'Área de texto', ar: 'منطقة نص Textarea', 'fr-FR': 'Zone de texte', ru: 'Текстовая область' },
      },
    ],
  },
  {
    labels: {
      'zh-CN': '反馈组件',
      'en-US': 'Feedback',
      'zh-TW': '反饋元件',
      'ja-JP': 'フィードバック',
      'ko-KR': '피드백',
      es: 'Retroalimentación',
      ar: 'التغذية الراجعة',
      'fr-FR': 'Retour',
      ru: 'Обратная связь',
    },
    items: [
      {
        slug: 'dialog',
        labels: { 'zh-CN': 'Dialog 对话框', 'en-US': 'Dialog', 'zh-TW': 'Dialog 對話框', 'ja-JP': 'Dialog ダイアログ', 'ko-KR': 'Dialog 대화상자', es: 'Diálogo', ar: 'مربع حوار Dialog', 'fr-FR': 'Boîte de dialogue', ru: 'Диалог' },
      },
      {
        slug: 'toast',
        labels: { 'zh-CN': 'Toast 轻提示', 'en-US': 'Toast', 'zh-TW': 'Toast 輕提示', 'ja-JP': 'Toast 通知', 'ko-KR': 'Toast 알림', es: 'Toast (notificación breve)', ar: 'Toast (تنبيه)', 'fr-FR': 'Toast (notification)', ru: 'Toast (короткое уведомление)' },
      },
      {
        slug: 'picker',
        labels: { 'zh-CN': 'Picker 选择器', 'en-US': 'Picker', 'zh-TW': 'Picker 選擇器', 'ja-JP': 'Picker ピッカー', 'ko-KR': 'Picker 피커', es: 'Selector', ar: 'منتقي Picker', 'fr-FR': 'Sélecteur', ru: 'Средство выбора' },
      },
    ],
  },
  {
    labels: {
      'zh-CN': '导航组件',
      'en-US': 'Navigation',
      'zh-TW': '導覽元件',
      'ja-JP': 'ナビゲーション',
      'ko-KR': '내비게이션',
      es: 'Navegación',
      ar: 'التنقل',
      'fr-FR': 'Navigation',
      ru: 'Навигация',
    },
    items: [
      {
        slug: 'navbar',
        labels: { 'zh-CN': 'Navbar 导航栏', 'en-US': 'Navbar', 'zh-TW': 'Navbar 導覽列', 'ja-JP': 'Navbar ナビゲーションバー', 'ko-KR': 'Navbar 내비게이션 바', es: 'Barra de navegación', ar: 'شريط تنقل Navbar', 'fr-FR': 'Barre de navigation', ru: 'Панель навигации' },
      },
    ],
  },
]

const guideGroups: Entry[] = [
  {
    slug: 'introduction',
    labels: { 'zh-CN': '介绍', 'en-US': 'Introduction', 'zh-TW': '介紹', 'ja-JP': '紹介', 'ko-KR': '소개', es: 'Introducción', ar: 'مقدمة', 'fr-FR': 'Introduction', ru: 'Введение' },
  },
  {
    slug: 'installation',
    labels: { 'zh-CN': '安装', 'en-US': 'Installation', 'zh-TW': '安裝', 'ja-JP': 'インストール', 'ko-KR': '설치', es: 'Instalación', ar: 'التثبيت', 'fr-FR': 'Installation', ru: 'Установка' },
  },
  {
    slug: 'quickstart',
    labels: { 'zh-CN': '快速开始', 'en-US': 'Quick Start', 'zh-TW': '快速開始', 'ja-JP': 'クイックスタート', 'ko-KR': '빠른 시작', es: 'Inicio rápido', ar: 'البدء السريع', 'fr-FR': 'Démarrage rapide', ru: 'Быстрый старт' },
  },
  {
    slug: 'theming',
    labels: { 'zh-CN': '主题与暗色', 'en-US': 'Theming & Dark Mode', 'zh-TW': '主題與暗色', 'ja-JP': 'テーマとダークモード', 'ko-KR': '테마 및 다크 모드', es: 'Temas y modo oscuro', ar: 'السمات والوضع الداكن', 'fr-FR': 'Thèmes et mode sombre', ru: 'Темы и тёмный режим' },
  },
  {
    slug: 'local-linking',
    labels: { 'zh-CN': '本地联调', 'en-US': 'Local Linking', 'zh-TW': '本地聯調', 'ja-JP': 'ローカル連携', 'ko-KR': '로컬 연결', es: 'Enlace local', ar: 'الربط المحلي', 'fr-FR': 'Liaison locale', ru: 'Локальная линковка' },
  },
]

function buildSidebar(prefix: string, entries: (Group | Entry)[], lang: Lang) {
  return entries.map((group) => {
    if ('items' in group) {
      return {
        text: group.labels[lang],
        items: group.items.map((item) => ({ text: item.labels[lang], link: `${prefix}/${item.slug}` })),
      }
    }
    return { text: group.labels[lang], link: `${prefix}/${group.slug}` }
  })
}

// ── 由 LOCALES + UI + 侧边栏数据自动生成九份 locale 配置 ───────────────
function buildLocales() {
  const locales: Record<string, object> = {}
  for (const l of LOCALES) {
    // 内容门禁：目标语言内容目录尚不存在时跳过（切换器不展示该语言），目录出现后自动失效（2026-10-15）
    if (l.key !== 'root' && !existsSync(resolve(__dirname, l.key))) continue
    // root 的内容在 docs/ 根，其余语言在 docs/<key>/
    const prefix = l.key === 'root' ? '' : `/${l.key}`
    const entry: Record<string, unknown> = {
      label: l.label,
      lang: l.lang,
      title: UI.siteTitle[l.lang],
      description: UI.description[l.lang],
      ...(l.dir ? { dir: l.dir } : {}),
      themeConfig: {
        nav: [
          { text: UI.nav.guide[l.lang], link: `${prefix}/guide/introduction`, activeMatch: `${prefix}/guide/` },
          { text: UI.nav.components[l.lang], link: `${prefix}/components/button`, activeMatch: `${prefix}/components/` },
          {
            text: UI.nav.family[l.lang],
            items: [
              { text: UI.nav.overview[l.lang], link: 'https://www.lhgb.top' },
              { text: UI.nav.vue3[l.lang], link: 'https://www.lhgb.top/lhui/vue3/' },
            ],
          },
        ],
        sidebar: {
          [`${prefix}/guide/`]: buildSidebar(`${prefix}/guide`, guideGroups, l.lang),
          [`${prefix}/components/`]: buildSidebar(`${prefix}/components`, componentGroups, l.lang),
        },
        outline: { level: [2, 3], label: UI.outline[l.lang] },
        socialLinks: [{ icon: 'github', link: 'https://github.com/lhgb-top/lh-ui-ios' }],
        footer: {
          message: UI.footerMessage[l.lang],
          copyright: beianCopyright(l.lang, base),
        },
      },
    }
    if (l.key === 'root') {
      locales.root = entry
    } else {
      locales[l.key] = { ...entry, link: `/${l.key}/` }
    }
  }
  return locales
}

export default defineConfig({
  lang: 'zh-CN',
  title: UI.siteTitle['zh-CN'],
  description: UI.description['zh-CN'],
  base,
  cleanUrls: true,
  lastUpdated: true,
  // sitemap：产物输出 sitemap.xml，robots.txt 指向 https://www.lhgb.top/lhui/ios/sitemap.xml
  sitemap: {
    hostname: hostname + base,
  },

  head: [
    // 图标：SVG 主（浏览器现代版）+ ICO fallback（搜索引擎/老浏览器）+ apple-touch-icon
    ['link', { rel: 'icon', type: 'image/svg+xml', href: `${base}logo.svg` }],
    ['link', { rel: 'icon', sizes: '32x32', href: `${base}favicon.ico` }],
    ['link', { rel: 'apple-touch-icon', href: `${base}apple-touch-icon.png` }],
    // 社交分享图（docs/部署/favicon-src/og.png 同源栅格化）
    ['meta', { property: 'og:image', content: `${hostname}${base}og.png` }],
    ['meta', { name: 'twitter:image', content: `${hostname}${base}og.png` }],
    // 中文 meta（SEO 文案与 docs/部署/seo-meta.json 同源）
    ['meta', { name: 'description', content: UI.description['zh-CN'] }],
    [
      'meta',
      {
        name: 'keywords',
        content: 'lh-ui,lh-ui-ios,iOS,Swift,SwiftUI,UI组件库,国风,Component Library',
      },
    ],
    // Open Graph
    ['meta', { property: 'og:title', content: UI.siteTitle['zh-CN'] }],
    ['meta', { property: 'og:description', content: UI.description['zh-CN'] }],
    ['meta', { property: 'og:type', content: 'website' }],
    ['meta', { property: 'og:url', content: hostname + base }],
    ['meta', { property: 'og:site_name', content: 'lh-ui-ios' }],
    // Twitter Card
    ['meta', { name: 'twitter:card', content: 'summary' }],
    ['meta', { name: 'twitter:title', content: UI.siteTitle['en-US'] }],
    ['meta', { name: 'twitter:description', content: UI.description['en-US'] }],
    // JSON-LD structured data
    [
      'script',
      { type: 'application/ld+json' },
      JSON.stringify({
        '@context': 'https://schema.org',
        '@type': 'SoftwareApplication',
        name: 'lh-ui-ios',
        description: UI.description['zh-CN'],
        applicationCategory: 'DeveloperApplication',
        operatingSystem: 'iOS',
        programmingLanguage: 'Swift',
        url: hostname + base,
        author: { '@type': 'Organization', name: 'lhgb.top' },
        offers: { '@type': 'Offer', price: '0', priceCurrency: 'CNY' },
      }),
    ],
  ],

  // search 必须放在顶层 themeConfig：VitePress 的 __VP_LOCAL_SEARCH__ 构建期常量
  // 只读 site.themeConfig（= userConfig.themeConfig），不合并 locales[*].themeConfig，
  // 放在 locales 里会被求值为 false，导航栏搜索框渲染成空壳。
  themeConfig: {
    search: { provider: 'local' },
    siteTitle: 'lh-ui-ios',
  },

  locales: buildLocales(),

  vite: {
    // 模拟器令牌 CSS 由 scripts/gen-sim-tokens.mjs 生成（docs:dev / docs:build 前自动跑）
    // 站点主题只引静态 CSS，无运行时框架依赖（D19）
  },
})
