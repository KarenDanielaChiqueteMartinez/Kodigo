# 🐛 Debugging: Problema de 2 Preguntas

## 🎯 Problema Reportado

La app solo muestra 2 preguntas cuando debería mostrar 6-7 por lección.

## ✅ Soluciones Implementadas

### 1. Key Única para el Widget
Agregado `ValueKey` al `DraggableQuestionCard` para forzar recreación cuando cambia la pregunta:

```dart
DraggableQuestionCard(
  key: ValueKey('question_${_currentQuestionIndex}_${currentQuestion.id}'),
  // ...
)
```

### 2. Reset de Estado en didUpdateWidget
El widget ahora detecta cuando cambia la pregunta y resetea su estado:

```dart
@override
void didUpdateWidget(DraggableQuestionCard oldWidget) {
  super.didUpdateWidget(oldWidget);
  if (oldWidget.question.id != widget.question.id) {
    _resetState();
    _availableOptions = List<String>.from(widget.question.options);
  }
}
```

### 3. Logs Detallados
Agregados logs para rastrear el flujo:

```dart
🚀 Iniciando lección: [Nombre]
   Total de preguntas: 7
   Preguntas IDs: var_001_q1, var_001_q2, ...
   
✅ Respuesta correcta en pregunta 1
🔄 _nextQuestion llamado
   Pregunta actual: 1/7
   ➡️ Avanzando a pregunta 2
```

## 🔍 Cómo Verificar el Problema

### Paso 1: Ver los Logs

Ejecuta la app y observa la consola cuando inicias una lección:

```bash
flutter run
```

Deberías ver:
```
🚀 Iniciando lección: Introducción a Variables
   Total de preguntas: 7
   Preguntas IDs: var_001_q1, var_001_q2, var_001_q3, var_001_q4, var_001_q5, var_001_q6, var_001_q7
   Módulos interactivos: 2
```

### Paso 2: Completar una Pregunta

Cuando arrastras y respondes correctamente:

```
✅ Respuesta correcta en pregunta 1
🔄 _nextQuestion llamado
   Pregunta actual: 1/7
   ➡️ Avanzando a pregunta 2
```

### Paso 3: Verificar el Total

En la parte superior de la pantalla deberías ver: **"1/7"**, **"2/7"**, etc.

## 🐛 Posibles Causas del Problema

### Causa 1: Widget No se Recrea
**Síntoma:** La pregunta no cambia después de responder
**Solución:** ✅ Agregada key única
**Verificar:** El log "➡️ Avanzando a pregunta X" debería aparecer

### Causa 2: Estado se Mantiene Entre Preguntas
**Síntoma:** La segunda pregunta muestra opciones de la primera
**Solución:** ✅ Agregado didUpdateWidget con reset
**Verificar:** Cada pregunta debe mostrar sus propias opciones

### Causa 3: onCorrectAnswer No se Llama
**Síntoma:** No avanza a la siguiente pregunta
**Solución:** ✅ Agregado log cuando se llama
**Verificar:** Debe aparecer "✅ Respuesta correcta en pregunta X"

### Causa 4: Las Preguntas No Existen en el Servicio
**Síntoma:** Log muestra "Total de preguntas: 2"
**Solución:** Verificar lesson_service.dart
**Verificar:** Cada lección debe tener 6-7 preguntas

## 📊 Verificación Manual de Preguntas

Puedes verificar cuántas preguntas tiene cada lección:

### var_001 (Introducción a Variables)
- ✅ var_001_q1 (¿Qué es una variable?)
- ✅ var_001_q2 (Sintaxis correcta)
- ✅ var_001_q3 (Valor de la variable)
- ✅ var_001_q4 (¿Se puede cambiar?)
- ✅ var_001_q5 (const)
- ✅ var_001_q6 (String mensaje)
- ✅ var_001_q7 (Nombre válido)
**Total: 7 preguntas** ✅

### var_002 (Tipos de Datos)
- ✅ var_002_q1 (Edad - int)
- ✅ var_002_q2 (Booleano true)
- ✅ var_002_q3 (Precio - double)
- ✅ var_002_q4 (Comillas en String)
- ✅ var_002_q5 (Declaración incorrecta)
- ✅ var_002_q6 (x + y)
- ✅ var_002_q7 (bool esEstudiante)
**Total: 7 preguntas** ✅

