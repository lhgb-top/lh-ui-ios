# Démarrage rapide

## Exemple minimal

```swift
import SwiftUI
import LhUI

struct Demo: View {
  var body: some View {
    LhTheme {
      LhButton(
        lhOnClick: { /* gérer le clic */ },
        type: .primary,
        text: "Bouton principal"
      )
    }
  }
}
```

`LhTheme` est le conteneur de thème : tous les composants Lh qu'il encapsule consomment les jetons automatiquement via Environment ; sans encapsulation, la palette claire est utilisée par repli.

## Types et dimensions

```swift
// Six types
LhButton(lhOnClick: {}, text: "Par défaut")                // .default
LhButton(lhOnClick: {}, type: .primary, text: "Principal")
LhButton(lhOnClick: {}, type: .success, text: "Succès")
LhButton(lhOnClick: {}, type: .warning, text: "Avertissement")
LhButton(lhOnClick: {}, type: .danger, text: "Danger")
LhButton(lhOnClick: {}, type: .info, text: "Info")

// Trois dimensions
LhButton(lhOnClick: {}, lhSize: .small, text: "Petit")
LhButton(lhOnClick: {}, lhSize: .medium, text: "Moyen")
LhButton(lhOnClick: {}, lhSize: .large, text: "Grand")
```

## États

```swift
// Désactivé : ne répond pas au clic, affiche l'apparence désactivée
LhButton(lhOnClick: {}, disabled: true, text: "Désactivé")

// Chargement : affiche un indicateur, ne déclenche pas lhOnClick
LhButton(lhOnClick: {}, loading: true, text: "Chargement...")

// Les deux réunis : le désactivé prime (cas doré disabled-precedes-loading)
LhButton(lhOnClick: {}, disabled: true, loading: true, text: "Désactivé prioritaire")
```

## Icône et motif décoratif

```swift
// Le nom de l'icône est résolu par le système d'icônes local (mapping SF Symbol via LhButtonStyle.icon(for:) ; les noms non enregistrés ne sont pas dessinés)
LhButton(lhOnClick: {}, type: .primary, icon: "search", text: "Rechercher")

// Motif décoratif style chinois (consomme le jeton color.decoration)
LhButton(lhOnClick: {}, type: .primary, bgPattern: true, text: "Motif décoratif")
```

## Thèmes clair et sombre

```swift
LhTheme(isDark: isDark) {
  // Tous les composants encapsulés basculent automatiquement sur les jetons sombres (valeurs précalculées par core, aucun mélange à l'exécution)
}
```

## Aperçu des exemples de composants

L'UI native ne peut pas être rendue en temps réel dans le navigateur ; ce site présente l'apparence via un **simulateur de cadre de téléphone en HTML statique intégré** :

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>lh-ui-ios</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn">Bouton par défaut</button>
      <button class="sim-btn sim-btn--primary">Bouton principal</button>
      <button class="sim-btn sim-btn--success">Succès</button>
      <button class="sim-btn sim-btn--warning">Avertissement</button>
      <button class="sim-btn sim-btn--danger">Danger</button>
      <button class="sim-btn sim-btn--info">Info</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--small">Petit</button>
      <button class="sim-btn sim-btn--primary sim-btn--large">Grand</button>
      <button class="sim-btn sim-btn--primary sim-btn--disabled">Désactivé</button>
      <button class="sim-btn sim-btn--primary sim-btn--loading">
        <span class="sim-btn__spinner"></span>Chargement...
      </button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary"><span class="sim-btn__icon"></span>Rechercher</button>
      <button class="sim-btn sim-btn--primary sim-btn--pattern">Motif décoratif</button>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé de l'apparence iOS (SwiftUI), pas un rendu sur appareil réel ; toutes les valeurs de style proviennent de l'instantané des jetons core, mêmes valeurs que sur appareil réel. L'apparence réelle fait référence à <code>#Preview</code> et aux captures d'écran de l'appareil.</p>

> Le mode sombre du simulateur est lié au site : basculez le thème en haut à droite et les couleurs du cadre du téléphone changent (les jetons sombres sont précalculés par core).
