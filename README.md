# 🛡️ HellBox Sentinel - Linux Server Health Monitor

A robust Bash-based monitoring tool designed for DevOps engineers to track system health, manage services, and ensure uptime.

## 🚀 Features
- **Disk & RAM Monitoring:** Real-time resource usage tracking.
- **Service Auto-Healing:** Detects crashed services (e.g., Nginx, Docker) and attempts to restart them automatically.
- **Logging:** Keeps detailed audit logs of every scan.
- **Interactive Mode:** User-friendly menu for manual checks.

## 📂 Versions Included

### 1. v1 - The Automator (`sentinel_v1_basic.sh`)
- Basic script for cron jobs.
- Checks Disk/RAM and Nginx automatically.
- **Usage:** `./sentinel_v1_basic.sh`

### 2. v2 - The CLI Tool (`sentinel_v2_cli.sh`)
- Dynamic argument parsing using flags.
- **Usage:** `./sentinel_v2_cli.sh -s docker -t 90`
- `-s`: Service name to check.
- `-t`: Disk threshold percentage.

### 3. v3 - The Interactive Suite (`sentinel_v3_menu.sh`)
- Full menu-driven interface.
- Select options (1-5) to check specific resources.
- **Usage:** `./sentinel_v3_menu.sh`

## 🛠️ Installation
```bash
git clone [https://github.com/YOUR_USERNAME/HellBox-Sentinel.git](https://github.com/YOUR_USERNAME/HellBox-Sentinel.git)
cd HellBox-Sentinel
chmod +x *.sh
./sentinel_v3_menu.sh
