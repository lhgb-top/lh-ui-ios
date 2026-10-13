import SwiftUI
import LhUITokens
import LhUI

// 本文件是手写真源（非生成物）—— 预览排版工具与预览框，全文不出现色值/尺寸字面量。

/// 预览排版工具：行/列间距统一取令牌，预览内部只调它，不散写间距。
enum PreviewLayout {
  static let gap = LhTokens.Spacing.sm
  static let gapLarge = LhTokens.Spacing.md

  /// 纵向排列（左对齐），间距取 spacing.sm
  static func column<V: View>(@ViewBuilder _ items: () -> V) -> some View {
    VStack(alignment: .leading, spacing: gap) { items() }
  }

  /// 横向排列（居中），间距取 spacing.sm；超出宽度由内部换行逻辑兜底
  static func row<V: View>(@ViewBuilder _ items: () -> V) -> some View {
    HStack(spacing: gap) { items() }
  }

  /// 纵向排列，间距取 spacing.md（分组之间更宽松）
  static func columnGroup<V: View>(@ViewBuilder _ items: () -> V) -> some View {
    VStack(alignment: .leading, spacing: gapLarge) { items() }
  }
}

/// 预览小标题：场景内分组说明（次要正文色）
struct PreviewCaption: View {
  let text: String
  @Environment(\.colorScheme) private var scheme

  var body: some View {
    DocProse(text: text, secondary: true)
  }
}

/// 预览框：给真交互预览一块固定的「屏幕」区域。
///
/// 浮层组件（Dialog / Picker / Toast）在其内定位，宿主侧不再为预览单独开浮层——
/// 预览自包含，宿主拖入即用（对标 Android :docsui 的 SCENE 预览框）。
struct DocPreviewFrame<Content: View>: View {
  let title: String
  @ViewBuilder let content: Content

  @Environment(\.colorScheme) private var scheme
  @Environment(\.lhColors) private var colors

  /// 预览区最小高度：令牌派生（xxl * 6），保证浮层有展开空间
  static let minHeight = LhTokens.Spacing.xxl * 6

  var body: some View {
    VStack(alignment: .leading, spacing: DocPalette.cellPaddingY) {
      if !title.isEmpty {
        PreviewCaption(text: title)
      }
      content
        .frame(maxWidth: .infinity)
        .frame(minHeight: Self.minHeight)
        .padding(DocPalette.cardPadding)
        .background(
          RoundedRectangle(cornerRadius: DocPalette.cardRadius)
            .fill(colors.backgroundPage)
        )
        .overlay(
          RoundedRectangle(cornerRadius: DocPalette.cardRadius)
            .stroke(DocPalette.cardBorder(scheme), lineWidth: DocPalette.cardBorderWidth)
        )
    }
  }
}
