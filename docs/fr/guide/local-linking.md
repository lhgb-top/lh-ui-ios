# Liaison locale

## Convention de disposition de la famille

```
lh-ui/                        # répertoire parent de la famille (pas un dépôt)
├── lh-ui-core/               # source de vérité des jetons + codegen
├── lh-ui-android/            # dépôt frère
├── lh-ui-ios/                # ce dépôt
├── lh-ui-harmony/
└── lh-ui-windows/
```

Lorsque tous les dépôts partagent le même répertoire parent, les jetons sont **liés localement en direct** ; lorsqu'un dépôt frère est absent (clone mono-dépôt en CI), **retour automatique au paquet npm**.
Mécanisme isomorphe à la garde vite alias de la lignée web (plan directeur D18).

## Garde à trois niveaux

`scripts/link-tokens.mjs` recherche les artefacts de jetons par ordre de priorité :

| Priorité | Source | Description |
| --- | --- | --- |
| 1 | `../lh-ui-core/dist/ios` | Liaison locale : modifier un jeton prend effet immédiatement |
| 2 | `node_modules/@lh-ui/core/dist/ios` | Retour npm : le champ `files:["dist"]` de `@lh-ui/core` contient les artefacts des quatre plateformes |
| 3 | — | Erreur et arrêt : sans jeton, impossible de construire |

## Flux quotidien

```bash
# 1. Modifier les jetons (dans le dépôt core)
cd ../lh-ui-core
vim tokens/color.json           # ou spacing / typography / ...

# 2. Régénérer + valider
pnpm codegen                    # génère les artefacts dist/ des quatre plateformes
pnpm verify                     # schema + références + contraste WCAG + cohérence des contrats

# 3. Synchroniser depuis ce dépôt
cd ../lh-ui-ios
pnpm link:tokens                # écrase Sources/LhUITokens/

# 4. Régression
swift test
```

## Garde CI

```bash
pnpm link:tokens:check          # vérifie si les jetons sont synchronisés (comparaison du nombre de fichiers ; code de sortie 1 si non synchronisé)
```

## Interdictions

- ❌ Modifier à la main `Sources/LhUITokens/` (artefact généré, gitignore)
- ❌ Committer les fichiers de jetons générés dans le dépôt
- ❌ Écrire des littéraux de couleur/d'espacement dans les composants (comme `Color(red: 0.169, ...)`, `CGFloat(40)`, police `14`)
- ❌ Contourner `link:tokens` en copiant les artefacts manuellement

## Dépannage

| Symptôme | Cause | Solution |
| --- | --- | --- |
| Erreur de compilation `cannot find 'LhTokens' in scope` | Jetons non synchronisés | `pnpm link:tokens` |
| La valeur d'un jeton ne correspond pas à l'attendu | Le dépôt core n'a pas relancé codegen | Après `pnpm codegen` dans core, relancer la liaison |
| `link:tokens` signale « artefact de jetons introuvable » | Dépôt frère absent et paquet npm non installé | Vérifier la disposition de la famille ou `pnpm i -D @lh-ui/core` |
| Les couleurs sombres sont incorrectes | Couleur principale claire modifiée sans mettre à jour le précalcul du sombre | Mettre à jour `color-dark.json` et relancer (R-n6) |
| Erreurs de compilation liées à `default` | Nom de membre généré non échappé (mot-clé) | Mettre à niveau core (corrigé : les noms de membres portent les accents graves `` `default` ``) |
