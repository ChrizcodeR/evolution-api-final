# 🚀 Guía de Despliegue en Railway - Evolution API

Esta guía te ayudará a desplegar Evolution API en Railway de manera rápida y eficiente.

## 📋 Prerrequisitos

1. Cuenta en [Railway](https://railway.app)
2. Repositorio de GitHub con tu código
3. Conocimientos básicos de variables de entorno

## 🛠️ Pasos para el Despliegue

### 1. Crear el Proyecto en Railway

1. Ve a [Railway](https://railway.app) y crea una cuenta
2. Haz clic en "New Project"
3. Selecciona "Deploy from GitHub repo"
4. Conecta tu repositorio de GitHub
5. Selecciona este repositorio

### 2. Configurar Servicios Adicionales

Railway detectará automáticamente que necesitas una base de datos. Agrega estos servicios:

#### PostgreSQL Database
- Railway creará automáticamente una base de datos PostgreSQL
- La variable `DATABASE_URL` se generará automáticamente

#### Redis (Opcional pero Recomendado)
- Agrega un servicio Redis para el cache
- La variable `REDIS_URL` se generará automáticamente

### 3. Configurar Variables de Entorno

Ve a la pestaña "Variables" de tu servicio principal y configura las siguientes variables:

#### 🔧 Variables Obligatorias

```bash
# Configuración del servidor
SERVER_TYPE=http
SERVER_PORT=8080
SERVER_URL=https://tu-app.railway.app

# Base de datos (Railway la proporciona automáticamente)
DATABASE_CONNECTION_URI=${{Postgres.DATABASE_URL}}
DATABASE_PROVIDER=postgresql

# Cache Redis (si agregaste Redis)
CACHE_REDIS_ENABLED=true
CACHE_REDIS_URI=${{Redis.REDIS_URL}}

# Autenticación (¡IMPORTANTE! Cambia esta clave)
AUTHENTICATION_API_KEY=tu-clave-secreta-super-segura-aqui

# Configuración básica
NODE_ENV=production
DOCKER_ENV=true
LANGUAGE=es
```

#### 🔧 Variables Opcionales (Configurar según necesidades)

```bash
# Webhooks (si necesitas recibir notificaciones)
WEBHOOK_GLOBAL_ENABLED=true
WEBHOOK_GLOBAL_URL=https://tu-webhook-url.com/webhook

# WebSocket
WEBSOCKET_ENABLED=true
WEBSOCKET_GLOBAL_EVENTS=true

# Logs
LOG_LEVEL=ERROR,WARN,INFO
LOG_COLOR=false

# Configuración de instancias
DEL_TEMP_INSTANCES=true
QRCODE_LIMIT=30
```

### 4. Variables de Entorno Completas

Para una configuración completa, puedes usar todas las variables del archivo `railway.env.example` que se encuentra en la raíz del proyecto.

## 🚀 Despliegue

1. Una vez configuradas las variables, Railway comenzará el despliegue automáticamente
2. El proceso puede tomar 5-10 minutos
3. Una vez completado, obtendrás una URL pública para tu API

## 🔍 Verificación del Despliegue

### 1. Verificar que la API esté funcionando
```bash
curl https://tu-app.railway.app/manager
```

### 2. Verificar la documentación
```bash
curl https://tu-app.railway.app/docs
```

### 3. Crear una instancia de prueba
```bash
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

## 📊 Monitoreo

Railway proporciona métricas básicas en el dashboard:
- Uso de CPU y memoria
- Logs en tiempo real
- Estado del servicio

## 🔧 Configuraciones Avanzadas

### Integraciones Opcionales

Si necesitas integrar con otros servicios, configura estas variables:

```bash
# OpenAI
OPENAI_ENABLED=true
OPENAI_API_KEY_GLOBAL=tu-openai-api-key

# Chatwoot
CHATWOOT_ENABLED=true
CHATWOOT_IMPORT_DATABASE_CONNECTION_URI=tu-chatwoot-db-url

# Typebot
TYPEBOT_ENABLED=true
TYPEBOT_API_VERSION=old
```

### Almacenamiento S3

Para almacenar archivos multimedia:

```bash
S3_ENABLED=true
S3_ACCESS_KEY=tu-access-key
S3_SECRET_KEY=tu-secret-key
S3_ENDPOINT=https://tu-s3-endpoint.com
S3_BUCKET=tu-bucket-name
S3_USE_SSL=true
```

## 🚨 Solución de Problemas

### Error de Base de Datos
- Verifica que `DATABASE_URL` esté configurada correctamente
- Asegúrate de que el servicio PostgreSQL esté ejecutándose

### Error de Redis
- Si no tienes Redis, configura `CACHE_REDIS_ENABLED=false`
- O agrega un servicio Redis en Railway

### Error de Autenticación
- Verifica que `AUTHENTICATION_API_KEY` esté configurada
- Usa la misma clave en tus requests

### Puerto no disponible
- Railway usa automáticamente el puerto 8080
- No cambies `SERVER_PORT` a menos que sea necesario

## 📝 Notas Importantes

1. **Seguridad**: Nunca expongas tu `AUTHENTICATION_API_KEY` en el código
2. **Base de Datos**: Railway maneja automáticamente las migraciones
3. **Logs**: Los logs están disponibles en el dashboard de Railway
4. **Escalabilidad**: Railway puede escalar automáticamente según la demanda

## 🔗 Enlaces Útiles

- [Documentación de Railway](https://docs.railway.app)
- [Documentación de Evolution API](https://doc.evolution-api.com)
- [Soporte de Railway](https://railway.app/support)

## 📞 Soporte

Si tienes problemas con el despliegue:
1. Revisa los logs en Railway
2. Verifica las variables de entorno
3. Consulta la documentación oficial
4. Contacta al soporte de Railway

---

¡Felicitaciones! 🎉 Tu Evolution API debería estar funcionando en Railway.
