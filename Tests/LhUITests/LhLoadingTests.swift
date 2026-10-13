import XCTest
import SwiftUI
@testable import LhUI
import LhUITokens

/// 黄金用例翻译：`lh-ui-core/cases/loading.json` 的 5 条断言。
final class LhLoadingTests: XCTestCase {
  private let light = LightLhColors
  private let dark = DarkLhColors

  private func resolve(
    size: LhLoadingSize = .medium,
    tone: LhLoadingTone = .primary,
    colors: LhColors
  ) -> LhLoadingAppearance {
    LhLoadingStyle.resolveAppearance(size: size, tone: tone, colors: colors)
  }

  // case: medium-size-uses-medium-token（默认尺寸，并反向确认 small 不同）
  func testMediumSizeUsesMediumToken() {
    let a = resolve(colors: light)
    XCTAssertEqual(a.size, LhTokens.Loading.Size.medium)
    XCTAssertNotEqual(
      LhTokens.Loading.Size.medium, LhTokens.Loading.Size.small,
      "medium 与 small 尺寸必须不同，否则用例无意义"
    )
  }

  // case: large-size-uses-large-token（并反向确认 medium 不同）
  func testLargeSizeUsesLargeToken() {
    let a = resolve(size: .large, colors: light)
    XCTAssertEqual(a.size, LhTokens.Loading.Size.large)
    XCTAssertNotEqual(
      LhTokens.Loading.Size.large, LhTokens.Loading.Size.medium,
      "large 与 medium 尺寸必须不同，否则用例无意义"
    )
  }

  // case: primary-tone-uses-primary-token
  func testPrimaryToneUsesPrimaryToken() {
    let a = resolve(tone: .primary, colors: light)
    XCTAssertEqual(a.color, LhTokens.Color.Primary.`default`, "默认色调 = color.primary.default")
  }

  // case: success-tone-uses-success-token
  func testSuccessToneUsesSuccessToken() {
    let a = resolve(tone: .success, colors: light)
    XCTAssertEqual(a.color, LhTokens.Color.Success.`default`, "成功色调 = color.success.default")
  }

  // case: render-emits-ring-command —— 环描边宽取 loading.strokeWidth
  func testRingUsesStrokeWidthToken() {
    let a = resolve(colors: light)
    XCTAssertEqual(a.strokeWidth, LhTokens.Loading.strokeWidth)
  }

  /// 全部色调都能解析（外观层不缺映射分支）
  func testAllTonesResolve() {
    for tone in LhLoadingTone.allCases {
      let a = resolve(tone: tone, colors: light)
      XCTAssertEqual(a.size, LhTokens.Loading.Size.medium)
    }
  }

  /// 暗色色板必须逐字段取自 LhDarkTokens（并列对象模型，见 LhTheme 文档）
  func testDarkColorsComeFromDarkTokens() {
    let a = resolve(tone: .success, colors: dark)
    XCTAssertEqual(a.color, LhDarkTokens.Color.Success.`default`)
  }

  /// 尺寸令牌暗色不覆盖：明暗色板下尺寸应一致
  func testDimensionsAreIdenticalInDarkMode() {
    XCTAssertEqual(resolve(size: .large, colors: light).size, resolve(size: .large, colors: dark).size)
  }

  /// View 层渲染佐证
  func testLoadingViewInitAndRender() {
    let loading = LhLoading(size: .large, tone: .info)
    XCTAssertNotNil(loading.body)
  }
}
