import SwiftUI
import LhUI
import LhUITokens

// 本文件是手写真源（非生成物）—— Cell 文档的真交互预览。
// SCENE_MAP：基本形态→basic、图标 / 必填 / 不可点击→iconRequiredAndClick。

enum CellPreviews {
  static func basic(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "标题 / 副标题 / 右侧值 / 分隔线") {
      PreviewLayout.column {
        LhCell(title: "标题文字", value: "右侧值")
        LhCell(title: "带副标题", label: "这是副标题说明文字")
        LhCell(title: "无分隔线", value: "值", bordered: false)
      }
    })
  }

  static func iconRequiredAndClick(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "icon 走 LhIconMap；required 显示红星；clickable 控制点击") {
      PreviewLayout.column {
        LhCell(title: "带图标", value: "设置", icon: "setting")
        LhCell(title: "必填项", required: true)
        LhCell(title: "可点击", value: "点击有反馈", clickable: true) {
          scope.showToast("点击了单元格")
        }
        LhCell(title: "不可点击（默认）", value: "点击无反馈", clickable: false) {
          scope.showToast("不该触发")
        }
      }
    })
  }
}
