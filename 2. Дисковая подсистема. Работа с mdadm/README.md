Документация: Работа с RAID 5 в Linux

1. Введение
Назначение

Данный документ описывает процесс создания, настройки и управления программным RAID 5 массивом в Linux с использованием утилиты mdadm.
Целевая аудитория

    Системные администраторы
    DevOps инженеры
    Специалисты по хранению данных

Обзор

Процесс включает создание RAID 5 массива, тестирование отказоустойчивости, создание разделов и файловых систем, настройку автоматического монтирования.

2. Предварительная информация
Аппаратная конфигурация

    Системный диск: /dev/sda (100GB)
    Диски для RAID: /dev/sdb, /dev/sdc, /dev/sdd, /dev/sde, /dev/sdf (по 1GB каждый)
    Общее количество дисков в RAID: 5
    Тип RAID: RAID 5

Программное обеспечение

    Утилита управления RAID: mdadm
    Утилита разделов: parted
    Файловая система: ext4

3. Создание RAID 5 массива
3.1. Запуск скрипта создания RAID
bash

sudo ./create_raid5.sh

3.2. Параметры созданного RAID

    Устройство: /dev/md0
    Уровень: RAID 5
    Размер чанка: 512K
    Метаданные: версия 1.2
    Алгоритм: 2 (left-symmetric)
    Размер массива: 3.99 GiB (4.29 GB)

3.3. Инициализация файловой системы
bash

mke2fs 1.47.0 (5-Feb-2023)
Creating filesystem with 1046528 4k blocks and 261632 inodes
Filesystem UUID: 0782f6e1-54ef-4a3b-8664-f59e2a6a8849

4. Проверка состояния RAID
4.1. Просмотр статуса массива
bash

cat /proc/mdstat

Результат:
text

md0 : active raid5 sdf[5] sde[3] sdd[2] sdc[1] sdb[0]
      4186112 blocks super 1.2 level 5, 512k chunk, algorithm 2 [5/5] [UUUUU]

4.2. Детальная информация о массиве
bash

sudo mdadm -D /dev/md0

5. Тестирование отказоустойчивости
5.1. Имитация сбоя диска
bash

sudo mdadm /dev/md0 --fail /dev/sde

5.2. Проверка состояния после сбоя
bash

cat /proc/mdstat

Результат:
text

[5/4] [UUU_U]  # Один диск помечен как faulty

5.3. Удаление сбойного диска
bash

sudo mdadm /dev/md0 --remove /dev/sde

5.4. Добавление диска обратно в массив
bash

sudo mdadm /dev/md0 --add /dev/sde

5.5. Мониторинг восстановления
bash

cat /proc/mdstat

Результат восстановления:
text

[===========>.........] recovery = 55.2% (578168/1046528)

6. Работа с разделами на RAID массиве
6.1. Создание GPT разметки
bash

sudo parted /dev/md0 mklabel gpt

6.2. Создание разделов
bash

sudo parted /dev/md0 mkpart part1 0% 20%
sudo parted /dev/md0 mkpart part2 20% 40%
sudo parted /dev/md0 mkpart part3 40% 60%
sudo parted /dev/md0 mkpart part4 60% 80%
sudo parted /dev/md0 mkpart part5 80% 100%

6.3. Информация о разделах
text

Number  Start   End     Size   File system  Name
1      2097kB  858MB   856MB               part1
2      858MB   1715MB  858MB               part2
3      1715MB  2571MB  856MB               part3
4      2571MB  3429MB  858MB               part4
5      3429MB  4284MB  856MB               part5

7. Создание файловых систем
7.1. Форматирование разделов в ext4
bash

sudo mkfs.ext4 /dev/md0p1
sudo mkfs.ext4 /dev/md0p2
sudo mkfs.ext4 /dev/md0p3
sudo mkfs.ext4 /dev/md0p4
sudo mkfs.ext4 /dev/md0p5

7.2. UUID созданных файловых систем

    /dev/md0p1: 53d114f2-edda-4b3a-ab2c-49cbf534f2d7
    /dev/md0p2: 6d7a4bf1-e2f5-4c82-a172-b468f49c1b82
    /dev/md0p3: df242000-29e4-4853-adb4-35066c6f340b
    /dev/md0p4: 6cd6e172-4116-4cf0-917b-b277f8a29965
    /dev/md0p5: 780f4835-1551-4c0c-aa0f-dbaa92b78b91

8. Настройка монтирования
8.1. Создание точек монтирования
bash

sudo mkdir -p /raid/part{1,2,3,4,5}

8.2. Настройка /etc/fstab
bash

sudo nano /etc/fstab

8.3. Монтирование разделов
bash

for i in $(seq 1 5); do sudo mount /dev/md0p$i /raid/part$i; done

9. Структура RAID массива
9.1. Итоговая структура
text

/dev/md0 (RAID 5, 3.99 GiB)
├── /dev/md0p1 (856MB, ext4) → /raid/part1
├── /dev/md0p2 (858MB, ext4) → /raid/part2
├── /dev/md0p3 (856MB, ext4) → /raid/part3
├── /dev/md0p4 (858MB, ext4) → /raid/part4
└── /dev/md0p5 (856MB, ext4) → /raid/part5

10. Ключевые команды управления
10.1. Мониторинг
bash

cat /proc/mdstat                    # Статус RAID массивов
sudo mdadm -D /dev/md0              # Детальная информация
sudo lsblk -f /dev/md0              # Информация о разделах и ФС

10.2. Управление дисками
bash

sudo mdadm /dev/md0 --fail /dev/sde     # Пометить диск как сбойный
sudo mdadm /dev/md0 --remove /dev/sde   # Удалить диск из массива
sudo mdadm /dev/md0 --add /dev/sde      # Добавить диск в массив

10.3. Работа с разделами
bash

sudo parted /dev/md0 mklabel gpt        # Создать GPT разметку
sudo parted /dev/md0 mkpart ...         # Создать раздел
sudo parted /dev/md0 print              # Показать разделы

11. Часто задаваемые вопросы (FAQ)
Q: Почему требуется использовать sudo для большинства команд?
A: Работа с блочными устройствами и RAID массивами требует привилегий суперпользователя.

Q: Что означает статус [UUU_U] в /proc/mdstat?
A: Это показывает состояние дисков в массиве: U - активен, _ - отсутствует/сбойный.

Q: Как долго длится восстановление RAID?
A: Время восстановления зависит от размера дисков и нагрузки на систему. В данном случае восстановление заняло несколько минут.

Q: Можно ли использовать RAID массив без разделов?
A: Да, можно создать файловую систему непосредственно на /dev/md0, но разделы обеспечивают лучшую организацию данных.

Q: Как обеспечить автоматический запуск RAID при загрузке
A: Необходимо сохранить конфигурацию с помощью mdadm --detail --scan >> /etc/mdadm/mdadm.conf

12. Рекомендации

    Регулярно проверяйте состояние RAID с помощью cat /proc/mdstat и mdadm -D
    Настройте мониторинг для автоматического оповещения о сбоях дисков
    Создавайте резервные копии конфигурации RAID:
    bash

sudo mdadm --detail --scan > /etc/mdadm/mdadm.conf

    Тестируйте процедуру восстановления на тестовой среде перед использованием в production
    Используйте journaling файловые системы (как ext4) для повышения надежности

13. Контакты и поддержка

Для решения проблем с RAID массивами обратитесь к:

    Документации mdadm: man mdadm
    Официальной документации дистрибутива Linux
    Форумам и сообществам системных администраторов