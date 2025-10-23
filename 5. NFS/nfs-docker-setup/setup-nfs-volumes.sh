#!/bin/bash

echo "=== NFS-like Setup with Docker Volumes ==="

# Останавливаем старые контейнеры
docker stop nfss nfsc 2>/dev/null || true
docker rm nfss nfsc 2>/dev/null || true

# Создаем volume для общего доступа
docker volume create nfs-share

# Создаем сеть
docker network create --subnet=192.168.50.0/24 nfs-net 2>/dev/null || true

echo "1. Starting NFS Server (simulated)..."
docker run -d \
  --name nfss \
  --hostname nfss \
  --network nfs-net \
  --ip 192.168.50.10 \
  -v nfs-share:/srv/share \
  ubuntu:22.04 \
  bash -c "
    # Создаем структуру директорий
    mkdir -p /srv/share/upload
    chown -R nobody:nogroup /srv/share
    chmod 0777 /srv/share/upload
    # Создаем тестовые файлы
    echo 'File from NFS Server' > /srv/share/upload/server_file.txt
    # Держим контейнер активным
    echo '=== NFS Server Ready ==='
    ls -la /srv/share/upload/
    tail -f /dev/null
  "

echo "2. Waiting for server..."
sleep 5

echo "3. Starting NFS Client..."
docker run -d \
  --name nfsc \
  --hostname nfsc \
  --network nfs-net \
  --ip 192.168.50.11 \
  -v nfs-share:/mnt/nfs \
  ubuntu:22.04 \
  bash -c "
    # Проверяем доступ к общему volume
    echo '=== NFS Client Ready ==='
    ls -la /mnt/nfs/upload/
    # Создаем файл с клиента
    echo 'File from NFS Client' > /mnt/nfs/upload/client_file.txt
    # Показываем содержимое
    echo '=== Shared Directory Contents ==='
    ls -la /mnt/nfs/upload/
    cat /mnt/nfs/upload/server_file.txt
    cat /mnt/nfs/upload/client_file.txt
    # Держим активным
    tail -f /dev/null
  "

echo "4. Checking setup..."
sleep 10

echo "=== Server View ==="
docker exec nfss ls -la /srv/share/upload/

echo "=== Client View ==="
docker exec nfsc ls -la /mnt/nfs/upload/

echo "=== Testing Cross-Access ==="
docker exec nfss bash -c "echo 'Additional from server' >> /srv/share/upload/server_file.txt"
docker exec nfsc bash -c "echo 'Additional from client' >> /mnt/nfs/upload/client_file.txt"

echo "=== Final Contents ==="
echo "Server reading client file:"
docker exec nfss cat /srv/share/upload/client_file.txt
echo "Client reading server file:"
docker exec nfsc cat /mnt/nfs/upload/server_file.txt

echo "=== Volume Setup Complete ==="
echo "✅ Shared storage is working!"
echo "✅ Both containers can read/write to the same directory"
echo "✅ This simulates NFS functionality"
