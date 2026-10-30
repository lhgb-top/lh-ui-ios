# Thèmes et mode sombre

## Modèle de jetons

La source de vérité des jetons de la lignée native se trouve dans `lh-ui-core/tokens/*.json` ; le codegen génère les artefacts iOS :

| Artefact | Contenu | Forme sombre |
| --- | --- | --- |
| `LhTokens` | Palette claire complète : dimensions Button, palette Color, Motion, Radius, Shadow, Spacing, Typography, ZIndex | — |
| `LhDarkTokens` | Uniquement le sous-objet `Color` (modèle **d'objets côte à côte**) | Le sombre ne couvre que les couleurs ; dimensions, animations et arrondis sont inchangés en sombre |
| `LhShadow` | Structure porteuse d'ombre SwiftUI (color/opacity/radius/x/y) | — |

> Identique à android / harmony / windows (objets côte à côte), différent du côté documentation (fusion JSON superficielle).
> La couche de thème est conçue en conséquence : `LhColors` ne porte que les couleurs, les dimensions sont prises directement par les composants depuis `LhTokens`.

## LhColors

`LightLhColors` / `DarkLhColors` aplatissent les deux enums générés en un type valeur `Equatable` :

```swift
public struct LhColors: Equatable {
  public let primary: Color
  public let onPrimary: Color
  // ... toutes les couleurs sémantiques
}

public let LightLhColors = LhColors(primary: LhTokens.Color.Primary.`default`, /* ... */)
public let DarkLhColors = LhColors(primary: LhDarkTokens.Color.Primary.`default`, /* ... */)
```

L'initialiseur est public : les tests unitaires peuvent construire directement une palette pour leurs assertions ; côté application, la consommation doit passer par `LhTheme`.

## LhTheme

```swift
LhTheme(isDark: true) {
  // Environment(\.lhColors) injecte DarkLhColors, les composants encapsulés consomment automatiquement
}
```

Sans encapsulation par `LhTheme`, la defaultValue de la clé Environment revient à `LightLhColors` (clair par défaut).

## Précalcul du sombre (important)

Le sombre de la lignée web est évalué dynamiquement via la fonction CSS `color-mix()` ; le natif n'ayant pas de cascade CSS, core a donc **précalculé les expressions sombres en littéraux** (par ex. `rgba(61,100,158,0.25)`, `#B1C1D8`). Conséquence (plan directeur R-n6) :

> **Lorsque vous modifiez la couleur principale du préréglage, les valeurs sombres précalculées ne suivent pas automatiquement** : il faut les recalculer manuellement et mettre à jour
> `lh-ui-core/tokens/color-dark.json`, puis rafraîchir *Baseline du langage de conception*.

## Conventions spécifiques à iOS

- **L'unité de durée est la seconde** : `LhTokens.Motion.Duration.base = 0.300` (android/harmony utilisent des millisecondes, C aussi),
  consommable directement par les API d'animation SwiftUI, sans conversion.
- **Expression des couleurs** : les artefacts générés utilisent du RGB normalisé (`SwiftUI.Color(red:green:blue:)` + `.opacity()`),
  pas de chaînes hexadécimales.
- **Arrondi** : `Radius.circle` est une fraction de 0,5 ; le côté plateforme calcule `min(largeur, hauteur)/2`, à ne pas utiliser tel quel en pt.
- **Ombre** : SwiftUI ne gère pas l'étendue (spread) ; le `LhShadow` généré ignore donc le spread, avec un commentaire.
- **Police** : `Typography.fontFamily` est une chaîne représentant la pile de polices ; le côté plateforme prend la première famille disponible ; le style chinois à empattements est le ton par défaut.

## Aperçu des jetons

Le tableau complet des jetons (clair/sombre/description) se trouve dans `dist/docs/tokens.md` du dépôt core (généré après `pnpm codegen`).
Le mappage des jetons au niveau du composant se trouve dans [Référence des jetons de Button](/fr/components/button#reference-des-jetons).
