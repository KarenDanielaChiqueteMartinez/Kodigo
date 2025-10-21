@echo off
echo ========================================
echo    PROGRAMMING TUTOR - Ejecutar App
echo ========================================
echo.

echo Verificando Flutter...
flutter --version 2>nul
if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Flutter no esta instalado
    echo.
    echo INSTALAR FLUTTER:
    echo 1. Descargar desde: https://docs.flutter.dev/get-started/install/windows
    echo 2. Extraer a C:\flutter
    echo 3. Agregar C:\flutter\bin al PATH
    echo 4. Reiniciar terminal
    echo.
    pause
    exit /b 1
)

echo.
echo Instalando dependencias...
flutter pub get

echo.
echo Verificando dispositivos...
flutter devices

echo.
echo ========================================
echo    OPCIONES PARA EJECUTAR
echo ========================================
echo.
echo 1. Dispositivo Android conectado por USB
echo 2. Emulador Android
echo 3. Navegador Web
echo.

set /p opcion="Selecciona una opcion (1-3): "

if "%opcion%"=="1" (
    echo.
    echo Ejecutando en dispositivo Android...
    flutter run
) else if "%opcion%"=="2" (
    echo.
    echo Listando emuladores disponibles...
    flutter emulators
    echo.
    echo Ejecutando en emulador...
    flutter run
) else if "%opcion%"=="3" (
    echo.
    echo Ejecutando en navegador web...
    flutter run -d web
) else (
    echo.
    echo Opcion no valida. Ejecutando por defecto...
    flutter run
)

echo.
pause

