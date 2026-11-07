/**
 * 令牌本地连接（家族统一机制，总纲 D18）。ios 仓版本。
 *
 * 三级存在性守卫：
 *   1. 同级 ../lh-ui-core/dist/ios  —— 家族布局下直连 codegen 产物
 *   2. node_modules/@lh-ui/core/dist/ios —— npm 已发包产物（CI 单仓 clone 回退）
 *   3. 都不存在 —— 报错退出
 *
 * 目标 Sources/LhUITokens/ 是生成物（.gitignore），禁止手改；整目录皆为生成物
 * （与 android / windows 仓「源根共存手写代码」不同，无需前缀过滤）。
 * 与 android / harmony / windows 仓的脚本同构。
 *
 * 用法：
 *   pnpm link:tokens          # 同步令牌到本仓源码树
 *   pnpm link:tokens --check  # 仅探测，不写入（CI 校验令牌是否已同步）
 */

import { cpSync, existsSync, readFileSync, readdirSync, rmSync, statSync } from 'node:fs'
import { resolve, relative } from 'node:path'

const PLATFORM = 'ios'
const REPO_ROOT = resolve(import.meta.dirname, '..')
const CORE_ROOT = resolve(REPO_ROOT, '..', 'lh-ui-core')
const TOKEN_DEST = resolve(REPO_ROOT, 'Sources', 'LhUITokens')

function resolveTokenSource() {
  const localDist = resolve(CORE_ROOT, 'dist', PLATFORM)
  if (existsSync(localDist)) return localDist
  const npmDist = resolve(REPO_ROOT, 'node_modules', '@lh-ui', 'core', 'dist', PLATFORM)
  if (existsSync(npmDist)) return npmDist
  return null
}

/** 收集目录内全部文件的相对路径（相对该目录，POSIX 分隔符），用于集合比对 */
function listFiles(dir, base = dir) {
  const out = []
  for (const name of readdirSync(dir)) {
    const full = resolve(dir, name)
    if (statSync(full).isDirectory()) out.push(...listFiles(full, base))
    else out.push(relative(base, full).split('\\').join('/'))
  }
  return out
}

/**
 * 校验落点与来源是否逐文件一致（名称集合 + 字节内容）。
 *
 * 早期版本只比文件数：内容过期（甚至改名的令牌）都能蒙混过关，曾在
 * checkbox.dashScale 缺失时给出过假绿灯。名称集合比对拦「改名/新增/删除」，
 * 逐文件字节比对拦「内容漂移」。
 *
 * ios 落点整目录都是生成物（无前缀过滤），比对基准与
 * cpSync(source, TOKEN_DEST) 的整树拷贝语义一致：来源相对路径即落点相对路径。
 *
 * @returns 缺失 / 多余 / 改动 三个清单
 */
function diffTokens(source, destRoot) {
  const srcNames = listFiles(source)
  const destNames = existsSync(destRoot) ? listFiles(destRoot) : []
  const srcSet = new Set(srcNames)
  const destSet = new Set(destNames)
  const missing = srcNames.filter(n => !destSet.has(n))
  const extra = destNames.filter(n => !srcSet.has(n))
  const modified = srcNames.filter(n => {
    if (!destSet.has(n)) return false
    const a = readFileSync(resolve(source, n))
    const b = readFileSync(resolve(destRoot, n))
    return Buffer.compare(a, b) !== 0
  })
  return { missing, extra, modified }
}

function main() {
  const checkOnly = process.argv.slice(2).includes('--check')
  const source = resolveTokenSource()

  if (!source) {
    console.error(
      `❌ 未找到 ${PLATFORM} 令牌产物：既无本地 ${resolve(CORE_ROOT, 'dist', PLATFORM)}，` +
        `也无 node_modules/@lh-ui/core/dist/${PLATFORM}。\n` +
        '请先在家族布局下 `cd ../lh-ui-core && pnpm codegen`，或安装 @lh-ui/core。',
    )
    process.exitCode = 1
    return
  }

  const isLocal = source === resolve(CORE_ROOT, 'dist', PLATFORM)
  const mode = isLocal ? '本地直连（../lh-ui-core/dist）' : 'npm 产物回退（@lh-ui/core）'

  if (checkOnly) {
    const { missing, extra, modified } = diffTokens(source, TOKEN_DEST)
    if (missing.length || extra.length || modified.length) {
      console.error(`❌ 令牌未同步（来源：${mode}）`)
      if (missing.length) console.error(`   缺失 ${missing.length} 个：${missing.join(', ')}`)
      if (extra.length) console.error(`   多余 ${extra.length} 个：${extra.join(', ')}`)
      if (modified.length) console.error(`   改动 ${modified.length} 个：${modified.join(', ')}`)
      console.error('   请执行 `pnpm link:tokens` 重新同步（令牌真源在 lh-ui-core/tokens/*.json）')
      process.exitCode = 1
      return
    }
    console.log(`✅ 令牌已同步：${listFiles(TOKEN_DEST).length} 个文件逐文件一致（来源：${mode}）`)
    return
  }

  rmSync(TOKEN_DEST, { recursive: true, force: true })
  cpSync(source, TOKEN_DEST, { recursive: true })
  console.log(`✅ ${PLATFORM} 令牌已同步：${listFiles(TOKEN_DEST).length} 个文件 → ${TOKEN_DEST}（${mode}）`)
  if (isLocal) {
    console.log('   令牌改动后：cd ../lh-ui-core && pnpm codegen，再回本仓 pnpm link:tokens')
  }
}

main()
