import SwiftUI
import LhUI
import LhUITokens

// 本文件是手写真源（非生成物）—— Tag 文档的真交互预览。
// SCENE_MAP：类型→types、尺寸与圆角→sizesAndRadius、可关闭→closable。

enum TagPreviews {
  static func label(_ type: LhTagType) -> String {
    switch type {
    case .default: return "默认"
    case .primary: return "主要"
    case .success: return "成功"
    case .warning: return "警告"
    case .danger: return "危险"
    case .info: return "信息"
    }
  }

  static func types(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "六种语义类型（实底 / plain 浅底描边）") {
      PreviewLayout.column {
        PreviewLayout.row {
          ForEach(LhTagType.allCases, id: \.self) { type in
            LhTag(label(type), type: type)
          }
        }
        PreviewCaption(text: "plain 为 true 时为浅底描边形态")
        PreviewLayout.row {
          ForEach(LhTagType.allCases, id: \.self) { type in
            LhTag(label(type), type: type, plain: true)
          }
        }
      }
    })
  }

  static func sizesAndRadius(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "三种尺寸 × 直角 / 胶囊（round 取高度一半）") {
      PreviewLayout.column {
        ForEach(LhTagSize.allCases, id: \.self) { size in
          PreviewLayout.row {
            LhTag("\(size.rawValue)", type: .primary, size: size)
            LhTag("\(size.rawValue)", type: .primary, size: size, round: true)
          }
        }
      }
    })
  }

  static func closable(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "closable 显示关闭符，点击触发 onClose") {
      PreviewLayout.column {
        PreviewLayout.row {
          ForEach(LhTagType.allCases, id: \.self) { type in
            LhTag(label(type), type: type, closable: true) { scope.showToast("关闭了「\(label(type))」标签") }
          }
        }
        PreviewCaption(text: "onClose 只在点击关闭符时触发，点击标签本体不触发")
      }
    })
  }
}
