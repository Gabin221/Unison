# Script de Synchronisation avec Unison

Ce script Bash utilise Unison pour synchroniser plusieurs répertoires entre une machine locale, une machine distante via SSH, et un disque dur externe. Voici une explication détaillée des fonctionnalités du script :

## Variables

- **REMOTE_USER** : Nom d'utilisateur sur la machine distante.
- **REMOTE_HOST** : Adresse IP ou nom de domaine de la machine distante.
- **REMOTE_BASE_DIR** : Chemin de base du répertoire sur la machine distante.
- **DISK_MOUNT_PATH** : Chemin du disque dur externe monté.

## Dossiers à Synchroniser

- **DIRS** : Liste des répertoires locaux à synchroniser (**exercism**, **Documents**, **bin**, **Images**).

## Fonctionnalités

1. **Vérification de l'accessibilité de la machine distante** :
   - La fonction **check_ssh** teste la connexion SSH à la machine distante. Si la connexion échoue, le script se termine avec un message d'erreur.

2. **Vérification de l'accessibilité du disque dur** :
   - La fonction **check_disk** vérifie si le disque dur externe est monté et accessible. Si le disque dur n'est pas monté ou inaccessible, le script se termine avec un message d'erreur.

3. **Synchronisation des répertoires locaux avec la machine distante** :
   - La boucle **for** parcourt les répertoires spécifiés et utilise Unison pour les synchroniser avec les répertoires correspondants sur la machine distante. L'option **-ignore 'Path env'** permet d'ignorer les dossiers **env**.

4. **Synchronisation des répertoires locaux avec le disque dur externe** :
   - Une autre boucle **for** utilise Unison pour synchroniser les répertoires locaux avec les répertoires correspondants sur le disque dur externe. L'option **-perms 0** est utilisée pour ignorer les permissions de fichiers.

## Exécution du Script

1. **Définir les variables** : Remplacez les valeurs dans les variables **REMOTE_USER**, **REMOTE_HOST**, et **DISK_MOUNT_PATH** avec les valeurs appropriées.
2. **Accorder les permissions d'exécution** : Rendez le script exécutable avec **chmod +x script.sh**.
3. **Exécuter le script** : Lancez le script avec **./script.sh**.

Assurez-vous que les chemins et les permissions sont corrects avant d'exécuter le script pour éviter tout problème de synchronisation.
