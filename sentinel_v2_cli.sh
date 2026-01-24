#!/bin/bash

# ==========================================
# Project: HellBox Sentinel (v2.0 - CLI)
# Author: Tori
# Usage: ./sentinel_v2_cli.sh -s <service> -t <threshold>
# ==========================================

# Default Defaults
LOG_FILE="sentinel_cli.log"
TARGET="nginx"
THRESHOLD=85
INTERNET_HOST="8.8.8.8"

# UI Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Help Menu
usage() {
    echo "Usage: $0 [-s service_name] [-t disk_threshold]"
    echo "Example: $0 -s docker -t 90"
    exit 1
}

# Parsing Arguments
while getopts "s:t:h" opt; do
    case $opt in
        s) TARGET="$OPTARG" ;;
        t) THRESHOLD="$OPTARG" ;;
        h) usage ;;
        *) usage ;;
    esac
done

# Utility Functions
log() { echo "[$(date '+%H:%M:%S')] $1" >> $LOG_FILE; }
notify() { notify-send "HellBox Alert" "$1" -u critical; }

clear
echo -e "${YELLOW}::: HellBox Sentinel v2.0 :::${NC}"
echo "Target: $TARGET | Disk Limit: $THRESHOLD%"
log "Scan initiated for $TARGET"

# 1. Connectivity Check
if ! ping -c 1 $INTERNET_HOST &> /dev/null; then
    echo -e "${RED}[!] No Internet Connection${NC}"
    notify "Network Down!"
    log "CRITICAL: Offline mode detected."
fi

# 2. Disk Check
USAGE=$(df -h / | awk 'NR==2 {print $5}' | tr -d %)
if [ "$USAGE" -ge "$THRESHOLD" ]; then
    echo -e "${RED}[CRITICAL] Disk Usage: $USAGE%${NC}"
    notify "Disk Full: $USAGE%"
    log "DISK: Critical usage $USAGE%"
else
    echo -e "${GREEN}[OK] Disk Usage: $USAGE%${NC}"
fi

# 3. Service Check logic
if systemctl is-active --quiet "$TARGET"; then
    echo -e "${GREEN}[OK] Service '$TARGET' is active.${NC}"
else
    echo -e "${RED}[!] '$TARGET' is DOWN. Attempting fix...${NC}"
    log "SERVICE DOWN: $TARGET"
    notify "$TARGET is down! Restarting..."
    
    sudo systemctl start "$TARGET"
    sleep 2
    
    if systemctl is-active --quiet "$TARGET"; then
        echo -e "${GREEN} -> Restarted successfully.${NC}"
        log "SERVICE RECOVERED: $TARGET"
    else
        echo -e "${RED} -> Failed to restart.${NC}"
        notify "Failed to fix $TARGET"
    fi
fi

echo "Done."
