#!/bin/sh
 
# Обновление пакетов
apt-get update -y
apt-get upgrade -y

# Установка AWS CLI
sudo apt-get install -y unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Установка Docker и Docker Compose
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Добавление пользователя ubuntu в группу docker
sudo usermod -aG docker ubuntu

# Запуск Docker
sudo systemctl enable docker
sudo systemctl start docker

# Проверка установки Docker и Docker Compose
docker --version
docker compose version

echo "Docker и Docker Compose успешно установлены!"

# Получение секретов из AWS Secrets Manager и сохранение в .env файл
# Указываем регион AWS
AWS_REGION="eu-north-1"
ENV_FILE="/home/ubuntu/.env"

# Очищаем файл перед записью
> "$ENV_FILE"

# Получаем список всех секретов
SECRETS=$(aws secretsmanager list-secrets --region "$AWS_REGION" --query 'SecretList[*].Name' --output text)

for SECRET in $SECRETS; do
    echo "Получение секрета: $SECRET"
    
    # Получаем значение секрета
    SECRET_VALUE=$(aws secretsmanager get-secret-value --secret-id "$SECRET" --region "$AWS_REGION" --query 'SecretString' --output text)

    # Если секрет в формате JSON, то преобразуем его в ключ=значение
    if echo "$SECRET_VALUE" | jq -e . >/dev/null 2>&1; then
        echo "$SECRET_VALUE" | jq -r 'to_entries | map("\(.key)=\(.value)") | .[]' >> "$ENV_FILE"
    else
        echo "$SECRET=$SECRET_VALUE" >> "$ENV_FILE"
    fi
done

# Устанавливаем правильные права на .env
chown ubuntu:ubuntu "$ENV_FILE"
chmod 600 "$ENV_FILE"

echo "Все секреты сохранены в $ENV_FILE"