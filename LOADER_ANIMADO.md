# ⏳ Loader Animado - Sistema de Carga

## ✨ **Nueva Funcionalidad**

Se ha implementado un **sistema de loaders animados** profesional y llamativo que mejora significativamente la experiencia del usuario durante las cargas.

## 🎯 **Componentes Creados**

### **1. CustomLoader** - Loader Principal ⭐

El loader más completo y visual:

#### **Características:**
- 🔄 **Rotación continua** del círculo exterior
- 💓 **Pulsación** del círculo central
- ✨ **Gradiente radial** con efecto glow
- 🎓 **Icono central** (school icon)
- 📝 **Mensaje personalizable**
- 🎨 **Colores configurables**

#### **Animaciones:**
- **Rotación**: 2000ms continua
- **Escala pulsante**: 1000ms con reverse
- **Fade del mensaje**: 1500ms con reverse
- **Curvas**: Elastic out para rebote elegante

#### **Uso:**
```dart
CustomLoader(
  size: 80.0,
  color: Color(0xFF1976D2),
  message: 'Cargando lecciones...',
)
```

### **2. DotLoader** - Loader de Puntos 🔵

Loader minimalista con tres puntos animados:

#### **Características:**
- 🔵 **3 puntos** que se animan secuencialmente
- 🌊 **Efecto de onda** con delay entre puntos
- 💫 **Escala y opacidad** dinámicas
- 📏 **Tamaño compacto** para botones

#### **Uso:**
```dart
DotLoader(
  color: Colors.white,
  size: 40.0,
)
```

**Integrado en:**
- Botones de login/registro
- Botones de guardar
- Cualquier CustomButton

### **3. CircularLoader** - Loader Circular 🔄

Spinner circular profesional:

#### **Características:**
- 🔄 **Rotación fluida** continua
- 🎨 **Gradiente de opacidad** en 3 capas
- ⚡ **Ligero y performante**
- 🎯 **Grosor personalizable**

#### **Uso:**
```dart
CircularLoader(
  color: Color(0xFF1976D2),
  size: 50.0,
  strokeWidth: 4.0,
)
```

### **4. LoadingOverlay** - Overlay de Pantalla Completa

Capa de carga sobre contenido:

#### **Características:**
- 🌑 **Backdrop oscuro** semitransparente
- 🔒 **Bloquea interacciones** durante carga
- 📱 **Overlay no intrusivo**
- 🎭 **Transiciones suaves**

#### **Uso:**
```dart
LoadingOverlay(
  isLoading: _isLoading,
  message: 'Procesando...',
  child: YourWidget(),
)
```

## 🎨 **Diseño Visual**

### **CustomLoader Anatomy:**
```
        ┌─────────────────┐
        │                 │
        │   ┌─────────┐   │
        │ ┌─┴─────────┴─┐ │  ← Círculo exterior rotando
        │ │             │ │
        │ │   ┌─────┐   │ │
        │ │   │ 🎓  │   │ │  ← Centro pulsante + icono
        │ │   └─────┘   │ │
        │ │             │ │
        │ └─────────────┘ │
        │                 │
        └─────────────────┘
             
        Cargando lecciones...  ← Mensaje animado
```

### **DotLoader Animation:**
```
Frame 1:  ● ○ ○
Frame 2:  ○ ● ○
Frame 3:  ○ ○ ●
Frame 4:  ● ○ ○  (repite)
```

## 🚀 **Integración en la App**

### **Pantallas Actualizadas:**

#### **1. LessonsScreen**
```dart
body: _isLoading
  ? CustomLoader(message: 'Cargando lecciones...')
  : Column(...)
```

#### **2. ProgressScreen**
```dart
body: _isLoading
  ? CustomLoader(message: 'Analizando tu progreso...')
  : SingleChildScrollView(...)
```

#### **3. ProfileScreen**
```dart
body: _isLoading
  ? CustomLoader(message: 'Cargando perfil...')
  : SingleChildScrollView(...)
```

#### **4. CustomButton**
```dart
child: isLoading
  ? DotLoader(color: Colors.white, size: 40)
  : Text('Iniciar Sesión')
```

## 🎯 **Casos de Uso**

### **Por Tipo de Loader:**

| Loader | Cuándo Usar | Ejemplo |
|--------|-------------|---------|
| **CustomLoader** | Carga de pantallas completas | Iniciando app, cargando datos |
| **DotLoader** | Dentro de botones | Login, guardar, enviar |
| **CircularLoader** | Espacios reducidos | Cards, listas, refresh |
| **LoadingOverlay** | Sobre contenido existente | Procesando, guardando |

## 💡 **Ventajas del Sistema**

### **1. Consistencia Visual**
- Mismo estilo en toda la app
- Colores coordina con el tema
- Animaciones coherentes

### **2. Feedback Claro**
- Usuario sabe que algo está pasando
- Mensajes personalizados informativos
- Animaciones no invasivas

### **3. Profesionalismo**
- Diseño moderno y pulido
- Animaciones suaves
- Mejor percepción de velocidad

### **4. Rendimiento**
- Animaciones optimizadas
- No bloquea la UI
- Usa hardware acceleration

## 🔧 **Personalización**

### **Colores:**
```dart
// Azul (default)
CustomLoader(color: Color(0xFF1976D2))

// Morado
CustomLoader(color: Color(0xFF7E57C2))

// Verde
CustomLoader(color: Color(0xFF66BB6A))
```

### **Tamaños:**
```dart
CustomLoader(size: 60.0)   // Pequeño
CustomLoader(size: 80.0)   // Mediano (default)
CustomLoader(size: 120.0)  // Grande
```

### **Mensajes:**
```dart
CustomLoader(message: 'Cargando...')
CustomLoader(message: 'Procesando datos...')
CustomLoader(message: 'Generando recomendaciones...')
```

## 🎬 **Animaciones Implementadas**

### **Rotación Continua:**
```dart
AnimationController(
  duration: Duration(milliseconds: 2000),
)..repeat()
```

### **Pulsación:**
```dart
AnimationController(
  duration: Duration(milliseconds: 1000),
)..repeat(reverse: true)
```

### **Fade In/Out:**
```dart
AnimationController(
  duration: Duration(milliseconds: 1500),
)..repeat(reverse: true)
```

### **Secuencia de Puntos:**
```dart
// Delay escalonado de 0.2 entre cada punto
final delay = index * 0.2;
final scale = sin(value * pi);
```

## 📱 **Ejemplo de Uso Completo**

```dart
class MyScreen extends StatefulWidget {
  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    
    // Simular carga
    await Future.delayed(Duration(seconds: 2));
    
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? CustomLoader(
              message: 'Cargando datos...',
              color: Theme.of(context).primaryColor,
            )
          : YourContent(),
    );
  }
}
```

## ✅ **Estado Actual**

- ✅ **4 tipos de loaders** implementados
- ✅ **Animaciones fluidas** y optimizadas
- ✅ **Integrado** en todas las pantallas principales
- ✅ **Mensajes personalizados** por pantalla
- ✅ **Sin errores de linting**
- ✅ **Diseño profesional** y llamativo

## 🎉 **Resultado**

El sistema de loaders de **Programming Tutor** proporciona:

1. **Feedback visual excelente** durante cargas
2. **Animaciones suaves** que mejoran UX
3. **Diseño consistente** con el tema de la app
4. **Múltiples opciones** según el contexto
5. **Fácil de usar** y personalizar

¡Los usuarios ahora tienen un feedback visual claro y atractivo durante todas las operaciones de carga! ⏳✨🚀
