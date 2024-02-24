# Установка базового образа
FROM node:14 AS builder

# Установка рабочей директории в контейнере
WORKDIR /app

# Копирование package.json и package-lock.json
COPY package*.json ./

# Установка зависимостей проекта
RUN npm install

# Копирование остальных файлов проекта
COPY . .

# Сборка приложения
RUN npm run build

# Установка сервера для обслуживания сборки
FROM nginx:stable-alpine

# Добавление curl для health check
RUN apk add --no-cache curl

# Копирование собранного приложения
COPY --from=builder /app/build /usr/share/nginx/html

# Создание и копирование файла конфигурации Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Health Check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Объявление используемого порта
EXPOSE 80

# Запуск nginx
CMD ["nginx", "-g", "daemon off;"]