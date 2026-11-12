# 🌪️ Le Déproblématisateur

**Trouver le calme au centre du tourbillon.** Transformer les problèmes en déproblèmes.

Application Flutter Android + Web pour aider à clarifier une situation difficile et trouver un prochain pas réaliste. L’application n’est pas un service médical ni un service d’urgence.

## Fonctionnalités du MVP

- Interface responsive et identité visuelle 🌪️💛
- Parcours guidé : décrire la situation, préciser urgence, énergie, budget et temps
- Pistes d’action adaptées aux réponses (fonctionnement local, sans IA ni compte)
- PANIK : pause et étapes simples pour revenir au prochain pas
- Coffre de solutions avec recherche
- Historique local des problèmes et marquage comme terminé
- Conservation des données sur l’appareil avec `shared_preferences`

## Démarrer

Installer le SDK Flutter : https://docs.flutter.dev/get-started/install

```bash
flutter pub get
flutter run -d chrome
```

Pour lancer sur un appareil Android connecté :

```bash
flutter devices
flutter run -d <device-id>
```

Pour produire les builds :

```bash
flutter build web
flutter build apk
```

Les dossiers de plateforme Flutter (`android/` et `web/`) doivent être générés avec `flutter create .` depuis la racine du projet si ton clone ne les contient pas encore. Cette commande nécessite le SDK Flutter installé.

## Données et vie privée

Les problèmes saisis sont stockés localement sur l’appareil. Cette version ne synchronise pas les données entre appareils et ne les envoie pas à un serveur. Évite d’y inscrire des informations permettant d’identifier une autre personne.

## Sécurité

L’application propose des exercices généraux de clarification, pas un diagnostic ni un traitement. En cas de danger immédiat, contacte les services d’urgence de ta région ou une personne de confiance.

## Slogans

- 🌪️ Trouver le calme au centre du tourbillon.
- 🛠️ Transformer les problèmes en déproblèmes.
- 💛 Est-ce suffisamment bon pour aujourd’hui ?
- « Quand la vie devient un tourbillon, trouve le calme au centre, puis fais un seul pas à la fois. »
