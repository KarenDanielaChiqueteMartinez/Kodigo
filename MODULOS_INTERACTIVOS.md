# Módulos Educativos Interactivos - Documentación

## 📚 Resumen

Se ha implementado un sistema completo de módulos educativos interactivos para mejorar la experiencia de aprendizaje en la aplicación Kodigo. Cada lección ahora incluye módulos interactivos con:

1. ✅ Explicaciones breves y claras del concepto
2. ✅ Ejemplos de código en un recuadro tipo "editor"
3. ✅ Actividades prácticas interactivas
4. ✅ Retroalimentación inmediata (✅ Correcto / ❌ Inténtalo de nuevo)

## 🎯 Características Implementadas

### 1. Modelo de Datos Extendido

**Archivo:** `lib/models/lesson.dart`

Se agregaron nuevos modelos:
- `InteractiveModule`: Representa un módulo educativo completo
- `CodeExample`: Ejemplo de código con resaltado de sintaxis
- `Activity`: Actividad práctica interactiva
- `ActivityType`: Enum con tipos de actividad (fillInBlank, multipleChoice, dragAndDrop)

### 2. Widget de Visualización de Código

**Archivo:** `lib/widgets/code_editor_display.dart`

Widget que muestra código con:
- Fondo oscuro tipo VS Code
- Barra superior con nombre del lenguaje
- Botón para copiar código al portapapeles
- Soporte para múltiples lenguajes (Dart, JavaScript, Python, Java)
- Descripción opcional del código
- Scroll horizontal y vertical para código largo

### 3. Widgets de Actividades Interactivas

**Archivo:** `lib/widgets/activity_widgets.dart`

Tres tipos de actividades implementadas:

#### a) FillInBlankActivity (Completar espacios en blanco)
- Muestra código con un espacio en blanco (___)
- Presenta opciones para completar
- Resalta la opción seleccionada en el código
- Muestra retroalimentación visual (verde=correcto, rojo=incorrecto)

#### b) MultipleChoiceActivity (Opción múltiple)
- Pregunta con múltiples opciones
- Las opciones se colorean según el resultado
- Permite reintentar si la respuesta es incorrecta
- Muestra explicación al responder

#### c) DragDropActivity (Arrastrar y soltar)
- Bloques arrastrables de código
- Zonas de soltar numeradas
- Verifica el orden correcto
- Permite reorganizar bloques fácilmente

### 4. Widget de Módulo Interactivo

**Archivo:** `lib/widgets/interactive_lesson_module.dart`

Componente principal que integra todo:
- Encabezado atractivo con gradiente
- Sección de explicación del concepto (💡)
- Sección de ejemplo de código (📝)
- Sección de práctica con actividades (✍️)
- Barra de progreso de actividades
- Resumen de completado con estadísticas
- Transición automática entre actividades cuando se responde correctamente

### 5. Pantalla de Lección Actualizada

**Archivo:** `lib/screens/lessons/lesson_detail_screen.dart`

Mejoras implementadas:
- Detecta si la lección tiene módulos interactivos
- Muestra módulos interactivos antes de las preguntas tradicionales
- Barra de progreso entre módulos
- Calcula puntuación combinada (módulos + preguntas)
- Transición fluida de módulos interactivos a preguntas tradicionales
- Completa automáticamente la lección si no hay preguntas tradicionales

### 6. Lecciones con Contenido Interactivo

**Archivo:** `lib/services/lesson_service.dart`

Se agregaron módulos interactivos a 4 lecciones de ejemplo:

#### Lección 1: Introducción a Variables (var_001)
- 2 módulos interactivos
- Temas: ¿Qué es una variable? / Declarando variables
- 4 actividades totales

#### Lección 2: Tipos de Datos Básicos (var_002)
- 1 módulo interactivo
- Tema: Entendiendo los tipos de datos
- 3 actividades (múltiple opción, completar código, arrastrar y soltar)

#### Lección 3: Estructuras Condicionales IF (cond_001)
- 2 módulos interactivos
- Temas: Tomando decisiones con IF / Operadores de comparación
- 5 actividades totales

#### Lección 4: Bucles FOR básicos (loop_001)
- 1 módulo interactivo
- Tema: Repetir código con FOR
- 3 actividades con diferentes tipos

## 🎨 Diseño Visual

