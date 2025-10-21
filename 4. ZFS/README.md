Документация: Работа с ZFS (Zettabyte File System)
1. Введение
Назначение

Данный документ описывает процесс работы с файловой системой ZFS, включая создание пулов, настройку сжатия, импорт/экспорт пулов и работу со снапшотами.
Целевая аудитория

    Системные администраторы
    DevOps инженеры
    Специалисты по хранению данных

Обзор

Процесс включает создание ZFS пулов с различными алгоритмами сжатия, тестирование эффективности сжатия, импорт готового пула и восстановление данных из снапшота.

2. Предварительная информация
Аппаратная конфигурация

    Системный диск: /dev/sda (25GB)
    Диски для ZFS: 8 дисков по 512MB каждый:

        /dev/sdb, /dev/sdc, /dev/sdd, /dev/sde
        /dev/sdf, /dev/sdg, /dev/sdh, /dev/sdi

Программное обеспечение

    ZFS версия: 2.2.2-0ubuntu9.4
    Дистрибутив: Ubuntu

3. Создание ZFS пулов
3.1. Создание mirrored пулов
bash

zpool create otus1 mirror /dev/sdb /dev/sdc
zpool create otus2 mirror /dev/sdd /dev/sde  
zpool create otus3 mirror /dev/sdf /dev/sdg
zpool create otus4 mirror /dev/sdh /dev/sdi

3.2. Проверка созданных пулов
bash

zpool list

Результат:
text

NAME    SIZE  ALLOC   FREE  CKPOINT  EXPANDSZ   FRAG    CAP  DEDUP    HEALTH  ALTROOT
otus1   480M   108K   480M        -         -     3%     0%  1.00x    ONLINE  -
otus2   480M   494K   480M        -         -     3%     0%  1.00x    ONLINE  -
otus3   480M   106K   480M        -         -     3%     0%  1.00x    ONLINE  -
otus4   480M   106K   480M        -         -     3%     0%  1.00x    ONLINE  -

4. Настройка сжатия и тестирование
4.1. Установка различных алгоритмов сжатия
bash

zfs set compression=lzjb otus1
zfs set compression=lz4 otus2
zfs set compression=gzip-9 otus3
zfs set compression=zle otus4

4.2. Проверка настроек сжатия
bash

zfs get all | grep compression | grep -v ref

Результат:
text

otus1  compression  lzjb    local
otus2  compression  lz4     local  
otus3  compression  gzip-9  local
otus4  compression  zle     local

4.3. Тестирование эффективности сжатия
bash

for i in {1..4}; do
  wget -P /otus$i https://gutenberg.org/cache/epub/2600/pg2600.converter.log
done

4.4. Анализ результатов сжатия
bash

ls -l /otus*

Размеры файлов после сжатия:

    /otus1: 22,114 KB (lzjb)

    /otus2: 18,015 KB (lz4)

    /otus3: 10,970 KB (gzip-9)

    /otus4: 40,249 KB (zle)

bash

zfs get all | grep compressratio | grep -v ref

Коэффициенты сжатия:
text

otus1  compressratio  1.82x  # lzjb
otus2  compressratio  2.23x  # lz4
otus3  compressratio  3.67x  # gzip-9
otus4  compressratio  1.00x  # zle

5. Импорт существующего ZFS пула
5.1. Загрузка и распаковка архива
bash

wget -O archive.tar.gz --no-check-certificate 'https://drive.usercontent.google.com/download?id=1MvrcEp-WgAQe57aDEzxSRalPAwbNN1Bb&export=download'
tar -xzvf archive.tar.gz

5.2. Предварительный просмотр пула
bash

zpool import -d zpoolexport/

Результат:
text

pool: otus
id: 6554193320433390805
state: ONLINE
status: Some supported features are not enabled on the pool.

5.3. Импорт пула
bash

zpool import -d zpoolexport/ otus

5.4. Проверка состояния пула
bash

zpool status otus

Результат:
text

pool: otus
state: ONLINE
config:
    NAME                         STATE     READ WRITE CKSUM
    otus                         ONLINE       0     0     0
      mirror-0                   ONLINE       0     0     0
        /root/zpoolexport/filea  ONLINE       0     0     0
        /root/zpoolexport/fileb  ONLINE       0     0     0

6. Анализ свойств импортированного пула
6.1. Проверка основных свойств
bash

