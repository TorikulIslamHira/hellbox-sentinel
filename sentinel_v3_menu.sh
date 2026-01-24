#!/bin/bash

# ==========================================
# Project: HellBox Sentinel (v3.0 - Interactive)
# Author: Tori
# Description: Menu-driven system monitor
# ==========================================

# Colors
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# --- Modules ---

check_storage() {
    echo -e "\n${CYAN}[ Disk Analysis ]${NC}"
    df -h / | awk 'NR==2 {printf "Total: %s | Used: %s (%s)\n", $2, $3, $5}'
    echo "--------------------------"
}

check_memory() {
    echo -e "\n${CYAN}[ RAM Analysis ]${NC}"
    free -h | awk 'NR==2 {printf "Total: %s | Free: %s | Available: %s\n", $2, $4, $7}'
    echo "--------------------------"
}

check_custom_service() {
    echo -e "\n${CYAN}[ Service Monitor ]${NC}"
    read -p "Enter service name (e.g., nginx, ssh, docker): " SERV
    
    if [ -z "$SERV" ]; then
        echo "Error: No name entered."
        return
    fi

    if systemctl is-active --quiet "$SERV"; then
        echo -e "${GREEN}✔ $SERV is RUNNING.${NC}"
    else
        echo -e "${RED}✘ $SERV is NOT RUNNING.${NC}"
        read -p "Attempt start? (y/n): " CONFIRM
        if [[ "$CONFIRM" == "y" || "$CONFIRM" == "Y" ]]; then
            sudo systemctl start "$SERV"
            echo "Starting..."
            sleep 1
            if systemctl is-active --quiet "$SERV"; then
                echo -e "${GREEN}Success.${NC}"
            else
                echo -e "${RED}Failed. Check logs.${NC}"
            fi
        fi
    fi
}

full_system_scan() {
    echo "Running global scan..."
    check_storage
    check_memory
    # Default check for nginx
    if systemctl is-active --quiet nginx; then
        echo -e "Nginx Status: ${GREEN}OK${NC}"
    else
        echo -e "Nginx Status: ${RED}DOWN${NC}"
    fi
}

# --- Main Interface ---
clear
echo -e "${GREEN}==============================${NC}"
echo -e "${GREEN}   HELLBOX SENTINEL v3.0      ${NC}"
echo -e "${GREEN}==============================${NC}"

PS3='Select Option: '
options=("Check Disk" "Check RAM" "Service Manager" "Full Scan" "Exit")

select opt in "${options[@]}"
do
    case $opt in
        "Check Disk") check_storage ;;
        "Check RAM") check_memory ;;
        "Service Manager") check_custom_service ;;
        "Full Scan") full_system_scan ;;
        "Exit") 
            echo "Exiting..."
            break 
            ;;
        *) echo "Invalid selection." ;;
    esac
    echo -e "\n${CYAN}Task complete. Waiting for command...${NC}"
done
