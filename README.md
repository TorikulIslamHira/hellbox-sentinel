<div align="center">

# 🛡️ HellBox Sentinel

**A lightweight Bash health monitor for Linux servers, with self-healing.**

![Bash](https://img.shields.io/badge/Bash-5.x-4EAA25?logo=gnubash&logoColor=white) ![Linux](https://img.shields.io/badge/Linux-Server-FCC624?logo=linux&logoColor=black) ![systemd](https://img.shields.io/badge/systemd-ready-orange) ![License](https://img.shields.io/badge/License-MIT-blue)

</div>

HellBox Sentinel watches disk and RAM usage, checks critical services such as Nginx or Docker, restarts them if they crash, and keeps an audit log of every scan. It is built for DevOps engineers and sysadmins who want simple, dependency-free monitoring that runs from cron or from an interactive menu.

## 📌 Table of Contents

[🎯 What it does](#-what-it-does) · [🧠 Architecture](#-architecture--at-a-glance) · [🛠️ Tech stack](#️-tech-stack) · [📂 Versions](#-versions) · [🚀 Getting started](#-getting-started) · [🗂️ Project status](#️-project-status) · [🧭 Design principles](#-design-principles)

## 🎯 What it does

| Feature | What it does |
|---|---|
| Disk and RAM monitoring | Real-time resource usage tracking with configurable thresholds |
| Service auto-healing | Detects crashed services (for example Nginx or Docker) and tries to restart them |
| Audit logging | Keeps a detailed log of every scan |
| Three modes | Cron-ready script, flag-driven CLI tool, and an interactive menu |
| No dependencies | Pure Bash, works on systemd-based Linux distributions |

## 🧠 Architecture: at a glance

```
cron / CLI / menu  ->  sentinel script  ->  checks (disk, RAM, service)
                                              |
                              healthy  <------+------>  failing
                                |                          |
                            log result            restart service + log
```

The same checks power all three versions. Only the way you start them changes: a cron job (v1), flags on the command line (v2) or a menu (v3).

## 🛠️ Tech stack

| Layer | Technology |
|---|---|
| Language | Bash |
| Service management | systemd (`systemctl`) |
| Scheduling | cron |
| Output | Plain-text audit log |

## 📂 Versions

| Version | Script | Best for |
|---|---|---|
| v1 - The Automator | `sentinel_v1_basic.sh` | Cron jobs. Checks disk, RAM and Nginx automatically |
| v2 - The CLI Tool | `sentinel_v2_cli.sh` | Scripting. Flags: `-s` service name, `-t` disk threshold % |
| v3 - The Interactive Suite | `sentinel_v3_menu.sh` | Manual checks through a menu (options 1-5) |

## 🚀 Getting started

```bash
git clone https://github.com/TorikulIslamHira/hellbox-sentinel.git
cd hellbox-sentinel
chmod +x *.sh
```

Run it:

```bash
# v1: basic automatic check
./sentinel_v1_basic.sh

# v2: check the docker service with a 90% disk threshold
./sentinel_v2_cli.sh -s docker -t 90

# v3: interactive menu
./sentinel_v3_menu.sh
```

Run automatically with cron, every 5 minutes:

```bash
*/5 * * * * /path/to/hellbox-sentinel/sentinel_v1_basic.sh
```

## 🗂️ Project status

| Item | Status |
|---|---|
| Disk and RAM checks | ✅ Done |
| Service auto-healing | ✅ Done |
| CLI flags and interactive menu | ✅ Done |
| Telegram / Discord alerts | ⏳ Planned |
| Docker container health checks | ⏳ Planned |
| Install script with a systemd unit | ⏳ Planned |
| Multi-server status overview | ⏳ Planned |

## 🧭 Design principles

| Principle | Meaning |
|---|---|
| Zero dependencies | Plain Bash, nothing to install on the server |
| Self-healing first | Fix the common failure (a crashed service) before alerting a human |
| Auditable | Every scan leaves a log line you can read later |

## 🔗 Related

See also [NightWatcher](https://github.com/TorikulIslamHira/NightWatcher), a Linux intrusion detection system with Discord alerts.

## 📄 License

Released under the [MIT License](LICENSE).
