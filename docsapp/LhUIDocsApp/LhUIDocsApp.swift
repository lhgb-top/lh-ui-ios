import SwiftUI
import LhUIDocs

// 极薄打包壳（对标 lh-ui-android 的 :docsapp 模块：一个 LAUNCHER Activity 直接
// setContent { LhDocsContent() }）。本 App 的唯一职责是把 LhUIDocs 库的文档宿主
// 装进一个可 Run / 可 Archive 的 iOS App 壳；全部内容由 LhDocsView 自管
// （自管返回栈 + LhNavbar dogfood + 明暗切换 + 全局 Toast）。

@main
struct LhUIDocsApp: App {
  var body: some Scene {
    WindowGroup {
      LhDocsView()
    }
  }
}
