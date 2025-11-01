#!/usr/bin/env bash
# 🌈 infofetch — a cute neofetch-style system info script with emojis
# No Nerd Font symbols, clean and portable

# ---- Basic System Info ----
USER_NAME=$(whoami)
HOST="GitHub Codespaces"

# OS from /etc/os-release
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS="${PRETTY_NAME}"
else
    OS=$(uname -s)
fi

KERNEL=$(uname -r)
ARCH=$(uname -m)
UPTIME=$(uptime -p | sed 's/up //')
IP=$(hostname -I 2>/dev/null | awk '{print $1}')

# ---- Hardware Info ----
CPU=$(lscpu | grep 'Model name' | sed 's/Model name:[ \t]*//' | head -n1)
MEM_USED=$(free -h | awk '/Mem/ {print $3}')
MEM_TOTAL=$(free -h | awk '/Mem/ {print $2}')
DISK_USED=$(df -h / | awk 'END{print $3}')
DISK_TOTAL=$(df -h / | awk 'END{print $2}')

# ---- Environment Info ----
DE="${XDG_CURRENT_DESKTOP:-N/A}"
WM="${XDG_SESSION_DESKTOP:-N/A}"
GPU=$(lspci 2>/dev/null | grep -E "VGA|3D" | head -n1 | sed 's/.*: //')

# ---- Output ----
echo -e "
🌈  \033[1mInfoFetch — A Cute System Info Tool 💻\033[0m

👤 User:        $USER_NAME
🖥️  Host:        $HOST
💽 OS:          ${OS}
🧠 Kernel:      ${KERNEL}
🏗️  Arch:        ${ARCH}
⚙️  CPU:         ${CPU:-Unknown}
🎨 DE:           ${DE}
🪟 WM:           ${WM}
🎮 GPU:          ${GPU:-Unknown}
💾 Memory:      ${MEM_USED} / ${MEM_TOTAL}
🧱 Disk:        ${DISK_USED} / ${DISK_TOTAL}
⏱️  Uptime:      ${UPTIME}
🌐 IP Address:  ${IP:-N/A}
"