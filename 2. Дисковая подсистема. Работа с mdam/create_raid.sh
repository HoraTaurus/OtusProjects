#!/bin/bash

# скрипт для создания RAID 5 из пяти дисков

echo "=== Создание RAUD 5 ==="


# Проверка установки mdadm и устанавливаем если нет
if ! command -v mdadm &> /dev/null; then
	echo "Установка mdadm..."
	sudo apt-get update && apt-get install -y mdadm
fi

# создаём RAID 5 из 5 дисков
echo "Создание RAID массива..."
mdadm --create --verbose /dev/md01 --level=5 /dev/sdb1 /dev/sdb2 /dev/sdb3 /dev/sdb4 /dev/sdb5

# проверяем статус RAID
echo "Статус RAID массива:"
cat /proc/mdstat

# Сохраняем файловую систему
echo "Сохранение конфигурации..."
mdadm --detail --scan >> /etc/mdadm/mdadm.conf
update-initramfs -u

# создаём файловую систему
echo "Создание файловой системы ext4..."
mkfs.ext4 /dev/md01

# Создаём точку монтирования
mkdir -p /mnt/raid5

# монтируем RAID
mount /dev/md01 /mnt/raid5

# Добавляем в fstab для автоматического монтирования
echo "/dev/md01 /mnt/raid5 ext4 defaults 0 2" >> /etc/fstab

echo "=== RAID 5 успешно создан и смонтирован в /mnt/raid5 ==="
echo "Детальная информация:"
mdadm --detail /dev/md01