RPM Builder - Документация
Обзор проекта

Проект представляет собой контейнеризированное решение для сборки RPM-пакетов и организации репозитория на базе AlmaLinux 9 с использованием Docker и Docker Compose.

Docker Конфигурация
Dockerfile
dockerfile

FROM almalinux:9

RUN dnf update -y && \
    dnf install -y wget rpmdevtools rpm-build createrepo yum-utils cmake gcc git nano nginx lynx && \
    dnf clean all

WORKDIR /root
EXPOSE 80
CMD ["/bin/bash"]

Ключевые особенности:

    Базовый образ: AlmaLinux 9

    Установленные пакеты:

        Инструменты сборки: rpmdevtools, rpm-build, createrepo, cmake, gcc
        Утилиты управления пакетами: yum-utils
        Веб-сервер: nginx (порт 80)
        Сетевые утилиты: wget, lynx
        Системные утилиты: git, nano

    Рабочая директория: /root

    Открытый порт: 80 (для веб-доступа к репозиторию)

docker-compose.yml
yaml

version: '3.8'

services:
  rpm-builder:
    build: .
    container_name: rpm-builder
    volumes:
      - ./rpms:/root/rpmbuild/RPMS
      - ./sources:/root/rpmbuild/SOURCES
      - ./specs:/root/rpmbuild/SPECS
    stdin_open: true
    tty: true

Конфигурация сервиса:
    Имя контейнера: rpm-builder
    Volume маунты:

        ./rpms → /root/rpmbuild/RPMS (выходные RPM-пакеты)
        ./sources → /root/rpmbuild/SOURCES (исходные коды)
        ./specs → /root/rpmbuild/SPECS (spec-файлы)

Интерактивный режим с TTY

Процесс сборки (из RPM.log)
Установленные зависимости
text

yum install -y gcc
yum install -y rpm-build
yum install -y redhat-rpm-config

Структура каталогов RPM
text

/root/rpmbuild/
├── BUILD
├── RPMS
├── SOURCES
├── SPECS
└── SRPMS

Процесс сборки пакета
text

Сборка пакета: example-app
Версия: 1.0.0
Архитектура: x86_64

Результаты сборки
text

Собранные RPM-пакеты:
/root/rpmbuild/RPMS/x86_64/example-app-1.0.0-1.el8.x86_64.rpm

Использование
Запуск среды сборки
bash

# Сборка и запуск контейнера
docker-compose up -d

# Вход в контейнер
docker-compose exec rpm-builder bash

Подготовка файлов для сборки
bash

# Создание структуры каталогов на хосте
mkdir -p specs sources rpms

# Размещение файлов:
# - spec-файлы в ./specs/
# - исходные коды в ./sources/
# - готовые RPM в ./rpms/ (автоматически)

Процесс сборки внутри контейнера
bash

# Инициализация RPM окружения
rpmdev-setuptree

# Копирование spec-файлов и исходных кодов
cp /path/to/specs/* /root/rpmbuild/SPECS/
cp /path/to/sources/* /root/rpmbuild/SOURCES/

# Сборка RPM пакета
cd /root/rpmbuild/SPECS
rpmbuild -ba example.spec

Настройка веб-репозитория
bash

# Создание репозитория из собранных пакетов
createrepo /root/rpmbuild/RPMS/x86_64/

# Запуск nginx для доступа к репозиторию
systemctl start nginx

# Проверка доступности репозитория
lynx http://localhost/rpmbuild/RPMS/x86_64/

Структура файлов проекта
text

rpm-builder/
├── Dockerfile                 # Конфигурация Docker образа
├── docker-compose.yml         # Оркестрация контейнеров
├── RPM.log                   # Лог процесса сборки
└── rpms/                     # Собранные RPM-пакеты (volume)

Требования
    Docker
    Docker Compose
    Доступ к репозиториям AlmaLinux 9 (для установки пакетов)

Веб-доступ к репозиторию
После сборки пакетов и настройки nginx, репозиторий доступен по:

    Внутри контейнера: http://localhost/rpmbuild/RPMS/x86_64/
    С хоста: http://localhost:PORT/ (требуется настройка портов в docker-compose)

Особенности

    Полный набор инструментов: Все необходимые утилиты для сборки RPM и создания репозитория
    Веб-интерфейс: Встроенный nginx для доступа к репозиторию через HTTP
    Автоматическое монтирование: Готовые пакеты доступны на хосте в папке ./rpms/
    Интерактивный режим: Возможность отладки и ручного управления
    Оптимизированный образ: Очистка кэша DNF для уменьшения размера

Доступные инструменты

    rpmbuild - сборка RPM пакетов
    createrepo - создание метаданных репозитория
    rpmdevtools - дополнительные утилиты для разработки RPM
    nginx - веб-сервер для хостинга репозитория
    lynx - текстовый браузер для тестирования
    cmake, gcc - инструменты для сборки из исходных кодов

Устранение неполадок

При проблемах со сборкой проверьте:

    Наличие spec-файлов в ./specs/
    Наличие исходных кодов в ./sources/
    Корректность прав доступа к volume каталогам
    Доступность репозиториев AlmaLinux из контейнера
    Состояние nginx сервиса: systemctl status nginx
