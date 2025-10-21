Документация: Работа с LVM (Logical Volume Manager)
1. Введение
Назначение

Данный документ описывает полный процесс работы с LVM в Linux, включая миграцию системы на LVM, создание томов, снапшотов и работу с различными файловыми системами.
Целевая аудитория

    Системные администраторы

    DevOps инженеры

    Специалисты по хранению данных

Обзор

Процесс включает три основных этапа:

    Миграция корневой файловой системы на LVM

    Создание и настройка томов для /var, /home, /opt

    Работа со снапшотами и различными файловыми системами

2. Предварительная информация
Аппаратная конфигурация

    Системный диск: /dev/sda (25GB)

    Диск для LVM: /dev/sdb (100GB)

    Дополнительные диски: /dev/sdc (20GB), /dev/sdd (10GB), /dev/sde (10GB)

Исходное состояние системы
text

Файловая система: 30% использовано (6.8GB из 25GB)
Тип ФС: ext4 на /dev/sda2

3. Этап 1: Миграция системы на LVM
3.1. Создание физического тома и группы томов
bash

pvcreate /dev/sdb
vgcreate vg_root /dev/sdb
lvcreate -n lv_root -l +100%FREE /dev/vg_root

3.2. Создание файловой системы и копирование данных
bash

mkfs.ext4 /dev/vg_root/lv_root
mount /dev/vg_root/lv_root /mnt
rsync -avxHAX --progress / /mnt/

3.3. Подготовка chroot окружения
bash

for i in /proc /sys /dev /run /boot; do
    mount --bind /$i /mnt/$i
done
chroot /mnt

3.4. Обновление загрузчика
bash

grub-mkconfig -o /boot/grub/grub.cfg
update-initramfs -u

3.5. Результат миграции

    Новая корневая ФС: /dev/mapper/vg_root-lv_root

    Размер: 100GB (увеличение с 25GB)

    Использование: 8% (6.8GB)

4. Этап 2: Создание дополнительных томов
4.1. Подготовка физических томов
bash

pvcreate /dev/sdc /dev/sdd /dev/sde
vgcreate ubuntu-vg /dev/sdc /dev/sdd /dev/sde

4.2. Создание логических томов
bash

lvcreate -n lv_var -L 20G ubuntu-vg    # Для /var
lvcreate -n lv_home -L 10G ubuntu-vg   # Для /home  
lvcreate -n lv_opt -L 5G ubuntu-vg     # Для /opt

4.3. Создание файловых систем
bash

mkfs.ext4 /dev/ubuntu-vg/lv_var        # ext4 для /var
mkfs.xfs /dev/ubuntu-vg/lv_home        # XFS для /home

4.4. Установка необходимых пакетов
bash

apt install xfsprogs    # Для XFS
apt install btrfs-progs # Для Btrfs

5. Этап 3: Перенос данных и настройка монтирования
5.1. Перенос /var
bash

