#!/bin/bash

# Variables
REMOTE_USER=""      # Nom d'utilisateur sur la machine distante
REMOTE_HOST=""  # Adresse IP ou nom de domaine de la machine distante
REMOTE_BASE_DIR="/home/${REMOTE_USER}"  # Chemin de base du répertoire sur la machine distante
DISK_MOUNT_PATH="/media/<your name>/DISQUE ESSB"  # Chemin du disque dur externe

# Dossiers à synchroniser
DIRS=("exercism" "Documents" "bin" "Images")

# Fonction pour vérifier si une machine est accessible via SSH
check_ssh() {
    echo "Vérification de l'accessibilité de la machine distante..."
    if ssh -o BatchMode=yes -o ConnectTimeout=5 ${REMOTE_USER}@${REMOTE_HOST} exit 2>/dev/null; then
        echo "La machine distante est accessible."
        return 0
    else
        echo "La machine distante n'est pas accessible. Synchronisation annulée."
        exit 1
    fi
}

# Fonction pour vérifier si le disque dur est monté
check_disk() {
    echo "Vérification de l'accessibilité du disque dur..."
    if [ -d "${DISK_MOUNT_PATH}/unison" ]; then
        echo "Le disque dur est monté et accessible."
        return 0
    else
        echo "Le disque dur n'est pas monté ou accessible. Synchronisation annulée."
        exit 1
    fi
}

# Vérification de la machine distante
check_ssh

# Vérification du disque dur
check_disk

# Synchronisation
for DIR in "${DIRS[@]}"; do
    echo "Synchronisation du répertoire ~/${DIR}..."
    unison ~/$(basename ${DIR}) ssh://${REMOTE_USER}@${REMOTE_HOST}//${REMOTE_BASE_DIR}/$(basename ${DIR}) -auto -batch -confirmbigdel=false -prefer newer -ignore 'Path env'
done

# Synchronisation avec le disque dur
for DIR in "${DIRS[@]}"; do
    echo "Synchronisation avec le disque dur du répertoire ~/${DIR}..."
    sudo unison ~/$(basename ${DIR}) /media/<your name>/DISQUE\ ESSB/unison/$(basename ${DIR}) -auto -batch -confirmbigdel=false -prefer newer -ignore 'Path env' -perms 0
done

echo "Synchronisation terminée."
