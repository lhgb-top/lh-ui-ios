import type { Theme } from 'vitepress'
import DefaultTheme from 'vitepress/theme'
import './style.css'
// 模拟器：基础手机框 + 平台外观 + 生成的令牌 CSS 变量（D19）
import './sim/base.css'
import './sim/ios.css'
import './sim-tokens.css'

// 语言切换不入历史栈：默认主题语言菜单是原生 <a href>，点击整页载入并 push 一条历史；
// 同一页面试 N 种语言就堆 N 条，back 只能逐语言退。捕获阶段拦截语言菜单内的同源链接改用
// location.replace——同样整页载入，但不留历史条目，back 直达切换前的页面（2026-10-15）
function setupLocaleReplaceNavigation() {
  if (typeof document === 'undefined') return
  document.addEventListener(
    'click',
    (e) => {
      const link = (e.target as HTMLElement | null)?.closest('a')
      if (!link) return
      if (!link.closest('.VPNavBarTranslations, .VPNavScreenTranslations')) return
      if (e.metaKey || e.ctrlKey || e.shiftKey || e.altKey || link.target === '_blank') return
      let url: URL
      try {
        url = new URL(link.href, window.location.href)
      } catch {
        return
      }
      if (url.origin !== window.location.origin) return
      e.preventDefault()
      window.location.replace(url.href)
    },
    true,
  )
}

export default {
  extends: DefaultTheme,
  enhanceApp() {
    // 站点不注册任何组件：模拟器是 md 内联的静态 HTML，零运行时框架依赖
    setupLocaleReplaceNavigation()
  },
} satisfies Theme
