#!/bin/bash

echo "🚀 Iniciando build para Railway..."

# Verificar que estamos en el directorio correcto
if [ ! -f "package.json" ]; then
    echo "❌ Error: No se encontró package.json. Asegúrate de estar en el directorio raíz del proyecto."
    exit 1
fi

# Verificar y crear directorio public si no existe
if [ ! -d "public" ]; then
    echo "⚠️ Directorio public no existe, creándolo..."
    mkdir -p public
    echo "✅ Directorio public creado"
fi

# Verificar que public tenga contenido
if [ ! -f "public/.gitkeep" ] && [ ! -f "public/index.html" ]; then
    echo "⚠️ Directorio public está vacío, agregando archivos..."
    echo "# Este archivo asegura que el directorio public se incluya en el repositorio" > public/.gitkeep
    echo "✅ Archivo .gitkeep creado en public"
fi

# Verificar estructura del proyecto
echo "📁 Verificando estructura del proyecto..."
echo "   - public: $(ls -la public/ | wc -l) archivos"
echo "   - src: $(ls -la src/ | wc -l) archivos"
echo "   - prisma: $(ls -la prisma/ | wc -l) archivos"
echo "   - manager: $(ls -la manager/ | wc -l) archivos"

# Verificar archivos necesarios
echo "📄 Verificando archivos necesarios..."
required_files=("Dockerfile" "package.json" ".env.example" "src/railway.json")
for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "   ✅ $file"
    else
        echo "   ❌ $file - FALTANTE"
        exit 1
    fi
done

echo ""
echo "🎉 ¡Proyecto listo para Railway!"
echo "📋 Próximos pasos:"
echo "   1. git add ."
echo "   2. git commit -m 'Fix: Resolver problema del directorio public'"
echo "   3. git push"
echo "   4. Desplegar en Railway"
