#!/bin/bash

# Script de configuración automática para Railway
# Este script te ayuda a configurar las variables de entorno necesarias

echo "🚀 Configurando Evolution API para Railway..."
echo "=============================================="

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para mostrar mensajes
print_message() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Verificar si Railway CLI está instalado
if ! command -v railway &> /dev/null; then
    print_warning "Railway CLI no está instalado. Instalando..."
    npm install -g @railway/cli
fi

# Verificar si el usuario está logueado en Railway
if ! railway whoami &> /dev/null; then
    print_warning "No estás logueado en Railway. Por favor, ejecuta: railway login"
    exit 1
fi

print_info "Configurando variables de entorno para Railway..."

# Variables obligatorias
print_message "Configurando variables obligatorias..."

railway variables set SERVER_TYPE=http
railway variables set SERVER_PORT=8080
railway variables set DATABASE_PROVIDER=postgresql
railway variables set NODE_ENV=production
railway variables set DOCKER_ENV=true
railway variables set LANGUAGE=es

# Generar clave de autenticación segura
API_KEY=$(openssl rand -hex 32)
railway variables set AUTHENTICATION_API_KEY="$API_KEY"
print_message "Clave de autenticación generada: $API_KEY"

# Configurar base de datos
print_info "Configurando base de datos..."
railway variables set DATABASE_CONNECTION_URI='${{Postgres.DATABASE_URL}}'
railway variables set DATABASE_CONNECTION_CLIENT_NAME=evolution

# Configurar cache Redis (si está disponible)
print_info "Configurando cache Redis..."
railway variables set CACHE_REDIS_ENABLED=true
railway variables set CACHE_REDIS_URI='${{Redis.REDIS_URL}}'
railway variables set CACHE_REDIS_PREFIX_KEY=evolution-cache
railway variables set CACHE_REDIS_TTL=604800
railway variables set CACHE_REDIS_SAVE_INSTANCES=true

# Configurar cache local como fallback
railway variables set CACHE_LOCAL_ENABLED=true
railway variables set CACHE_LOCAL_TTL=86400

# Configurar logs
print_info "Configurando logs..."
railway variables set LOG_LEVEL=ERROR,WARN,INFO
railway variables set LOG_COLOR=false
railway variables set LOG_BAILEYS=error

# Configurar WebSocket
print_info "Configurando WebSocket..."
railway variables set WEBSOCKET_ENABLED=true
railway variables set WEBSOCKET_GLOBAL_EVENTS=true

# Configurar instancias
print_info "Configurando gestión de instancias..."
railway variables set DEL_INSTANCE=false
railway variables set DEL_TEMP_INSTANCES=true
railway variables set QRCODE_LIMIT=30
railway variables set QRCODE_COLOR=#198754

# Configurar sesión telefónica
railway variables set CONFIG_SESSION_PHONE_CLIENT="Evolution API"
railway variables set CONFIG_SESSION_PHONE_NAME=Chrome

# Configurar WhatsApp Business
print_info "Configurando WhatsApp Business..."
railway variables set WA_BUSINESS_TOKEN_WEBHOOK=evolution
railway variables set WA_BUSINESS_URL=https://graph.facebook.com
railway variables set WA_BUSINESS_VERSION=v18.0
railway variables set WA_BUSINESS_LANGUAGE=es

# Configurar guardado de datos
print_info "Configurando guardado de datos..."
railway variables set DATABASE_SAVE_DATA_INSTANCE=true
railway variables set DATABASE_SAVE_DATA_NEW_MESSAGE=true
railway variables set DATABASE_SAVE_MESSAGE_UPDATE=true
railway variables set DATABASE_SAVE_DATA_CONTACTS=true
railway variables set DATABASE_SAVE_DATA_CHATS=true
railway variables set DATABASE_SAVE_DATA_HISTORIC=true
railway variables set DATABASE_SAVE_DATA_LABELS=true
railway variables set DATABASE_SAVE_IS_ON_WHATSAPP=true
railway variables set DATABASE_SAVE_IS_ON_WHATSAPP_DAYS=7
railway variables set DATABASE_DELETE_MESSAGE=false

# Configurar CORS
print_info "Configurando CORS..."
railway variables set CORS_ORIGIN=*
railway variables set CORS_METHODS=POST,GET,PUT,DELETE
railway variables set CORS_CREDENTIALS=true

# Configurar proveedor de sesiones
railway variables set PROVIDER_ENABLED=false

# Configurar autenticación
railway variables set AUTHENTICATION_EXPOSE_IN_FETCH_INSTANCES=false

print_message "¡Configuración completada!"
echo ""
print_info "Variables configuradas:"
echo "  - SERVER_TYPE: http"
echo "  - SERVER_PORT: 8080"
echo "  - DATABASE_PROVIDER: postgresql"
echo "  - NODE_ENV: production"
echo "  - AUTHENTICATION_API_KEY: [GENERADA AUTOMÁTICAMENTE]"
echo "  - CACHE_REDIS_ENABLED: true"
echo "  - WEBSOCKET_ENABLED: true"
echo "  - Y muchas más..."
echo ""
print_warning "IMPORTANTE: Guarda tu clave de autenticación: $API_KEY"
echo ""
print_info "Próximos pasos:"
echo "  1. Agrega un servicio PostgreSQL en Railway"
echo "  2. Agrega un servicio Redis en Railway (opcional pero recomendado)"
echo "  3. Despliega tu aplicación"
echo "  4. Verifica que funcione en: https://tu-app.railway.app/manager"
echo ""
print_info "Para configurar variables adicionales, usa:"
echo "  railway variables set VARIABLE_NAME=value"
echo ""
print_info "Para ver todas las variables configuradas:"
echo "  railway variables"
echo ""
print_message "¡Listo para desplegar en Railway! 🚀"
