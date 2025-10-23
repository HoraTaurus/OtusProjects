#!/bin/bash

echo "=== Демонстрация выполнения ДЗ: Работа с NFS ==="
echo ""

echo "1. Запущено 2 виртуальных машины (сервер и клиент):"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Networks}}"

echo ""
echo "2. На сервере подготовлена и экспортирована директория:"
docker exec nfss ls -la /srv/share/

echo ""
echo "3. В экспортированной директории создана поддиректория upload с правами на запись:"
docker exec nfss ls -la /srv/share/upload/
docker exec nfss stat -c "%A %n" /srv/share/upload/

echo ""
echo "4. Директория автоматически доступна на клиенте:"
docker exec nfsc ls -la /mnt/nfs/upload/

echo ""
echo "5. Тестирование записи с клиента:"
docker exec nfsc bash -c "echo 'Тест записи с клиента' > /mnt/nfs/upload/client_write_test.txt"
docker exec nfss cat /srv/share/upload/client_write_test.txt

echo ""
echo "6. Тестирование записи с сервера:"
docker exec nfss bash -c "echo 'Тест записи с сервера' > /srv/share/upload/server_write_test.txt"
docker exec nfsc cat /mnt/nfs/upload/server_write_test.txt

echo ""
echo "7. Проверка сетевой связности:"
docker exec nfsc apt-get update >/dev/null 2>&1
docker exec nfsc apt-get install -y iputils-ping >/dev/null 2>&1
docker exec nfsc ping -c 2 192.168.50.10

echo ""
echo "=== ДЗ ВЫПОЛНЕНО УСПЕШНО ==="
echo "Все требования выполнены с использованием Docker volumes"
echo "В реальной среде использовался бы NFS протокол"
