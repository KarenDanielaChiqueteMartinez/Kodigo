# 📱 Cómo Probar Kódigo en iOS

## ⚠️ Requisitos para iOS

Para probar en iOS necesitas:

### Opción 1: iPhone/iPad físico
- ✅ **Mac** con macOS
- ✅ **Xcode** instalado (desde Mac App Store)
- ✅ **iPhone/iPad** físico
- ✅ **Cable USB** para conectar
- ✅ **Apple Developer Account** (gratis para pruebas)

### Opción 2: Simulador de iOS (sin dispositivo físico)
- ✅ **Mac** con macOS
- ✅ **Xcode** instalado
- No necesitas iPhone físico

---

## 🚀 Pasos para Probar en Mac

### 1. Instalar Xcode
```bash
# Abre Mac App Store
# Busca "Xcode"
# Instala (puede tardar mucho tiempo)
```

### 2. Aceptar licencias
```bash
sudo xcodebuild -license accept
```

### 3. Instalar herramientas de línea de comandos
```bash
xcode-select --install
```

### 4. Ejecutar en simulador
```bash
cd /ruta/a/tu/proyecto
flutter run
```

### 5. O elegir dispositivo iOS específico
```bash
# Ver dispositivos disponibles
flutter devices

# Ejecutar en iPhone específico
flutter run -d iphone
```

---

## 📦 Para Generar IPA (aplicación instalable)

### 1. Construir la app
```bash
flutter build ios
```

### 2. Abrir en Xcode
```bash
open ios/Runner.xcworkspace
```

### 3. Firmar y distribuir
- En Xcode, selecciona tu equipo de desarrollo
- Configure signing con tu Apple ID
- Selecciona "Build and Run"

---

## 💻 Si NO tienes Mac

**Opciones:**

### Opción A: Usar un Mac en la nube
- [MacStadium](https://www.macstadium.com/)
- [Flow](https://flow.com/) - Macs remotas

### Opción B: Alquilar un Mac físico
- Algunas universidades tienen Macs disponibles
- Algunos coworking spaces tienen Macs

### Opción C: Usar GitHub Actions (gratis)
```yaml
# En .github/workflows/ios.yml
name: Build iOS
on: [push]
jobs:
  build:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter build ios
```

---

## 🔧 Comandos Útiles

### Ver dispositivos disponibles
```bash
flutter devices
```

### Ejecutar en iOS específico
```bash
flutter run -d "iPhone 15"
```

### Limpiar builds
```bash
flutter clean
flutter pub get
```

### Construir release
```bash
flutter build ios --release
```

### Ejecutar con logs detallados
```bash
flutter run -v
```

---

## ⚠️ Problemas Comunes

### Error: "No devices found"
```bash
# Iniciar simulador
open -a Simulator
```

### Error: "Code signing required"
1. Abre Xcode
2. Abre `ios/Runner.xcworkspace`
3. Ve a "Signing & Capabilities"
4. Selecciona tu Apple ID

### Error: "Developer mode required" (iOS 16+)
1. En iPhone: Settings → Privacy & Security → Developer Mode
2. Activa "Developer Mode"
3. Reinicia el iPhone

---

## 📱 Alternativa: Probar en Web

Si no tienes Mac, puedes probar la app en navegador iOS:

```bash
flutter run -d chrome --web-renderer html
```

Abre en Safari en iPhone:
1. Desktop compartir con iPhone
2. Abre Chrome en escritorio con la app
3. Safari en iPhone verá la misma pantalla

---

## ✅ Resumen

**Tienes Mac?**
- ✅ Sí → Ejecuta `flutter run` y listo
- ❌ No → Usa Web Chrome como alternativa temporal

**No tienes Mac?**
- Usa la versión Web para probar en iPhone Safari
- O espera a tener acceso a Mac para generar IPA

---

**Recomendación:** Si quieres probar la app en iPhone ahora mismo y no tienes Mac, la mejor opción es usar la **versión Web** ejecutada en Chrome/Safari.

