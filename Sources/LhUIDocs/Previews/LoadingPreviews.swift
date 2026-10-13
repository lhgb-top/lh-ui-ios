import SwiftUI
import LhUI
import LhUITokens

// 本文件是手写真源（非生成物）—— Loading 文档的真交互预览。
// SCENE_MAP：色调→tone、尺寸→sizes、静态帧→staticFrame。

enum LoadingPreviews {
  static func toneLabel(_ tone: LhLoadingTone) -> String {
    switch tone {
    case .primary: return "主要"
    case .success: return "成功"
    case .warning: return "警告"
    case .danger: return "危险"
    case .info: return "信息"
    }
  }

  static func tone(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "五种色调（语义色）") {
      PreviewLayout.column {
        ForEach(LhLoadingTone.allCases, id: \.self) { tone in
          PreviewLayout.row {
            LhLoading(tone: tone)
            PreviewCaption(text: toneLabel(tone))
          }
        }
      }
    })
  }

  static func sizes(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "三种尺寸（loading.size 令牌）") {
      PreviewLayout.column {
        ForEach(LhLoadingSize.allCases, id: \.self) { size in
          PreviewLayout.row {
            LhLoading(size: size, tone: .primary)
            PreviewCaption(text: "\(size.rawValue)")
          }
        }
      }
    })
  }

  static func staticFrame(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "animating 为 false 时停在静态帧（截图/静态文档用）") {
      PreviewLayout.column {
        ForEach(LhLoadingTone.allCases, id: \.self) { tone in
          PreviewLayout.row {
            LhLoading(tone: tone, animating: false)
            PreviewCaption(text: "\(toneLabel(tone))（静态）")
          }
        }
      }
    })
  }
}
