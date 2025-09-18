#!/bin/bash

# Script de build alternativo para Railway
echo "🚀 Iniciando build alternativo para Railway..."

# Verificar si estamos en Railway
if [ "$RAILWAY_ENVIRONMENT" = "production" ]; then
    echo "✅ Detectado entorno Railway"
    export NODE_ENV=production
    export DOCKER_ENV=true
fi

# Configurar npm para mejor rendimiento
npm config set registry https://registry.npmjs.org/
npm config set fetch-retry-mintimeout 20000
npm config set fetch-retry-maxtimeout 120000
npm config set fetch-retries 3

# Limpiar cache de npm
npm cache clean --force

# Instalar dependencias con diferentes estrategias
echo "📦 Instalando dependencias..."

# Estrategia 1: npm ci
if npm ci --silent --no-audit --no-fund; then
    echo "✅ npm ci exitoso"
else
    echo "⚠️ npm ci falló, intentando npm install..."
    
    # Estrategia 2: npm install
    if npm install --silent --no-audit --no-fund; then
        echo "✅ npm install exitoso"
    else
        echo "⚠️ npm install falló, intentando con legacy peer deps..."
        
        # Estrategia 3: npm install con legacy peer deps
        if npm install --silent --no-audit --no-fund --legacy-peer-deps; then
            echo "✅ npm install con legacy peer deps exitoso"
        else
            echo "❌ Todas las estrategias de instalación fallaron"
            exit 1
        fi
    fi
fi

# Generar base de datos
echo "🗄️ Generando configuración de base de datos..."
if [ -f "./Docker/scripts/generate_database.sh" ]; then
    chmod +x ./Docker/scripts/generate_database.sh
    ./Docker/scripts/generate_database.sh
else
    echo "⚠️ Script de generación de base de datos no encontrado"
fi

# Construir la aplicación
echo "🔨 Construyendo la aplicación..."
if npm run build; then
    echo "✅ Build exitoso"
else
    echo "❌ Build falló"
    exit 1
fi

echo "🎉 Build completado exitosamente!"
