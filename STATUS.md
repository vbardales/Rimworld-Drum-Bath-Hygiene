---
mod:        Drum Bath Hygiene
packageId:  nelim.drumbathhygiene
depot:      Rimworld-Drum-Bath-Hygiene
visibilite: public
detache:    oui
etape:      done
licence:    original
licence_ou: création originale, MIT
vitrine:    complete
teste_le:
workshop:   
reste:
  - non_verifie: les treize scenarios de _tools/FUNCTIONAL-SCENARIOS.md, aucun joue, le scenario 0 compris
  - non_verifie: la branche eau froide, qui ne s'atteint qu'en vidant le fut pendant le trajet du baigneur (scenario 3)
  - non_verifie: une sauvegarde faite pendant un bain, mod retire ensuite, laisse-t-elle un avertissement d'orphelin (scenario 12)
  - feature: le feu qui pourrait etre trop fort, parque dans BACKLOG.md
session:    local_86846e45-ee66-436e-978d-5b312225c26f
maj:        2026-09-12, revu a la main par le fil du mod
---

# Drum Bath Hygiene — etat

Fiche d'etat, lue par une passe sur tous les mods plutot qu'en interrogeant les fils un a un.
Elle vit a la racine, jamais dans `Mod/`, donc Steam ne la recoit pas.

Les champs ci-dessus ont ete deduits du disque le 2026-09-12, puis les trois qui ne peuvent pas
l'etre ont ete remplis par le fil qui tient ce mod :

- **`etape`** — `done`. Le mod est ecrit, il compile, il est detache et documente. Il n'a jamais
  tourne en jeu, ce que dit `teste_le` et non `etape`.
- **`teste_le`** — la date du dernier essai en jeu. Vide veut dire jamais, et c'est le cas ici.
- **`reste`** — ce qu'il reste a faire, en trois categories : `feature` pour une
  fonctionnalite manquante au premier jet, `defaut` pour un defaut connu non corrige,
  `non_verifie` pour ce qui n'a pas pu etre verifie.

Ce mod ne declare aucune def, aucun libelle et aucune texture : il n'y a donc **rien a traduire**,
et l'absence de dossier `Languages/` n'est pas un manque.

Ce qui reste tient en une phrase : **tout est ecrit, rien n'a ete joue.** Les treize scenarios de
`_tools/FUNCTIONAL-SCENARIOS.md` attendent une partie, et deux d'entre eux posent une question a
laquelle le disque ne peut pas repondre. Le premier essai en jeu videra presque tout ce bloc d'un
coup ; d'ici la, ne pas publier d'item Workshop.

Vocabulaire de `licence` : `open` licence explicite, `silent` aucune licence et source morte,
`alive` aucune licence mais source vivante, `forbidden` refus ecrit, `original` rien de repris.
