FROM node:20-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
ARG VITE_API_URL=http://localhost:7000
ENV VITE_API_URL=${VITE_API_URL}
RUN npm run build

FROM node:20-alpine AS runtime

WORKDIR /app
RUN npm install --global serve@14.2.4 \
    && addgroup -S app && adduser -S app -G app

COPY --from=build --chown=app:app /app/dist ./dist

USER app
ENV PORT=5002
EXPOSE 5002

CMD ["serve", "-s", "dist", "-l", "5002"]
