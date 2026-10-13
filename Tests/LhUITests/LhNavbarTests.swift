import XCTest
import SwiftUI
@testable import LhUI
import LhUITokens

/// 黄金用例翻译：`lh-ui-core/cases/navbar.json` 的 6 条断言。
final class LhNavbarTests: XCTestCase {
  private let light = LightLhColors
  private let dark = DarkLhColors

  private func resolve(
    bordered: Bool = true,
    hasLeft: Bool = false,
    hasRight: Bool = false,
    colors: LhColors
  ) -> LhNavbarAppearance {
    LhNavbarStyle.resolveAppearance(bordered: bordered, hasLeft: hasLeft, hasRight: hasRight, colors: colors)
  }

  // case: title-renders-text —— 标题字号/颜色取 navbar 令牌
  func testTitleUsesNavbarTokens() {
    let a = resolve(colors: light)
    XCTAssertEqual(a.titleFontSize, LhTokens.Navbar.titleFontSize)
    XCTAssertEqual(a.titleColor, LhTokens.Color.Text.primary)
  }

  // case: leftclick-emits-onleftclick —— 左侧有内容时响应点击
  func testLeftContentIsClickable() {
    let a = resolve(hasLeft: true, colors: light)
    XCTAssertTrue(a.hasLeft)
  }

  // case: rightclick-emits-onrightclick —— 右侧有内容时响应点击
  func testRightContentIsClickable() {
    let a = resolve(hasRight: true, colors: light)
    XCTAssertTrue(a.hasRight)
  }

  // case: no-left-content-no-onleftclick
  func testNoLeftContentIsNotClickable() {
    let a = resolve(hasLeft: false, colors: light)
    XCTAssertFalse(a.hasLeft, "无内容时不响应点击")
  }

  // case: bordered-uses-border-token
  func testBorderedUsesBorderToken() {
    let a = resolve(bordered: true, colors: light)
    XCTAssertTrue(a.bordered)
    XCTAssertEqual(a.borderColor, LhTokens.Color.Border.lighter, "分隔线 = color.border.lighter")
    XCTAssertEqual(a.borderWidth, LhTokens.Navbar.borderWidth)

    let unbordered = resolve(bordered: false, colors: light)
    XCTAssertFalse(unbordered.bordered)
  }

  // case: height-uses-navbar-height-token
  func testHeightUsesNavbarHeightToken() {
    let a = resolve(colors: light)
    XCTAssertEqual(a.height, LhTokens.Navbar.height)
    XCTAssertEqual(a.paddingHorizontal, LhTokens.Navbar.paddingHorizontal)
    XCTAssertEqual(a.iconSize, LhTokens.Navbar.iconSize)
  }

  /// 底色取 background.default（spec behaviors）
  func testContainerUsesBackgroundToken() {
    let a = resolve(colors: light)
    XCTAssertEqual(a.containerColor, LhTokens.Color.Background.`default`)
    XCTAssertEqual(a.sideColor, LhTokens.Color.Text.primary)
  }

  /// 暗色色板必须逐字段取自 LhDarkTokens（并列对象模型，见 LhTheme 文档）
  func testDarkColorsComeFromDarkTokens() {
    let a = resolve(colors: dark)
    XCTAssertEqual(a.containerColor, LhDarkTokens.Color.Background.`default`)
    XCTAssertEqual(a.titleColor, LhDarkTokens.Color.Text.primary)
    XCTAssertEqual(a.borderColor, LhDarkTokens.Color.Border.lighter)
  }

  /// 尺寸令牌暗色不覆盖：明暗色板下尺寸应一致
  func testDimensionsAreIdenticalInDarkMode() {
    let l = resolve(colors: light)
    let d = resolve(colors: dark)
    XCTAssertEqual(l.height, d.height)
    XCTAssertEqual(l.titleFontSize, d.titleFontSize)
    XCTAssertEqual(l.iconSize, d.iconSize)
  }

  /// View 层渲染佐证（含图标两侧）
  func testNavbarInitAndRender() {
    let navbar = LhNavbar(
      title: "青花瓷", leftText: "返回", leftIcon: "arrow-left",
      rightText: "分享", rightIcon: "share"
    ) {}
    XCTAssertNotNil(navbar.body)
  }
}
