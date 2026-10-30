---
layout: home

hero:
  name: lh-ui-ios
  text: Lignée native · iOS
  tagline: Bibliothèque de composants Swift + SwiftUI, pilotée par jetons, alignée sur les contrats, gardée par les cas dorés
  actions:
    - theme: brand
      text: Démarrage rapide
      link: /fr/guide/quickstart
    - theme: alt
      text: Vue d'ensemble des composants
      link: /fr/components/button

features:
  - title: Pilotée par jetons
    details: "Aucune valeur de couleur ou d'espacement codée en dur dans les composants : ils consomment tous les LhTokens / LhDarkTokens générés par le codegen de core. Modifier un jeton s'applique instantanément à toute la plateforme."
  - title: Contrats cohérents
    details: Le nommage des props est aligné mot pour mot avec lh-ui-core/specs, avec un comportement partagé entre Android / HarmonyOS / Windows et la lignée web.
  - title: Garde des cas dorés
    details: Les assertions comportementales de cases/button.json sont traduites en XCTest, exécutables sur l'hôte macOS (sans simulateur).
  - title: Thèmes clair et sombre
    details: "LhTheme bascule en une ligne ; les jetons sombres sont précalculés par core : aucun mélange de couleurs à l'exécution, aucun clignotement."
  - title: Langage de design style chinois
    details: Couleur principale bleu 青花瓷 (porcelaine bleue), fond blanc 宣纸 (papier xuan), touches 藤黄 (jaune herbacé) et 朱砂 (cinabre), pile de polices à empattements, mêmes valeurs que la lignée web.
  - title: SwiftUI natif
    details: UI écrite à la main en Swift + SwiftUI pur, aucun runtime JS, UI déclarative de première classe, intégration SPM en un clic.
---
