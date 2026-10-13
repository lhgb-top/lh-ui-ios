import SwiftUI

// 本文件是手写真源（非生成物）—— 绑定工具。

extension Binding {
  /// 从数组绑定拆出元素绑定。
  ///
  /// 等价于 SwiftUI 惯用的 `$array[index]`，但多尺寸预览里显式写法不依赖
  /// `Binding` 的下标推断，意图更清楚（索引越界由调用方保证，预览内索引来自枚举）。
  func element(_ index: Value.Index) -> Binding<Value.Element> where Value: MutableCollection {
    Binding(
      get: { wrappedValue[index] },
      set: { wrappedValue[index] = $0 }
    )
  }
}
