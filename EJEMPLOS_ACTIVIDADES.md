# 📚 Ejemplos de Actividades Interactivas

Este documento muestra ejemplos visuales de cómo se ven las diferentes actividades interactivas implementadas.

## 🎯 Estructura de un Módulo Interactivo Completo

Cada módulo tiene tres secciones:

### 1. 💡 Explicación del Concepto
```
┌─────────────────────────────────────────────┐
│ 💡 Concepto                                  │
├─────────────────────────────────────────────┤
│                                             │
│ Texto explicativo claro y conciso con      │
│ analogías del mundo real y ejemplos        │
│ prácticos para entender el concepto.       │
│                                             │
└─────────────────────────────────────────────┘
```

### 2. 📝 Ejemplo de Código
```
┌─────────────────────────────────────────────┐
│ 📝 Ejemplo de código                         │
├─────────────────────────────────────────────┤
│ ┌─────────────────────────────────────────┐ │
│ │ DART                          [Copiar]  │ │
│ ├─────────────────────────────────────────┤ │
│ │ // Código de ejemplo                    │ │
│ │ int edad = 25;                          │ │
│ │ String nombre = "María";                │ │
│ │ print(nombre + " tiene " + edad);       │ │
│ └─────────────────────────────────────────┘ │
│ ℹ️ Descripción opcional del código          │
└─────────────────────────────────────────────┘
```

### 3. ✍️ Práctica (Actividades)
```
┌─────────────────────────────────────────────┐
│ ✍️ Práctica                                  │
├─────────────────────────────────────────────┤
│                                             │
│      [Comenzar actividades] 🎯              │
│                                             │
└─────────────────────────────────────────────┘
```

---

## 🎲 Tipos de Actividades

### Tipo 1: Opción Múltiple (MultipleChoiceActivity)

**Antes de responder:**
```
┌─────────────────────────────────────────────────────┐
│ 🎯 Pregunta de opción múltiple                      │
├─────────────────────────────────────────────────────┤
│                                                     │
│ ¿Qué tipo de dato usarías para el nombre           │
│ de una persona?                                     │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │  int                                        │   │
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │  double                                     │   │
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │  String                                 ✓   │   │ ← seleccionado
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │  bool                                       │   │
│ └─────────────────────────────────────────────┘   │
│                                                     │
│          [Verificar respuesta]                      │
│                                                     │
└─────────────────────────────────────────────────────┘
```

**Después de responder correctamente:**
```
┌─────────────────────────────────────────────────────┐
│ 🎯 Pregunta de opción múltiple                      │
├─────────────────────────────────────────────────────┤
│                                                     │
│ ¿Qué tipo de dato usarías para el nombre           │
│ de una persona?                                     │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │  int                                        │   │
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │  double                                     │   │
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │  String                             ✓ ✅    │   │ ← correcto (verde)
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │  bool                                       │   │
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │ ✅ ¡Correcto!                                │   │
│ │ Los nombres son texto, por lo que usamos    │   │
│ │ String (siempre entre comillas).            │   │
│ └─────────────────────────────────────────────┘   │
│                                                     │
└─────────────────────────────────────────────────────┘
```

**Si la respuesta es incorrecta:**
```
┌─────────────────────────────────────────────────────┐
│ 🎯 Pregunta de opción múltiple                      │
├─────────────────────────────────────────────────────┤
│                                                     │
│ ¿Qué tipo de dato usarías para el nombre           │
│ de una persona?                                     │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │  int                                    ❌  │   │ ← incorrecto (rojo)
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │  double                                     │   │
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │  String                             ✅      │   │ ← respuesta correcta
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │  bool                                       │   │
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │ ❌ Inténtalo de nuevo                        │   │
│ │ Los nombres son texto, por lo que usamos    │   │
│ │ String (siempre entre comillas).            │   │
│ └─────────────────────────────────────────────┘   │
│                                                     │
│          [Intentar de nuevo]                        │
│                                                     │
└─────────────────────────────────────────────────────┘
```

---

### Tipo 2: Completar Código (FillInBlankActivity)

**Antes de responder:**
```
┌─────────────────────────────────────────────────────┐
│ ✏️ Completa el código                                │
├─────────────────────────────────────────────────────┤
│                                                     │
│ Completa la declaración correcta de una            │
│ variable entera:                                    │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │  ___ edad = 25;                             │   │ ← espacio en blanco
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ Selecciona el valor correcto:                      │
│                                                     │
│  [int]  [var]  [String]  [number]                  │
│                                                     │
│          [Verificar respuesta]                      │
│                                                     │
└─────────────────────────────────────────────────────┘
```

**Con opción seleccionada:**
```
┌─────────────────────────────────────────────────────┐
│ ✏️ Completa el código                                │
├─────────────────────────────────────────────────────┤
│                                                     │
│ Completa la declaración correcta de una            │
│ variable entera:                                    │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │  int edad = 25;                             │   │ ← opción resaltada
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ Selecciona el valor correcto:                      │
│                                                     │
│  [int] ✓  [var]  [String]  [number]                │
│   ^seleccionado                                     │
│                                                     │
│          [Verificar respuesta]                      │
│                                                     │
└─────────────────────────────────────────────────────┘
```

