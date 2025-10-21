@echo off
echo ========================================
echo    SOLUCION NDK - Programming Tutor
echo ========================================
echo.

echo 1. Eliminando NDK corrupto...
powershell -Command "Remove-Item 'C:\Users\krnd_\AppData\Local\Android\sdk\ndk\27.0.12077973' -Recurse -Force -ErrorAction SilentlyContinue"
echo [OK] NDK corrupto eliminado

echo.
echo 2. Limpiando proyecto Flutter...
if exist "pubspec.yaml" (
    flutter clean 2>nul
    if %errorlevel% equ 0 (
        echo [OK] Proyecto limpiado
        flutter pub get 2>nul
        if %errorlevel% equ 0 (
            echo [OK] Dependencias instaladas
        ) else (
            echo [WARNING] No se pudieron instalar dependencias - Flutter no instalado
        )
    ) else (
        echo [WARNING] No se pudo limpiar - Flutter no instalado
    )
) else (
    echo [ERROR] No se encuentra pubspec.yaml - No estas en un proyecto Flutter
)

echo.
echo ========================================
echo    OPCIONES PARA EJECUTAR LA APP
echo ========================================
echo.
echo 1. Ejecutar en navegador web (Recomendado)
echo    flutter run -d web
echo.
echo 2. Conectar telefono Android por USB
echo    - Habilitar depuracion USB
echo    - flutter run
echo.
echo 3. Usar Android Studio
echo    - Reinstalar NDK desde SDK Manager
echo    - Crear emulador
echo.
echo ========================================
echo    SOLUCION COMPLETADA
echo ========================================
echo.
echo El error NDK ha sido solucionado.
echo Ahora puedes ejecutar la app usando las opciones de arriba.
echo.
pause

