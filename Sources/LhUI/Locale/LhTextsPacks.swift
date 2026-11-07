import SwiftUI

/// 内置语言包：10 种语言，代码与 web 血脉 `lh-ui-share` 的 `LH_LANGUAGE_CONST`
/// 逐字对齐。
///
/// 命名对标 `LightLhColors` / `DarkLhColors`（顶层 public let 常量）。
/// 译文取 web 语言包（`lh-ui-share/src/locales/lang/*.ts`）与家族术语表
/// （`docs/i18n/glossary.md`）的既有共识；zh-CN 的确认/取消取
/// `lh-ui-core/specs/*.json` 的 `"确认"` / `"取消"`（R-n5 逐字对齐）。

/// 简体中文（缺省语言）
public let ZhCnLhTexts = LhTexts(
  dialogConfirm: "确认",
  dialogCancel: "取消",
  pickerConfirm: "确认",
  pickerCancel: "取消",
  loadingLabel: "加载中",
  switchLabel: "开关",
  inputLabelFallback: "输入框",
  textareaLabelFallback: "多行输入框"
)

/// 繁體中文
public let ZhTwLhTexts = LhTexts(
  dialogConfirm: "確認",
  dialogCancel: "取消",
  pickerConfirm: "確認",
  pickerCancel: "取消",
  loadingLabel: "載入中",
  switchLabel: "開關",
  inputLabelFallback: "輸入框",
  textareaLabelFallback: "多行輸入框"
)

/// English
public let EnUsLhTexts = LhTexts(
  dialogConfirm: "Confirm",
  dialogCancel: "Cancel",
  pickerConfirm: "Confirm",
  pickerCancel: "Cancel",
  loadingLabel: "Loading",
  switchLabel: "Switch",
  inputLabelFallback: "Text field",
  textareaLabelFallback: "Multi-line text field"
)

/// 日本語
public let JaJpLhTexts = LhTexts(
  dialogConfirm: "確認",
  dialogCancel: "キャンセル",
  pickerConfirm: "確認",
  pickerCancel: "キャンセル",
  loadingLabel: "読み込み中",
  switchLabel: "スイッチ",
  inputLabelFallback: "テキストフィールド",
  textareaLabelFallback: "複数行テキストフィールド"
)

/// 한국어
public let KoKrLhTexts = LhTexts(
  dialogConfirm: "확인",
  dialogCancel: "취소",
  pickerConfirm: "확인",
  pickerCancel: "취소",
  loadingLabel: "로딩 중",
  switchLabel: "스위치",
  inputLabelFallback: "텍스트 필드",
  textareaLabelFallback: "여러 줄 텍스트 필드"
)

/// Deutsch（仅运行时，文档站不提供——与 web 血脉一致）
public let DeDeLhTexts = LhTexts(
  dialogConfirm: "Bestätigen",
  dialogCancel: "Abbrechen",
  pickerConfirm: "Bestätigen",
  pickerCancel: "Abbrechen",
  loadingLabel: "Wird geladen",
  switchLabel: "Schalter",
  inputLabelFallback: "Textfeld",
  textareaLabelFallback: "Mehrzeiliges Textfeld"
)

/// Français
public let FrFrLhTexts = LhTexts(
  dialogConfirm: "Confirmer",
  dialogCancel: "Annuler",
  pickerConfirm: "Confirmer",
  pickerCancel: "Annuler",
  loadingLabel: "Chargement",
  switchLabel: "Commutateur",
  inputLabelFallback: "Champ de texte",
  textareaLabelFallback: "Champ de texte multiligne"
)

/// Español
public let EsLhTexts = LhTexts(
  dialogConfirm: "Confirmar",
  dialogCancel: "Cancelar",
  pickerConfirm: "Confirmar",
  pickerCancel: "Cancelar",
  loadingLabel: "Cargando",
  switchLabel: "Interruptor",
  inputLabelFallback: "Campo de texto",
  textareaLabelFallback: "Campo de texto de varias líneas"
)

/// العربية（RTL）
public let ArLhTexts = LhTexts(
  dialogConfirm: "تأكيد",
  dialogCancel: "إلغاء",
  pickerConfirm: "تأكيد",
  pickerCancel: "إلغاء",
  loadingLabel: "جارٍ التحميل",
  switchLabel: "مفتاح تبديل",
  inputLabelFallback: "حقل نص",
  textareaLabelFallback: "حقل نص متعدد الأسطر"
)

/// Русский
public let RuLhTexts = LhTexts(
  dialogConfirm: "Подтвердить",
  dialogCancel: "Отмена",
  pickerConfirm: "Подтвердить",
  pickerCancel: "Отмена",
  loadingLabel: "Загрузка",
  switchLabel: "Переключатель",
  inputLabelFallback: "Текстовое поле",
  textareaLabelFallback: "Многострочное текстовое поле"
)
