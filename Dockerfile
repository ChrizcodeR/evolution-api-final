# Dockerfile optimizado para Railway
FROM node:20-alpine AS builder

# Instalar dependencias del sistema
RUN apk update && \
    apk add --no-cache git ffmpeg wget curl bash openssl python3 make g++

LABEL version="2.3.2" description="Evolution API optimizada para Railway" 
LABEL maintainer="Evolution API Team"

WORKDIR /evolution

# Configurar npm para mejor rendimiento
RUN npm config set registry https://registry.npmjs.org/ && \
    npm config set fetch-retry-mintimeout 20000 && \
    npm config set fetch-retry-maxtimeout 120000 && \
    npm config set fetch-retries 3

# Copiar archivos de configuración
COPY ./package*.json ./
COPY ./tsconfig.json ./
COPY ./tsup.config.ts ./

# Instalar dependencias con manejo de errores mejorado
RUN npm ci --silent --no-audit --no-fund --prefer-offline || \
    (echo "npm ci failed, trying npm install..." && \
     npm install --silent --no-audit --no-fund --prefer-offline) || \
    (echo "npm install failed, trying with legacy peer deps..." && \
     npm install --silent --no-audit --no-fund --legacy-peer-deps)

# Crear directorios necesarios
RUN mkdir -p ./public ./src ./prisma ./manager

# Copiar código fuente
COPY ./src ./src

# Copiar directorio public (asegurar que existe)
COPY ./public ./public

# Copiar resto de archivos
COPY ./prisma ./prisma
COPY ./manager ./manager
COPY ./runWithProvider.js ./

# Copiar archivo de entorno
COPY ./.env.example ./.env

COPY ./Docker ./Docker

RUN chmod +x ./Docker/scripts/* && dos2unix ./Docker/scripts/*

RUN ./Docker/scripts/generate_database.sh

RUN npm run build

FROM node:20-alpine AS final

RUN apk update && \
    apk add tzdata ffmpeg bash openssl

ENV TZ=America/Sao_Paulo
ENV DOCKER_ENV=true

WORKDIR /evolution

COPY --from=builder /evolution/package.json ./package.json
COPY --from=builder /evolution/package-lock.json ./package-lock.json

COPY --from=builder /evolution/node_modules ./node_modules
COPY --from=builder /evolution/dist ./dist
COPY --from=builder /evolution/prisma ./prisma
COPY --from=builder /evolution/manager ./manager
COPY --from=builder /evolution/public ./public
COPY --from=builder /evolution/.env ./.env
COPY --from=builder /evolution/Docker ./Docker
COPY --from=builder /evolution/runWithProvider.js ./runWithProvider.js
COPY --from=builder /evolution/tsup.config.ts ./tsup.config.ts

ENV DOCKER_ENV=true

EXPOSE 8080

ENTRYPOINT ["/bin/bash", "-c", ". ./Docker/scripts/deploy_database.sh && npm run start:prod" ]
