fr :
C’est quoi, Unemployed Staff ? Un annuaire de freelances né entre potes, sur Montpellier. Beaucoup de talents, peu de vitrine : voici donc l’annuaire pour les trouver et leur écrire.

En :
What is Unemployed Staff? A directory of freelancers born between friends, in Montpellier. Many talents, few showcases: here is the directory to find them and write to them.

---

## Pour l’admin : aperçus des réseaux sur la page profil

Chaque page profil (`#profil-prenom-nom`) affiche une grille « bento » : Instagram, LinkedIn, Behance (si le lien existe) et un QR code vers le profil, avec un bouton pour télécharger une image story 1080 × 1920.

**Instagram en direct :** si le lien Instagram du profil contient un pseudo (ex. `https://www.instagram.com/studio.lelatin/`), la case affiche un bouton « Afficher l’aperçu en direct ». Au clic, l’aperçu officiel du profil (photo, abonnés, derniers posts) se charge et se met à jour tout seul. Il ne se charge qu’après un clic, à cause des cookies d’Instagram. Cette page d’aperçu n’est pas documentée par Instagram : si elle disparaît un jour, les cases ci-dessous restent affichées.

**Behance automatique :** chaque lundi à 7 h, le robot `.github/workflows/behance.yml` lit le flux public de chaque compte Behance de `profiles.json` (lien du type `https://www.behance.net/pseudo`). Il télécharge les couvertures des 4 derniers projets dans `img/behance/` et écrit `behance.json`. Ne modifie pas ces fichiers à la main.
- Pour lancer le robot tout de suite : onglet **Actions** du dépôt GitHub → **Aperçus Behance** → **Run workflow**.
- En local (Windows) : `powershell -ExecutionPolicy Bypass -File scripts/behance.ps1`.
- Si le site ne se met pas à jour après le passage du robot, vérifie dans **Settings → Pages** que la publication se fait bien depuis la branche principale.

**LinkedIn :** LinkedIn ne permet pas de récupérer automatiquement la photo ni la bannière, et les liens de ses images expirent. Télécharge-les depuis ton profil LinkedIn, place-les dans le dépôt et indique-les dans `profiles.json`.

Les autres aperçus se règlent dans `profiles.json` :

```json
"previews": {
  "instagram": ["img/apercus/lea-1.jpg", "img/apercus/lea-2.jpg", "img/apercus/lea-3.jpg"],
  "behance": ["img/apercus/lea-projet-1.jpg", "img/apercus/lea-projet-2.jpg"],
  "linkedin": "Designer graphique · Branding & packaging",
  "linkedinPhoto": "img/apercus/lea-linkedin.jpg",
  "linkedinBanner": "img/apercus/lea-banniere.jpg"
}
```

- `instagram` : jusqu’à 6 images carrées, affichées avant le clic sur l’aperçu en direct (3 ou 6, c’est le plus joli).
- `behance` : 2 images au format 4:3, utilisées seulement si le flux Behance automatique est vide.
- `linkedin` : le titre affiché sous le nom.
- `linkedinPhoto` : la photo de profil LinkedIn. Si elle est vide, c’est la `photo` du profil qui s’affiche.
- `linkedinBanner` : la bannière LinkedIn (format 4:1, idéalement 1584 × 396 px). Si elle est vide, un dégradé bleu s’affiche.
- Place les images dans le dépôt (par exemple `img/apercus/`). Les liens directs vers les images d’Instagram expirent : ne les utilise pas.
- Sans images, des cases aux couleurs du métier s’affichent à la place.
