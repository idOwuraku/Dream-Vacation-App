FROM node:19.0.0-slim AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM node:18-alpine 

WORKDIR /app

COPY package*.json ./

RUN npm install --production --no-cache

COPY --from=builder /app/dist/ ./dist

RUN npm install pm2 -g

EXPOSE 3001

CMD [ "pm2-runtime", "dist/server.js" ]


