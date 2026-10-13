/**
 * 把 master 与本次发版的 tag 推到 GitHub，触发 release.yml 自动留档。
 *
 * iOS 端用 SPM 发包，SPM 的版本语义完全由 git tag 决定（Package.swift 里
 * 没有 version 字段），所以「打 tag」就是「发包」。tag 格式为
 * `lh-ui-ios@<版本>`（家族原生端命名约定，见 docs/发包流程.md §十一）。
 *
 * 版本号取 package.json 的 version（由 changeset:version bump）。SPM 消费者
 * 通过该 tag 引用本包，SPR（Swift Package Registry）也按该 tag 索引。
 *
 * 只推 GitHub（remote: github-lhgb）。Gitee 的 tag 与发行版统一由
 * release.yml 接管，避免本地/CI 双写冲突。
 *
 * 注意：令牌目录 Sources/LhUITokens/ 是 codegen 生成物且被 gitignore，
 * 远程 clone 后需先 pnpm link:tokens 注入才能编译（发版留档不依赖构建）。
 *
 * 用法：pnpm release:push
 *      pnpm release:push -- --dry-run（只打印命令不执行，发版前自检）
 */
import fs from 'node:fs'
import path from 'node:path'
import { execFileSync } from 'node:child_process'
import { fileURLToPath } from 'node:url'

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const pkgPath = path.resolve(__dirname, '..', 'package.json')

const dryRun = process.argv.includes('--dry-run')

const pkg = JSON.parse(fs.readFileSync(pkgPath, 'utf8'))
const tag = `lh-ui-ios@${pkg.version}`
const remote = 'github-lhgb'

const run = (command) => {
  console.log(`$ ${command}`)
  if (dryRun) return
  execFileSync(command, { stdio: 'inherit', shell: true })
}

// tag 若已存在（重跑场景）直接复用，不重复打
let tagExists = false
try {
  execFileSync('git', ['rev-parse', '--verify', `refs/tags/${tag}`], { stdio: 'ignore' })
  tagExists = true
} catch {
  tagExists = false
}
if (!tagExists) {
  run(`git tag -a ${tag} -m "release: ${tag}"`)
}

run(`git push ${remote} master`)
run(`git push ${remote} ${tag}`)

console.log(`
✅${dryRun ? '（dry-run，未实际执行）' : ''} 已推送 ${tag} 到 GitHub。
SPM 消费者按该 tag 引用本包；GitHub Actions 将自动创建发行版（挂源码 zip），
随后同步 tag 与发行版到 Gitee。
跟踪进度：https://github.com/lhgb-top/lh-ui-ios/actions`)
