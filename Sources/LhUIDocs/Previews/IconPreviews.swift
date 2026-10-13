import SwiftUI
import LhUI
import LhUITokens

// 本文件是手写真源（非生成物）—— Icon 文档的真交互预览。
// SCENE_MAP：色调→tone、尺寸→sizes、图标名映射→iconNames。

enum IconPreviews {
  static func toneLabel(_ tone: LhIconTone) -> String {
    switch tone {
    case .default: return "默认"
    case .primary: return "主要"
    case .success: return "成功"
    case .warning: return "警告"
    case .danger: return "危险"
    case .info: return "信息"
    case .regular: return "常规文字"
    case .secondary: return "次要文字"
    }
  }

  static func tone(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "色调（tone 映射语义色）") {
      PreviewLayout.column {
        PreviewLayout.row {
          ForEach(LhIconTone.allCases, id: \.self) { tone in
            LhIcon(name: "star", tone: tone, onClick: { scope.showToast("\(toneLabel(tone)) 色调图标") })
          }
        }
        PreviewCaption(text: "未登记的图标名返回 nil，调用方不绘制、不崩溃")
        LhIcon(name: "not-a-registered-icon", onClick: { scope.showToast("不会触发") })
      }
    })
  }

  static func sizes(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "三种尺寸（icon.size 令牌）") {
      PreviewLayout.column {
        ForEach(LhIconSize.allCases, id: \.self) { size in
          PreviewLayout.row {
            LhIcon(name: "search", size: size, onClick: { scope.showToast("点击了 \(size.rawValue) 号图标") })
            PreviewCaption(text: "\(size.rawValue)（\(sizeLabel(size))）")
          }
        }
      }
    })
  }

  static func sizeLabel(_ size: LhIconSize) -> String {
    switch size {
    case .small: return "16pt"
    case .medium: return "20pt（默认）"
    case .large: return "24pt"
    }
  }

  static func iconNames(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "已登记图标名（点击图标把名字送到 Toast）") {
      LazyVGrid(
        columns: Array(repeating: GridItem(.flexible(), alignment: .center), count: 4),
        spacing: LhTokens.Spacing.md
      ) {
        ForEach(LhIconMap.names, id: \.self) { name in
          IconNameCell(name: name, scope: scope)
        }
      }
    })
  }
}

/// 图标名单元格：图标 + 名字（名字色取 docs 令牌，故需 colorScheme）
private struct IconNameCell: View {
  let name: String
  let scope: DocPreviewScope
  @Environment(\.colorScheme) private var scheme

  var body: some View {
    Button {
      scope.showToast("图标名：\(name)")
    } label: {
      VStack(spacing: LhTokens.Spacing.xs) {
        LhIcon(name: name)
        Text(name)
          .font(.system(size: DocPalette.codeFontSize, design: .monospaced))
          .foregroundColor(DocPalette.proseSecondary(scheme))
      }
    }
    .buttonStyle(.plain)
  }
}
