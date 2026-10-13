// gen-doc-pages.mjs —— md → 原生文档页（Swift）
//
// 数据驱动：新增/改文档只重跑本脚本（pnpm gen:docs）。生成的 pages/*.swift 与
// DocRegistry.swift 禁手改（漂移由脚本兜底）；真交互预览手写在 Sources/LhUIDocs/Previews/，
// 本脚本按 section 标题经 SCENE_MAP 映射引用，命名固定为 {Comp}{Scene}(scope)。
//
// 输入：docs/components/{slug}.md + docs/guide/{slug}.md + docs/.vitepress/config.ts（分组顺序真源）
// 输出：Sources/LhUIDocs/pages/{Pascal}Doc.swift（组件）/ Guide{Pascal}Doc.swift（指南）
//       + Sources/LhUIDocs/DocRegistry.swift
//
// md 解析约定（与 lh-ui-android / lh-ui-windows 的同名脚本对齐）：
//   首行 `# ` 为 title；其后散文为 lede；连续 `> ` 合并为 contract
//   `## ` 分节，`### ` 为 API 子标题（仅记录 Props 表标题用）
//   `|` 表格逐行解析，含 `:-:` 的分割行跳过
//   ```bash 代码块进 commands，其余代码块进当前 section 的 code
//   `<div>` / `<p>` / `<details>` / `::: tip` 容器整块跳过（网页模拟器 HTML 不进原生）

import { readFileSync, writeFileSync, existsSync, mkdirSync } from 'node:fs'
import { resolve, dirname } from 'node:path'
import { fileURLToPath } from 'node:url'

const ROOT = resolve(dirname(fileURLToPath(import.meta.url)), '..')
const DOCS = resolve(ROOT, 'docs')
const OUT_DIR = resolve(ROOT, 'Sources/LhUIDocs/pages')
const OUT_REGISTRY = resolve(ROOT, 'Sources/LhUIDocs/DocRegistry.swift')

// section 标题 → 预览方法名（手写预览须命名同名方法，签名为 (DocPreviewScope) -> AnyView）
const SCENE_MAP = {
  // Button / 通用
  类型: 'types',
  尺寸: 'sizes',
  状态: 'states',
  图标与花纹底: 'iconAndPattern',
  明暗主题: 'theme',
  // Icon / Loading
  色调: 'tone',
  图标名映射: 'iconNames',
  静态帧: 'staticFrame',
  // Tag
  尺寸与圆角: 'sizesAndRadius',
  可关闭: 'closable',
  // Cell
  基本形态: 'basic',
  '图标 / 必填 / 不可点击': 'iconRequiredAndClick',
  // Checkbox
  不确定态: 'indeterminate',
  // Switch
  加载态: 'loadingState',
  // Input / Textarea
  密码与清除: 'passwordAndClearable',
  字数计数: 'count',
  // Dialog
  显隐与回调: 'visibleAndCallbacks',
  // Toast
  定位: 'position',
  自动消失: 'autoHide',
  // Picker
  滚轮交互: 'wheel',
  回调与边界: 'callbacksAndBounds',
  // Navbar
  图标与边框: 'iconAndBorder',
  '点击 gate': 'clickGate',
}

const TERMINAL_SECTIONS = ['API', '令牌对照', '黄金用例对照']

const GROUP_TO_ENUM = {
  基础组件: 'basic',
  表单组件: 'form',
  反馈组件: 'feedback',
  导航组件: 'navigation',
}

function pascal(slug) {
  return slug.split(/[-_]/).map((s) => s.charAt(0).toUpperCase() + s.slice(1)).join('')
}

// 转义进 Swift 字符串字面量：反斜杠与双引号
function esc(s) {
  return s.replace(/\\/g, '\\\\').replace(/"/g, '\\"')
}

function stringArray(lines, indent) {
  if (lines.length === 0) return '[]'
  return `[\n${lines.map((l) => `${indent}"${esc(l)}"`).join(',\n')},\n${indent.slice(0, -2)}]`
}

// ---------- config.ts 分组顺序解析（侧边栏顺序即首页顺序）----------
function sliceArrayLiteral(src, startKeyword) {
  const kw = src.indexOf(startKeyword)
  const br = src.indexOf('[', kw)
  let depth = 0
  for (let i = br; i < src.length; i++) {
    if (src[i] === '[') depth++
    else if (src[i] === ']') {
      depth--
      if (depth === 0) return src.slice(br, i + 1)
    }
  }
  return src.slice(br)
}

function parseConfig() {
  const src = readFileSync(resolve(DOCS, '.vitepress/config.ts'), 'utf-8')
  const out = { guides: [], components: [] }

  const guideSeg = sliceArrayLiteral(src, 'const guideGroups =')
  const compSeg = sliceArrayLiteral(src, 'const componentGroups =')

  const pairRe = /text:\s*'([^']+)'[^}]*?slug:\s*'([^']+)'/g
  let m
  while ((m = pairRe.exec(guideSeg))) out.guides.push({ text: m[1], slug: m[2] })

  const groupRe = /text:\s*'([^']+)'\s*,\s*items:\s*\[([\s\S]*?)\]/g
  while ((m = groupRe.exec(compSeg))) {
    const items = []
    const itemRe = /text:\s*'([^']+)'[^}]*?slug:\s*'([^']+)'/g
    let im
    while ((im = itemRe.exec(m[2]))) items.push({ text: im[1], slug: im[2] })
    out.components.push({ group: m[1], items })
  }
  return out
}