mkdir -p /mnt/var
mount /dev/ubuntu-vg/lv_var /mnt/var
cp -aR /var/* /mnt/var/
rm -rf /var/*
umount /mnt/var

5.2. Перенос /home
bash

mkdir -p /mnt/home  
mount /dev/ubuntu-vg/lv_home /mnt/home
cp -aR /home/* /mnt/home/

5.3. Настройка /etc/fstab
text

/dev/ubuntu-vg/lv_var /var ext4 defaults,noatime 0 2
/dev/ubuntu-vg/lv_home /home xfs defaults,nodev,nosuid 0 2
/dev/ubuntu-vg/lv_opt /opt btrfs compress=zstd,noatime,autodefrag 0 2

6. Работа со снапшотами
6.1. Создание снапшота для /home
bash

lvcreate -L 2G -n lv_home_snap ubuntu-vg
mkfs.ext4 /dev/ubuntu-vg/lv_home_snap

6.2. Проверка снапшотов
bash

lvs | grep snap

Результат:
text

lv_home_snap ubuntu-vg -wi-a----- 2.00g

7. Настройка Btrfs для /opt
7.1. Создание файловой системы Btrfs
bash

mkfs.btrfs -f /dev/ubuntu-vg/lv_opt

7.2. Монтирование с оптимизациями
bash

mount -o compress=zstd,noatime,autodefrag /dev/ubuntu-vg/lv_opt /opt

7.3. Работа с субволюмами Btrfs
bash

btrfs subvolume create /opt/data
btrfs subvolume snapshot /opt/data /opt/data_snapshot
btrfs subvolume list /opt

8. Итоговая конфигурация
8.1. Структура томов
text

vg_root (100GB)
└── lv_root (100GB) - ext4 - /

ubuntu-vg (40GB)
├── lv_var (20GB) - ext4 - /var
├── lv_home (10GB) - XFS - /home  
├── lv_opt (5GB) - Btrfs - /opt
└── lv_home_snap (2GB) - ext4 - снапшот

8.2. Состояние файловых систем
text

/    - 98G, 4.0G used (5%) - ext4
/var - 20G, 2.4G used (13%) - ext4  
/home - 10G, 604M used (6%) - XFS
/opt - 5.0G, 5.9M used (1%) - Btrfs

8.3. Проверка данных

    Файлов в /home: 20 тестовых файлов

    Btrfs настроен: Да, с субволюмами

    Снапшоты: lv_home_snap (2GB)

9. Ключевые команды управления LVM
9.1. Мониторинг
bash

pvs                    # Физические тома
vgs                    # Группы томов  
lvs                    # Логические тома
lsblk                  # Блочные устройства
df -hT                 # Файловые системы

9.2. Создание томов
bash

pvcreate /dev/sdX      # Создать физический том
vgcreate vg_name /dev/sdX # Создать группу томов
lvcreate -n lv_name -L size vg_name # Создать логический том

9.3. Снапшоты
bash

lvcreate -L size -n snap_name -s /dev/vg/lv_original # Создать снапшот

9.4. Изменение размеров
bash

lvextend -L +size /dev/vg/lv_name # Увеличить том
lvreduce -L -size /dev/vg/lv_name # Уменьшить том

10. Особенности файловых систем
10.1. Ext4

    Использование: /, /var

    Преимущества: Надежность, journaling

    Настройки: defaults, noatime

10.2. XFS

    Использование: /home

    Преимущества: Высокая производительность для больших файлов

    Настройки: defaults, nodev, nosuid

10.3. Btrfs

    Использование: /opt

    Преимущества: Снапшоты, компрессия, субволюмы

    Настройки: compress=zstd, noatime, autodefrag

11. Рекомендации
11.1. Безопасность

    Используйте nodev,nosuid для пользовательских разделов (/home)

    Регулярно создавайте снапшоты важных данных

    Настройте мониторинг использования пространства

11.2. Производительность

    Используйте noatime для уменьшения нагрузки на диск

    Применяйте компрессию для Btrfs томов

    Выбирайте файловую систему в зависимости от нагрузки

11.3. Резервное копирование
bash

# Создание снапшота для бэкапа
lvcreate -L 2G -n backup_snap -s /dev/ubuntu-vg/lv_home

12. Часто задаваемые вопросы (FAQ)
Q: Почему выбраны разные файловые системы?

A: Каждая ФС имеет свои преимущества: ext4 - надежность, XFS - производительность, Btrfs - современные функции.
Q: Как увеличить том при нехватке места?

A: Используйте lvextend, затем resize2fs для ext4 или xfs_growfs для XFS.
Q: Как создать новый снапшот?

A: lvcreate -L size -n snap_name -s /dev/vg/lv_original
Q: Что делать при проблемах с загрузкой?

A: Используйте LiveCD и восстановите конфигурацию LVM через vgchange -ay.
13. Контакты и поддержка

Для решения проблем с LVM обратитесь к:

    Документации LVM: man lvm

    Официальной документации дистрибутива

    Форумам системных администраторов

Статус выполнения: Все задачи успешно выполнены, система мигрирована на LVM с оптимальной конфигурацией томов и файловых систем.