#!/bin/bash

# ==========================================
# Project: HellBox Sentinel (v1.0)
# Author: Tori
# Purpose: Basic Server Health Monitoring
# ==========================================

# Configs
LOG_FILE="sentinel_basic.log"
SERVICE="nginx"
DISK_LIMIT=80

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> $LOG_FILE
}

echo "--- Starting Scan ---"

# 1. Check Disk Space
# Using awk to grab the percentage only
CURRENT_USAGE=$(df -h / | awk 'NR==2 {print $5}' | tr -d %)

if [ "$CURRENT_USAGE" -ge "$DISK_LIMIT" ]; then
    echo "WARNING: Disk space is critical: $CURRENT_USAGE%"
    log "CRITICAL: Disk usage at $CURRENT_USAGE%"
else
    echo "Disk Space: OK ($CURRENT_USAGE%)"
fi

# 2. Check Service Status (Auto-Heal)
if systemctl is-active --quiet "$SERVICE"; then
    echo "Service [$SERVICE]: RUNNING"
else
    echo "ALERT: [$SERVICE] is DOWN! Trying to restart..."
    log "ALERT: $SERVICE was down. Attempting restart."
    
    # Try to fix it
    sudo systemctl start "$SERVICE"
    sleep 2
    
    if systemctl is-active --quiet "$SERVICE"; then
        echo " -> Recovery Successful."
        log "RECOVERY: $SERVICE restarted successfully."
    else
        echo " -> Failed to restart."
        log "ERROR: Could not restart $SERVICE."
    fi
fi

echo "--- Scan Finished ---"
