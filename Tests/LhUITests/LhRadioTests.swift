import XCTest
import SwiftUI
@testable import LhUI
import LhUITokens

/// 黄金用例翻译：`lh-ui-core/cases/radio.json` 的 6 条断言。
final class LhRadioTests: XCTestCase {
  private let light = LightLhColors
  private let dark = DarkLhColors

  private func resolve(
    checked: Bool = false,
    disabled: Bool = false,
    size: LhRadioSize = .medium,
    colors: LhColors
  ) -> LhRadioAppearance {
    LhRadioStyle.resolveAppearance(checked: checked, disabled: disabled, size: size, colors: colors)
  }

  // case: tap-unchecked-emits-onchange —— 未选中时可交互（点击触发 onChange(true)）
  func testUncheckedIsInteractive() {
    let a = resolve(checked: false, colors: light)
    XCTAssertTrue(a.enabled)
    XCTAssertFalse(a.showsDot, "未选中不画圆点")
  }

  // case: tap-checked-keeps-checked —— 已选中时仍可交互（但 View 层不再触发，见 onTapGesture gate）
  func testCheckedShowsDot() {
    let a = resolve(checked: true, colors: light)
    XCTAssertTrue(a.showsDot, "选中时画圆点")
  }

  // case: disabled-blocks-change
  func testDisabledBlocksChange() {
    let a = resolve(disabled: true, colors: light)
    XCTAssertFalse(a.enabled, "禁用态应不可交互")
  }

  // case: checked-uses-primary-tokens
  func testCheckedUsesPrimaryTokens() {
    let a = resolve(checked: true, colors: light)
    XCTAssertEqual(a.ringColor, LhTokens.Color.Primary.`default`, "选中外环 = color.primary.default")
    XCTAssertEqual(a.dotColor, LhTokens.Color.Primary.`default`, "圆点 = color.primary.default")
  }

  // case: unchecked-uses-border-token
  func testUncheckedUsesBorderToken() {
    let a = resolve(checked: false, colors: light)
    XCTAssertEqual(a.ringColor, LhTokens.Color.Border.base, "未选中外环 = color.border.base")
    XCTAssertEqual(a.dotColor, .clear)
  }

  // case: small-size-uses-small-token
  func testSmallSizeUsesSmallToken() {
    let a = resolve(size: .small, colors: light)
    XCTAssertEqual(a.size, LhTokens.Radio.Size.small)
    XCTAssertNotEqual(
      LhTokens.Radio.Size.small, LhTokens.Radio.Size.large,
      "small 与 large 尺寸必须不同，否则用例无意义"
    )
  }

  /// 描边宽/圆点比例/间距取 radio 令牌
  func testStrokeUsesRadioTokens() {
    let a = resolve(checked: true, colors: light)
    XCTAssertEqual(a.ringWidth, LhTokens.Radio.ringWidth)
    XCTAssertEqual(a.dotScale, CGFloat(LhTokens.Radio.dotScale))
    XCTAssertEqual(a.gap, LhTokens.Radio.gap)
    // 圆点直径 = 尺寸 × dotScale
    XCTAssertEqual(a.size * a.dotScale, a.size * CGFloat(LhTokens.Radio.dotScale))
  }

  /// 暗色色板必须逐字段取自 LhDarkTokens（并列对象模型，见 LhTheme 文档）
  func testDarkColorsComeFromDarkTokens() {
    let a = resolve(checked: true, colors: dark)
    XCTAssertEqual(a.ringColor, LhDarkTokens.Color.Primary.`default`)
    XCTAssertEqual(a.dotColor, LhDarkTokens.Color.Primary.`default`)
  }

  /// 禁用态在暗色下取暗色禁用令牌
  func testDisabledInDarkUsesDarkDisabledTokens() {
    let a = resolve(checked: true, disabled: true, colors: dark)
    XCTAssertEqual(a.ringColor, LhDarkTokens.Color.Disabled.border)
    XCTAssertEqual(a.dotColor, LhDarkTokens.Color.Disabled.text)
  }

  /// 尺寸令牌暗色不覆盖：明暗色板下尺寸应一致
  func testDimensionsAreIdenticalInDarkMode() {
    XCTAssertEqual(resolve(size: .large, colors: light).size, resolve(size: .large, colors: dark).size)
  }

  /// View 层受控构造与渲染佐证
  func testRadioViewInitAcceptsConstant() {
    let radio = LhRadio(checked: .constant(true), label: "选项", value: "opt") { _ in }
    XCTAssertNotNil(radio.body)
  }
}