zfs get available otus    # 350M
zfs get readonly otus     # off
zfs get recordsize otus   # 128K
zfs get compression otus  # zle
zfs get checksum otus     # sha256

Сводка свойств пула otus:

    Доступное пространство: 350M
    Режим только для чтения: выключен
    Размер записи: 128K
    Сжатие: zle
    Контрольная сумма: sha256

7. Работа со снапшотами ZFS
7.1. Загрузка файла снапшота
bash

wget -O otus_task2.file --no-check-certificate 'https://drive.usercontent.google.com/download?id=1wgxjih8YZ-cqLqaZVa0lA3h3Y029c3oI&export=download'

7.2. Восстановление из снапшота
bash

zfs receive otus/test@today < otus_task2.file

7.3. Поиск и извлечение данных
bash

find /otus/test -name "secret_message"
cat /otus/test/task1/file_mess/secret_message

Результат: https://otus.ru/lessons/linux-hl/
8. Сравнение алгоритмов сжатия

8.1. Эффективность сжатия текстовых данных
Алгоритм	Коэффициент сжатия	Размер файла	Эффективность
gzip-9	3.67x	10,970 KB
lz4	2.23x	18,015 KB
lzjb	1.82x	22,114 KB
zle	1.00x	40,249 KB

8.2. Рекомендации по использованию

    gzip-9: Максимальное сжатие, высокая нагрузка на CPU
    lz4: Хороший баланс скорости и сжатия
    lzjb: Устаревший, но совместимый алгоритм
    zle: Только исключение нулей, минимальное сжатие

9. Ключевые команды ZFS
9.1. Управление пулами
bash

zpool create <pool> <devices>     # Создать пул
zpool list                        # Список пулов
zpool status <pool>               # Статус пула
zpool import -d <dir> <pool>      # Импорт пула
zpool export <pool>               # Экспорт пула

9.2. Управление файловыми системами
bash

zfs set compression=<alg> <pool>  # Установить сжатие
zfs get all <pool>                # Показать все свойства
zfs list                          # Список файловых систем

9.3. Снапшоты и резервное копирование
bash

zfs snapshot <pool>@<name>        # Создать снапшот
zfs send <pool>@<snap> > file     # Экспорт снапшота
zfs receive <pool> < file         # Импорт снапшота

10. Преимущества ZFS
10.1. Функции целостности данных

    Copy-on-Write: предотвращает повреждение данных
    Контрольные суммы: автоматическая проверка целостности
    Self-healing: автоматическое восстановление при mirror/raidz

10.2. Управление хранилищем

    Объединение пулов: гибкое управление пространством
    Динамическое изменение размеров
    Встроенное сжатие и дедупликация

10.3. Снапшоты и клонирование

    Мгновенные снапшоты
    Эффективное клонирование
    Пространственная экономия

11. Рекомендации по использованию
11.1. Настройка сжатия

    Используйте lz4 для общего назначения
    Используйте gzip-9 для архивных данных
    Избегайте zle для сжимаемых данных

11.2. Размер recordsize

    128K для больших файлов (видео, базы данных)
    16K-32K для маленьких файлов
    1M для очень больших файлов

11.3. Мониторинг и обслуживание
bash

zpool status    # Регулярная проверка здоровья
zfs list        # Мониторинг использования
zpool scrub     # Проактивная проверка целостности

12. Часто задаваемые вопросы (FAQ)
Q: Какой алгоритм сжатия лучше?
A: lz4 обеспечивает лучший баланс производительности и сжатия для большинства сценариев.

Q: Как увеличить ZFS пул?
A: Используйте zpool add <pool> <device> для добавления дисков.

Q: Как настроить автоматические снапшоты?
A: Используйте cron или systemd timer с zfs snapshot.

Q: Что делать при ошибках в пуле?
A: Выполните zpool scrub <pool> для проверки и восстановления.

13. Заключение

Все задачи успешно выполнены:

    Созданы 4 ZFS пула с разными алгоритмами сжатия
    Протестирована эффективность сжатия (gzip-9 показал лучший результат - 3.67x)
    Импортирован готовый ZFS пул и проанализированы его свойства
    Восстановлены данные из снапшота и найден секретный URL

ZFS доказала свою эффективность как современная файловая система с расширенными возможностями управления хранилищем, целостностью данных и сжатием.
