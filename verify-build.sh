#!/bin/bash

echo "🔍 Verificando estructura del proyecto para Railway..."

# Verificar que los directorios necesarios existan
echo "📁 Verificando directorios..."

if [ -d "public" ]; then
    echo "✅ Directorio public existe"
    if [ -f "public/.gitkeep" ]; then
        echo "✅ Archivo .gitkeep existe en public"
    fi
    if [ -f "public/index.html" ]; then
        echo "✅ Archivo index.html existe en public"
    fi
    echo "📊 Contenido de public:"
    ls -la public/
else
    echo "❌ Directorio public NO existe"
    exit 1
fi

if [ -d "src" ]; then
    echo "✅ Directorio src existe"
else
    echo "❌ Directorio src NO existe"
    exit 1
fi

if [ -d "prisma" ]; then
    echo "✅ Directorio prisma existe"
else
    echo "❌ Directorio prisma NO existe"
    exit 1
fi

if [ -d "manager" ]; then
    echo "✅ Directorio manager existe"
else
    echo "❌ Directorio manager NO existe"
    exit 1
fi

# Verificar archivos necesarios
echo "📄 Verificando archivos necesarios..."

if [ -f "Dockerfile" ]; then
    echo "✅ Dockerfile existe"
else
    echo "❌ Dockerfile NO existe"
    exit 1
fi

if [ -f "package.json" ]; then
    echo "✅ package.json existe"
else
    echo "❌ package.json NO existe"
    exit 1
fi

if [ -f ".env.example" ]; then
    echo "✅ .env.example existe"
else
    echo "❌ .env.example NO existe"
    exit 1
fi

if [ -f "src/railway.json" ]; then
    echo "✅ src/railway.json existe"
else
    echo "❌ src/railway.json NO existe"
    exit 1
fi

echo ""
echo "🎉 ¡Verificación completada! El proyecto está listo para Railway."
echo "📋 Próximos pasos:"
echo "   1. git add ."
echo "   2. git commit -m 'Fix: Resolver problema del directorio public'"
echo "   3. git push"
echo "   4. Desplegar en Railway"
