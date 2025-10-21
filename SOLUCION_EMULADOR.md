# 🔧 Solución: Error del Emulador Android

## ❌ **Error Reportado**
```
Device daemon started.
[ERR] The Android emulator exited with code 1 during startup
[ERR] Android emulator stderr:
[ERR] Address these issues and try again.
```

## 🎯 **Causas Comunes y Soluciones**

### 1. 📱 **Flutter No Instalado/Configurado**

#### **Instalar Flutter**
1. **Descargar Flutter**:
   - Ve a: https://flutter.dev/docs/get-started/install/windows
   - Descarga el ZIP de Flutter SDK

2. **Extraer y Configurar**:
   ```bash
   # Extraer a: C:\flutter
   # Agregar al PATH: C:\flutter\bin
   ```

3. **Verificar Variables de Entorno**:
   - Abrir "Variables de entorno del sistema"
   - Agregar `C:\flutter\bin` al PATH
   - Reiniciar terminal

#### **Verificar Instalación**:
```bash
flutter --version
flutter doctor
```

### 2. 🤖 **Android Studio y SDK**

#### **Instalar Android Studio**:
1. Descargar desde: https://developer.android.com/studio
2. Durante instalación, asegurar que se instale:
   - Android SDK
   - Android SDK Platform-Tools
   - Android SDK Build-Tools
   - Android Emulator

#### **Configurar SDK**:
```bash
# Verificar ubicación del SDK
flutter doctor -v

# Si no está configurado, agregar al PATH:
# ANDROID_HOME = C:\Users\[usuario]\AppData\Local\Android\Sdk
```

### 3. 📱 **Crear/Configurar Emulador**

#### **Crear Emulador en Android Studio**:
1. Abrir Android Studio
2. `Tools` → `AVD Manager`
3. `Create Virtual Device`
4. Seleccionar dispositivo (ej: Pixel 4)
5. Descargar imagen del sistema (API 30+)
6. Configurar y crear

#### **Configuración Recomendada**:
- **API Level**: 30 o superior
- **RAM**: 2GB mínimo
- **Storage**: 2GB mínimo
- **Graphics**: Hardware - GLES 2.0

### 4. 🔧 **Soluciones Específicas del Error**

#### **Problema: Virtualización Deshabilitada**
```bash
# Verificar en BIOS/UEFI:
# - Intel VT-x habilitado
# - AMD-V habilitado
# - Hyper-V deshabilitado (Windows)
```

#### **Problema: Conflicto con Hyper-V**
```bash
# Deshabilitar Hyper-V (como administrador):
dism.exe /Online /Disable-Feature:Microsoft-Hyper-V-All

# Reiniciar sistema
```

#### **Problema: Permisos Insuficientes**
```bash
# Ejecutar Android Studio como administrador
# Verificar permisos en carpeta SDK
```

#### **Problema: Memoria Insuficiente**
```bash
# Aumentar RAM del emulador:
# AVD Manager → Edit → Advanced Settings → RAM: 2048MB+
```

### 5. 🚀 **Alternativas al Emulador**

#### **Opción 1: Dispositivo Físico**
```bash
# Conectar teléfono Android por USB
# Habilitar "Depuración USB" en opciones de desarrollador
flutter devices
flutter run
```

#### **Opción 2: Emulador Web**
```bash
# Ejecutar en navegador web
flutter run -d web
```

#### **Opción 3: Emulador Alternativo**
- **BlueStacks**: Emulador Android popular
- **Genymotion**: Emulador profesional
- **Android-x86**: Máquina virtual

### 6. 📋 **Comandos de Diagnóstico**

#### **Verificar Estado Completo**:
```bash
flutter doctor -v
flutter devices
flutter emulators
```

#### **Listar Emuladores Disponibles**:
```bash
flutter emulators
flutter emulators --launch <emulator_id>
```

#### **Verificar Conexión ADB**:
```bash
adb devices
adb kill-server
adb start-server
```

### 7. 🔄 **Proceso de Solución Paso a Paso**

#### **Paso 1: Verificar Flutter**
```bash
flutter --version
# Si no funciona → Instalar Flutter
```

#### **Paso 2: Verificar Android Setup**
```bash
flutter doctor
# Resolver todos los issues marcados con [!]
```

#### **Paso 3: Crear Emulador**
```bash
# Android Studio → AVD Manager → Create Virtual Device
```

#### **Paso 4: Probar Emulador**
```bash
flutter emulators
flutter emulators --launch <nombre_emulador>
```

#### **Paso 5: Ejecutar App**
```bash
flutter pub get
flutter run
```

## 🎯 **Solución Rápida Recomendada**

### **Para Principiantes**:
1. **Usar dispositivo físico** (más fácil)
2. **Ejecutar en web** (sin configuración adicional)

### **Para Desarrollo Completo**:
1. Instalar Flutter correctamente
2. Instalar Android Studio
3. Crear emulador con configuración adecuada
4. Verificar virtualización habilitada

## 📞 **Si Persiste el Problema**

### **Información a Recopilar**:
```bash
flutter doctor -v
flutter --version
```

### **Logs Detallados**:
```bash
flutter run -v
# Revisar logs completos del error
```

## ✅ **Verificación Final**

Una vez solucionado, deberías ver:
```bash
flutter doctor
# [✓] Flutter (Channel stable, 3.x.x)
# [✓] Android toolchain
# [✓] Android Studio
# [✓] Connected device (1 available)
```

¡Con estos pasos deberías poder ejecutar la aplicación **Programming Tutor** sin problemas! 🚀📱
