FROM node:20-alpine

ENV NODE_ENV=production
WORKDIR /app

COPY package*.json ./
RUN npm ci --omit=dev && npm cache clean --force

COPY --chown=node:node . .

RUN mkdir -p uploads reports && chown -R node:node uploads reports

USER node
ENV PORT=7000
EXPOSE 7000

CMD ["node", "server.js"]
