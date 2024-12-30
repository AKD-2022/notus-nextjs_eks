
FROM node:current-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install --legacy-peer-deps

COPY . .

RUN npm run build 

EXPOSE 3000

ENV NODE_ENV=production

CMD [ "npm", "start" ]
