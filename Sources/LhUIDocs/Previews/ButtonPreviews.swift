import SwiftUI
import LhUI
import LhUITokens

// 本文件是手写真源（非生成物）—— Button 文档的真交互预览。
// 签名固定为 (DocPreviewScope) -> AnyView，生成页面按 SCENE_MAP 引用：
// 类型→types、尺寸→sizes、状态→states、图标与花纹底→iconAndPattern、明暗主题→theme。
// 取色取距一律走 LhTokens / DocPalette，不出现色值与尺寸字面量。

enum ButtonPreviews {
  static func label(_ type: LhButtonType) -> String {
    switch type {
    case .default: return "默认按钮"
    case .primary: return "主要按钮"
    case .success: return "成功按钮"
    case .warning: return "警告按钮"
    case .danger: return "危险按钮"
    case .info: return "信息按钮"
    }
  }

  static func sizeLabel(_ size: LhButtonSize) -> String {
    switch size {
    case .small: return "小号按钮"
    case .medium: return "中号按钮（默认）"
    case .large: return "大号按钮"
    }
  }

  static func types(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "六种语义类型（点击触发全局 Toast）") {
      PreviewLayout.column {
        ForEach(LhButtonType.allCases, id: \.self) { type in
          LhButton(onClick: { scope.showToast("点击了 \(label(type))") }, type: type, text: label(type))
        }
      }
    })
  }

  static func sizes(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "三种尺寸（高 / 内边距 / 字号随令牌映射）") {
      PreviewLayout.column {
        ForEach(LhButtonSize.allCases, id: \.self) { size in
          LhButton(
            onClick: { scope.showToast("点击了 \(sizeLabel(size))") },
            type: .primary,
            size: size,
            text: sizeLabel(size)
          )
        }
      }
    })
  }

  static func states(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "默认 / 禁用 / 加载中（后两者点击不触发 onClick）") {
      PreviewLayout.column {
        LhButton(onClick: { scope.showToast("点击了普通态按钮") }, text: "默认状态")
        LhButton(onClick: { scope.showToast("禁用态不该响应") }, disabled: true, text: "禁用状态")
        LhButton(onClick: { scope.showToast("加载态不该响应") }, loading: true, text: "加载状态")
      }
    })
  }

  static func iconAndPattern(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "图标（LhIconMap 映射）+ 国风花纹底纹（bgPattern）") {
      PreviewLayout.column {
        LhButton(onClick: { scope.showToast("点击了带图标的按钮") }, type: .primary, icon: "search", text: "搜索")
        LhButton(onClick: { scope.showToast("点击了花纹底纹按钮") }, type: .primary, bgPattern: true, text: "花纹底")
        LhButton(
          onClick: { scope.showToast("点击了图标 + 花纹按钮") },
          type: .warning,
          icon: "star",
          bgPattern: true,
          text: "收藏"
        )
      }
    })
  }

  static func theme(_ scope: DocPreviewScope) -> AnyView {
    AnyView(DocPreviewFrame(title: "明暗色板同屏对比（右上角「切换主题」切全站）") {
      PreviewLayout.columnGroup {
        PreviewLayout.column {
          LhButton(onClick: { scope.showToast("点击了明色主要按钮") }, type: .primary, text: "明色主题")
          LhButton(onClick: { scope.showToast("点击了明色默认按钮") }, text: "明色主题")
        }
        // 暗色区块：LhTheme 注入暗色色板，容器底色取暗色令牌（非字面量）
        LhTheme(isDark: true) {
          PreviewLayout.column {
            LhButton(onClick: { scope.showToast("点击了暗色主要按钮") }, type: .primary, text: "暗色主题")
            LhButton(onClick: { scope.showToast("点击了暗色默认按钮") }, text: "暗色主题")
          }
        }
        .padding(DocPalette.cardPadding)
        .background(
          RoundedRectangle(cornerRadius: DocPalette.cardRadius)
            .fill(DarkLhColors.backgroundPage)
        )
        .environment(\.colorScheme, .dark)
      }
    })
  }
}
