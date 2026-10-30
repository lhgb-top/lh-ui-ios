# Introduction

**lh-ui-ios** est l'implémentation iOS de la **lignée native** de la famille lh-ui : une bibliothèque de composants UI basée sur **Swift + SwiftUI**.

## Place dans la famille

```
                     ┌── lignée web : share (core TS + SCSS) → plus / vue2 / react / uniapp
famille lh-ui ───────┤ (même marque)
                     └── lignée native : core (jetons JSON + contrats + codegen) → android / ios / harmony / windows
                                                                                ↑ ce dépôt
```

- **Centre de construction** : `lh-ui-core` est la source de vérité des jetons de la lignée native (`tokens/*.json`), les contrats des composants (`specs/`), les cas dorés (`cases/`) et les outils de codegen. Il génère le squelette des jetons Swift (`LhTokens` / `LhDarkTokens` / `LhShadow`), **sans générer aucune implémentation UI**.
- **Rôle de ce dépôt** : écrire à la main les vues SwiftUI, l'intégration des thèmes (injection via Environment), les enums de props et la liaison des valeurs par défaut, et traduire les cas dorés en XCTest.
- **Indépendante de la lignée web** : aucune dépendance à `@lh-ui/share`, les releases ne se contraignent pas mutuellement. La cohérence visuelle est alignée manuellement via *Baseline du langage de conception*.

## Langage de design

Thématique style chinois : couleur principale bleu 青花瓷 (porcelaine bleue) (`#2B4C7C`), fond blanc 宣纸 (papier xuan) (`#FAF6F0`), succès vert 松花绿 (vert songhua), avertissement 藤黄 (jaune herbacé), danger 朱砂 (cinabre), pile de polices à empattements (Noto Serif SC → STSong → SimSun). Toutes les valeurs visuelles sont des jetons ; aucun littéral n'apparaît dans les composants.

## Pourquoi SwiftUI

- UI déclarative, citoyenne de première classe de la plateforme, mentalement isomorphe à Compose / ArkUI : les contrats multi-plateformes sont faciles à aligner
- Intégration SPM en un clic, aucun runtime JS, aucune couche de pontage
- `#Preview` sert de documentation, `View` est le composant — symétrique avec l'expérience de développement SFC de la lignée web

## État actuel

- **La chaîne complète de button est livrée comme prototype** (consommation des jetons + résolution de l'apparence via resolveAppearance + vue SwiftUI + XCTest + `#Preview` + site de documentation)
- Les 13 autres composants P0 (icon / input / textarea / cell / checkbox / radio / switch / tag / dialog / toast / loading / picker / navbar) suivront selon le même paradigme
