import XCTest
import SwiftUI
@testable import LhUI
import LhUITokens

/// 黄金用例翻译：`lh-ui-core/cases/text.json` 的 5 条断言。
final class LhTextTests: XCTestCase {
  private let light = LightLhColors
  private let dark = DarkLhColors

  private func resolve(
    level: LhTextLevel = .base,
    weight: LhTextWeight = .primary,
    tone: LhTextTone = .primary,
    colors: LhColors
  ) -> LhTextAppearance {
    LhTextStyle.resolveAppearance(level: level, weight: weight, tone: tone, colors: colors)
  }

  // case: default-level-uses-base-tokens —— 默认级别消费 base 排版令牌
  func testDefaultLevelUsesBaseTokens() {
    let a = resolve(colors: light)
    XCTAssertEqual(a.fontSize, LhTokens.Typography.FontSize.base, "默认字号 = typography.fontSize.base")
    XCTAssertEqual(a.fontWeight, LhTokens.Typography.FontWeight.primary, "默认字重 = typography.fontWeight.primary")
    XCTAssertEqual(a.textColor, LhTokens.Color.Text.primary, "默认文字色 = color.text.primary")
    XCTAssertEqual(
      a.lineHeight,
      LhTokens.Typography.FontSize.base * CGFloat(LhTokens.Typography.LineHeight.primary),
      "默认行高 = 字号 × typography.lineHeight.primary"
    )
  }

  // case: large-level-uses-large-token（反向断言 base 未应用）
  func testLargeLevelUsesLargeToken() {
    let a = resolve(level: .large, colors: light)
    XCTAssertEqual(a.fontSize, LhTokens.Typography.FontSize.large, "大字号 = typography.fontSize.large")
    XCTAssertNotEqual(a.fontSize, LhTokens.Typography.FontSize.base, "base 字号未应用")
  }

  // case: bold-weight-uses-bold-token（反向断言 primary 未应用）
  func testBoldWeightUsesBoldToken() {
    let a = resolve(weight: .bold, colors: light)
    XCTAssertEqual(a.fontWeight, LhTokens.Typography.FontWeight.bold, "粗体字重 = typography.fontWeight.bold")
    XCTAssertNotEqual(a.fontWeight, LhTokens.Typography.FontWeight.primary, "primary 字重未应用")
  }

  // case: secondary-tone-uses-text-secondary
  func testSecondaryToneUsesTextSecondary() {
    let a = resolve(tone: .secondary, colors: light)
    XCTAssertEqual(a.textColor, LhTokens.Color.Text.secondary, "次要文字色 = color.text.secondary")
    XCTAssertNotEqual(a.textColor, LhTokens.Color.Text.primary, "color.text.primary 未应用")
  }

  /// 全部色调逐条覆盖（spec behaviors 的 tone 映射；selected 取 color.selected）
  func testAllTonesMapToTheirTokens() {
    XCTAssertEqual(resolve(tone: .regular, colors: light).textColor, LhTokens.Color.Text.regular)
    XCTAssertEqual(resolve(tone: .placeholder, colors: light).textColor, LhTokens.Color.Text.placeholder)
    XCTAssertEqual(resolve(tone: .disabled, colors: light).textColor, LhTokens.Color.Text.disabled)
    // selected 取 color.selected 而非 color.text.*
    XCTAssertEqual(resolve(tone: .selected, colors: light).textColor, LhTokens.Color.selected)
    XCTAssertNotEqual(
      resolve(tone: .selected, colors: light).textColor,
      LhTokens.Color.Text.primary,
      "selected 不应回落到 text.primary"
    )
  }

  /// 全部级别逐条覆盖（spec behaviors 的 level 映射）
  func testAllLevelsUseTheirTokens() {
    let expected: [(LhTextLevel, CGFloat)] = [
      (.extraLarge, LhTokens.Typography.FontSize.extraLarge),
      (.large, LhTokens.Typography.FontSize.large),
      (.medium, LhTokens.Typography.FontSize.medium),
      (.base, LhTokens.Typography.FontSize.base),
      (.small, LhTokens.Typography.FontSize.small),
      (.extraSmall, LhTokens.Typography.FontSize.extraSmall),
    ]
    for (level, size) in expected {
      XCTAssertEqual(resolve(level: level, colors: light).fontSize, size, "level=\(level.rawValue)")
    }
  }

  /// 行高始终 = 字号 × typography.lineHeight.primary，随级别缩放
  func testLineHeightScalesWithLevel() {
    for level in LhTextLevel.allCases {
      let a = resolve(level: level, colors: light)
      XCTAssertEqual(
        a.lineHeight,
        a.fontSize * CGFloat(LhTokens.Typography.LineHeight.primary),
        "lineHeight(\(level.rawValue)) = fontSize × lineHeight.primary"
      )
    }
  }

  /// 暗色主题下文字色取暗色色板
  func testDarkToneUsesDarkColors() {
    let a = resolve(tone: .primary, colors: dark)
    XCTAssertEqual(a.textColor, dark.textPrimary)
    XCTAssertNotEqual(a.textColor, light.textPrimary)
  }

  /// 排版令牌（字号/行高/字重）在明暗色板下一致
  func testTypographyIsIdenticalInDarkMode() {
    let l = resolve(colors: light)
    let d = resolve(colors: dark)
    XCTAssertEqual(l.fontSize, d.fontSize)
    XCTAssertEqual(l.lineHeight, d.lineHeight)
    XCTAssertEqual(l.fontWeight, d.fontWeight)
  }

  /// View 层佐证：默认初始化可渲染
  func testTextInitAndRender() {
    let text = LhText("水墨")
    XCTAssertNotNil(text.body)
  }
}
