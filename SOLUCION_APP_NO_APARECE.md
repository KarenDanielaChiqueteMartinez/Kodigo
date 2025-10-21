# 🔧 Solución: App No Aparece en el Emulador

## ❌ **Problema**
El emulador se ejecuta correctamente, pero la aplicación **Programming Tutor** no aparece instalada en el teléfono virtual.

## 🎯 **Causas Comunes y Soluciones**

### **1. 🔍 Verificar Estado de la Instalación**

#### Comandos de Diagnóstico:
```bash
# Verificar dispositivos conectados
flutter devices

# Verificar si la app está instalada
adb devices
adb shell pm list packages | findstr programming

# Ver logs en tiempo real
flutter logs
```

### **2. 📱 La App Puede Estar Instalada Pero Oculta**

#### Buscar la App:
1. **En el emulador Android:**
   - Deslizar hacia arriba desde la parte inferior
   - Buscar "Programming Tutor" en el cajón de aplicaciones
   - Revisar todas las pantallas de inicio

2. **Buscar por nombre del paquete:**
   - Buscar "com.example.programming_tutor"
   - O simplemente "programming"

### **3. 🚀 Reinstalar la Aplicación**

#### Método 1: Reinstalación Completa
```bash
# Desinstalar app anterior (si existe)
flutter clean
adb uninstall com.example.programming_tutor

# Reinstalar
flutter pub get
flutter run
```

#### Método 2: Instalación Forzada
```bash
# Compilar e instalar directamente
flutter install
```

### **4. 🔧 Verificar Configuración del Proyecto**

#### Revisar pubspec.yaml:
```yaml
name: programming_tutor
description: Una aplicación educativa para aprender programación

flutter:
  uses-material-design: true
```

#### Verificar AndroidManifest.xml:
Archivo: `android/app/src/main/AndroidManifest.xml`
```xml
<application
    android:label="Programming Tutor"
    android:name="${applicationName}"
    android:icon="@mipmap/ic_launcher">
    
    <activity
        android:name=".MainActivity"
        android:exported="true"
        android:launchMode="singleTop"
        android:theme="@style/LaunchTheme">
        
        <intent-filter android:autoVerify="true">
            <action android:name="android.intent.action.MAIN"/>
            <category android:name="android.intent.category.LAUNCHER"/>
        </intent-filter>
    </activity>
</application>
```

### **5. 🐛 Problemas de Compilación**

#### Verificar Errores de Build:
```bash
# Ver logs detallados
flutter run -v

# Compilar manualmente
flutter build apk --debug
```

#### Errores Comunes:
- **Gradle sync failed**: Limpiar proyecto
- **NDK errors**: Ya solucionado anteriormente
- **SDK version mismatch**: Actualizar SDK

### **6. 🔄 Proceso de Solución Paso a Paso**

#### Paso 1: Limpiar Todo
```bash
flutter clean
flutter pub get
```

#### Paso 2: Verificar Emulador
```bash
flutter devices
# Debe mostrar el emulador como disponible
```

#### Paso 3: Reinstalar App
```bash
flutter run --debug
```

#### Paso 4: Verificar Instalación
```bash
adb shell pm list packages | findstr programming_tutor
```

### **7. 🚨 Soluciones de Emergencia**

#### Opción 1: Crear APK Manual
```bash
# Generar APK
flutter build apk --debug

# Instalar manualmente
adb install build/app/outputs/flutter-apk/app-debug.apk
```

#### Opción 2: Usar Dispositivo Físico
```bash
# Conectar teléfono real por USB
# Habilitar depuración USB
flutter run
```

#### Opción 3: Ejecutar en Web
```bash
flutter run -d web
```

### **8. 📋 Script de Diagnóstico Completo**

```batch
@echo off
echo ========================================
echo    DIAGNOSTICO - App No Aparece
echo ========================================

echo 1. Verificando dispositivos...
flutter devices

echo.
echo 2. Verificando ADB...
adb devices

echo.
echo 3. Buscando app instalada...
adb shell pm list packages | findstr programming

echo.
echo 4. Limpiando proyecto...
flutter clean
flutter pub get

echo.
echo 5. Reinstalando app...
flutter run --debug

pause
```

## 🎯 **Solución Más Probable**

### **La app SÍ está instalada, pero:**

1. **Nombre diferente**: Busca "programming_tutor" o "com.example.programming_tutor"
2. **En cajón de apps**: Desliza hacia arriba para ver todas las apps
3. **Instalación en progreso**: Espera a que termine completamente

### **Verificación Rápida:**
```bash
# Ver si el proceso está corriendo
adb shell ps | findstr flutter

# Ver logs en tiempo real
flutter logs
```

## ✅ **Pasos de Verificación Final**

1. **Ejecutar**: `flutter devices` (debe mostrar emulador)
2. **Ejecutar**: `flutter run` (debe instalar y abrir la app)
3. **En el emulador**: Buscar "Programming Tutor" en todas las pantallas
4. **Si no aparece**: Usar `adb install` manual

## 🚀 **Resultado Esperado**

Después de seguir estos pasos, deberías ver:
- ✅ La app "Programming Tutor" en el cajón de aplicaciones
- ✅ Pantalla de login al abrirla
- ✅ Funcionalidad completa del sistema educativo

## 📞 **Si Persiste el Problema**

Ejecuta este comando y comparte el resultado:
```bash
flutter run -v 2>&1 | findstr -i "error\|exception\|fail"
```

¡La app está ahí, solo hay que encontrarla! 📱✨

