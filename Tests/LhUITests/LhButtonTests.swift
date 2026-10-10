import XCTest
import SwiftUI
@testable import LhUI
import LhUITokens

/// 黄金用例翻译：`lh-ui-core/cases/button.json` 的 8 条断言。
///
/// cases.then.tokens（「某令牌是否被应用」）在此断言为「解析后的外观值 == 生成令牌的值」——
/// 只要 resolveAppearance 的返回取自令牌对象，映射即成立。这样黄金用例可以在
/// 无模拟器的 macOS 宿主环境跑（交互类 gate 也走 appearance.enabled 纯断言，
/// 真机交互验证见后续 UI 自动化）。
final class LhButtonTests: XCTestCase {
  private let light = LightLhColors
  private let dark = DarkLhColors

  private func resolve(
    type: LhButtonType = .default,
    size: LhButtonSize = .medium,
    disabled: Bool = false,
    loading: Bool = false,
    bgPattern: Bool = false,
    colors: LhColors
  ) -> LhButtonAppearance {
    LhButtonStyle.resolveAppearance(
      type: type, size: size, disabled: disabled, loading: loading, bgPattern: bgPattern,
      colors: colors
    )
  }

  // case: click-emits-onclick —— gate 放行（点击是否真正触发见 UI 自动化，后续补）
  func testEnabledButtonIsInteractive() {
    let a = resolve(colors: light)
    XCTAssertTrue(a.enabled, "默认状态应可交互")
  }

  // case: disabled-blocks-click
  func testDisabledIsNotInteractive() {
    let a = resolve(disabled: true, colors: light)
    XCTAssertFalse(a.enabled, "禁用态应不可交互")
  }

  // case: loading-blocks-click
  func testLoadingIsNotInteractive() {
    let a = resolve(loading: true, colors: light)
    XCTAssertFalse(a.enabled, "加载态应不可交互")
  }

  // case: disabled-precedes-loading
  func testDisabledPrecedesLoading() {
    let a = resolve(disabled: true, loading: true, colors: light)
    XCTAssertFalse(a.enabled, "禁用 + 加载共存时应按禁用处理")
    // 禁用样式（而非加载样式）：消费 disabled.* 令牌
    XCTAssertEqual(a.containerColor, LhTokens.Color.Disabled.bg)
    XCTAssertEqual(a.contentColor, LhTokens.Color.Disabled.text)
    XCTAssertEqual(a.borderColor, LhTokens.Color.Disabled.border)
  }

  // case: default-type-renders-text —— 默认类型取中性底 + 主文字色
  func testDefaultTypeUsesNeutralTokens() {
    let a = resolve(colors: light)
    XCTAssertEqual(a.containerColor, LhTokens.Color.Background.`default`, "默认底色 = background.default")
    XCTAssertEqual(a.contentColor, LhTokens.Color.Text.primary, "默认文字 = text.primary")
    XCTAssertEqual(a.borderColor, LhTokens.Color.Border.base, "默认描边 = border.base")
  }

  // case: primary-type-uses-primary-tokens
  func testPrimaryTypeUsesPrimaryTokens() {
    let a = resolve(type: .primary, colors: light)
    XCTAssertEqual(a.containerColor, LhTokens.Color.Primary.`default`, "主色底 = color.primary.default")
    XCTAssertEqual(a.contentColor, LhTokens.Color.onPrimary, "主色按钮文字 = color.onPrimary")
  }

  // case: small-size-uses-small-tokens（并反向确认 large 不同）
  func testSmallSizeUsesSmallTokens() {
    let a = resolve(size: .small, colors: light)
    XCTAssertEqual(a.height, LhTokens.Button.Height.small)
    XCTAssertEqual(a.fontSize, LhTokens.Button.FontSize.small)
    XCTAssertNotEqual(
      LhTokens.Button.Height.small, LhTokens.Button.Height.large,
      "small 与 large 高度必须不同，否则用例无意义"
    )
  }

  // case: bgpattern-uses-decoration-token
  func testBgPatternUsesDecorationToken() {
    let withPattern = resolve(bgPattern: true, colors: light)
    XCTAssertEqual(withPattern.patternColor, LhTokens.Color.decoration)

    let withoutPattern = resolve(colors: light)
    XCTAssertNil(withoutPattern.patternColor, "未开启花纹底时 patternColor 应为 nil")
  }

  /// 暗色色板必须逐字段取自 LhDarkTokens（并列对象模型，见 LhTheme 文档）
  func testDarkColorsComeFromDarkTokens() {
    let a = resolve(type: .primary, colors: dark)
    XCTAssertEqual(a.containerColor, LhDarkTokens.Color.Primary.`default`)
    XCTAssertEqual(a.contentColor, LhDarkTokens.Color.onPrimary)
  }

  /// 禁用态在暗色下取暗色禁用令牌
  func testDisabledInDarkUsesDarkDisabledTokens() {
    let a = resolve(disabled: true, colors: dark)
    XCTAssertEqual(a.containerColor, LhDarkTokens.Color.Disabled.bg)
    XCTAssertEqual(a.contentColor, LhDarkTokens.Color.Disabled.text)
  }

  /// 尺寸令牌暗色不覆盖：明暗色板下尺寸应一致
  func testDimensionsAreIdenticalInDarkMode() {
    let lightAppearance = resolve(size: .large, colors: light)
    let darkAppearance = resolve(size: .large, colors: dark)
    XCTAssertEqual(lightAppearance.height, darkAppearance.height)
    XCTAssertEqual(lightAppearance.paddingHorizontal, darkAppearance.paddingHorizontal)
    XCTAssertEqual(lightAppearance.fontSize, darkAppearance.fontSize)
  }

  /// 便捷初始化器渲染文字内容（case: default-type-renders-text 的 View 层佐证）
  func testButtonViewInitAcceptsText() {
    let button = LhButton(onClick: {}, text: "按钮")
    XCTAssertNotNil(button.body)
  }
}
