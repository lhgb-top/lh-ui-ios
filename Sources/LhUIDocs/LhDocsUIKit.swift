// 本文件是手写真源（非生成物）—— UIKit 宿主嵌入桥（对标 Android LhDocs.launch(context)）。
//
// SwiftUI 宿主直接放 LhDocsView() 即可；UIKit 宿主没有 View 树入口，这里提供一个
// UIViewController 子类，一行 present 即得完整文档界面。
//
// canImport(UIKit) 门控：macOS 宿主（swift build / swift test 的黄金用例环境）
// 整文件跳过；只有 iOS 构建（如 docsapp）编译本桥。因此本桥的编译验证只能
// 在 iOS 构建里完成（见 AGENTS gotcha）。

#if canImport(UIKit)
import SwiftUI
import UIKit

/// UIKit 宿主的文档入口：装着完整 `LhDocsView` 的托管控制器。
///
/// 用法（对标 Android `LhDocs.launch(context)`）：
/// ```swift
/// present(LhDocsViewController(), animated: true)
/// ```
///
/// 内部外观全部由 `LhDocsView` 自管（返回栈、明暗切换、全局 Toast），
/// 宿主无需任何配置。
@MainActor
public final class LhDocsViewController: UIHostingController<LhDocsView> {
  /// 无参入口：内部构造默认的 `LhDocsView()`。
  /// 注意：`init(coder:)` 从父类继承（UIKit 内部即禁用 Storyboard 初始化），
  /// 本类只允许通过 `init()` 构造。
  public convenience init() {
    self.init(rootView: LhDocsView())
  }
}
#endif
