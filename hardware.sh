#!/bin/bash

# Define expected specifications
EXPECTED_TIMEZONE="IST"
EXPECTED_CPU_ARCH="x86_64"
EXPECTED_OS_FAMILY="Red Hat"
CPU_USAGE_THRESHOLD=60
RAM_USAGE_THRESHOLD=60
STORAGE_USAGE_THRESHOLD=60

# Functions to gather system information
get_uptime() {
    uptime -p
}

get_last_reboot() {
    who -b | awk '{print $3, $4}'
}

get_timezone() {
    timedatectl | grep "Time zone" | awk '{print $3}'
}

get_installed_packages() {
    rpm -qa --last | head -n 10
}

get_os_version() {
    cat /etc/redhat-release
}

get_kernel_version() {
    uname -r
}

get_cpu_cores() {
    nproc
}

get_cpu_speed() {
    lscpu | grep "MHz" | awk '{print $3}'
}

get_cpu_architecture() {
    uname -m
}

get_disk_info() {
    df -hT
}

get_ip_addresses() {
    echo "Private IP: $(hostname -I)"
    echo "Public IP: $(curl -s ifconfig.me)"
}

get_dns_info() {
    echo "Hostname: $(hostname)"
    echo "Private DNS: $(hostname -f)"
    echo "Public DNS: $(curl -s http://169.254.169.254/latest/meta-data/public-hostname)"
}

get_network_bandwidth() {
    sudo ethtool $(ip route get 8.8.8.8 | awk '{print $5}') | grep -i speed
}

get_firewall_info() {
    sudo firewall-cmd --list-all
}

get_network_firewall_info() {
    sudo iptables -L
}

get_cpu_utilization() {
    mpstat | awk '$3 ~ /[0-9.]+/ { print 100 - $13 }'
}

get_ram_utilization() {
    free | grep Mem | awk '{print $3/$2 * 100.0}'
}

get_storage_utilization() {
    df -h | awk '$NF=="/"{printf "%.2f", $5}'
}

get_password_expiry() {
    chage -l $USER | grep "Password expires" | awk -F": " '{print $2}'
}

# Collect and audit hardware specifications
report="Hardware Audit Report\n\n"

report+="Server Uptime: $(get_uptime)\n"
report+="Last Server Reboot Timestamp: $(get_last_reboot)\n"

timezone=$(get_timezone)
if [ "$timezone" != "$EXPECTED_TIMEZONE" ]; then
    report+="Server Local Time Zone: $timezone (NON-IST)\n"
else
    report+="Server Local Time Zone: $timezone\n"
fi

report+="Last 10 installed packages with dates:\n$(get_installed_packages)\n\n"

os_version=$(get_os_version)
if [[ "$os_version" != *"$EXPECTED_OS_FAMILY"* ]]; then
    report+="OS version: $os_version (NON-RHEL family)\n"
else
    report+="OS version: $os_version\n"
fi

report+="Kernel version: $(get_kernel_version)\n"
report+="CPU - Virtual cores: $(get_cpu_cores)\n"
report+="CPU - Clock speed: $(get_cpu_speed) MHz\n"

cpu_arch=$(get_cpu_architecture)
if [ "$cpu_arch" != "$EXPECTED_CPU_ARCH" ]; then
    report+="CPU - Architecture: $cpu_arch (NON-x86-64)\n"
else
    report+="CPU - Architecture: $cpu_arch\n"
fi

report+="Disk - Mounted/Unmounted volumes, type, storage:\n$(get_disk_info)\n"
report+="Private and Public IP:\n$(get_ip_addresses)\n"
report+="Private and Public DNS or Hostname:\n$(get_dns_info)\n"
report+="Networking - Bandwidth: $(get_network_bandwidth)\n"
report+="Networking - OS Firewall (Allowed Ports & Protocols):\n$(get_firewall_info)\n"
report+="Networking - Network Firewall (Allowed Ports & Protocols):\n$(get_network_firewall_info)\n"

cpu_utilization=$(get_cpu_utilization)
if (( $(echo "$cpu_utilization > $CPU_USAGE_THRESHOLD" | bc -l) )); then
    report+="CPU - Utilization: $cpu_utilization% (Above Threshold)\n"
else
    report+="CPU - Utilization: $cpu_utilization%\n"
fi

ram_utilization=$(get_ram_utilization)
if (( $(echo "$ram_utilization > $RAM_USAGE_THRESHOLD" | bc -l) )); then
    report+="RAM - Utilization: $ram_utilization% (Above Threshold)\n"
else
    report+="RAM - Utilization: $ram_utilization%\n"
fi

storage_utilization=$(get_storage_utilization)
if (( $(echo "$storage_utilization > $STORAGE_USAGE_THRESHOLD" | bc -l) )); then
    report+="Storage: $storage_utilization% (Above Threshold)\n"
else
    report+="Storage: $storage_utilization%\n"
fi

report+="Current User Password Expiring: $(get_password_expiry)\n"

# Print the audit report
echo -e "$report"