### Colores y Temas
- **Editor de código**: Fondo oscuro (#1E1E1E) tipo VS Code
- **Actividades correctas**: Verde (#4CAF50)
- **Actividades incorrectas**: Rojo (#F44336)
- **Información**: Azul (#2196F3)
- **Advertencia**: Naranja (#FF9800)

### Iconos Utilizados
- 💡 Explicación del concepto
- 📝 Ejemplo de código
- ✍️ Práctica (actividades)
- ✅ Respuesta correcta
- ❌ Respuesta incorrecta
- 🎉 Módulo completado

## 📊 Flujo de Usuario

1. **Inicio de lección**: Usuario selecciona una lección
2. **Módulo interactivo**: Se muestra el primer módulo con información contextual
3. **Explicación**: Usuario lee el concepto explicado de forma clara
4. **Ejemplo de código**: Usuario ve código de ejemplo (puede copiar)
5. **Práctica**: Usuario hace clic en "Comenzar actividades"
6. **Actividad**: Usuario completa la primera actividad
7. **Retroalimentación**: Sistema muestra si es correcto o incorrecto
8. **Progreso**: Si es correcto, avanza automáticamente (después de 2 segundos)
9. **Siguiente actividad**: Se repite el proceso para cada actividad
10. **Completado**: Al terminar todas las actividades, se muestra resumen
11. **Siguiente módulo**: Avanza al siguiente módulo (si existe)
12. **Preguntas tradicionales**: Después de los módulos, continúan las preguntas tradicionales
13. **Finalización**: Se guarda el progreso y se muestra felicitación

## 🔧 Cómo Agregar Módulos a Nuevas Lecciones

Para agregar módulos interactivos a una lección existente o nueva:

```dart
Lesson(
  id: 'ejemplo_001',
  title: 'Mi Lección',
  // ... otros campos ...
  interactiveModules: [
    InteractiveModule(
      id: 'ejemplo_001_mod1',
      title: 'Título del Módulo',
      explanation: '''
        Explicación clara y concisa del concepto.
        Usa analogías del mundo real.
      ''',
      codeExample: CodeExample(
        code: '''
// Tu código de ejemplo aquí
int numero = 42;
print(numero);
        ''',
        language: 'dart',
        description: 'Descripción opcional del código',
      ),
      activities: [
        Activity(
          id: 'ejemplo_001_act1',
          type: ActivityType.multipleChoice,
          question: '¿Cuál es la respuesta correcta?',
          data: {
            'options': ['Opción 1', 'Opción 2', 'Opción 3', 'Opción 4'],
          },
          correctAnswer: 'Opción 2',
          feedback: 'Explicación de por qué es correcta.',
        ),
        // Más actividades...
      ],
    ),
    // Más módulos...
  ],
  questions: [
    // Preguntas tradicionales (se muestran después de los módulos)
  ],
)
```

## 📝 Tipos de Actividades Disponibles

### 1. Multiple Choice (Opción Múltiple)
```dart
Activity(
  type: ActivityType.multipleChoice,
  question: 'Tu pregunta aquí',
  data: {
    'options': ['Opción 1', 'Opción 2', 'Opción 3'],
  },
  correctAnswer: 'Opción 2',
  feedback: 'Retroalimentación',
)
```

### 2. Fill in the Blank (Completar código)
```dart
Activity(
  type: ActivityType.fillInBlank,
  question: 'Completa el código:',
  data: {
    'codeTemplate': 'int edad ___ 25;',
    'options': ['=', '==', '!=', '>='],
    'blankPosition': '___',
  },
  correctAnswer: '=',
  feedback: 'Retroalimentación',
)
```

### 3. Drag and Drop (Arrastrar y soltar)
```dart
Activity(
  type: ActivityType.dragAndDrop,
  question: 'Ordena los elementos correctamente:',
  data: {
    'blocks': ['int', 'edad', '=', '25', ';'],
    'slots': 5,
  },
  correctAnswer: 'int,edad,=,25,;',
  feedback: 'Retroalimentación',
)
```

## ✨ Mejores Prácticas

1. **Explicaciones**: Usa analogías del mundo real para conceptos complejos
2. **Código de ejemplo**: Incluye comentarios explicativos en el código
3. **Actividades**: Empieza con fáciles y aumenta la dificultad gradualmente
4. **Feedback**: Proporciona explicaciones claras de por qué la respuesta es correcta/incorrecta
5. **Variedad**: Alterna entre los diferentes tipos de actividades
6. **Progresión**: Cada módulo debe construir sobre el anterior

## 🚀 Próximos Pasos Sugeridos

1. Agregar módulos interactivos a las lecciones restantes
2. Agregar más tipos de actividades (ej: ordenar código línea por línea)
3. Implementar sistema de puntos/insignias por completar módulos
4. Agregar animaciones más sofisticadas
5. Soporte para imágenes/diagramas en explicaciones
6. Modo "desafío" con límite de tiempo

## 🐛 Notas Técnicas

- Los módulos son opcionales: las lecciones sin módulos funcionan como antes
- La puntuación se calcula: módulos (máx 20 pts cada uno) + preguntas tradicionales
- Los módulos se guardan en el progreso del usuario
- Todos los widgets son responsivos y funcionan en diferentes tamaños de pantalla
- No hay errores de linting en ningún archivo

## 📱 Prueba la Funcionalidad

1. Ejecuta la aplicación: `flutter run`
2. Navega a "Lecciones"
3. Selecciona cualquiera de estas lecciones mejoradas:
   - Introducción a Variables
   - Tipos de Datos Básicos
   - Estructuras Condicionales IF
   - Bucles FOR básicos
4. Experimenta con los módulos interactivos y actividades

¡Disfruta enseñando programación de forma interactiva! 🎓

