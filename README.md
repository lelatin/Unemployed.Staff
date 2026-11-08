fr :
C’est quoi, Unemployed Staff ? Un annuaire de freelances né entre potes, sur Montpellier. Beaucoup de talents, peu de vitrine : voici donc l’annuaire pour les trouver et leur écrire.

En :
What is Unemployed Staff? A directory of freelancers born between friends, in Montpellier. Many talents, few showcases: here is the directory to find them and write to them.

---

## Pour l’admin : aperçus des réseaux sur la page profil

Chaque page profil (`#profil-prenom-nom`) affiche une grille « bento » : Instagram, LinkedIn, Behance (si le lien existe) et un QR code vers le profil, avec un bouton pour télécharger une image story 1080 × 1920.

Instagram, LinkedIn et Behance n’autorisent pas l’affichage en direct de leurs contenus sur un site statique. Les aperçus sont donc des images que tu choisis, à ajouter dans `profiles.json` :

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
