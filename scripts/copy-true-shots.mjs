/**
 * 真渲染对照图拷贝（总纲 D21 / A0）。
 *
 * iOS 仓的组件示例第一现场是 SwiftUI 的 #Preview（各组件目录下的 Lh<Comp>Previews.swift），
 * 真机/模拟器实拍图存放在仓根 test-shots/（<章节>-{light,dark}.png，命名与各组件文档页
 * 的演示章节一一对应）。本脚本把实拍图拷进 docs 树（docs/true/），供文档页以
 * <figure class="sim-true"> 并排展示「HTML 模拟 vs 真渲染」，明/暗双图随站点主题自动切换。
 *
 * 为什么走 docs/true/ 而非 docs/public：VitePress 对 md 里相对路径引用的常规资源会
 * 在构建期自动加 base 前缀，public 目录的绝对路径需要自行拼 base，容易在
 * /lhui/ios/ 部署形态下失效。
 *
 * docs:dev / docs:build 前随 gen:sim 之后自动执行。
 */

import { cpSync, existsSync, mkdirSync, readdirSync } from 'node:fs'
import { resolve } from 'node:path'

const REPO_ROOT = resolve(import.meta.dirname, '..')
const SRC = resolve(REPO_ROOT, 'test-shots')
const OUT = resolve(REPO_ROOT, 'docs', 'true')

function main() {
  if (!existsSync(SRC)) {
    console.error(
      `❌ 未找到真机实拍图目录：${SRC}\n` +
        '请先在 Xcode 跑 #Preview / 模拟器截图，输出到仓根 test-shots/（<章节>-{light,dark}.png）。',
    )
    process.exitCode = 1
    return
  }

  mkdirSync(OUT, { recursive: true })
  let count = 0
  for (const file of readdirSync(SRC)
    .sort()
    .filter((f) => f.endsWith('.png'))) {
    cpSync(resolve(SRC, file), resolve(OUT, file))
    count++
  }
  console.log(`✅ 真渲染对照图已拷贝：${count} 张 test-shots/*.png → docs/true/`)
}

main()
