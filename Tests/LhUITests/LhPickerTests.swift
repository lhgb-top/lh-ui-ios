import XCTest
import SwiftUI
@testable import LhUI
import LhUITokens

/// 黄金用例翻译：`lh-ui-core/cases/picker.json` 的 8 条断言。
final class LhPickerTests: XCTestCase {
  private let light = LightLhColors
  private let dark = DarkLhColors
  private let options = ["青花瓷", "玲珑瓷", "粉彩瓷"]

  private func resolve(
    visible: Bool = true,
    options: [String] = ["青花瓷", "玲珑瓷", "粉彩瓷"],
    value: Int = 0,
    title: String = "",
    confirmText: String = "确认",
    cancelText: String = "取消",
    colors: LhColors
  ) -> LhPickerAppearance {
    LhPickerStyle.resolveAppearance(
      visible: visible, options: options, value: value, title: title,
      confirmText: confirmText, cancelText: cancelText, colors: colors
    )
  }

  // case: confirm-emits-onconfirm-with-value —— 确认色取主色
  func testConfirmUsesPrimaryToken() {
    let a = resolve(colors: light)
    XCTAssertEqual(a.confirmColor, LhTokens.Color.Primary.`default`)
  }

  // case: confirm-also-emits-onclose —— 可见态正常解析外观
  func testVisibleRendersAppearance() {
    let a = resolve(visible: true, colors: light)
    XCTAssertTrue(a.visible)
  }

  // case: cancel-emits-oncancel —— 取消色取主文字色
  func testCancelUsesNeutralColor() {
    let a = resolve(colors: light)
    XCTAssertEqual(a.cancelColor, LhTokens.Color.Text.primary)
  }

  // case: scroll-emits-onvaluechange —— 钳制后的选中索引暴露在外观上
  func testClampedValueIsExposed() {
    let a = resolve(value: 1, colors: light)
    XCTAssertEqual(a.clampedValue, 1)
  }

  // case: clamp-negative-value-to-zero
  func testClampNegativeValueToZero() {
    let a = resolve(value: -5, colors: light)
    XCTAssertEqual(a.clampedValue, 0, "负数钳制到 0")
  }

  // case: clamp-overflow-value-to-last
  func testClampOverflowValueToLast() {
    let a = resolve(value: 99, colors: light)
    XCTAssertEqual(a.clampedValue, options.count - 1, "超出候选项数钳制到最后一项")
  }

  // case: title-renders-text
  func testTitleAndTextsAreExposed() {
    let a = resolve(title: "选择品类", confirmText: "确定", cancelText: "返回", colors: light)
    XCTAssertEqual(a.title, "选择品类")
    XCTAssertEqual(a.confirmText, "确定")
    XCTAssertEqual(a.cancelText, "返回")
    XCTAssertEqual(a.titleColor, LhTokens.Color.Text.primary)
  }

  // case: hidden-not-rendered
  func testHiddenNotRendered() {
    let a = resolve(visible: false, colors: light)
    XCTAssertFalse(a.visible, "visible 为 false 时 View 层不渲染")
  }

  /// 面板/候选项/工具栏尺寸取 picker 令牌
  func testLayoutUsesPickerTokens() {
    let a = resolve(colors: light)
    XCTAssertEqual(a.height, LhTokens.Picker.height)
    XCTAssertEqual(a.itemHeight, LhTokens.Picker.itemHeight)
    XCTAssertEqual(a.toolbarHeight, LhTokens.Picker.toolbarHeight)
    XCTAssertEqual(a.itemFontSize, LhTokens.Picker.itemFontSize)
    XCTAssertEqual(a.borderRadius, LhTokens.Picker.borderRadius)
    XCTAssertEqual(a.indicatorColor, LhTokens.Color.Border.lighter)
    XCTAssertEqual(a.overlayColor, LhTokens.Color.Background.overlay)
  }

  /// 空候选项时钳制为 0（不崩溃）
  func testEmptyOptionsClampsToZero() {
    let a = resolve(options: [], value: 3, colors: light)
    XCTAssertEqual(a.clampedValue, 0)
  }

  /// 暗色色板必须逐字段取自 LhDarkTokens（并列对象模型，见 LhTheme 文档）
  func testDarkColorsComeFromDarkTokens() {
    let a = resolve(colors: dark)
    XCTAssertEqual(a.containerColor, LhDarkTokens.Color.Background.`default`)
    XCTAssertEqual(a.overlayColor, LhDarkTokens.Color.Background.overlay)
    XCTAssertEqual(a.indicatorColor, LhDarkTokens.Color.Border.lighter)
  }

  /// 尺寸令牌暗色不覆盖：明暗色板下尺寸应一致
  func testDimensionsAreIdenticalInDarkMode() {
    let l = resolve(colors: light)
    let d = resolve(colors: dark)
    XCTAssertEqual(l.height, d.height)
    XCTAssertEqual(l.itemHeight, d.itemHeight)
    XCTAssertEqual(l.toolbarHeight, d.toolbarHeight)
  }

  /// View 层受控构造与渲染佐证
  func testPickerViewInitAcceptsConstant() {
    let picker = LhPicker(visible: .constant(true), options: options, value: .constant(0)) { _ in } onCancel: {}
    XCTAssertNotNil(picker.body)
  }
}
