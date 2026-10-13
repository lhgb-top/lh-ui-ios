import SwiftUI
import LhUI
import LhUITokens

// 本文件是手写真源（非生成物）—— Navbar 文档的真交互预览。
// SCENE_MAP：基本形态→basic、图标与边框→iconAndBorder、点击 gate→clickGate。

enum NavbarPreviews {
  static func basic(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "标题水平居中；左侧返回出栈（宿主侧由调用方管理栈）") {
      PreviewLayout.column {
        LhNavbar(title: "页面标题", bordered: true)
        LhNavbar(title: "无分隔线", bordered: false)
        PreviewCaption(text: "高度、内边距、字号均取 navbar 令牌，悬浮定位由调用方用 .overlay 挂载")
      }
    })
  }

  static func iconAndBorder(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "左侧图标 + 右侧文字（两者可同时显示）") {
      PreviewLayout.column {
        LhNavbar(
          title: "带两侧内容",
          leftText: "返回",
          leftIcon: "arrow-left",
          rightText: "更多",
          bordered: true,
          onLeftClick: { scope.showToast("点击了左侧返回") },
          onRightClick: { scope.showToast("点击了右侧更多") }
        )
        LhNavbar(
          title: "仅右侧",
          rightIcon: "setting",
          rightText: "设置",
          bordered: false,
          onRightClick: { scope.showToast("点击了右侧设置") }
        )
      }
    })
  }

  static func clickGate(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "左/右无内容时不响应点击（no-left-content-no-onleftclick）") {
      PreviewLayout.column {
        LhNavbar(
          title: "两侧都空",
          bordered: true,
          onLeftClick: { scope.showToast("左侧不该响应") },
          onRightClick: { scope.showToast("右侧不该响应") }
        )
        PreviewCaption(text: "无内容时左侧占位为零尺寸，标题仍居中；有内容时整块区域可点")
        LhNavbar(
          title: "仅左侧可点",
          leftText: "返回",
          onLeftClick: { scope.showToast("点击了左侧返回") },
          onRightClick: { scope.showToast("右侧不该响应") }
        )
      }
    })
  }
}
