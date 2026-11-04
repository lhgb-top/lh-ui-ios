import SwiftUI
import LhUI
import LhUITokens

// 本文件是手写真源（非生成物）—— Text 文档的真交互预览。
// SCENE_MAP：字号级别→levels、字重→weight、色调→tone、对齐与行高→align。

enum TextPreviews {
  static func levels(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "六档字号映射 typography.fontSize.<level> 令牌") {
      PreviewLayout.column {
        ForEach(LhTextLevel.allCases, id: \.self) { level in
          LhText(level.rawValue, level: level)
        }
        PreviewCaption(text: "行高始终取 typography.lineHeight.primary（字号 × 1.8）")
      }
    })
  }

  static func weight(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "两档字重映射 typography.fontWeight.<weight> 令牌") {
      PreviewLayout.column {
        LhText("primary（默认，400）")
        LhText("bold（600）", weight: .bold)
      }
    })
  }

  static func tone(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "六种色调映射 color.text.<tone>；selected 取 color.selected") {
      PreviewLayout.column {
        ForEach(LhTextTone.allCases, id: \.self) { tone in
          LhText(tone.rawValue, tone: tone)
        }
      }
    })
  }

  static func align(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "lhAlign 在行盒宽度内对齐") {
      PreviewLayout.column {
        LhText("start（默认）", lhAlign: .start)
        LhText("center", lhAlign: .center)
        LhText("end", lhAlign: .end)
      }
    })
  }
}
