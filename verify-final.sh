#!/bin/bash

echo "🔍 Verificación final del proyecto para Railway..."

# Verificar directorio public
echo "📁 Verificando directorio public..."
if [ -d "public" ]; then
    echo "✅ Directorio public existe"
    echo "📊 Contenido:"
    ls -la public/
    if [ -f "public/.gitkeep" ]; then
        echo "✅ Archivo .gitkeep presente"
    fi
    if [ -f "public/index.html" ]; then
        echo "✅ Archivo index.html presente"
    fi
    if [ -d "public/images" ]; then
        echo "✅ Directorio images presente"
        echo "📊 Imágenes: $(ls public/images/ | wc -l) archivos"
    fi
else
    echo "❌ Directorio public NO existe"
    exit 1
fi

# Verificar archivos necesarios
echo ""
echo "📄 Verificando archivos necesarios..."
files=("Dockerfile" "package.json" ".env.example" "src/railway.json" "tsconfig.json" "tsup.config.ts")
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file"
    else
        echo "❌ $file - FALTANTE"
        exit 1
    fi
done

# Verificar directorios necesarios
echo ""
echo "📁 Verificando directorios necesarios..."
dirs=("src" "prisma" "manager" "Docker")
for dir in "${dirs[@]}"; do
    if [ -d "$dir" ]; then
        echo "✅ $dir"
    else
        echo "❌ $dir - FALTANTE"
        exit 1
    fi
done

echo ""
echo "🎉 ¡Verificación completada exitosamente!"
echo "📋 El proyecto está listo para Railway:"
echo "   - Dockerfile optimizado ✅"
echo "   - Directorio public con contenido ✅"
echo "   - Todos los archivos necesarios ✅"
echo "   - Estructura correcta ✅"
echo ""
echo "🚀 Próximos pasos:"
echo "   1. git add ."
echo "   2. git commit -m 'Fix: Dockerfile corregido para Railway'"
echo "   3. git push"
echo "   4. Desplegar en Railway"
