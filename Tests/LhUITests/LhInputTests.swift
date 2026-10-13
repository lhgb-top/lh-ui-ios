import XCTest
import SwiftUI
@testable import LhUI
import LhUITokens

/// 黄金用例翻译：`lh-ui-core/cases/input.json` 的 8 条断言。
final class LhInputTests: XCTestCase {
  private let light = LightLhColors
  private let dark = DarkLhColors

  private func resolve(
    type: LhInputType = .text,
    size: LhInputSize = .medium,
    disabled: Bool = false,
    readonly: Bool = false,
    clearable: Bool = false,
    hasValue: Bool = false,
    focused: Bool = false,
    colors: LhColors
  ) -> LhInputAppearance {
    LhInputStyle.resolveAppearance(
      type: type, size: size, disabled: disabled, readonly: readonly,
      clearable: clearable, hasValue: hasValue, focused: focused, colors: colors
    )
  }

  // case: input-emits-onvaluechange —— 默认可输入
  func testDefaultIsEditable() {
    let a = resolve(colors: light)
    XCTAssertTrue(a.editable)
  }

  // case: clearable-emits-empty-value —— clearable 且有值时显示清除按钮
  func testClearableShowsClearButtonWhenHasValue() {
    XCTAssertTrue(resolve(clearable: true, hasValue: true, colors: light).showsClear)
    XCTAssertFalse(resolve(clearable: true, hasValue: false, colors: light).showsClear, "无值时不显示清除按钮")
    XCTAssertFalse(resolve(clearable: false, hasValue: true, colors: light).showsClear, "未开启 clearable 时不显示")
  }

  // case: disabled-blocks-input
  func testDisabledBlocksInput() {
    let a = resolve(disabled: true, colors: light)
    XCTAssertFalse(a.editable, "禁用态应不可输入")
    XCTAssertEqual(a.containerColor, LhTokens.Color.Disabled.bg, "禁用底 = color.disabled.bg")
    XCTAssertEqual(a.textColor, LhTokens.Color.Disabled.text, "禁用文字 = color.disabled.text")
    // 禁用时不响应清除
    XCTAssertFalse(resolve(disabled: true, clearable: true, hasValue: true, colors: light).showsClear)
  }

  // case: readonly-blocks-input
  func testReadonlyBlocksInput() {
    let a = resolve(readonly: true, colors: light)
    XCTAssertFalse(a.editable, "只读态应不可输入")
    // 只读态外观与可输入态一致（spec：只读可聚焦，仅不接受输入）
    XCTAssertEqual(a.containerColor, LhTokens.Color.Background.`default`)
    XCTAssertEqual(a.borderColor, LhTokens.Color.Border.base)
  }

  // case: placeholder-uses-placeholder-token
  func testPlaceholderUsesPlaceholderToken() {
    let a = resolve(colors: light)
    XCTAssertEqual(a.placeholderColor, LhTokens.Color.Text.placeholder, "占位文字 = color.text.placeholder")
  }

  // case: focus-uses-focus-token
  func testFocusUsesFocusToken() {
    let a = resolve(focused: true, colors: light)
    XCTAssertEqual(a.borderColor, LhTokens.Color.focus, "聚焦描边 = color.focus")
    XCTAssertEqual(a.borderWidth, LhTokens.Input.focusRingWidth, "聚焦描边宽 = input.focusRingWidth")
    // 失焦回默认
    let unfocused = resolve(focused: false, colors: light)
    XCTAssertEqual(unfocused.borderColor, LhTokens.Color.Border.base)
    XCTAssertEqual(unfocused.borderWidth, LhTokens.Input.borderWidth)
  }

  // case: small-size-uses-small-tokens
  func testSmallSizeUsesSmallTokens() {
    let a = resolve(size: .small, colors: light)
    XCTAssertEqual(a.height, LhTokens.Input.Height.small)
    XCTAssertEqual(a.paddingHorizontal, LhTokens.Input.PaddingHorizontal.small)
    XCTAssertEqual(a.fontSize, LhTokens.Input.FontSize.small)
    XCTAssertNotEqual(
      LhTokens.Input.Height.small, LhTokens.Input.Height.large,
      "small 与 large 高度必须不同，否则用例无意义"
    )
  }

  // case: maxlength-truncates-input
  func testMaxlengthTruncatesInput() {
    XCTAssertEqual(LhInputStyle.truncated("青花瓷", maxlength: 2), "青花", "超出长度截断")
    XCTAssertEqual(LhInputStyle.truncated("青花", maxlength: 2), "青花", "恰好等长不截断")
    XCTAssertEqual(LhInputStyle.truncated("青花瓷", maxlength: nil), "青花瓷", "无 maxlength 不截断")
  }

  /// password 类型以圆点掩码显示
  func testPasswordTypeIsSecure() {
    XCTAssertTrue(resolve(type: .password, colors: light).isSecure)
    XCTAssertFalse(resolve(type: .text, colors: light).isSecure)
  }

  /// 暗色色板必须逐字段取自 LhDarkTokens（并列对象模型，见 LhTheme 文档）
  func testDarkColorsComeFromDarkTokens() {
    let a = resolve(focused: true, colors: dark)
    XCTAssertEqual(a.borderColor, LhDarkTokens.Color.focus)
    XCTAssertEqual(a.placeholderColor, LhDarkTokens.Color.Text.placeholder)
  }

  /// 尺寸令牌暗色不覆盖：明暗色板下尺寸应一致
  func testDimensionsAreIdenticalInDarkMode() {
    let l = resolve(size: .large, colors: light)
    let d = resolve(size: .large, colors: dark)
    XCTAssertEqual(l.height, d.height)
    XCTAssertEqual(l.fontSize, d.fontSize)
  }

  /// View 层受控构造与渲染佐证
  func testInputViewInitAcceptsConstant() {
    let input = LhInput(value: .constant("青花瓷"), placeholder: "占位") { _ in }
    XCTAssertNotNil(input.body)
  }
}
