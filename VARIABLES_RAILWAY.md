# 🔧 Variables de Entorno para Railway - Evolution API

## 📋 Resumen de Variables Necesarias

### 🔴 Variables OBLIGATORIAS

Estas variables son **esenciales** para que la aplicación funcione:

```bash
# Configuración del servidor
SERVER_TYPE=http
SERVER_PORT=8080
SERVER_URL=https://tu-app.railway.app

# Base de datos (Railway la proporciona automáticamente)
DATABASE_CONNECTION_URI=${{Postgres.DATABASE_URL}}
DATABASE_PROVIDER=postgresql
DATABASE_CONNECTION_CLIENT_NAME=evolution

# Autenticación (¡CAMBIA ESTA CLAVE!)
AUTHENTICATION_API_KEY=tu-clave-secreta-super-segura-aqui

# Entorno
NODE_ENV=production
DOCKER_ENV=true
LANGUAGE=es
```

### 🟡 Variables RECOMENDADAS

Estas variables mejoran el rendimiento y funcionalidad:

```bash
# Cache Redis (si agregaste Redis en Railway)
CACHE_REDIS_ENABLED=true
CACHE_REDIS_URI=${{Redis.REDIS_URL}}
CACHE_REDIS_PREFIX_KEY=evolution-cache
CACHE_REDIS_TTL=604800
CACHE_REDIS_SAVE_INSTANCES=true

# Cache local (fallback)
CACHE_LOCAL_ENABLED=true
CACHE_LOCAL_TTL=86400

# WebSocket
WEBSOCKET_ENABLED=true
WEBSOCKET_GLOBAL_EVENTS=true

# Configuración de instancias
DEL_TEMP_INSTANCES=true
QRCODE_LIMIT=30
QRCODE_COLOR=#198754

# Logs
LOG_LEVEL=ERROR,WARN,INFO
LOG_COLOR=false
LOG_BAILEYS=error
```

### 🟢 Variables OPCIONALES

Estas variables son para funcionalidades específicas:

#### Configuración de Guardado de Datos
```bash
DATABASE_SAVE_DATA_INSTANCE=true
DATABASE_SAVE_DATA_NEW_MESSAGE=true
DATABASE_SAVE_MESSAGE_UPDATE=true
DATABASE_SAVE_DATA_CONTACTS=true
DATABASE_SAVE_DATA_CHATS=true
DATABASE_SAVE_DATA_HISTORIC=true
DATABASE_SAVE_DATA_LABELS=true
DATABASE_SAVE_IS_ON_WHATSAPP=true
DATABASE_SAVE_IS_ON_WHATSAPP_DAYS=7
DATABASE_DELETE_MESSAGE=false
```

#### Configuración CORS
```bash
CORS_ORIGIN=*
CORS_METHODS=POST,GET,PUT,DELETE
CORS_CREDENTIALS=true
```

#### Configuración de Sesión Telefónica
```bash
CONFIG_SESSION_PHONE_CLIENT=Evolution API
CONFIG_SESSION_PHONE_NAME=Chrome
```

#### Configuración de WhatsApp Business
```bash
WA_BUSINESS_TOKEN_WEBHOOK=evolution
WA_BUSINESS_URL=https://graph.facebook.com
WA_BUSINESS_VERSION=v18.0
WA_BUSINESS_LANGUAGE=es
```

#### Configuración de Proveedor de Sesiones
```bash
PROVIDER_ENABLED=false
PROVIDER_HOST=
PROVIDER_PORT=5656
PROVIDER_PREFIX=evolution
```

#### Configuración de Autenticación
```bash
AUTHENTICATION_EXPOSE_IN_FETCH_INSTANCES=false
```

## 🔧 Variables para Integraciones

### Webhooks
```bash
WEBHOOK_GLOBAL_ENABLED=false
WEBHOOK_GLOBAL_URL=
WEBHOOK_GLOBAL_WEBHOOK_BY_EVENTS=false

# Eventos específicos (configurar según necesidades)
WEBHOOK_EVENTS_APPLICATION_STARTUP=false
WEBHOOK_EVENTS_INSTANCE_CREATE=false
WEBHOOK_EVENTS_QRCODE_UPDATED=false
WEBHOOK_EVENTS_MESSAGES_UPSERT=false
# ... (ver archivo railway.env.example para lista completa)
```

### OpenAI
```bash
OPENAI_ENABLED=false
OPENAI_API_KEY_GLOBAL=tu-openai-api-key
```

### Chatwoot
```bash
CHATWOOT_ENABLED=false
CHATWOOT_MESSAGE_DELETE=false
CHATWOOT_MESSAGE_READ=false
CHATWOOT_BOT_CONTACT=true
CHATWOOT_IMPORT_DATABASE_CONNECTION_URI=
```

### Typebot
```bash
TYPEBOT_ENABLED=false
TYPEBOT_API_VERSION=old
TYPEBOT_SEND_MEDIA_BASE64=false
```

