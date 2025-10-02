#!/bin/bash

echo "=== Интерактивное создание RAID ==="

if [ "$EUID" -ne 0 ]; then
    echo "Запустите скрипт с sudo!"
    exit 1
fi

# Показываем доступные диски
echo "Доступные диски:"
lsblk

# Проверяем mdadm
if ! command -v mdadm &> /dev/null; then
    apt-get update && apt-get install -y mdadm
fi

# Создаем RAID
read -p "Создать RAID 5 из /dev/sdb1 /dev/sdb2 /dev/sdb3 /dev/sdb4 /dev/sdb5? (y/n): " confirm
if [ "$confirm" = "y" ]; then
    mdadm --create --verbose /dev/md0 --level=5 --raid-devices=5 /dev/sdb1 /dev/sdb2 /dev/sdb3 /dev/sdb4 /dev/sdb5
    
    echo "Статус создания:"
    cat /proc/mdstat
    sleep 3
    
    # Ждем пока массив соберется
    echo "Ожидание сборки массива..."
    while grep -q "resync" /proc/mdstat; do
        sleep 5
    done
    
    # Продолжаем настройку
    mkfs.ext4 /dev/md0
    mkdir -p /mnt/raid5
    mount /dev/md0 /mnt/raid5
    mdadm --detail --scan >> /etc/mdadm/mdadm.conf
    echo "/dev/md0 /mnt/raid5 ext4 defaults 0 2" >> /etc/fstab
    
    echo "Готово!"
    mdadm --detail /dev/md0
fi
