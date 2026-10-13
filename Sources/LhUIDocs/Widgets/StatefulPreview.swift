import SwiftUI

// 本文件是手写真源（非生成物）—— 有状态预览的通用载体。

/// 有状态预览载体：预览方法包一层即可在 SwiftUI 里持有可变状态。
///
/// 预览方法是 `static func`（生成页按 SCENE_MAP 引用），本身不能放 `@State`；
/// 交互类预览（表单值、显隐开关、选中态）用它持有初值，闭包里拿 `Binding` 驱动组件。
/// 多个状态用元组：`StatefulPreview(initial: (false, "a")) { $state in $state.0 }`
/// （Binding 的 dynamicMember 下标支持元组取值）。
struct StatefulPreview<State, Content: View>: View {
  @State private var value: State
  private let content: (Binding<State>) -> Content

  init(initial: State, @ViewBuilder content: @escaping (Binding<State>) -> Content) {
    self._value = State(initialValue: initial)
    self.content = content
  }

  var body: some View {
    content($value)
  }
}