### Otras Integraciones
```bash
DIFY_ENABLED=false
N8N_ENABLED=false
EVOAI_ENABLED=false
FLOWISE_ENABLED=false
```

## 🗄️ Variables para Almacenamiento S3

```bash
S3_ENABLED=false
S3_ACCESS_KEY=tu-access-key
S3_SECRET_KEY=tu-secret-key
S3_ENDPOINT=https://tu-s3-endpoint.com
S3_BUCKET=tu-bucket-name
S3_PORT=9000
S3_USE_SSL=true
S3_REGION=us-east-1
S3_SKIP_POLICY=false
```

## 🔄 Variables para Colas de Mensajes

### RabbitMQ
```bash
RABBITMQ_ENABLED=false
RABBITMQ_URI=
RABBITMQ_GLOBAL_ENABLED=false
RABBITMQ_PREFIX_KEY=
RABBITMQ_EXCHANGE_NAME=evolution_exchange
RABBITMQ_FRAME_MAX=8192
```

### NATS
```bash
NATS_ENABLED=false
NATS_URI=
NATS_GLOBAL_ENABLED=false
NATS_PREFIX_KEY=
NATS_EXCHANGE_NAME=evolution_exchange
```

### SQS (AWS)
```bash
SQS_ENABLED=false
SQS_ACCESS_KEY_ID=
SQS_SECRET_ACCESS_KEY=
SQS_ACCOUNT_ID=
SQS_REGION=
```

## 🔔 Variables para Pusher

```bash
PUSHER_ENABLED=false
PUSHER_GLOBAL_ENABLED=false
PUSHER_GLOBAL_APP_ID=
PUSHER_GLOBAL_KEY=
PUSHER_GLOBAL_SECRET=
PUSHER_GLOBAL_CLUSTER=
PUSHER_GLOBAL_USE_TLS=true
```

## 🔒 Variables de Seguridad

```bash
# SSL (si usas HTTPS)
SSL_CONF_PRIVKEY=
SSL_CONF_FULLCHAIN=
```

## 📊 Configuración de Reintentos de Webhook

```bash
WEBHOOK_REQUEST_TIMEOUT_MS=30000
WEBHOOK_RETRY_MAX_ATTEMPTS=10
WEBHOOK_RETRY_INITIAL_DELAY_SECONDS=5
WEBHOOK_RETRY_USE_EXPONENTIAL_BACKOFF=true
WEBHOOK_RETRY_MAX_DELAY_SECONDS=300
WEBHOOK_RETRY_JITTER_FACTOR=0.2
WEBHOOK_RETRY_NON_RETRYABLE_STATUS_CODES=400,401,403,404,422
```

## 🚀 Cómo Configurar en Railway

### Método 1: Interfaz Web
1. Ve a tu proyecto en Railway
2. Selecciona el servicio
3. Ve a la pestaña "Variables"
4. Agrega cada variable con su valor

### Método 2: Railway CLI
```bash
# Instalar Railway CLI
npm install -g @railway/cli

# Loguearse
railway login

# Configurar variables
railway variables set SERVER_TYPE=http
railway variables set SERVER_PORT=8080
# ... etc
```

### Método 3: Script Automático
```bash
# Ejecutar el script de configuración
./railway-setup.sh
```

## ⚠️ Notas Importantes

1. **DATABASE_URL**: Railway la proporciona automáticamente cuando agregas PostgreSQL
2. **REDIS_URL**: Railway la proporciona automáticamente cuando agregas Redis
3. **AUTHENTICATION_API_KEY**: ¡CAMBIA ESTA CLAVE! Usa una clave segura
4. **SERVER_URL**: Actualiza con la URL real de tu aplicación en Railway
5. **NODE_ENV**: Debe ser `production` para Railway
6. **DOCKER_ENV**: Debe ser `true` para Railway

## 🔍 Verificación

Después de configurar las variables, verifica que todo funcione:

```bash
# Verificar que la API esté funcionando
curl https://tu-app.railway.app/manager

# Verificar documentación
curl https://tu-app.railway.app/docs

# Crear instancia de prueba
curl -X POST https://tu-app.railway.app/instance/create \
  -H "Content-Type: application/json" \
  -H "apikey: tu-clave-secreta-super-segura-aqui" \
  -d '{
    "instanceName": "test",
    "token": "test-token",
    "qrcode": true,
    "integration": "WHATSAPP-BAILEYS"
  }'
```

## 📝 Lista de Verificación

- [ ] Variables obligatorias configuradas
- [ ] PostgreSQL agregado en Railway
- [ ] Redis agregado en Railway (opcional)
- [ ] AUTHENTICATION_API_KEY cambiada
- [ ] SERVER_URL actualizada
- [ ] Aplicación desplegada
- [ ] API funcionando correctamente
- [ ] Documentación accesible
- [ ] Instancia de prueba creada

---

¡Con estas variables tu Evolution API estará lista para funcionar en Railway! 🚀
