import XCTest
import SwiftUI
@testable import LhUI
import LhUITokens

/// 黄金用例翻译：`lh-ui-core/cases/textarea.json` 的断言。
final class LhTextareaTests: XCTestCase {
  private let light = LightLhColors
  private let dark = DarkLhColors

  private func resolve(
    value: String = "",
    disabled: Bool = false,
    readonly: Bool = false,
    showCount: Bool = false,
    maxlength: Int? = nil,
    focused: Bool = false,
    colors: LhColors
  ) -> LhTextareaAppearance {
    LhTextareaStyle.resolveAppearance(
      value: value, disabled: disabled, readonly: readonly, showCount: showCount,
      maxlength: maxlength, focused: focused, colors: colors
    )
  }

  // case: input-emits-onvaluechange —— 默认可输入
  func testDefaultIsEditable() {
    let a = resolve(colors: light)
    XCTAssertTrue(a.editable)
  }

  // case: disabled-blocks-input
  func testDisabledBlocksInput() {
    let a = resolve(disabled: true, colors: light)
    XCTAssertFalse(a.editable, "禁用态应不可输入")
    XCTAssertEqual(a.containerColor, LhTokens.Color.Disabled.bg, "禁用底 = color.disabled.bg")
    XCTAssertEqual(a.textColor, LhTokens.Color.Disabled.text, "禁用文字 = color.disabled.text")
  }

  // case: showcount-renders-count
  func testShowCountRendersCount() {
    let a = resolve(value: "青花", showCount: true, maxlength: 10, colors: light)
    XCTAssertTrue(a.showsCount)
    XCTAssertEqual(a.countText, "2/10", "字数统计格式为「当前/最大」")
    XCTAssertEqual(a.countFontSize, LhTokens.Textarea.countFontSize, "字数字号 = textarea.countFontSize")
  }

  // case: showcount-without-maxlength-renders-length-only
  func testShowCountWithoutMaxlengthRendersLengthOnly() {
    let a = resolve(value: "青花瓷", showCount: true, colors: light)
    XCTAssertEqual(a.countText, "3", "无 maxlength 时只显示当前长度")
  }

  // case: focus-uses-focus-token
  func testFocusUsesFocusToken() {
    let a = resolve(focused: true, colors: light)
    XCTAssertEqual(a.borderColor, LhTokens.Color.focus, "聚焦描边 = color.focus")
    XCTAssertEqual(a.borderWidth, LhTokens.Textarea.focusRingWidth, "聚焦描边宽 = textarea.focusRingWidth")
    let unfocused = resolve(focused: false, colors: light)
    XCTAssertEqual(unfocused.borderColor, LhTokens.Color.Border.base)
    XCTAssertEqual(unfocused.borderWidth, LhTokens.Textarea.borderWidth)
  }

  // case: maxlength-truncates-input
  func testMaxlengthTruncatesInput() {
    XCTAssertEqual(LhTextareaStyle.truncated("青花瓷", maxlength: 2), "青花")
    XCTAssertEqual(LhTextareaStyle.truncated("青花", maxlength: 2), "青花")
    XCTAssertEqual(LhTextareaStyle.truncated("青花瓷", maxlength: nil), "青花瓷")
  }

  /// 内边距/字号/圆角/最小高度取 textarea 令牌
  func testLayoutUsesTextareaTokens() {
    let a = resolve(colors: light)
    XCTAssertEqual(a.paddingHorizontal, LhTokens.Textarea.paddingHorizontal)
    XCTAssertEqual(a.paddingVertical, LhTokens.Textarea.paddingVertical)
    XCTAssertEqual(a.fontSize, LhTokens.Textarea.fontSize)
    XCTAssertEqual(a.borderRadius, LhTokens.Textarea.borderRadius)
    XCTAssertEqual(a.minHeight, LhTokens.Textarea.minHeight)
  }

  /// 只读态可聚焦但不接受输入（外观与可输入态一致）
  func testReadonlyBlocksInputButKeepsFocusStyle() {
    let a = resolve(readonly: true, focused: true, colors: light)
    XCTAssertFalse(a.editable)
    XCTAssertEqual(a.borderColor, LhTokens.Color.focus, "只读态仍可聚焦取聚焦环")
  }

  /// 暗色色板必须逐字段取自 LhDarkTokens（并列对象模型，见 LhTheme 文档）
  func testDarkColorsComeFromDarkTokens() {
    let a = resolve(focused: true, colors: dark)
    XCTAssertEqual(a.borderColor, LhDarkTokens.Color.focus)
    XCTAssertEqual(a.textColor, LhDarkTokens.Color.Text.primary)
  }

  /// 尺寸令牌暗色不覆盖：明暗色板下尺寸应一致
  func testDimensionsAreIdenticalInDarkMode() {
    let l = resolve(colors: light)
    let d = resolve(colors: dark)
    XCTAssertEqual(l.fontSize, d.fontSize)
    XCTAssertEqual(l.minHeight, d.minHeight)
    XCTAssertEqual(l.countFontSize, d.countFontSize)
  }

  /// View 层受控构造与渲染佐证
  func testTextareaViewInitAcceptsConstant() {
    let textarea = LhTextarea(value: .constant("青花瓷"), placeholder: "占位", showCount: true, maxlength: 10) { _ in }
    XCTAssertNotNil(textarea.body)
  }
}
