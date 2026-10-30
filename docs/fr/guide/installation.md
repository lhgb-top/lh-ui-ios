# Installation

## Prérequis

- Xcode 15+, Swift 5.9+
- iOS 15.0+ (macOS 12+ uniquement pour exécuter les XCTest sur l'hôte)
- Chaîne de build : Node.js >= 20 + pnpm (uniquement pour la liaison des jetons et le site de documentation, **n'entre pas dans le runtime**)

## Intégration SPM

Dans Xcode : File → Add Package Dependencies…, renseignez l'adresse de ce dépôt ; ou éditez directement `Package.swift` :

```swift
dependencies: [
  .package(url: "https://github.com/lhgb-top/lh-ui-ios", from: "0.0.1")
],
targets: [
  .target(name: "MyApp", dependencies: [.product(name: "LhUI", from: "lh-ui-ios")])
]
```

La cible de jetons `LhUITokens` est automatiquement incluse avec la dépendance `LhUI` (cible interne au paquet SPM, aucune déclaration supplémentaire nécessaire).

## Synchroniser les jetons (lors du développement de ce dépôt depuis les sources)

Les jetons sont des artefacts générés : ils doivent être synchronisés depuis `lh-ui-core` (source unique, ne pas modifier à la main) :

```bash
cd ../lh-ui-core && pnpm codegen   # génère les artefacts de jetons dist/ios
cd ../lh-ui-ios
pnpm install                        # installe la chaîne de build
pnpm link:tokens                    # synchronise les jetons vers Sources/LhUITokens/
```

`pnpm link:tokens` embarque une garde d'existence à trois niveaux : `../lh-ui-core/dist/ios` local → artefact npm `@lh-ui/core` → erreur.

## Vérifier l'installation

```bash
swift build        # compiler
swift test         # cas dorés (exécutables sur l'hôte macOS, sans simulateur)
```
