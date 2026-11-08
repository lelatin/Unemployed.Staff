fr :
C’est quoi, Unemployed Staff ? Un annuaire de freelances né entre potes, sur Montpellier. Beaucoup de talents, peu de vitrine : voici donc l’annuaire pour les trouver et leur écrire.

En :
What is Unemployed Staff? A directory of freelancers born between friends, in Montpellier. Many talents, few showcases: here is the directory to find them and write to them.

---

## Pour l’admin : aperçus des réseaux sur la page profil

Chaque page profil (`#profil-prenom-nom`) affiche une grille « bento » : Instagram, LinkedIn, Behance (si le lien existe) et un QR code vers le profil, avec un bouton pour télécharger une image story 1080 × 1920.

**Instagram en direct :** si le lien Instagram du profil contient un pseudo (ex. `https://www.instagram.com/studio.lelatin/`), la case affiche un bouton « Afficher l’aperçu en direct ». Au clic, l’aperçu officiel du profil (photo, abonnés, derniers posts) se charge et se met à jour tout seul. Il ne se charge qu’après un clic, à cause des cookies d’Instagram. Cette page d’aperçu n’est pas documentée par Instagram : si elle disparaît un jour, les cases ci-dessous restent affichées.

LinkedIn et Behance n’ont pas d’équivalent. Pour eux (et pour l’image affichée avant le clic sur Instagram), les aperçus sont des images que tu choisis, à ajouter dans `profiles.json` :

```json
"previews": {
  "instagram": ["img/apercus/lea-1.jpg", "img/apercus/lea-2.jpg", "img/apercus/lea-3.jpg"],
  "behance": ["img/apercus/lea-projet-1.jpg", "img/apercus/lea-projet-2.jpg"],
  "linkedin": "Designer graphique · Branding & packaging"
}
```

- `instagram` : jusqu’à 6 images carrées (3 ou 6, c’est le plus joli).
- `behance` : jusqu’à 2 images au format 4:3.
- `linkedin` : le titre affiché sous le nom.
- Place les images dans le dépôt (par exemple `img/apercus/`). Les liens directs vers les images d’Instagram expirent : ne les utilise pas.
- Sans images, des cases aux couleurs du métier s’affichent à la place.
