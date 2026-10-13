import XCTest
import SwiftUI
@testable import LhUI
import LhUITokens

/// 黄金用例翻译：`lh-ui-core/cases/cell.json` 的 6 条断言。
final class LhCellTests: XCTestCase {
  private let light = LightLhColors
  private let dark = DarkLhColors

  private func resolve(
    clickable: Bool = false,
    colors: LhColors
  ) -> LhCellAppearance {
    LhCellStyle.resolveAppearance(clickable: clickable, colors: colors)
  }

  // case: title-and-value-render —— 标题与值字号取标题/值字号令牌
  func testTitleAndValueUseFontTokens() {
    let a = resolve(colors: light)
    XCTAssertEqual(a.titleFontSize, LhTokens.Cell.fontSizeTitle)
    XCTAssertEqual(a.valueFontSize, LhTokens.Cell.fontSizeValue)
  }

  // case: label-renders-secondary-tone
  func testLabelRendersSecondaryTone() {
    let a = resolve(colors: light)
    XCTAssertEqual(a.labelColor, LhTokens.Color.Text.secondary, "说明文字 = color.text.secondary")
    XCTAssertEqual(a.labelFontSize, LhTokens.Cell.fontSizeLabel)
  }

  // case: required-uses-danger-token
  func testRequiredUsesDangerToken() {
    let a = resolve(colors: light)
    XCTAssertEqual(a.requiredColor, LhTokens.Color.Danger.`default`, "必填红星 = color.danger.default")
  }

  // case: bordered-emits-line-command —— 分隔线取 border.lighter + cell.borderWidth
  func testBorderedUsesBorderTokens() {
    let a = resolve(colors: light)
    XCTAssertEqual(a.borderColor, LhTokens.Color.Border.lighter, "分隔线 = color.border.lighter")
    XCTAssertEqual(a.borderWidth, LhTokens.Cell.borderWidth)
  }

  // case: clickable-emits-onclick
  func testClickableIsInteractive() {
    let a = resolve(clickable: true, colors: light)
    XCTAssertTrue(a.clickable, "clickable 为 true 时应响应点击")
  }

  // case: not-clickable-no-onclick
  func testNotClickableIsNotInteractive() {
    let a = resolve(clickable: false, colors: light)
    XCTAssertFalse(a.clickable, "clickable 为 false 时不应响应点击")
  }

  /// 内边距与间距取 cell 令牌（spec behaviors 的布局基线）
  func testLayoutUsesCellTokens() {
    let a = resolve(colors: light)
    XCTAssertEqual(a.paddingHorizontal, LhTokens.Cell.paddingHorizontal)
    XCTAssertEqual(a.paddingVertical, LhTokens.Cell.paddingVertical)
    XCTAssertEqual(a.gap, LhTokens.Cell.gap)
  }

  /// 图标尺寸取 icon.size.medium（spec：左侧图标尺寸为 icon.size.medium）
  func testIconSizeUsesIconToken() {
    let a = resolve(colors: light)
    XCTAssertEqual(a.iconSize, LhTokens.Icon.Size.medium)
  }

  /// 暗色色板必须逐字段取自 LhDarkTokens（并列对象模型，见 LhTheme 文档）
  func testDarkColorsComeFromDarkTokens() {
    let a = resolve(colors: dark)
    XCTAssertEqual(a.titleColor, LhDarkTokens.Color.Text.primary)
    XCTAssertEqual(a.labelColor, LhDarkTokens.Color.Text.secondary)
    XCTAssertEqual(a.borderColor, LhDarkTokens.Color.Border.lighter)
    XCTAssertEqual(a.requiredColor, LhDarkTokens.Color.Danger.`default`)
  }

  /// 尺寸令牌暗色不覆盖：明暗色板下尺寸应一致
  func testDimensionsAreIdenticalInDarkMode() {
    let l = resolve(colors: light)
    let d = resolve(colors: dark)
    XCTAssertEqual(l.titleFontSize, d.titleFontSize)
    XCTAssertEqual(l.paddingHorizontal, d.paddingHorizontal)
    XCTAssertEqual(l.borderWidth, d.borderWidth)
  }

  /// View 层渲染佐证（含全部可选 props）
  func testCellInitAndRender() {
    let cell = LhCell(
      title: "标题", value: "值", label: "说明", clickable: true,
      required: true, icon: "user"
    ) {}
    XCTAssertNotNil(cell.body)
  }
}
