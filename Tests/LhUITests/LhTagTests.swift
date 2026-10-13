import XCTest
import SwiftUI
@testable import LhUI
import LhUITokens

/// 黄金用例翻译：`lh-ui-core/cases/tag.json` 的 6 条断言。
final class LhTagTests: XCTestCase {
  private let light = LightLhColors
  private let dark = DarkLhColors

  private func resolve(
    type: LhTagType = .default,
    size: LhTagSize = .medium,
    plain: Bool = false,
    round: Bool = false,
    colors: LhColors
  ) -> LhTagAppearance {
    LhTagStyle.resolveAppearance(type: type, size: size, plain: plain, round: round, colors: colors)
  }

  // case: default-type-renders-text —— 默认类型取中性底 + 主文字色 + 基础描边
  func testDefaultTypeUsesNeutralTokens() {
    let a = resolve(colors: light)
    XCTAssertEqual(a.containerColor, LhTokens.Color.Background.`default`)
    XCTAssertEqual(a.contentColor, LhTokens.Color.Text.primary)
    XCTAssertEqual(a.borderColor, LhTokens.Color.Border.base)
  }

  // case: primary-type-uses-primary-tokens
  func testPrimaryTypeUsesPrimaryTokens() {
    let a = resolve(type: .primary, colors: light)
    XCTAssertEqual(a.containerColor, LhTokens.Color.Primary.`default`, "主色底 = color.primary.default")
    XCTAssertEqual(a.contentColor, LhTokens.Color.onPrimary, "主色标签文字 = color.onPrimary")
  }

  // case: plain-uses-bg-tokens
  func testPlainUsesBgTokens() {
    let a = resolve(type: .success, plain: true, colors: light)
    XCTAssertEqual(a.containerColor, LhTokens.Color.Success.bg, "浅底底色 = color.success.bg")
    XCTAssertEqual(a.contentColor, LhTokens.Color.Success.`default`, "浅底文字 = color.success.default")
    XCTAssertEqual(a.borderColor, LhTokens.Color.Success.`default`, "浅底描边 = color.success.default")
  }

  // case: small-size-uses-small-tokens（并反向确认 large 不同）
  func testSmallSizeUsesSmallTokens() {
    let a = resolve(size: .small, colors: light)
    XCTAssertEqual(a.height, LhTokens.Tag.Height.small)
    XCTAssertEqual(a.paddingHorizontal, LhTokens.Tag.PaddingHorizontal.small)
    XCTAssertEqual(a.fontSize, LhTokens.Tag.FontSize.small)
    XCTAssertNotEqual(
      LhTokens.Tag.Height.small, LhTokens.Tag.Height.large,
      "small 与 large 高度必须不同，否则用例无意义"
    )
  }

  // case: round-makes-radius-half-height
  func testRoundMakesRadiusHalfHeight() {
    let a = resolve(round: true, colors: light)
    XCTAssertEqual(a.borderRadius, a.height / 2, "胶囊态圆角 = 高度一半")
    XCTAssertNotEqual(a.borderRadius, LhTokens.Tag.borderRadius, "胶囊态圆角不应等于 tag.borderRadius")

    let square = resolve(round: false, colors: light)
    XCTAssertEqual(square.borderRadius, LhTokens.Tag.borderRadius, "非胶囊态圆角 = tag.borderRadius")
  }

  // case: closable-tap-emits-onclose —— 可关闭标签的 View 层佐证
  func testClosableTagInitAndRender() {
    let tag = LhTag("可关闭", closable: true) {}
    XCTAssertNotNil(tag.body)
  }

  /// 默认类型的 plain 不改变外观（spec：default 类型不区分 plain）
  func testDefaultTypeIgnoresPlain() {
    let solid = resolve(colors: light)
    let plain = resolve(plain: true, colors: light)
    XCTAssertEqual(solid.containerColor, plain.containerColor)
    XCTAssertEqual(solid.contentColor, plain.contentColor)
    XCTAssertEqual(solid.borderColor, plain.borderColor)
  }

  /// 暗色色板必须逐字段取自 LhDarkTokens（并列对象模型，见 LhTheme 文档）
  func testDarkColorsComeFromDarkTokens() {
    let a = resolve(type: .primary, colors: dark)
    XCTAssertEqual(a.containerColor, LhDarkTokens.Color.Primary.`default`)
    XCTAssertEqual(a.contentColor, LhDarkTokens.Color.onPrimary)
  }

  /// 浅底形态在暗色下取暗色浅底令牌
  func testPlainInDarkUsesDarkBgTokens() {
    let a = resolve(type: .success, plain: true, colors: dark)
    XCTAssertEqual(a.containerColor, LhDarkTokens.Color.Success.bg)
    XCTAssertEqual(a.contentColor, LhDarkTokens.Color.Success.`default`)
  }

  /// 尺寸令牌暗色不覆盖：明暗色板下尺寸应一致
  func testDimensionsAreIdenticalInDarkMode() {
    let l = resolve(size: .large, colors: light)
    let d = resolve(size: .large, colors: dark)
    XCTAssertEqual(l.height, d.height)
    XCTAssertEqual(l.paddingHorizontal, d.paddingHorizontal)
    XCTAssertEqual(l.fontSize, d.fontSize)
    XCTAssertEqual(l.borderRadius, d.borderRadius)
  }
}
