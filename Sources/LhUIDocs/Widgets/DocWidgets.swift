import SwiftUI
import LhUITokens

// 本文件是手写真源（非生成物）—— 文档构件与取色别名，全文不出现色值/尺寸字面量。

/// 文档明暗取色别名：docs 令牌的暗色只覆盖颜色（尺寸回退明色），统一在此按
/// `colorScheme` 解析。与 Windows 端 `DocPalette` / Android 端同名别名同构。
enum DocPalette {
  static func cardBackground(_ scheme: ColorScheme) -> Color {
    scheme == .dark ? LhDarkTokens.Docs.Card.background : LhTokens.Docs.Card.background
  }
  static func cardBorder(_ scheme: ColorScheme) -> Color {
    scheme == .dark ? LhDarkTokens.Docs.Card.borderColor : LhTokens.Docs.Card.borderColor
  }
  static let cardRadius = LhTokens.Docs.Card.borderRadius
  static let cardBorderWidth = LhTokens.Docs.Card.borderWidth
  static let cardPadding = LhTokens.Docs.Card.padding

  static func codeBackground(_ scheme: ColorScheme) -> Color {
    scheme == .dark ? LhDarkTokens.Docs.Code.background : LhTokens.Docs.Code.background
  }
  static func codeText(_ scheme: ColorScheme) -> Color {
    scheme == .dark ? LhDarkTokens.Docs.Code.textColor : LhTokens.Docs.Code.textColor
  }
  static let codeRadius = LhTokens.Docs.Code.borderRadius
  static let codeFontSize = LhTokens.Docs.Code.fontSize
  static let codePaddingX = LhTokens.Docs.Code.paddingX
  static let codePaddingY = LhTokens.Docs.Code.paddingY

  static func headingColor(_ scheme: ColorScheme) -> Color {
    scheme == .dark ? LhDarkTokens.Docs.Heading.color : LhTokens.Docs.Heading.color
  }
  static func headingFontSize(level: Int) -> CGFloat {
    switch level {
    case 1: return LhTokens.Docs.Heading.fontSizeH1
    case 2: return LhTokens.Docs.Heading.fontSizeH2
    default: return LhTokens.Docs.Heading.fontSizeH3
    }
  }

  static func proseText(_ scheme: ColorScheme) -> Color {
    scheme == .dark ? LhDarkTokens.Docs.Prose.textColor : LhTokens.Docs.Prose.textColor
  }
  static func proseSecondary(_ scheme: ColorScheme) -> Color {
    scheme == .dark ? LhDarkTokens.Docs.Prose.secondaryColor : LhTokens.Docs.Prose.secondaryColor
  }
  static let proseFontSize = LhTokens.Docs.Prose.fontSize

  static func tableBorder(_ scheme: ColorScheme) -> Color {
    scheme == .dark ? LhDarkTokens.Docs.Table.borderColor : LhTokens.Docs.Table.borderColor
  }
  static func tableHeaderBg(_ scheme: ColorScheme) -> Color {
    scheme == .dark ? LhDarkTokens.Docs.Table.headerBg : LhTokens.Docs.Table.headerBg
  }
  static func tableHeaderText(_ scheme: ColorScheme) -> Color {
    scheme == .dark ? LhDarkTokens.Docs.Table.headerTextColor : LhTokens.Docs.Table.headerTextColor
  }
  static let tableBorderWidth = LhTokens.Docs.Table.borderWidth
  static let cellPaddingX = LhTokens.Docs.Table.cellPaddingX
  static let cellPaddingY = LhTokens.Docs.Table.cellPaddingY
  static let tableFontSize = LhTokens.Docs.Table.fontSize
}

/// 把 md 行内反引号 `token` 渲染为等宽字形，其余为正文字体
private struct InlineText: View {
  let text: String
  let fontSize: CGFloat
  let color: Color

  var body: some View {
    // 以反引号分段：奇数段是代码，偶数段是正文（未闭合的尾段按正文处理）
    let parts = text.split(separator: "`", omittingEmptySubsequences: false)
    parts.enumerated().reduce(Text(""), { acc, part in
      let isCode = part.offset % 2 == 1
      let segment = Text(String(part.element))
      if isCode {
        return acc + segment.font(.system(size: DocPalette.codeFontSize, design: .monospaced))
          .foregroundColor(DocPalette.codeText(colorScheme))
      }
      return acc + segment.font(.system(size: fontSize)).foregroundColor(color)
    })
    // 注意：Text 拼接的 foregroundColor 需逐段施加（上面已分段着色）
  }

