#!/bin/bash

# Скрипт для генерации конфигурации Warp с сервером в США

# Задаем IP-адрес сервера в США
server="198.41.200.233"  # Пример IP Cloudflare в США

# Определяем регион для подключения (USA)
region="us"

# Генерация ключей
generate_keys() {
    private_key=$(wg genkey)
    public_key=$(echo "$private_key" | wg pubkey)
    echo "Приватный ключ: $private_key"
    echo "Публичный ключ: $public_key"
}

# Генерация конфигурации для клиента WireGuard
generate_config() {
    cat <<EOL > wg0.conf
[Interface]
PrivateKey = $private_key
Address = 10.0.0.2/24
DNS = 1.1.1.1

[Peer]
PublicKey = $public_key
Endpoint = $server:51820
AllowedIPs = 0.0.0.0/0, ::/0
PersistentKeepalive = 25
EOL
    echo "Конфигурация WireGuard сохранена в файл wg0.conf"
}

# Запуск скрипта
generate_keys
generate_config

echo "Скрипт завершен. Конфигурация готова!"