**Después de responder correctamente:**
```
┌─────────────────────────────────────────────────────┐
│ ✏️ Completa el código                                │
├─────────────────────────────────────────────────────┤
│                                                     │
│ Completa la declaración correcta de una            │
│ variable entera:                                    │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │  int edad = 25;                             │   │ ← resaltado verde
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ Selecciona el valor correcto:                      │
│                                                     │
│  [int] ✅  [var]  [String]  [number]                │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │ ✅ ¡Correcto!                                │   │
│ │ "int" es la palabra clave para declarar     │   │
│ │ números enteros en Dart.                    │   │
│ └─────────────────────────────────────────────┘   │
│                                                     │
└─────────────────────────────────────────────────────┘
```

---

### Tipo 3: Arrastrar y Soltar (DragDropActivity)

**Estado inicial:**
```
┌─────────────────────────────────────────────────────┐
│ 🔀 Ordena los bloques                               │
├─────────────────────────────────────────────────────┤
│                                                     │
│ Ordena las partes de una declaración de            │
│ variable correctamente:                             │
│                                                     │
│ Arrastra los bloques aquí:                         │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │ Bloque 1                                    │   │ ← zona vacía
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │ Bloque 2                                    │   │ ← zona vacía
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │ Bloque 3                                    │   │ ← zona vacía
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │ Bloque 4                                    │   │ ← zona vacía
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │ Bloque 5                                    │   │ ← zona vacía
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ Bloques disponibles:                               │
│                                                     │
│  [⋮ int]  [⋮ edad]  [⋮ =]  [⋮ 25]  [⋮ ;]         │
│                                                     │
│          [Verificar orden]                          │
│                    (deshabilitado)                  │
└─────────────────────────────────────────────────────┘
```

**Con bloques colocados:**
```
┌─────────────────────────────────────────────────────┐
│ 🔀 Ordena los bloques                               │
├─────────────────────────────────────────────────────┤
│                                                     │
│ Ordena las partes de una declaración de            │
│ variable correctamente:                             │
│                                                     │
│ Arrastra los bloques aquí:                         │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │ ⋮ int                                       │   │ ← bloque colocado
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │ ⋮ edad                                      │   │ ← bloque colocado
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │ ⋮ =                                         │   │ ← bloque colocado
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │ ⋮ 25                                        │   │ ← bloque colocado
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │ ⋮ ;                                         │   │ ← bloque colocado
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ Bloques disponibles: (ninguno)                     │
│                                                     │
│          [Verificar orden]                          │
│                                                     │
└─────────────────────────────────────────────────────┘
```

**Después de verificar (correcto):**
```
┌─────────────────────────────────────────────────────┐
│ 🔀 Ordena los bloques                               │
├─────────────────────────────────────────────────────┤
│                                                     │
│ Ordena las partes de una declaración de            │
│ variable correctamente:                             │
│                                                     │
│ Arrastra los bloques aquí:                         │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │ int                                         │   │ ← verde (correcto)
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │ edad                                        │   │ ← verde (correcto)
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │ =                                           │   │ ← verde (correcto)
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │ 25                                          │   │ ← verde (correcto)
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │ ;                                           │   │ ← verde (correcto)
│ └─────────────────────────────────────────────┘   │
│                                                     │
│ ┌─────────────────────────────────────────────┐   │
│ │ ✅ ¡Correcto!                                │   │
│ │ La sintaxis correcta es:                    │   │
│ │ tipo nombre = valor;                        │   │
│ └─────────────────────────────────────────────┘   │
│                                                     │
└─────────────────────────────────────────────────────┘
```

---

## 📊 Progreso y Resumen

**Barra de progreso entre actividades:**
```
┌─────────────────────────────────────────────────────┐
│ [████████████░░░░░░░░░░░░░░░░░] 2/3                │
└─────────────────────────────────────────────────────┘
```

**Resumen al completar el módulo:**
```
┌─────────────────────────────────────────────────────┐
│                                                     │
│                    🎉                               │
│                                                     │
│            ¡Módulo completado!                      │
│                                                     │
│    Has completado todas las actividades            │
│           de este módulo                           │
│                                                     │
│    ┌──────────────────────────────────────┐        │
│    │                                      │        │
│    │  ✅           📊                      │        │
│    │  3/3         100%                   │        │
│    │  Respuestas  Porcentaje             │        │
│    │  correctas                          │        │
│    │                                      │        │
│    └──────────────────────────────────────┘        │
│                                                     │
└─────────────────────────────────────────────────────┘
```

---

## 💡 Tips de UX Implementados

1. **Colores semánticos**:
   - Verde = Correcto ✅
   - Rojo = Incorrecto ❌
   - Azul = Seleccionado
   - Naranja = Advertencia/Info

2. **Feedback inmediato**: 
   - Respuesta visual instantánea
   - Mensaje de texto explicativo
   - Transición automática en 2 segundos si es correcto

3. **Reintentar sin penalización**:
   - Si falla, puede intentar de nuevo
   - No pierde progreso
   - Aprende del error

4. **Código interactivo**:
   - Puede copiar código al portapapeles
   - Vista de código profesional
   - Resaltado según resultado

5. **Progreso visible**:
   - Barra de progreso clara
   - Contador de actividades
   - Indicador del módulo actual

6. **Drag & Drop intuitivo**:
   - Indicador visual de arrastre (⋮)
   - Zonas de soltar claramente marcadas
   - Reorganización fácil

---

¡Ahora tienes una visión completa de cómo funcionan las actividades interactivas! 🎓

