# 🛡️ HellBox Sentinel

![Bash](https://img.shields.io/badge/Bash-5.x-4EAA25?logo=gnubash&logoColor=white) ![Linux](https://img.shields.io/badge/Linux-Server-FCC624?logo=linux&logoColor=black) ![License](https://img.shields.io/badge/License-MIT-blue)

A lightweight, Bash-based Linux server health monitor with self-healing. It watches disk and RAM usage, checks critical services such as Nginx or Docker, restarts them if they crash, and keeps an audit log of every scan.

Built for DevOps engineers and sysadmins who want simple, dependency-free monitoring that runs from cron or from an interactive menu.

## 🚀 Features

| Feature | What it does |
|---|---|
| Disk and RAM monitoring | Real-time resource usage tracking with configurable thresholds |
| Service auto-healing | Detects crashed services (for example Nginx or Docker) and tries to restart them |
| Audit logging | Keeps a detailed log of every scan |
| Three modes | Cron-ready script, flag-driven CLI tool, and an interactive menu |
| No dependencies | Pure Bash, works on systemd-based Linux distributions |

## 📂 Versions

| Version | Script | Best for |
|---|---|---|
| v1 - The Automator | `sentinel_v1_basic.sh` | Cron jobs. Checks disk, RAM and Nginx automatically |
| v2 - The CLI Tool | `sentinel_v2_cli.sh` | Scripting. Flags: `-s` service name, `-t` disk threshold % |
| v3 - The Interactive Suite | `sentinel_v3_menu.sh` | Manual checks through a menu (options 1-5) |

## 🛠️ Installation

```bash
git clone https://github.com/TorikulIslamHira/hellbox-sentinel.git
cd hellbox-sentinel
chmod +x *.sh
```

## ▶️ Usage

```bash
# v1: basic automatic check
./sentinel_v1_basic.sh

# v2: check the docker service with a 90% disk threshold
./sentinel_v2_cli.sh -s docker -t 90

# v3: interactive menu
./sentinel_v3_menu.sh
```

### Run automatically with cron

```bash
# every 5 minutes
*/5 * * * * /path/to/hellbox-sentinel/sentinel_v1_basic.sh
```

## 🗺️ Roadmap

| Planned | Status |
|---|---|
| Telegram / Discord alerts | Planned |
| Docker container health checks | Planned |
| Install script with a systemd unit | Planned |
| Multi-server status overview | Planned |

## 🔗 Related

See also [NightWatcher](https://github.com/TorikulIslamHira/NightWatcher), a Linux intrusion detection system with Discord alerts.

## 📄 License

Released under the [MIT License](LICENSE).