  @Environment(\.colorScheme) private var colorScheme
}

/// 文档标题（level 1/2/3 对应 H1/H2/H3 字号令牌）
struct DocHeading: View {
  let text: String
  let level: Int

  var body: some View {
    Text(text)
      .font(.system(size: DocPalette.headingFontSize(level: level), weight: .bold))
      .foregroundColor(DocPalette.headingColor(scheme))
      .frame(maxWidth: .infinity, alignment: .leading)
  }

  @Environment(\.colorScheme) private var scheme
}

/// 文档正文（支持行内反引号；secondary 为次要说明色）
struct DocProse: View {
  let text: String
  var secondary: Bool = false

  var body: some View {
    InlineText(
      text: text,
      fontSize: DocPalette.proseFontSize,
      color: secondary ? DocPalette.proseSecondary(scheme) : DocPalette.proseText(scheme)
    )
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  @Environment(\.colorScheme) private var scheme
}

/// 分隔线
struct DocDivider: View {
  var body: some View {
    Rectangle()
      .fill(DocPalette.cardBorder(scheme))
      .frame(height: DocPalette.cardBorderWidth)
  }

  @Environment(\.colorScheme) private var scheme
}

/// 卡片：承载预览框或任意内容
struct DocCard<Content: View>: View {
  @ViewBuilder let content: Content

  var body: some View {
    content
      .padding(DocPalette.cardPadding)
      .background(
        RoundedRectangle(cornerRadius: DocPalette.cardRadius)
          .fill(DocPalette.cardBackground(scheme))
          .overlay(
            RoundedRectangle(cornerRadius: DocPalette.cardRadius)
              .stroke(DocPalette.cardBorder(scheme), lineWidth: DocPalette.cardBorderWidth)
          )
      )
  }

  @Environment(\.colorScheme) private var scheme
}

/// 代码块：等宽字体、代码底色，逐行渲染
struct DocCodeBlock: View {
  let lines: [String]

  var body: some View {
    VStack(alignment: .leading, spacing: DocPalette.codePaddingY / 2) {
      ForEach(Array(lines.enumerated()), id: \.offset) { _, line in
        Text(line.isEmpty ? " " : line)
          .font(.system(size: DocPalette.codeFontSize, design: .monospaced))
          .foregroundColor(DocPalette.codeText(scheme))
          .frame(maxWidth: .infinity, alignment: .leading)
          .textSelection(.enabled)
      }
    }
    .padding(.horizontal, DocPalette.codePaddingX)
    .padding(.vertical, DocPalette.codePaddingY)
    .background(
      RoundedRectangle(cornerRadius: DocPalette.codeRadius)
        .fill(DocPalette.codeBackground(scheme))
    )
  }

  @Environment(\.colorScheme) private var scheme
}

/// 表格：表头底色 + 分割线，单元格内联反引号同样渲染为等宽字形
struct DocTableView: View {
  let table: DocTable

  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      if !table.title.isEmpty {
        DocProse(text: table.title, secondary: true)
          .padding(.bottom, DocPalette.cellPaddingY)
      }

      // 表头
      HStack(spacing: 0) {
        ForEach(Array(table.headers.enumerated()), id: \.offset) { _, header in
          InlineText(
            text: header,
            fontSize: DocPalette.tableFontSize,
            color: DocPalette.tableHeaderText(scheme)
          )
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal, DocPalette.cellPaddingX)
          .padding(.vertical, DocPalette.cellPaddingY)
          .background(DocPalette.tableHeaderBg(scheme))
        }
      }

      // 数据行
      ForEach(Array(table.rows.enumerated()), id: \.offset) { _, row in
        HStack(spacing: 0) {
          ForEach(Array(row.cells.enumerated()), id: \.offset) { _, cell in
            InlineText(
              text: cell,
              fontSize: DocPalette.tableFontSize,
              color: DocPalette.proseText(scheme)
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, DocPalette.cellPaddingX)
            .padding(.vertical, DocPalette.cellPaddingY)
          }
        }
        .overlay(
          Rectangle()
            .fill(DocPalette.tableBorder(scheme))
            .frame(height: DocPalette.tableBorderWidth),
          alignment: .top
        )
      }
    }
    .overlay(
      RoundedRectangle(cornerRadius: DocPalette.cardRadius)
        .stroke(DocPalette.tableBorder(scheme), lineWidth: DocPalette.tableBorderWidth)
    )
    .clipShape(RoundedRectangle(cornerRadius: DocPalette.cardRadius))
  }

  @Environment(\.colorScheme) private var scheme
}
