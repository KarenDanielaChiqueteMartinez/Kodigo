@echo off
echo ========================================
echo    DIAGNOSTICO - Programming Tutor
echo ========================================
echo.

echo 1. Verificando Flutter...
flutter --version 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Flutter no esta instalado
    echo Instalar desde: https://docs.flutter.dev/get-started/install/windows
    pause
    exit /b 1
)

echo [OK] Flutter instalado
echo.

echo 2. Verificando dispositivos conectados...
flutter devices
echo.

echo 3. Verificando ADB...
adb devices
echo.

echo 4. Buscando Programming Tutor instalada...
adb shell pm list packages 2>nul | findstr programming
if %errorlevel% neq 0 (
    echo [INFO] App no encontrada - necesita instalacion
) else (
    echo [OK] App encontrada en el dispositivo
)
echo.

echo 5. Verificando procesos Flutter...
adb shell ps 2>nul | findstr flutter
echo.

echo ========================================
echo    SOLUCION RAPIDA
echo ========================================
echo.

echo A. Limpiar e instalar:
echo    flutter clean
echo    flutter pub get
echo    flutter run
echo.

echo B. Buscar app en emulador:
echo    - Deslizar hacia arriba (cajon de apps)
echo    - Buscar "Programming Tutor"
echo    - Revisar todas las pantallas
echo.

echo C. Instalacion manual:
echo    flutter build apk --debug
echo    adb install build\app\outputs\flutter-apk\app-debug.apk
echo.

echo D. Alternativa web:
echo    flutter run -d web
echo.

set /p ejecutar="¿Quieres ejecutar la solucion A automaticamente? (s/n): "
if /i "%ejecutar%"=="s" (
    echo.
    echo Ejecutando solucion...
    flutter clean
    flutter pub get
    echo.
    echo Instalando app...
    flutter run
) else (
    echo.
    echo Ejecuta manualmente los comandos de arriba.
)

echo.
pause