### cond_001 (Condicionales IF)
- ✅ cond_001_q1 (edad = 20)
- ✅ cond_001_q2 (operador !=)
- ✅ cond_001_q3 (bloque else)
- ✅ cond_001_q4 (temperatura = 25)
- ✅ cond_001_q5 (operador ==)
- ✅ cond_001_q6 (nota >= 70)
- ✅ cond_001_q7 (if sin else)
**Total: 7 preguntas** ✅

## 🧪 Test de Diagnóstico

Ejecuta estos pasos para diagnosticar:

1. **Abre la app** y ve a una lección
2. **Observa la consola** - Busca: `Total de preguntas: X`
3. **Mira la pantalla** - Arriba derecha debe decir "1/X"
4. **Responde la primera pregunta** correctamente
5. **Observa la consola** - Busca: `Avanzando a pregunta 2`
6. **Verifica que cambió** la pregunta en pantalla
7. **Continúa hasta la última**
8. **Verifica el diálogo** de completación

### Resultados Esperados:

```
🚀 Iniciando lección: Introducción a Variables
   Total de preguntas: 7
   Preguntas IDs: var_001_q1, var_001_q2, var_001_q3, var_001_q4, var_001_q5, var_001_q6, var_001_q7
   Módulos interactivos: 2

[Usuario completa módulos...]

✅ Respuesta correcta en pregunta 1
🔄 _nextQuestion llamado
   Pregunta actual: 1/7
   ➡️ Avanzando a pregunta 2

✅ Respuesta correcta en pregunta 2
🔄 _nextQuestion llamado
   Pregunta actual: 2/7
   ➡️ Avanzando a pregunta 3

[... continúa hasta pregunta 7 ...]

✅ Respuesta correcta en pregunta 7
🔄 _nextQuestion llamado
   Pregunta actual: 7/7
   🏁 Última pregunta completada, llamando _completeLesson()

🔍 Iniciando guardado de progreso...
📊 Usuario actual: [Nombre]
📝 Lección: var_001
🎯 Puntuación: 85
```

## 🚨 Si Solo Muestra 2 Preguntas

### Escenario A: Log muestra "Total de preguntas: 2"
**Problema:** Las preguntas no están en lesson_service.dart
**Solución:** Las preguntas están ahí (verificado), puede ser un problema de caché

**Fix:**
```bash
flutter clean
flutter pub get
flutter run
```

### Escenario B: Log muestra "Total de preguntas: 7" pero solo se ven 2
**Problema:** El widget no avanza a la siguiente pregunta
**Solución:** Verificar que aparezca el log "✅ Respuesta correcta"

**Fix:** Ya implementado con la key única

### Escenario C: Después de 2 preguntas se completa la lección
**Problema:** _nextQuestion no está iterando correctamente
**Solución:** Verificar logs de _nextQuestion

**Fix:** Ya agregados logs detallados

## 📝 Cambios Realizados

1. **lib/widgets/draggable_question_card.dart**
   - Agregado `didUpdateWidget` para detectar cambios
   - Agregado `_resetState()` para limpiar estado
   - El widget ahora se resetea correctamente entre preguntas

2. **lib/screens/lessons/lesson_detail_screen.dart**
   - Agregada key única al `DraggableQuestionCard`
   - Logs en `initState` para ver total de preguntas
   - Logs en `_nextQuestion` para rastrear navegación
   - Logs en `onCorrectAnswer` para confirmar callback

## 🎯 Próximo Paso

**Ejecuta la app y envíame los logs** que aparecen en la consola cuando:
1. Inicias una lección
2. Respondes la primera pregunta
3. Se intenta avanzar a la segunda

Con esos logs podré ver exactamente qué está pasando.

---

**Ejemplo de lo que necesito ver:**

```
🚀 Iniciando lección: Introducción a Variables
   Total de preguntas: ?  ← ¿Qué número aparece aquí?
   Preguntas IDs: ...     ← ¿Qué IDs aparecen?

✅ Respuesta correcta en pregunta 1
🔄 _nextQuestion llamado
   Pregunta actual: 1/?   ← ¿Qué dice aquí?
   ➡️ Avanzando a pregunta 2  ← ¿Aparece esta línea?
```

