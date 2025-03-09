#!/bin/bash

# Variables
REMOTE_USER="<your name>"      # Nom d'utilisateur sur la machine distante
REMOTE_HOST="XX.XX.XX.XX"  # Adresse IP ou nom de domaine de la machine distante
REMOTE_BASE_DIR="/home/${REMOTE_USER}"  # Chemin de base du répertoire sur la machine distante
DISK_MOUNT_PATH="/media/<your name>/DISQUE ESSB"  # Chemin du disque dur externe
GREEN='\033[0;32m'  # Choix de la couleur vert
MAGENTA='\033[0;35m'  # Choix de la couleur magenta
NC='\033[0m'  # Réinitialisation de la couleur

# Dossiers à synchroniser
DIRS=("exercism" "Documents" "bin" "Images")
COMPLEX_DIRS=(".local/share/applications")

# Fonction pour vérifier si une machine est accessible via SSH
check_ssh() {
    echo -e "${GREEN}Vérification de l'accessibilité de la machine distante...${NC}"
    if ssh -o BatchMode=yes -o ConnectTimeout=5 ${REMOTE_USER}@${REMOTE_HOST} exit 2>/dev/null; then
        echo -e "${GREEN}La machine distante est accessible.${NC}"
        # Synchronisation des répertoires simples
        for DIR in "${DIRS[@]}"; do
            echo -e "${GREEN}Synchronisation du répertoire ~/${DIR}...${NC}"
            unison ~/${DIR} ssh://${REMOTE_USER}@${REMOTE_HOST}//${REMOTE_BASE_DIR}/$(basename ${DIR}) -auto -batch -confirmbigdel=false -prefer newer -ignore 'Path env' -ignorearchives
        done

        # Synchronisation des répertoires complexes
        for DIR in "${COMPLEX_DIRS[@]}"; do
            echo -e "${GREEN}Synchronisation du répertoire ~/${DIR}...${NC}"
            sudo unison ~/${DIR} ssh://${REMOTE_USER}@${REMOTE_HOST}//${REMOTE_BASE_DIR}/${DIR} -auto -batch -confirmbigdel=false -prefer newer -ignore 'Path env' -ignorearchives
        done
    else
        echo -e "${MAGENTA}La machine distante n'est pas accessible. Synchronisation annulée.${NC}"
    fi
}

# Fonction pour vérifier si le disque dur est monté
check_disk() {
    echo -e "${GREEN}Vérification de l'accessibilité du disque dur...${NC}"
    if [ -d "${DISK_MOUNT_PATH}/unison" ]; then
        echo -e "${GREEN}Le disque dur est monté et accessible.${NC}"
        # Synchronisation avec le disque dur des répertoires simples
        for DIR in "${DIRS[@]}"; do
            echo -e "${GREEN}Synchronisation avec le disque dur du répertoire ~/${DIR}...${NC}"}"
            unison ~/${DIR} ${DISK_MOUNT_PATH}/unison/$(basename ${DIR}) -auto -batch -confirmbigdel=false -prefer newer -ignore 'Path env' -perms 0 -ignorearchives
        done

        # Synchronisation avec le disque dur des répertoires complexes
        for DIR in "${COMPLEX_DIRS[@]}"; do
            echo -e "${GREEN}Synchronisation avec le disque dur du répertoire ~/${DIR}...${NC}"}"
            unison ~/${DIR} ${DISK_MOUNT_PATH}/unison/${DIR} -auto -batch -confirmbigdel=false -prefer newer -ignore 'Path env' -perms 0 -ignorearchives
        done
    else
        echo -e "${MAGENTA}Le disque dur n'est pas monté ou accessible. Synchronisation annulée.${NC}"
    fi
}

# Vérification de la machine distante
check_ssh

# Vérification du disque dur
check_disk

echo -e "${GREEN}Synchronisation terminée.${NC}"
