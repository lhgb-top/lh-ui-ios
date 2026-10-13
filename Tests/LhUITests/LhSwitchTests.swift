import XCTest
import SwiftUI
@testable import LhUI
import LhUITokens

/// 黄金用例翻译：`lh-ui-core/cases/switch.json` 的 6 条断言。
final class LhSwitchTests: XCTestCase {
  private let light = LightLhColors
  private let dark = DarkLhColors

  private func resolve(
    checked: Bool = false,
    disabled: Bool = false,
    loading: Bool = false,
    size: LhSwitchSize = .medium,
    colors: LhColors
  ) -> LhSwitchAppearance {
    LhSwitchStyle.resolveAppearance(
      checked: checked, disabled: disabled, loading: loading, size: size, colors: colors
    )
  }

  // case: tap-toggles-and-emits-onchange —— 默认可交互
  func testDefaultIsInteractive() {
    let a = resolve(colors: light)
    XCTAssertTrue(a.enabled)
  }

  // case: tap-checked-turns-off —— 开启态轨道取主色
  func testCheckedUsesPrimaryTrack() {
    let a = resolve(checked: true, colors: light)
    XCTAssertEqual(a.trackColor, LhTokens.Color.Primary.`default`)
    XCTAssertTrue(a.thumbOffset > 0, "开启时滑块应右移")
  }

  // case: disabled-blocks-change
  func testDisabledBlocksChange() {
    let a = resolve(checked: true, disabled: true, colors: light)
    XCTAssertFalse(a.enabled, "禁用态应不可交互")
    XCTAssertEqual(a.trackColor, LhTokens.Color.Disabled.bg, "禁用轨道 = color.disabled.bg")
    XCTAssertEqual(a.thumbColor, LhTokens.Color.Disabled.text, "禁用滑块 = color.text.disabled")
  }

  // case: loading-blocks-change
  func testLoadingBlocksChange() {
    let a = resolve(loading: true, colors: light)
    XCTAssertFalse(a.enabled, "加载态应不可交互")
    XCTAssertTrue(a.showsLoading, "加载态应显示加载环")
  }

  // case: checked-uses-primary-token
  func testCheckedUsesPrimaryToken() {
    let a = resolve(checked: true, colors: light)
    XCTAssertEqual(a.trackColor, LhTokens.Color.Primary.`default`, "开启轨道 = color.primary.default")
    XCTAssertEqual(a.thumbColor, LhTokens.Color.onPrimary, "滑块 = color.onPrimary")
  }

  // case: unchecked-uses-border-token
  func testUncheckedUsesBorderToken() {
    let a = resolve(checked: false, colors: light)
    XCTAssertEqual(a.trackColor, LhTokens.Color.Border.base, "关闭轨道 = color.border.base")
  }

  /// 尺寸令牌映射（spec：size 映射到 switch.width.<size> 与 switch.height.<size>）
  func testSizeUsesSwitchTokens() {
    let a = resolve(size: .large, colors: light)
    XCTAssertEqual(a.width, LhTokens.Switch.Width.large)
    XCTAssertEqual(a.height, LhTokens.Switch.Height.large)
    XCTAssertNotEqual(
      LhTokens.Switch.Width.small, LhTokens.Switch.Width.large,
      "small 与 large 宽度必须不同，否则用例无意义"
    )
  }

  /// 滑块直径 = 高度 - 2 × switch.gap（spec behaviors）
  func testThumbDiameterIsHeightMinusTwoGaps() {
    let a = resolve(size: .medium, colors: light)
    XCTAssertEqual(a.thumbSize, a.height - 2 * LhTokens.Switch.gap)
  }

  /// 暗色色板必须逐字段取自 LhDarkTokens（并列对象模型，见 LhTheme 文档）
  func testDarkColorsComeFromDarkTokens() {
    let a = resolve(checked: true, colors: dark)
    XCTAssertEqual(a.trackColor, LhDarkTokens.Color.Primary.`default`)
    XCTAssertEqual(a.thumbColor, LhDarkTokens.Color.onPrimary)
  }

  /// 尺寸令牌暗色不覆盖：明暗色板下尺寸应一致
  func testDimensionsAreIdenticalInDarkMode() {
    let l = resolve(size: .large, colors: light)
    let d = resolve(size: .large, colors: dark)
    XCTAssertEqual(l.width, d.width)
    XCTAssertEqual(l.height, d.height)
  }

  /// View 层受控构造与渲染佐证
  func testSwitchViewInitAcceptsConstant() {
    let sw = LhSwitch(checked: .constant(true)) { _ in }
    XCTAssertNotNil(sw.body)
  }
}
