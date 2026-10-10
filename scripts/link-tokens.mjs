/**
 * 令牌本地连接（家族统一机制，总纲 D18）。ios 仓版本。
 *
 * 三级存在性守卫：
 *   1. 同级 ../lh-ui-core/dist/ios  —— 家族布局下直连 codegen 产物
 *   2. node_modules/@lh-ui/core/dist/ios —— npm 已发包产物（CI 单仓 clone 回退）
 *   3. 都不存在 —— 报错退出
 *
 * 目标 Sources/LhUITokens/ 是生成物（.gitignore），禁止手改。
 * 与 android / harmony / c 仓的脚本同构。
 */

import { cpSync, existsSync, readdirSync, rmSync, statSync } from 'node:fs'
import { resolve } from 'node:path'

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

function countFiles(dir) {
  let count = 0
  for (const name of readdirSync(dir)) {
    const full = resolve(dir, name)
    if (statSync(full).isDirectory()) count += countFiles(full)
    else count += 1
  }
  return count
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
    const current = existsSync(TOKEN_DEST) ? countFiles(TOKEN_DEST) : 0
    const expected = countFiles(source)
    if (current !== expected) {
      console.error(`❌ 令牌未同步：落点 ${current} 个文件，来源 ${expected} 个（来源：${mode}）`)
      process.exitCode = 1
      return
    }
    console.log(`✅ 令牌已同步：${current} 个文件（来源：${mode}）`)
    return
  }

  rmSync(TOKEN_DEST, { recursive: true, force: true })
  cpSync(source, TOKEN_DEST, { recursive: true })
  console.log(`✅ ${PLATFORM} 令牌已同步：${countFiles(TOKEN_DEST)} 个文件 → ${TOKEN_DEST}（${mode}）`)
  if (isLocal) {
    console.log('   令牌改动后：cd ../lh-ui-core && pnpm codegen，再回本仓 pnpm link:tokens')
  }
}

main()
