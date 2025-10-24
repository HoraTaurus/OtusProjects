Документация: Сборка RPM-пакета и создание репозитория
Обзор процесса

Данный документ описывает процесс настройки окружения для сборки RPM-пакетов и создания собственного RPM-репозитория.
Предварительные требования
Системные требования

    Операционная система: Ubuntu/Debian или совместимая
    Доступ к интернету для загрузки зависимостей
    Права суперпользователя (sudo)

Установленные компоненты

    Docker
    Docker Compose
    Утилиты для работы с RPM

Настройка окружения
1. Установка и настройка Docker Compose

Первоначально возникли проблемы с Docker Compose:
bash

# Удаление старой версии docker-compose
sudo apt remove docker-compose

# Установка curl если не установлен
sudo apt install curl

# Загрузка актуальной версии Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Предоставление прав на выполнение
sudo chmod +x /usr/local/bin/docker-compose

# Проверка версии
docker-compose --version

2. Создание рабочей директории
bash

mkdir rpm-builder && cd rpm-builder

3. Сборка Docker-образа для RPM

Использование Docker-образа на основе AlmaLinux 9:
bash

docker-compose build

Структура проекта

Структура:
text

rpm-builder/
├── docker-compose.yml
└── Dockerfile

Dockerfile 
dockerfile

FROM almalinux:9
RUN dnf update -y && \
    dnf install -y wget rpmdevtools rpm-build createrepo yum-utils cmake gcc git nano nginx lynx && \
    dnf clean all

WORKDIR /root
EXPOSE 80
CMD ["/bin/bash"]

# Установка необходимых пакетов для сборки RPM
RUN dnf update -y && \
    dnf install -y \
    rpmdevtools \
    rpm-build \
    make \
    gcc \
    git \
    createrepo_c \
    && dnf clean all

# Настройка окружения для сборки RPM
RUN useradd builder && \
    mkdir -p /home/builder/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS} && \
    chown -R builder:builder /home/builder/

WORKDIR /home/builder
USER builder

docker-compose.yml
yaml

version: '3.8'

services:
  rpm-builder:
    build: .
    volumes:
      - ./rpms:/home/builder/rpmbuild/RPMS
      - ./sources:/home/builder/rpmbuild/SOURCES
      - ./specs:/home/builder/rpmbuild/SPECS
    working_dir: /home/builder

Процесс сборки RPM-пакета
1. Подготовка спецификации (spec файла)

Создайте spec-файл в директории specs/:
spec

Name:           my-custom-package
Version:        1.0
Release:        1%{?dist}
Summary:        My Custom Application

License:        MIT
URL:            https://github.com/username/my-app
Source0:        %{name}-%{version}.tar.gz

BuildRequires:  gcc
Requires:       bash

%description
My custom application description.

%prep
%setup -q

%build
make %{?_smp_mflags}

%install
mkdir -p %{buildroot}%{_bindir}
install -m 755 myapp %{buildroot}%{_bindir}/

%files
%{_bindir}/myapp

%changelog
* Thu Oct 23 2025 Your Name <email@example.com> - 1.0-1
- Initial package build

2. Сборка пакета
bash

# Запуск контейнера
docker-compose up -d

# Вход в контейнер
docker-compose exec rpm-builder bash

# Внутри контейнера - сборка RPM
rpmbuild -ba ~/rpmbuild/SPECS/my-custom-package.spec

Создание RPM-репозитория
1. Установка необходимых инструментов
bash

# В контейнере
sudo dnf install -y createrepo_c httpd

2. Создание структуры репозитория
bash

mkdir -p /var/www/html/repos/my-repo
cp /home/builder/rpmbuild/RPMS/x86_64/*.rpm /var/www/html/repos/my-repo/

3. Генерация метаданных репозитория
bash

cd /var/www/html/repos/my-repo
createrepo_c .

4. Настройка веб-сервера
bash

# Запуск Apache
systemctl start httpd
systemctl enable httpd

# Проверка доступности репозитория
curl http://localhost/repos/my-repo/repodata/repomd.xml

Настройка клиентов для использования репозитория
Создание файла репозитория на клиентских машинах
bash

# Создание файла репозитория
sudo tee /etc/yum.repos.d/my-repo.repo > /dev/null <<EOF
[my-repo]
name=My Custom Repository
baseurl=http://your-server/repos/my-repo/
enabled=1
gpgcheck=0
EOF

# Обновление кэша
sudo dnf makecache

# Установка пакета из репозитория
sudo dnf install my-custom-package

Автоматизация процесса
Скрипт для автоматической сборки и обновления репозитория
bash

#!/bin/bash
# build-and-update-repo.sh

set -e

# Сборка пакета
echo "Building RPM package..."
docker-compose exec rpm-builder rpmbuild -ba ~/rpmbuild/SPECS/my-custom-package.spec

# Копирование RPM в репозиторий
echo "Copying RPM to repository..."
cp ./rpms/x86_64/*.rpm /var/www/html/repos/my-repo/

# Обновление метаданных репозитория
echo "Updating repository metadata..."
cd /var/www/html/repos/my-repo
createrepo_c --update .

echo "Repository updated successfully!"

Мониторинг и обслуживание
Проверка целостности репозитория
bash

# Проверка репозитория
repoclosure --repo my-repo

# Проверка подписей пакетов
rpm -K /var/www/html/repos/my-repo/*.rpm

Резервное копирование репозитория
bash

# Создание резервной копии
tar -czf my-repo-backup-$(date +%Y%m%d).tar.gz -C /var/www/html/repos/my-repo .

Решение проблем
Распространенные проблемы и решения

    Ошибки зависимостей при сборке

        Убедитесь, что все BuildRequires указаны в spec-файле

        Проверьте доступность репозиториев в контейнере

    Проблемы с подписями пакетов

        Настройте GPG-подпись для пакетов

        Или отключите проверку подписи на клиентах (gpgcheck=0)

    Ошибки доступа к репозиторию

        Проверьте настройки веб-сервера

        Убедитесь, что файлы имеют правильные права доступа

Заключение

Данная документация описывает полный процесс создания RPM-пакетов и организации собственного RPM-репозитория. Процесс включает в себя настройку окружения сборки, создание spec-файлов, сборку пакетов, развертывание репозитория и настройку клиентских машин для использования созданного репозитория.

Для успешного выполнения домашнего задания необходимо:

    Собрать и установить RPM-пакет

    Создать и настроить RPM-репозиторий

    Обеспечить доступность репозитория через веб-сервер

    Проверить установку пакетов из созданного репозитория
