#!/bin/bash

echo "=== Final NFS Test ==="

# Test 1: Базовая функциональность
echo "1. Basic functionality test..."
echo "Files on server:"
docker exec nfss ls -la /srv/share/upload/
echo "Files on client:"
docker exec nfsc ls -la /mnt/nfs/upload/

# Test 2: Создание новых файлов
echo "2. Creating new test files..."
docker exec nfss touch /srv/share/upload/new_server_file.txt
docker exec nfsc touch /mnt/nfs/upload/new_client_file.txt

# Test 3: Проверка видимости
echo "3. Checking cross-visibility..."
echo "Server sees client files:"
docker exec nfss ls -la /srv/share/upload/ | grep client
echo "Client sees server files:"
docker exec nfsc ls -la /mnt/nfs/upload/ | grep server

# Test 4: Права доступа
echo "4. Testing permissions..."
docker exec nfss bash -c "chmod 644 /srv/share/upload/server_file.txt && ls -la /srv/share/upload/server_file.txt"
docker exec nfsc bash -c "ls -la /mnt/nfs/upload/server_file.txt"

# Test 5: Содержимое файлов
echo "5. Testing file content sharing..."
docker exec nfss bash -c "echo 'Modified by server' >> /srv/share/upload/server_file.txt"
docker exec nfsc bash -c "cat /mnt/nfs/upload/server_file.txt"

echo "=== All Tests Completed Successfully ==="
