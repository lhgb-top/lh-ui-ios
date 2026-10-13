import XCTest
import SwiftUI
@testable import LhUI
import LhUITokens

/// 黄金用例翻译：`lh-ui-core/cases/toast.json` 的 6 条断言。
final class LhToastTests: XCTestCase {
  private let light = LightLhColors
  private let dark = DarkLhColors

  private func resolve(
    type: LhToastType = .default,
    duration: Int = 2000,
    visible: Bool = true,
    colors: LhColors
  ) -> LhToastAppearance {
    LhToastStyle.resolveAppearance(type: type, duration: duration, visible: visible, colors: colors)
  }

  // case: show-makes-visible
  func testShowMakesVisible() {
    let a = resolve(visible: true, colors: light)
    XCTAssertTrue(a.visible)
  }

  // case: auto-hides-after-duration —— duration 从毫秒换算为秒
  func testDurationConvertsToSeconds() {
    XCTAssertEqual(resolve(duration: 2000, colors: light).durationSeconds, 2.0)
    XCTAssertEqual(resolve(duration: 3500, colors: light).durationSeconds, 3.5)
  }

  // case: tick-before-duration-keeps-visible —— duration 为正时外观层始终可见（计时在 View 层）
  func testVisibleDuringDuration() {
    let a = resolve(visible: true, duration: 2000, colors: light)
    XCTAssertTrue(a.visible)
  }

  // case: hide-is-silent —— 主动置 visible=false 不触发 onClose（onClose 只在计时到期时触发）
  func testHideIsSilent() {
    // 外观层只暴露可见性；View 层的 .task 只在计时到期后调 onClose
    let a = resolve(visible: false, colors: light)
    XCTAssertFalse(a.visible)
  }

  // case: success-type-uses-success-token
  func testSuccessTypeUsesSuccessToken() {
    let a = resolve(type: .success, colors: light)
    XCTAssertEqual(a.dotColor, LhTokens.Color.Success.`default`, "成功圆点 = color.success.default")
  }

  // case: hidden-emits-no-commands
  func testHiddenNotRendered() {
    let a = resolve(visible: false, colors: light)
    XCTAssertFalse(a.visible, "不可见时 View 层不渲染")
  }

  /// default 类型不画圆点
  func testDefaultTypeHasNoDot() {
    XCTAssertNil(resolve(type: .default, colors: light).dotColor)
    XCTAssertNotNil(resolve(type: .warning, colors: light).dotColor)
    XCTAssertNotNil(resolve(type: .danger, colors: light).dotColor)
    XCTAssertNotNil(resolve(type: .info, colors: light).dotColor)
  }

  /// 胶囊底取 color.ink，文字取 color.onPrimary（spec behaviors）
  func testInkBackgroundUsesInkToken() {
    let a = resolve(colors: light)
    XCTAssertEqual(a.containerColor, LhTokens.Color.ink, "胶囊底 = color.ink")
    XCTAssertEqual(a.textColor, LhTokens.Color.onPrimary, "文字 = color.onPrimary")
  }

  /// 内边距/圆角/字号/间距取 toast 令牌
  func testLayoutUsesToastTokens() {
    let a = resolve(colors: light)
    XCTAssertEqual(a.fontSize, LhTokens.Toast.fontSize)
    XCTAssertEqual(a.paddingHorizontal, LhTokens.Toast.paddingHorizontal)
    XCTAssertEqual(a.paddingVertical, LhTokens.Toast.paddingVertical)
    XCTAssertEqual(a.borderRadius, LhTokens.Toast.borderRadius)
    XCTAssertEqual(a.gap, LhTokens.Toast.gap)
    XCTAssertEqual(a.edgeMargin, LhTokens.Spacing.xl, "上下边距 = spacing.xl")
  }

  /// 暗色色板必须逐字段取自 LhDarkTokens（并列对象模型，ink 有暗色覆盖）
  func testDarkColorsComeFromDarkTokens() {
    let a = resolve(colors: dark)
    XCTAssertEqual(a.containerColor, LhDarkTokens.Color.ink, "暗色墨底取 ink 的暗色覆盖")
    XCTAssertEqual(a.textColor, LhDarkTokens.Color.onPrimary)
    XCTAssertNil(a.dotColor, "默认类型无圆点，dotColor 为 nil")
  }

  /// success 类型的圆点暗色取语义色覆盖
  func testDarkSuccessDotComesFromDarkTokens() {
    let a = resolve(type: .success, colors: dark)
    XCTAssertEqual(a.dotColor, LhDarkTokens.Color.Success.`default`)
  }

  /// ink 暗色覆盖必须与明色不同（否则暗色下 toast 与页面底糊在一起）
  func testDarkInkDiffersFromLightInk() {
    XCTAssertNotEqual(LhTokens.Color.ink, LhDarkTokens.Color.ink)
  }

  /// 尺寸令牌暗色不覆盖：明暗色板下尺寸应一致
  func testDimensionsAreIdenticalInDarkMode() {
    let l = resolve(colors: light)
    let d = resolve(colors: dark)
    XCTAssertEqual(l.fontSize, d.fontSize)
    XCTAssertEqual(l.borderRadius, d.borderRadius)
  }

  /// View 层受控构造与渲染佐证
  func testToastViewInitAcceptsConstant() {
    let toast = LhToast(visible: .constant(true), text: "提示") {}
    XCTAssertNotNil(toast.body)
  }
}
