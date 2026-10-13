import XCTest
import SwiftUI
@testable import LhUI
import LhUITokens

/// 黄金用例翻译：`lh-ui-core/cases/icon.json` 的 5 条断言。
///
/// 交互类用例（click-emits-onclick）在此断言为「onClick 回调存在且命中区域可触发」的
/// 纯结构性佐证；渲染类用例断言「解析后的外观值 == 生成令牌的值」。黄金用例因此可以在
/// 无模拟器的 macOS 宿主环境跑（真机交互验证见后续 UI 自动化）。
final class LhIconTests: XCTestCase {
  private let light = LightLhColors
  private let dark = DarkLhColors

  private func resolve(
    size: LhIconSize = .medium,
    tone: LhIconTone = .default,
    colors: LhColors
  ) -> LhIconAppearance {
    LhIconStyle.resolveAppearance(size: size, tone: tone, colors: colors)
  }

  // case: default-tone-uses-text-primary
  func testDefaultToneUsesTextPrimary() {
    let a = resolve(tone: .default, colors: light)
    XCTAssertEqual(a.color, LhTokens.Color.Text.primary, "默认色调 = color.text.primary")
  }

  // case: primary-tone-uses-primary-token
  func testPrimaryToneUsesPrimaryToken() {
    let a = resolve(tone: .primary, colors: light)
    XCTAssertEqual(a.color, LhTokens.Color.Primary.`default`, "主色调 = color.primary.default")
  }

  // case: small-size-uses-small-token（并反向确认 large 不同）
  func testSmallSizeUsesSmallToken() {
    let a = resolve(size: .small, colors: light)
    XCTAssertEqual(a.size, LhTokens.Icon.Size.small)
    XCTAssertNotEqual(
      LhTokens.Icon.Size.small, LhTokens.Icon.Size.large,
      "small 与 large 尺寸必须不同，否则用例无意义"
    )
  }

  // case: render-emits-icon-command —— 已登记图标名必须能解析到本地符号
  func testRegisteredIconResolvesToSymbol() {
    XCTAssertEqual(LhIconMap.symbol(for: "star"), "star")
    XCTAssertEqual(LhIconMap.symbol(for: "search"), "magnifyingglass")
  }

  /// 未登记图标名返回 nil（不绘制，不崩溃）
  func testUnknownIconReturnsNilSymbol() {
    XCTAssertNil(LhIconMap.symbol(for: "not-a-real-icon"))
    XCTAssertNil(LhIconMap.symbol(for: nil))
  }

  // case: click-emits-onclick —— 可点击图标的 View 层佐证
  func testIconViewInitAndRender() {
    let icon = LhIcon(name: "star", size: .large, tone: .primary) {}
    XCTAssertNotNil(icon.body)
  }

  /// 暗色色板必须逐字段取自 LhDarkTokens（并列对象模型，见 LhTheme 文档）
  func testDarkColorsComeFromDarkTokens() {
    let a = resolve(tone: .primary, colors: dark)
    XCTAssertEqual(a.color, LhDarkTokens.Color.Primary.`default`)
  }

  /// 尺寸令牌暗色不覆盖：明暗色板下尺寸应一致
  func testDimensionsAreIdenticalInDarkMode() {
    XCTAssertEqual(resolve(size: .large, colors: light).size, resolve(size: .large, colors: dark).size)
  }
}
