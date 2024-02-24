FROM node:latest
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 3000
CMD ["npm", "start"]