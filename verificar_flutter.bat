@echo off
echo ========================================
echo    VERIFICACION FLUTTER - Programming Tutor
echo ========================================
echo.

echo 1. Verificando Flutter...
flutter --version 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Flutter no esta instalado o no esta en el PATH
    echo.
    echo SOLUCION:
    echo - Descargar Flutter desde: https://flutter.dev/docs/get-started/install/windows
    echo - Extraer a C:\flutter
    echo - Agregar C:\flutter\bin al PATH del sistema
    echo - Reiniciar terminal
    goto :end
) else (
    echo [OK] Flutter instalado correctamente
)

echo.
echo 2. Verificando configuracion de Flutter...
flutter doctor
echo.

echo 3. Verificando dispositivos disponibles...
flutter devices
echo.

echo 4. Verificando emuladores...
flutter emulators
echo.

echo ========================================
echo    COMANDOS UTILES
echo ========================================
echo.
echo Para ejecutar la app:
echo   flutter pub get
echo   flutter run
echo.
echo Para usar emulador especifico:
echo   flutter emulators --launch ^<emulator_id^>
echo   flutter run
echo.
echo Para ejecutar en web:
echo   flutter run -d web
echo.
echo Para usar dispositivo fisico:
echo   1. Conectar telefono por USB
echo   2. Habilitar depuracion USB
echo   3. flutter run
echo.

:end
pause