// ---------- md 解析 ----------
function parseTable(lines) {
  const rows = lines
    .filter((l) => l.trim().startsWith('|'))
    .filter((l) => !/^\|[\s:|-]+\|$/.test(l.trim()))
    .map((l) =>
      l
        .trim()
        .replace(/^\|/, '')
        .replace(/\|$/, '')
        .split('|')
        .map((c) => c.trim()),
    )
  if (rows.length === 0) return null
  return { headers: rows[0], rows: rows.slice(1) }
}

function parseMd(path, isGuide) {
  const raw = readFileSync(path, 'utf-8').replace(/^\uFEFF/, '')
  const lines = raw.split(/\r?\n/)
  const entry = { title: '', lede: [], contract: [], sections: [] }

  let i = 0
  while (i < lines.length && !lines[i].startsWith('# ')) i++
  entry.title = lines[i].slice(2).trim()
  i++

  // lede 与 contract（到首个 ## 之前）
  while (i < lines.length && !lines[i].startsWith('## ')) {
    const l = lines[i].trim()
    if (l.startsWith('>')) {
      entry.contract.push(l.replace(/^>\s?/, '').trim())
    } else if (l !== '') {
      entry.lede.push(l)
    }
    i++
  }

  let section = null
  let inDiv = 0
  let inFence = false
  let fenceLang = ''
  let fenceLines = []
  let tableLines = []
  let apiSubTitle = null

  const flushTable = () => {
    if (tableLines.length === 0) return
    const t = parseTable(tableLines)
    tableLines = []
    if (t && section) {
      // API 节内：### 属性 的表为 Props，其余 ### 的表为枚举表（标题沿用子标题名）
      const title = section.terminal === 'API' && apiSubTitle && apiSubTitle !== '属性' ? apiSubTitle : ''
      section.tables.push({ title, ...t })
    }
  }

  while (i < lines.length) {
    const line = lines[i]

    if (inFence) {
      if (line.trim() === '```') {
        inFence = false
        if (section) section.code.push(...fenceLines)
        fenceLines = []
      } else {
        fenceLines.push(line)
      }
      i++
      continue
    }

    if (inDiv > 0) {
      inDiv += (line.match(/<div/g) || []).length - (line.match(/<\/div>/g) || []).length
      i++
      continue
    }

    const trimmed = line.trim()

    if (trimmed.startsWith('```')) {
      inFence = true
      fenceLang = trimmed.slice(3).trim()
      fenceLines = []
      i++
      continue
    }
    if (trimmed.startsWith('<div')) {
      inDiv = (line.match(/<div/g) || []).length - (line.match(/<\/div>/g) || []).length
      i++
      continue
    }
    if (trimmed.startsWith('<p') || trimmed.startsWith('<details')) {
      i++
      continue
    }
    // vitepress 容器（::: tip / ::: warning …）：只剥掉标记行，正文当散文保留
    if (trimmed.startsWith(':::')) {
      i++
      continue
    }

    if (line.startsWith('## ')) {
      flushTable()
      const title = line.slice(3).trim()
      section = {
        title,
        prose: [],
        code: [],
        tables: [],
        preview: null,
        terminal: TERMINAL_SECTIONS.includes(title) ? title : null,
      }
      apiSubTitle = null
      entry.sections.push(section)
      i++
      continue
    }

    if (line.startsWith('### ')) {
      flushTable()
      apiSubTitle = line.slice(4).trim()
      i++
      continue
    }

    if (trimmed.startsWith('|')) {
      tableLines.push(line)
      i++
      continue
    }
    flushTable()

    if (trimmed === '') {
      i++
      continue
    }
    if (section) section.prose.push(trimmed)
    i++
  }
  flushTable()

  // 预览映射：组件页按 SCENE_MAP；指南页不要预览
  if (!isGuide) {
    for (const s of entry.sections) {
      if (s.terminal) continue
      const name = SCENE_MAP[s.title]
      if (!name) {
        console.warn(`⚠ 未登记场景标题：${path} 的「${s.title}」（该节不生成预览）`)
        continue
      }
      s.preview = name
    }
  }
  return entry
}

// ---------- Swift 代码生成 ----------
function emitTable(t, baseIndent) {
  const cells = (arr) => arr.map((c) => `"${esc(c)}"`).join(', ')
  const rows = t.rows
    .map((r) => `${baseIndent}        DocRow(cells: [${cells(r.length ? r : [''])}]),`)
    .join('\n')
  return `${baseIndent}    DocTable(
${baseIndent}      title: "${esc(t.title)}",
${baseIndent}      headers: [${cells(t.headers)}],
${baseIndent}      rows: [
${rows}
${baseIndent}      ])`
}

