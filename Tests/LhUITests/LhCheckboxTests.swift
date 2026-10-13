import XCTest
import SwiftUI
@testable import LhUI
import LhUITokens

/// 黄金用例翻译：`lh-ui-core/cases/checkbox.json` 的 6 条断言。
final class LhCheckboxTests: XCTestCase {
  private let light = LightLhColors
  private let dark = DarkLhColors

  private func resolve(
    checked: Bool = false,
    indeterminate: Bool = false,
    disabled: Bool = false,
    size: LhCheckboxSize = .medium,
    colors: LhColors
  ) -> LhCheckboxAppearance {
    LhCheckboxStyle.resolveAppearance(
      checked: checked, indeterminate: indeterminate, disabled: disabled,
      size: size, colors: colors
    )
  }

  // case: tap-toggles-and-emits-onchange —— 未选中点击后新选中态为 true
  func testTapTogglesAndEmitsOnChange() {
    let a = resolve(checked: false, colors: light)
    XCTAssertTrue(a.nextChecked, "未选中点击后应变为选中")
  }

  // case: tap-checked-unchecks
  func testTapCheckedUnchecks() {
    let a = resolve(checked: true, colors: light)
    XCTAssertFalse(a.nextChecked, "已选中点击后应变为未选中")
  }

  // case: disabled-blocks-change
  func testDisabledBlocksChange() {
    let a = resolve(disabled: true, colors: light)
    XCTAssertFalse(a.enabled, "禁用态应不可交互")
  }

  // case: checked-uses-primary-tokens
  func testCheckedUsesPrimaryTokens() {
    let a = resolve(checked: true, colors: light)
    XCTAssertEqual(a.boxColor, LhTokens.Color.Primary.`default`, "选中底色 = color.primary.default")
    XCTAssertEqual(a.markColor, LhTokens.Color.onPrimary, "指示符色 = color.onPrimary")
    XCTAssertEqual(a.mark, .checkmark)
  }

  // case: unchecked-uses-border-token
  func testUncheckedUsesBorderToken() {
    let a = resolve(checked: false, colors: light)
    XCTAssertEqual(a.borderColor, LhTokens.Color.Border.base, "未选中描边 = color.border.base")
    XCTAssertEqual(a.boxColor, .clear, "未选中无填充")
    XCTAssertEqual(a.mark, .none)
  }

  // case: indeterminate-becomes-checked
  func testIndeterminateBecomesChecked() {
    let a = resolve(indeterminate: true, colors: light)
    XCTAssertEqual(a.mark, .dash, "不确定态画横杠")
    XCTAssertTrue(a.nextChecked, "不确定态点击后应变为选中（而非翻转）")
  }

  /// 尺寸令牌映射（spec：size 映射到 checkbox.size.*）
  func testSizeUsesSizeTokens() {
    XCTAssertEqual(resolve(size: .small, colors: light).size, LhTokens.Checkbox.Size.small)
    XCTAssertEqual(resolve(size: .medium, colors: light).size, LhTokens.Checkbox.Size.medium)
    XCTAssertEqual(resolve(size: .large, colors: light).size, LhTokens.Checkbox.Size.large)
    XCTAssertNotEqual(
      LhTokens.Checkbox.Size.small, LhTokens.Checkbox.Size.large,
      "small 与 large 尺寸必须不同，否则用例无意义"
    )
  }

  /// 描边/勾形/圆角/间距取 checkbox 令牌
  func testStrokeUsesCheckboxTokens() {
    let a = resolve(colors: light)
    XCTAssertEqual(a.borderWidth, LhTokens.Checkbox.borderWidth)
    XCTAssertEqual(a.checkWidth, LhTokens.Checkbox.checkWidth)
    XCTAssertEqual(a.borderRadius, LhTokens.Checkbox.borderRadius)
    XCTAssertEqual(a.gap, LhTokens.Checkbox.gap)
  }

  /// 暗色色板必须逐字段取自 LhDarkTokens（并列对象模型，见 LhTheme 文档）
  func testDarkColorsComeFromDarkTokens() {
    let a = resolve(checked: true, colors: dark)
    XCTAssertEqual(a.boxColor, LhDarkTokens.Color.Primary.`default`)
    XCTAssertEqual(a.markColor, LhDarkTokens.Color.onPrimary)
  }

  /// 禁用态在暗色下取暗色禁用令牌
  func testDisabledInDarkUsesDarkDisabledTokens() {
    let a = resolve(checked: true, disabled: true, colors: dark)
    XCTAssertEqual(a.boxColor, LhDarkTokens.Color.Disabled.bg)
    XCTAssertEqual(a.borderColor, LhDarkTokens.Color.Disabled.border)
    XCTAssertEqual(a.markColor, LhDarkTokens.Color.Disabled.text)
  }

  /// 尺寸令牌暗色不覆盖：明暗色板下尺寸应一致
  func testDimensionsAreIdenticalInDarkMode() {
    XCTAssertEqual(resolve(size: .large, colors: light).size, resolve(size: .large, colors: dark).size)
  }

  /// View 层受控构造与渲染佐证
  func testCheckboxViewInitAcceptsConstant() {
    let checkbox = LhCheckbox(checked: .constant(true), label: "同意") { _ in }
    XCTAssertNotNil(checkbox.body)
  }
}
