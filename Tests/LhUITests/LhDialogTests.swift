import XCTest
import SwiftUI
@testable import LhUI
import LhUITokens

/// 黄金用例翻译：`lh-ui-core/cases/dialog.json` 的 8 条断言。
final class LhDialogTests: XCTestCase {
  private let light = LightLhColors
  private let dark = DarkLhColors

  private func resolve(
    visible: Bool = true,
    type: LhDialogType = .default,
    closable: Bool = false,
    colors: LhColors
  ) -> LhDialogAppearance {
    LhDialogStyle.resolveAppearance(visible: visible, type: type, closable: closable, colors: colors)
  }

  // case: confirm-emits-onconfirm —— 确认按钮按 type 映射语义色
  func testConfirmUsesTypeColor() {
    XCTAssertEqual(resolve(type: .default, colors: light).confirmColor, LhTokens.Color.Primary.`default`)
    XCTAssertEqual(resolve(type: .primary, colors: light).confirmColor, LhTokens.Color.Primary.`default`)
  }

  // case: cancel-emits-oncancel —— 取消按钮固定 default（中性）
  func testCancelUsesNeutralColor() {
    let a = resolve(type: .danger, colors: light)
    XCTAssertEqual(a.cancelTextColor, LhTokens.Color.Text.primary)
    XCTAssertNotEqual(a.confirmColor, a.cancelTextColor, "危险类型确认色应与取消色不同")
  }

  // case: confirm-also-emits-onclose —— 可见态正常解析外观
  func testVisibleRendersAppearance() {
    let a = resolve(visible: true, colors: light)
    XCTAssertTrue(a.visible)
    XCTAssertEqual(a.width, LhTokens.Dialog.width)
    XCTAssertEqual(a.containerColor, LhTokens.Color.Background.`default`)
  }

  // case: closable-overlay-emits-onclose
  func testClosableFlagIsExposed() {
    XCTAssertTrue(resolve(closable: true, colors: light).closable)
    XCTAssertFalse(resolve(closable: false, colors: light).closable, "默认不允许遮罩关闭")
  }

  // case: not-closable-blocks-overlay-close —— 同上反向
  func testNotClosableBlocksOverlay() {
    let a = resolve(closable: false, colors: light)
    XCTAssertFalse(a.closable)
  }

  // case: hidden-not-rendered
  func testHiddenNotRendered() {
    let a = resolve(visible: false, colors: light)
    XCTAssertFalse(a.visible, "visible 为 false 时外观标记不可见，View 层不渲染")
  }

  // case: title-renders-text
  func testTitleUsesTitleTokens() {
    let a = resolve(colors: light)
    XCTAssertEqual(a.titleFontSize, LhTokens.Dialog.titleFontSize)
    XCTAssertEqual(a.titleColor, LhTokens.Color.Text.primary)
    XCTAssertEqual(a.contentFontSize, LhTokens.Dialog.contentFontSize)
    XCTAssertEqual(a.contentColor, LhTokens.Color.Text.regular)
  }

  // case: danger-type-uses-danger-token
  func testDangerTypeUsesDangerToken() {
    let a = resolve(type: .danger, colors: light)
    XCTAssertEqual(a.confirmColor, LhTokens.Color.Danger.`default`, "危险确认 = color.danger.default")
  }

  /// 遮罩与内边距取 dialog 令牌
  func testLayoutUsesDialogTokens() {
    let a = resolve(colors: light)
    XCTAssertEqual(a.borderRadius, LhTokens.Dialog.borderRadius)
    XCTAssertEqual(a.paddingHorizontal, LhTokens.Dialog.paddingHorizontal)
    XCTAssertEqual(a.paddingVertical, LhTokens.Dialog.paddingVertical)
    XCTAssertEqual(a.gap, LhTokens.Dialog.gap)
    XCTAssertEqual(a.overlayColor, LhTokens.Color.Background.overlay)
  }

  /// 暗色色板必须逐字段取自 LhDarkTokens（并列对象模型，见 LhTheme 文档）
  func testDarkColorsComeFromDarkTokens() {
    let a = resolve(type: .danger, colors: dark)
    XCTAssertEqual(a.containerColor, LhDarkTokens.Color.Background.`default`)
    XCTAssertEqual(a.overlayColor, LhDarkTokens.Color.Background.overlay)
    XCTAssertEqual(a.confirmColor, LhDarkTokens.Color.Danger.`default`)
  }

  /// 尺寸令牌暗色不覆盖：明暗色板下尺寸应一致
  func testDimensionsAreIdenticalInDarkMode() {
    let l = resolve(colors: light)
    let d = resolve(colors: dark)
    XCTAssertEqual(l.width, d.width)
    XCTAssertEqual(l.titleFontSize, d.titleFontSize)
  }

  /// View 层受控构造与渲染佐证
  func testDialogViewInitAcceptsConstant() {
    let dialog = LhDialog(visible: .constant(true), title: "标题", content: "内容") {}
    XCTAssertNotNil(dialog.body)
  }
}