function emitEntry(entry, className, group, previewClass) {
  const sections = entry.sections.map((s) => {
    const preview = s.preview ? `${previewClass}.${s.preview}` : 'nil'
    const prose = stringArray(s.prose, '        ')
    const code = stringArray(s.code, '        ')
    const tables =
      s.tables.length > 0
        ? `[\n${s.tables.map((t) => emitTable(t, '        ')).join(',\n')}\n      ]`
        : '[]'
    return `    DocSection(
      title: "${esc(s.title)}",
      prose: ${prose},
      preview: ${preview},
      code: ${code},
      tables: ${tables}
    ),`
  })

  const joined = sections
    .map((s) => s.split('\n').map((l) => (l === '' ? l : '  ' + l)).join('\n'))
    .join('\n')
  return `// 本文件由 scripts/gen-doc-pages.mjs 从 ${entry.source} 生成 —— 禁手改。
// 改文档请改 md 再跑 pnpm gen:docs；真交互预览手写在 Sources/LhUIDocs/Previews/${previewClass}.swift。
// 本文件与 DocRegistry.swift 同属 LhUIDocs 模块，无需 import 自身。

/// ${entry.title}（生成物，勿手改）
struct ${className} {
  static let entry = DocEntry(
    id: "${esc(entry.id)}",
    title: "${esc(entry.title)}",
    lede: ${stringArray(entry.lede, '      ')},
    contract: ${stringArray(entry.contract, '      ')},
    group: .${group},
    sections: [
  ${joined}
    ]
  )
}
`
}

function emitRegistry(registrations) {
  const list = registrations.map((r) => `    ${r.className}.entry,`).join('\n')
  return `// 本文件由 scripts/gen-doc-pages.mjs 生成 —— 禁手改（分组顺序对齐 docs 侧边栏）。
// 本文件与 pages/*.swift 同属 LhUIDocs 模块，无需 import 自身。

/// 文档注册表：数据驱动的页面清单。顺序与 docs/.vitepress/config.ts 的侧边栏一致。
enum DocRegistry {
  /// 全部条目（侧边栏顺序）
  static let all: [DocEntry] = [
${list}
  ]

  /// 按 id 取条目；宿主的返回栈与侧边栏选中都走它
  static func byId(_ id: String) -> DocEntry? {
    all.first { $0.id == id }
  }

  /// 取某分组的条目（保持 all 内顺序）
  static func entries(in group: DocGroup) -> [DocEntry] {
    all.filter { $0.group == group }
  }
}
`
}

// ---------- 主流程 ----------
function main() {
  const cfg = parseConfig()
  if (!existsSync(OUT_DIR)) mkdirSync(OUT_DIR, { recursive: true })

  const registrations = []
  let warnings = 0

  // 指南页
  for (const g of cfg.guides) {
    const mdPath = resolve(DOCS, 'guide', `${g.slug}.md`)
    if (!existsSync(mdPath)) {
      console.warn(`⚠ 缺少指南 md：${mdPath}`)
      warnings++
      continue
    }
    const entry = parseMd(mdPath, true)
    entry.id = g.slug
    entry.source = `docs/guide/${g.slug}.md`
    const className = `Guide${pascal(g.slug)}Doc`
    // 指南页无预览；previewClass 仅供文件头提示用
    writeFileSync(resolve(OUT_DIR, `${className}.swift`), emitEntry(entry, className, 'guide', 'GuidePreviews'))
    registrations.push({ className })
  }

  // 组件页
  for (const grp of cfg.components) {
    const group = GROUP_TO_ENUM[grp.group]
    if (!group) {
      console.warn(`⚠ 未知分组「${grp.group}」，请在 GROUP_TO_ENUM 登记`)
      warnings++
    }
    for (const item of grp.items) {
      const mdPath = resolve(DOCS, 'components', `${item.slug}.md`)
      if (!existsSync(mdPath)) {
        console.warn(`⚠ 缺少组件 md：${mdPath}`)
        warnings++
        continue
      }
      const entry = parseMd(mdPath, false)
      entry.id = item.slug
      entry.source = `docs/components/${item.slug}.md`
      const className = `${pascal(item.slug)}Doc`
      const previewClass = `${pascal(item.slug)}Previews`
      writeFileSync(resolve(OUT_DIR, `${className}.swift`), emitEntry(entry, className, group, previewClass))
      registrations.push({ className })
    }
  }

  writeFileSync(OUT_REGISTRY, emitRegistry(registrations))
  console.log(`✅ 生成 ${registrations.length} 个条目 → ${OUT_REGISTRY}`)
  console.log(`   页面目录：${OUT_DIR}`)
  if (warnings > 0) console.log(`⚠ ${warnings} 处告警，请检查上方输出`)
}

main()
