import XCTest
@testable import LhUI

/// 语言层测试：10 内置包完整性、setLocale 回退、自定义包注册（对标 web 血脉
/// `lh-ui-share/src/locales/locale.ts` 的 LhLocale 语义）。
///
/// 单例状态会跨用例泄漏：每个用例以 defer 恢复为 zh-CN，自定义包统一用
/// 非内置代码 "vi" 以免污染内置注册表。
final class LhLocaleTests: XCTestCase {
  private let allBuiltInPacks: [(code: String, pack: LhTexts)] = [
    ("zh-CN", ZhCnLhTexts),
    ("zh-TW", ZhTwLhTexts),
    ("en-US", EnUsLhTexts),
    ("ja-JP", JaJpLhTexts),
    ("ko-KR", KoKrLhTexts),
    ("de-DE", DeDeLhTexts),
    ("fr-FR", FrFrLhTexts),
    ("es", EsLhTexts),
    ("ar", ArLhTexts),
    ("ru", RuLhTexts),
  ]

  private let vietnamesePack = LhTexts(
    dialogConfirm: "Xác nhận",
    dialogCancel: "Hủy",
    pickerConfirm: "Xác nhận",
    pickerCancel: "Hủy",
    loadingLabel: "Đang tải",
    switchLabel: "Công tắc",
    inputLabelFallback: "Trường văn bản",
    textareaLabelFallback: "Trường văn bản nhiều dòng"
  )

  override func tearDown() {
    LhLocale.shared.setLocale(LhLocale.defaultLocale)
    super.tearDown()
  }

  /// 10 个内置包逐字段非空（缺字段即该语言下出现空按钮/空无障碍标签）
  func testAllBuiltInPacksAreComplete() {
    for (code, pack) in allBuiltInPacks {
      XCTAssertFalse(pack.dialogConfirm.isEmpty, "\(code) dialogConfirm 为空")
      XCTAssertFalse(pack.dialogCancel.isEmpty, "\(code) dialogCancel 为空")
      XCTAssertFalse(pack.pickerConfirm.isEmpty, "\(code) pickerConfirm 为空")
      XCTAssertFalse(pack.pickerCancel.isEmpty, "\(code) pickerCancel 为空")
      XCTAssertFalse(pack.loadingLabel.isEmpty, "\(code) loadingLabel 为空")
      XCTAssertFalse(pack.switchLabel.isEmpty, "\(code) switchLabel 为空")
      XCTAssertFalse(pack.inputLabelFallback.isEmpty, "\(code) inputLabelFallback 为空")
      XCTAssertFalse(pack.textareaLabelFallback.isEmpty, "\(code) textareaLabelFallback 为空")
    }
  }

  /// 内置注册表恰好覆盖 10 种语言；未登记语言取不到包
  func testBuiltInRegistryCoversTenLanguages() {
    for (code, _) in allBuiltInPacks {
      XCTAssertNotNil(LhLocale.pack(for: code), "\(code) 应有内置包")
    }
    XCTAssertNil(LhLocale.pack(for: "vi"), "未注册的自定义代码不应取到包")
  }

  /// zh-CN 包与 spec 默认值逐字对齐（R-n5）
  func testZhCnPackMatchesSpecDefaults() {
    XCTAssertEqual(ZhCnLhTexts.dialogConfirm, "确认")
    XCTAssertEqual(ZhCnLhTexts.dialogCancel, "取消")
    XCTAssertEqual(ZhCnLhTexts.pickerConfirm, "确认")
    XCTAssertEqual(ZhCnLhTexts.pickerCancel, "取消")
  }

  /// 各语言包译文互不相同（确认键至少应分语言）
  func testPacksDifferPerLanguage() {
    let confirms = allBuiltInPacks.map { $0.pack.dialogConfirm }
    XCTAssertEqual(Set(confirms).count, 10, "10 种语言的确认文案应彼此不同")
  }

  /// setLocale 切换生效
  func testSetLocaleSwitchesTexts() {
    LhLocale.shared.setLocale("en-US")
    XCTAssertEqual(LhLocale.shared.current, "en-US")
    XCTAssertEqual(LhLocale.shared.texts, EnUsLhTexts)
  }

  /// 未注册语言回退简体中文包内容（与 web 血脉一致：current 仍报告被请求的语言）
  func testUnknownLocaleFallsBackToZhCnPack() {
    LhLocale.shared.setLocale("xx-XX")
    XCTAssertEqual(LhLocale.shared.current, "xx-XX")
    XCTAssertEqual(LhLocale.shared.texts, ZhCnLhTexts, "未注册语言回退简体中文包内容")
  }

  /// 自定义包注册后遮蔽内置表（内置包永不被覆写：register 到非内置代码）
  func testCustomPackRegistrationShadowsRegistry() {
    LhLocale.shared.register("vi", pack: vietnamesePack)
    XCTAssertEqual(LhLocale.pack(for: "vi"), vietnamesePack)
    LhLocale.shared.setLocale("vi")
    XCTAssertEqual(LhLocale.shared.texts, vietnamesePack)
    XCTAssertEqual(LhLocale.shared.current, "vi")
  }

  /// 注册的语言正是当前语言时立即生效（无需再次 setLocale）
  func testRegistrationAppliesImmediatelyWhenCurrent() {
    LhLocale.shared.setLocale("fr-FR")
    XCTAssertEqual(LhLocale.shared.texts, FrFrLhTexts)
    LhLocale.shared.register("fr-FR", pack: vietnamesePack)
    XCTAssertEqual(LhLocale.shared.texts, vietnamesePack, "注册自定义包应立即生效")
    // 内置包未被覆写：其他地方取 fr-FR 仍能拿到用户包（遮蔽语义）
    XCTAssertEqual(LhLocale.pack(for: "fr-FR"), vietnamesePack)
  }
}
