import '../models/lesson.dart';

/// Servicio que maneja las lecciones de programación
/// Proporciona datos de ejemplo para demostrar la funcionalidad
class LessonService {
  /// Obtiene todas las lecciones disponibles
  /// En una app real, esto vendría de una base de datos o API
  Future<List<Lesson>> getLessons() async {
    // Simular delay de red
    await Future.delayed(const Duration(milliseconds: 500));
    
    return _sampleLessons;
  }

  /// Obtiene una lección específica por ID
  Future<Lesson?> getLessonById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    try {
      return _sampleLessons.firstWhere((lesson) => lesson.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Obtiene lecciones por categoría
  Future<List<Lesson>> getLessonsByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return _sampleLessons.where((lesson) => lesson.category == category).toList();
  }

  /// Obtiene lecciones por nivel
  Future<List<Lesson>> getLessonsByLevel(int level) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return _sampleLessons.where((lesson) => lesson.level == level).toList();
  }

  /// Datos de ejemplo de lecciones
  static final List<Lesson> _sampleLessons = [
    // Lecciones de Variables
    Lesson(
      id: 'var_001',
      title: 'Introducción a Variables',
      description: 'Aprende qué son las variables y cómo usarlas en programación',
      level: 1,
      category: 'Variables',
      concepts: ['Declaración', 'Asignación', 'Tipos de datos'],
      content: '''
Las variables son contenedores que almacenan datos en la memoria de la computadora. 
Piensa en ellas como cajas etiquetadas donde puedes guardar información.

En programación, las variables tienen:
• Un nombre (identificador)
• Un tipo de dato (número, texto, etc.)
• Un valor

Ejemplo:
int edad = 25;
String nombre = "Juan";
bool esEstudiante = true;
      ''',
      interactiveModules: [
        InteractiveModule(
          id: 'var_001_mod1',
          title: '¿Qué es una Variable?',
          explanation: '''Una variable es como una caja con una etiqueta donde guardas información. Por ejemplo, si quieres guardar tu edad, creas una variable llamada "edad" y guardas el número 25 dentro.

Las variables te permiten:
• Almacenar información para usar después
• Cambiar valores cuando sea necesario
• Hacer cálculos y operaciones

Imagina que tienes una caja llamada "puntos" donde guardas tu puntuación en un juego. Cada vez que ganas, puedes cambiar el número dentro de esa caja.''',
          codeExample: CodeExample(
            code: '''// Declarar variables de diferentes tipos
int edad = 25;           // Número entero
String nombre = "María";  // Texto
bool activo = true;      // Verdadero o falso
double precio = 19.99;   // Número decimal

// Usar las variables
print("Nombre: " + nombre);
print("Edad: " + edad.toString());''',
            language: 'dart',
            description: 'Ejemplos de cómo declarar y usar variables en Dart',
          ),
          activities: [
            Activity(
              id: 'var_001_act1',
              type: ActivityType.multipleChoice,
              question: '¿Cuál de las siguientes es la mejor analogía para una variable?',
              data: {
                'options': [
                  'Un candado que no se puede abrir',
                  'Una caja con etiqueta donde guardas cosas',
                  'Un número que nunca cambia',
                  'Una operación matemática'
                ],
              },
              correctAnswer: 'Una caja con etiqueta donde guardas cosas',
              feedback: 'Exacto! Una variable es como una caja etiquetada donde puedes guardar y cambiar información.',
            ),
            Activity(
              id: 'var_001_act2',
              type: ActivityType.fillInBlank,
              question: 'Completa la declaración correcta de una variable entera:',
              data: {
                'codeTemplate': '___  edad = 25;',
                'options': ['int', 'var', 'String', 'number'],
                'blankPosition': '___',
              },
              correctAnswer: 'int',
              feedback: '¡Correcto! "int" es la palabra clave para declarar números enteros en Dart y muchos otros lenguajes.',
            ),
          ],
        ),
        InteractiveModule(
          id: 'var_001_mod2',
          title: 'Declarando Variables',
          explanation: '''Para crear una variable necesitas tres cosas:

1. **El tipo**: Qué clase de información vas a guardar (int, String, bool, etc.)
2. **El nombre**: Cómo vas a llamar a tu variable (debe ser descriptivo)
3. **El valor**: La información que guardas (puede cambiar después)

Sintaxis básica:
tipo nombreVariable = valor;

Ejemplo: int puntos = 100;
- "int" es el tipo (número entero)
- "puntos" es el nombre
- "100" es el valor inicial''',
          codeExample: CodeExample(
            code: '''// Declaración básica
int puntos = 0;

// Cambiar el valor
puntos = 50;
puntos = 100;

// Usar el valor en operaciones
int puntosDobles = puntos * 2;
print("Puntos totales: " + puntosDobles.toString());''',
            language: 'dart',
            description: 'Cómo declarar y modificar variables',
          ),
          activities: [
            Activity(
              id: 'var_001_mod2_act1',
              type: ActivityType.fillInBlank,
              question: '¿Qué palabra usamos para asignar un valor a una variable?',
              data: {
                'codeTemplate': 'int edad ___ 18;',
                'options': ['=', '==', ':', '->'],
                'blankPosition': '___',
              },
              correctAnswer: '=',
              feedback: '¡Perfecto! El operador = (igual) se usa para asignar valores. No confundir con == que compara.',
            ),
            Activity(
              id: 'var_001_mod2_act2',
              type: ActivityType.dragAndDrop,
              question: 'Ordena las partes de una declaración de variable correctamente:',
              data: {
                'blocks': ['int', 'edad', '=', '25', ';'],
                'slots': 5,
              },
              correctAnswer: 'int,edad,=,25,;',
              feedback: '¡Excelente! La sintaxis correcta es: tipo nombre = valor;',
            ),
          ],
        ),
      ],
      questions: [
        Question(
          id: 'var_001_q1',
          question: '¿Qué es una variable en programación?',
          options: [
            'Un número que nunca cambia',
            'Un contenedor que almacena datos',
            'Una función matemática',
            'Un tipo de bucle'
          ],
          correctAnswerIndex: 1,
          explanation: 'Una variable es un contenedor que almacena datos en la memoria, permitiendo guardar y modificar información durante la ejecución del programa.',
        ),
        Question(
          id: 'var_001_q2',
          question: '¿Cuál es la sintaxis correcta para declarar una variable entera en muchos lenguajes?',
          options: [
            'variable edad = 25',
            'int edad = 25',
            'number edad = 25',
            'edad = 25 int'
          ],
          correctAnswerIndex: 1,
          explanation: 'La sintaxis "int edad = 25" es la forma estándar de declarar una variable entera, especificando el tipo, nombre y valor inicial.',
        ),
        Question(
          id: 'var_001_q3',
          question: '¿Qué parte de "int edad = 25" es el valor de la variable?',
          options: [
            'int',
            'edad',
            '25',
            '='
          ],
          correctAnswerIndex: 2,
          explanation: 'El valor es 25, que es lo que se almacena en la variable. "int" es el tipo, "edad" es el nombre, y "=" es el operador de asignación.',
        ),
        Question(
          id: 'var_001_q4',
          question: '¿Se puede cambiar el valor de una variable después de declararla?',
          options: [
            'No, nunca',
            'Sí, siempre',
            'Solo si es un número',
            'Solo con permiso del sistema'
          ],
          correctAnswerIndex: 1,
          explanation: 'Las variables pueden cambiar su valor durante la ejecución del programa. Por eso se llaman "variables" - su valor varía.',
        ),
        Question(
          id: 'var_001_q5',
          question: '¿Qué palabra clave se usa para declarar una variable que NO puede cambiar su valor?',
          options: [
            'var',
            'let',
            'const',
            'fixed'
          ],
          correctAnswerIndex: 2,
          explanation: '"const" se usa para declarar constantes, que son valores que no pueden cambiar después de su declaración inicial.',
        ),
        Question(
          id: 'var_001_q6',
          question: 'Si tienes: String mensaje = "Hola", ¿qué almacena la variable mensaje?',
          options: [
            'El número 5',
            'La palabra Hola',
            'True o False',
            'Un decimal'
          ],
          correctAnswerIndex: 1,
          explanation: 'La variable "mensaje" de tipo String almacena el texto "Hola". Los String almacenan cadenas de texto.',
        ),
        Question(
          id: 'var_001_q7',
          question: '¿Cuál es un nombre VÁLIDO para una variable?',
          options: [
            '123nombre',
            'mi-variable',
            'miVariable',
            'mi variable'
          ],
          correctAnswerIndex: 2,
          explanation: 'Los nombres de variables no pueden empezar con números, no pueden tener guiones o espacios. "miVariable" (camelCase) es válido.',
        ),
      ],
      estimatedMinutes: 8,
    ),

    Lesson(
      id: 'var_002',
      title: 'Tipos de Datos Básicos',
      description: 'Conoce los diferentes tipos de datos: números, texto y booleanos',
      level: 1,
      category: 'Variables',
      concepts: ['int', 'String', 'bool', 'double'],
      content: '''
Los tipos de datos básicos más comunes son:

1. **Números enteros (int)**: 1, 25, -10
2. **Números decimales (double)**: 3.14, -2.5, 0.0
3. **Texto (String)**: "Hola", "Programación", "123"
4. **Booleanos (bool)**: true, false

Cada tipo tiene características específicas:
• Los enteros no tienen decimales
• Los strings van entre comillas
• Los booleanos solo pueden ser verdadero o falso
      ''',
      interactiveModules: [
        InteractiveModule(
          id: 'var_002_mod1',
          title: 'Entendiendo los Tipos de Datos',
          explanation: '''Cada tipo de dato sirve para guardar información diferente, como tener diferentes tipos de cajas para diferentes cosas:

🔢 **int (entero)**: Para números sin decimales como tu edad (25), cantidad de likes (142)
💰 **double (decimal)**: Para números con decimales como precios (19.99), temperaturas (36.5)
📝 **String (texto)**: Para palabras y frases entre comillas como nombres ("Ana"), mensajes ("Hola")
✓ **bool (booleano)**: Solo true o false, como un interruptor prendido/apagado

Es importante elegir el tipo correcto para cada situación.''',
          codeExample: CodeExample(
            code: '''// Ejemplos de cada tipo
int edad = 25;              // Entero
double altura = 1.75;       // Decimal
String nombre = "Carlos";   // Texto (entre comillas)
bool esMayorDeEdad = true;  // Booleano

// Errores comunes a evitar:
// String edad = 25;        ❌ Incorrecto
// int precio = 19.99;      ❌ Incorrecto
// bool activo = "true";    ❌ Incorrecto''',
            language: 'dart',
            description: 'Ejemplos correctos e incorrectos de uso de tipos',
          ),
          activities: [
            Activity(
              id: 'var_002_mod1_act1',
              type: ActivityType.multipleChoice,
              question: '¿Qué tipo de dato usarías para almacenar el nombre de una persona?',
              data: {
                'options': ['int', 'double', 'String', 'bool'],
              },
              correctAnswer: 'String',
              feedback: '¡Correcto! Los nombres son texto, por lo que usamos String (siempre entre comillas).',
            ),
            Activity(
              id: 'var_002_mod1_act2',
              type: ActivityType.fillInBlank,
              question: 'Completa la declaración para guardar un precio con decimales:',
              data: {
                'codeTemplate': '___ precio = 19.99;',
                'options': ['int', 'double', 'String', 'bool'],
                'blankPosition': '___',
              },
              correctAnswer: 'double',
              feedback: '¡Perfecto! Para números con decimales usamos double. int solo sirve para números enteros.',
            ),
            Activity(
              id: 'var_002_mod1_act3',
              type: ActivityType.dragAndDrop,
              question: 'Ordena el código para declarar un booleano correctamente:',
              data: {
                'blocks': ['bool', 'activo', '=', 'true', ';'],
                'slots': 5,
              },
              correctAnswer: 'bool,activo,=,true,;',
              feedback: '¡Excelente! Los booleanos se declaran con "bool" y solo pueden ser true o false (sin comillas).',
            ),
          ],
        ),
      ],
      questions: [
        Question(
          id: 'var_002_q1',
          question: '¿Qué tipo de dato usarías para almacenar la edad de una persona?',
          options: ['String', 'bool', 'int', 'double'],
          correctAnswerIndex: 2,
          explanation: 'La edad es un número entero, por lo que se usa el tipo "int".',
        ),
        Question(
          id: 'var_002_q2',
          question: '¿Cuál de estos valores es un booleano?',
          options: ['25', '"verdadero"', 'true', '1.5'],
          correctAnswerIndex: 2,
          explanation: 'Los booleanos solo pueden ser "true" o "false", sin comillas.',
        ),
        Question(
          id: 'var_002_q3',
          question: '¿Qué tipo de dato usarías para almacenar el precio de un producto (ejemplo: 19.99)?',
          options: ['int', 'String', 'double', 'bool'],
          correctAnswerIndex: 2,
          explanation: 'Para números con decimales se usa "double". El precio 19.99 tiene decimales.',
        ),
        Question(
          id: 'var_002_q4',
          question: 'En "String nombre = \'Ana\'", ¿qué representan las comillas simples?',
          options: [
            'Son opcionales',
            'Indican que es un texto',
            'Son un error',
            'Multiplican el valor'
          ],
          correctAnswerIndex: 1,
          explanation: 'Las comillas (simples o dobles) indican que el contenido es un texto (String), no código.',
        ),
        Question(
          id: 'var_002_q5',
          question: '¿Cuál de estas declaraciones es INCORRECTA?',
          options: [
            'int puntos = 100;',
            'bool activo = true;',
            'String nombre = 25;',
            'double pi = 3.14;'
          ],
          correctAnswerIndex: 2,
          explanation: 'String nombre = 25 es incorrecto porque estás intentando asignar un número a una variable de tipo texto. Debería ser String nombre = "25".',
        ),
        Question(
          id: 'var_002_q6',
          question: '¿Qué imprime este código?\nint x = 5;\nint y = 10;\nint suma = x + y;\nprint(suma);',
          options: ['5', '10', '15', 'suma'],
          correctAnswerIndex: 2,
          explanation: 'La variable suma almacena el resultado de 5 + 10, que es 15. Luego se imprime ese valor.',
        ),
        Question(
          id: 'var_002_q7',
          question: 'Si declaras: bool esEstudiante = false; ¿Qué tipo de dato es "esEstudiante"?',
          options: [
            'Entero',
            'Texto',
            'Booleano',
            'Decimal'
          ],
          correctAnswerIndex: 2,
          explanation: 'La palabra clave "bool" indica que es un tipo de dato booleano, que solo puede ser true o false.',
        ),
      ],
      estimatedMinutes: 12,
    ),

    // Lecciones de Condicionales
    Lesson(
      id: 'cond_001',
      title: 'Estructuras Condicionales IF',
      description: 'Aprende a tomar decisiones en tu código con if-else',
      level: 2,
      category: 'Condicionales',
      concepts: ['if', 'else', 'condiciones', 'operadores'],
      content: '''
Las estructuras condicionales permiten que tu programa tome decisiones.

Sintaxis básica:
if (condición) {
    // código si es verdadero
} else {
    // código si es falso
}

Ejemplo:
int edad = 18;
if (edad >= 18) {
    print("Eres mayor de edad");
} else {
    print("Eres menor de edad");
}

Los operadores de comparación son:
• == (igual)
• != (diferente)
• > (mayor que)
• < (menor que)
• >= (mayor o igual)
• <= (menor o igual)
      ''',
      interactiveModules: [
        InteractiveModule(
          id: 'cond_001_mod1',
          title: 'Tomando Decisiones con IF',
          explanation: '''Los condicionales son como tomar decisiones en la vida real. Por ejemplo: "Si llueve, llevo paraguas. Si no llueve, no lo llevo."

En programación funciona igual:
• **IF**: "Si la condición es verdadera, haz esto"
• **ELSE**: "Si no (es falsa), haz esto otro"

La condición siempre se evalúa como true (verdadero) o false (falso). El programa decide qué camino tomar basándose en esa evaluación.

Ejemplo práctico:
Si tu puntuación >= 60, muestras "Aprobado"
Si no, muestras "Reprobado"''',
          codeExample: CodeExample(
            code: '''int puntos = 75;

// Ejemplo básico de IF
if (puntos >= 60) {
    print("¡Aprobado!");
} else {
    print("Reprobado");
}

// IF sin else (opcional)
if (puntos > 90) {
    print("¡Excelente trabajo!");
}

// Múltiples condiciones
if (puntos >= 90) {
    print("A - Sobresaliente");
} else if (puntos >= 70) {
    print("B - Notable");
} else {
    print("C - Suficiente");
}''',
            language: 'dart',
            description: 'Diferentes formas de usar condicionales IF',
          ),
          activities: [
            Activity(
              id: 'cond_001_mod1_act1',
              type: ActivityType.multipleChoice,
              question: 'Si edad = 20, ¿qué imprime este código?\nif (edad >= 18) { print("Mayor"); } else { print("Menor"); }',
              data: {
                'options': ['Mayor', 'Menor', 'Ambos', 'Ninguno'],
              },
              correctAnswer: 'Mayor',
              feedback: '¡Correcto! Como 20 >= 18 es verdadero, se ejecuta el bloque IF e imprime "Mayor".',
            ),
            Activity(
              id: 'cond_001_mod1_act2',
              type: ActivityType.fillInBlank,
              question: 'Completa el operador para verificar si dos valores son iguales:',
              data: {
                'codeTemplate': 'if (edad ___ 18) { print("Tiene 18"); }',
                'options': ['==', '=', '!=', '>='],
                'blankPosition': '___',
              },
              correctAnswer: '==',
              feedback: '¡Perfecto! El operador == compara si dos valores son iguales. No confundir con = que asigna.',
            ),
            Activity(
              id: 'cond_001_mod1_act3',
              type: ActivityType.dragAndDrop,
              question: 'Ordena las partes de un IF correctamente:',
              data: {
                'blocks': ['if', '(edad > 18)', '{', 'print("OK");', '}'],
                'slots': 5,
              },
              correctAnswer: 'if,(edad > 18),{,print("OK");,}',
              feedback: '¡Excelente! La sintaxis correcta es: if (condición) { código }',
            ),
          ],
        ),
        InteractiveModule(
          id: 'cond_001_mod2',
          title: 'Operadores de Comparación',
          explanation: '''Los operadores de comparación nos permiten comparar valores:

**==** : Igual a (¿son lo mismo?)
**!=** : Diferente de (¿son distintos?)
**>**  : Mayor que
**<**  : Menor que
**>=** : Mayor o igual que
**<=** : Menor o igual que

Estos operadores siempre devuelven true o false.

Ejemplos:
• 5 > 3 → true
• 10 == 10 → true
• 7 < 5 → false
• 15 != 20 → true''',
          codeExample: CodeExample(
            code: '''int nota = 85;

// Operador >
if (nota > 60) {
    print("Aprobado");
}

// Operador ==
if (nota == 100) {
    print("¡Perfecto!");
}

// Operador !=
if (nota != 0) {
    print("Hiciste el examen");
}

// Operador >=
if (nota >= 70) {
    print("Buen trabajo");
}

// Combinar en una variable
bool esBuenaNota = nota >= 80;
print(esBuenaNota); // imprime: true''',
            language: 'dart',
            description: 'Ejemplos de todos los operadores de comparación',
          ),
          activities: [
            Activity(
              id: 'cond_001_mod2_act1',
              type: ActivityType.multipleChoice,
              question: '¿Cuál es el resultado de: 10 >= 10?',
              data: {
                'options': ['true', 'false', 'Error', '10'],
              },
              correctAnswer: 'true',
              feedback: '¡Correcto! El operador >= es "mayor o igual", y 10 es igual a 10, por lo tanto es true.',
            ),
            Activity(
              id: 'cond_001_mod2_act2',
              type: ActivityType.fillInBlank,
              question: '¿Qué operador verifica si dos valores son diferentes?',
              data: {
                'codeTemplate': 'if (x ___ y) { print("Son diferentes"); }',
                'options': ['!=', '==', '<>', '=/='],
                'blankPosition': '___',
              },
              correctAnswer: '!=',
              feedback: '¡Perfecto! El operador != significa "no igual" o "diferente de".',
            ),
          ],
        ),
      ],
      questions: [
        Question(
          id: 'cond_001_q1',
          question: '¿Qué imprime este código si edad = 20?\nif (edad >= 18) { print("Mayor"); } else { print("Menor"); }',
          options: ['Mayor', 'Menor', 'Error', 'Nada'],
          correctAnswerIndex: 0,
          explanation: 'Como 20 >= 18 es verdadero, se ejecuta el primer bloque e imprime "Mayor".',
        ),
        Question(
          id: 'cond_001_q2',
          question: '¿Cuál es el operador para "diferente de"?',
          options: ['<>', '!=', '==', '=/='],
          correctAnswerIndex: 1,
          explanation: 'El operador "!=" significa "no igual" o "diferente de".',
        ),
        Question(
          id: 'cond_001_q3',
          question: '¿Qué bloque se ejecuta si la condición del if es falsa?',
          options: [
            'El bloque if',
            'El bloque else',
            'Ambos bloques',
            'Ningún bloque'
          ],
          correctAnswerIndex: 1,
          explanation: 'Si la condición es falsa, se ejecuta el bloque "else" (si existe). El bloque "if" solo se ejecuta cuando la condición es verdadera.',
        ),
        Question(
          id: 'cond_001_q4',
          question: 'Si temperatura = 25, ¿qué imprime?\nif (temperatura > 30) { print("Calor"); } else { print("Agradable"); }',
          options: ['Calor', 'Agradable', '25', 'Error'],
          correctAnswerIndex: 1,
          explanation: 'Como 25 > 30 es falso, se ejecuta el bloque else e imprime "Agradable".',
        ),
        Question(
          id: 'cond_001_q5',
          question: '¿Cuál es el operador para verificar si dos valores son iguales?',
          options: ['=', '==', '===', '!='],
          correctAnswerIndex: 1,
          explanation: 'El operador "==" compara dos valores. Un solo "=" se usa para asignar, no para comparar.',
        ),
        Question(
          id: 'cond_001_q6',
          question: '¿Qué hace este código?\nif (nota >= 70) { print("Aprobado"); }',
          options: [
            'Siempre imprime Aprobado',
            'Imprime Aprobado si nota es 70 o más',
            'Imprime Aprobado si nota es menor a 70',
            'Produce un error'
          ],
          correctAnswerIndex: 1,
          explanation: 'El código solo imprime "Aprobado" cuando la nota es mayor o igual a 70. Si es menor, no imprime nada (no hay else).',
        ),
        Question(
          id: 'cond_001_q7',
          question: '¿Es posible tener un if sin else?',
          options: [
            'No, siempre se necesita else',
            'Sí, else es opcional',
            'Solo en lenguajes avanzados',
            'Solo si la condición es falsa'
          ],
          correctAnswerIndex: 1,
          explanation: 'El bloque else es completamente opcional. Puedes tener solo un if, y si la condición es falsa, simplemente no se ejecuta nada.',
        ),
      ],
      estimatedMinutes: 15,
    ),

    // Lecciones de Bucles
    Lesson(
      id: 'loop_001',
      title: 'Bucles FOR básicos',
      description: 'Repite código de forma eficiente con bucles for',
      level: 2,
      category: 'Bucles',
      concepts: ['for', 'iteración', 'contador', 'repetición'],
      content: '''
Los bucles FOR permiten repetir código un número específico de veces.

Sintaxis:
for (inicialización; condición; incremento) {
    // código a repetir
}

Ejemplo:
for (int i = 0; i < 5; i++) {
    print("Número: " + i.toString());
}

Esto imprime:
Número: 0
Número: 1
Número: 2
Número: 3
Número: 4

Partes del bucle:
• Inicialización: int i = 0 (se ejecuta una vez)
• Condición: i < 5 (se verifica antes de cada iteración)
• Incremento: i++ (se ejecuta después de cada iteración)
      ''',
      interactiveModules: [
        InteractiveModule(
          id: 'loop_001_mod1',
          title: 'Repetir Código con FOR',
          explanation: '''Los bucles FOR son perfectos cuando necesitas repetir algo un número específico de veces. Es como decir "haz esto 10 veces" o "cuenta del 1 al 5".

El bucle FOR tiene 3 partes importantes:
1. **Inicialización**: Donde empiezas (int i = 0)
2. **Condición**: Hasta dónde llegas (i < 5)
3. **Incremento**: Cómo avanzas (i++ significa sumar 1)

Piensa en i como un contador que va aumentando:
• Primera vuelta: i = 0
• Segunda vuelta: i = 1
• Tercera vuelta: i = 2
... y así hasta que la condición sea falsa.''',
          codeExample: CodeExample(
            code: '''// Bucle básico: contar del 0 al 4
for (int i = 0; i < 5; i++) {
    print("Vuelta número: " + i.toString());
}

// Contar del 1 al 10
for (int i = 1; i <= 10; i++) {
    print(i);
}

// Contar de 2 en 2
for (int i = 0; i < 10; i += 2) {
    print(i); // imprime: 0, 2, 4, 6, 8
}

// Cuenta regresiva
for (int i = 5; i > 0; i--) {
    print(i); // imprime: 5, 4, 3, 2, 1
}''',
            language: 'dart',
            description: 'Diferentes formas de usar bucles FOR',
          ),
          activities: [
            Activity(
              id: 'loop_001_mod1_act1',
              type: ActivityType.multipleChoice,
              question: '¿Cuántas veces se ejecuta este bucle?\nfor (int i = 0; i < 3; i++) { print(i); }',
              data: {
                'options': ['2 veces', '3 veces', '4 veces', 'Infinitas veces'],
              },
              correctAnswer: '3 veces',
              feedback: '¡Correcto! Se ejecuta con i=0, i=1, i=2. Son 3 veces en total.',
            ),
            Activity(
              id: 'loop_001_mod1_act2',
              type: ActivityType.fillInBlank,
              question: 'Completa el bucle para que cuente del 1 al 5:',
              data: {
                'codeTemplate': 'for (int i = 1; i ___ 5; i++) { }',
                'options': ['<=', '<', '>', '=='],
                'blankPosition': '___',
              },
              correctAnswer: '<=',
              feedback: '¡Perfecto! Usamos <= para incluir el 5. Si usaras <, solo llegaría hasta el 4.',
            ),
            Activity(
              id: 'loop_001_mod1_act3',
              type: ActivityType.dragAndDrop,
              question: 'Ordena las partes del bucle FOR correctamente:',
              data: {
                'blocks': ['for', '(int i = 0;', 'i < 5;', 'i++)', '{', 'print(i);', '}'],
                'slots': 7,
              },
              correctAnswer: 'for,(int i = 0;,i < 5;,i++),{,print(i);,}',
              feedback: '¡Excelente! Recuerda: for (inicio; condición; incremento) { código }',
            ),
          ],
        ),
      ],
      questions: [
        Question(
          id: 'loop_001_q1',
          question: '¿Cuántas veces se ejecuta este bucle?\nfor (int i = 1; i <= 3; i++) { print(i); }',
          options: ['2 veces', '3 veces', '4 veces', '1 vez'],
          correctAnswerIndex: 1,
          explanation: 'El bucle se ejecuta con i=1, i=2, i=3, por lo tanto 3 veces.',
        ),
        Question(
          id: 'loop_001_q2',
          question: '¿Qué hace i++ en un bucle for?',
          options: [
            'Resta 1 a i',
            'Suma 1 a i',
            'Multiplica i por 2',
            'Reinicia i a 0'
          ],
          correctAnswerIndex: 1,
          explanation: 'i++ es una forma abreviada de escribir i = i + 1, incrementa el valor de i en 1.',
        ),
        Question(
          id: 'loop_001_q3',
          question: '¿Qué imprime este código?\nfor (int i = 0; i < 2; i++) { print("Hola"); }',
          options: [
            'Hola (1 vez)',
            'Hola (2 veces)',
            'Hola (3 veces)',
            'Nada'
          ],
          correctAnswerIndex: 1,
          explanation: 'El bucle se ejecuta mientras i < 2, es decir con i=0 e i=1. Imprime "Hola" 2 veces.',
        ),
        Question(
          id: 'loop_001_q4',
          question: 'En un bucle for, ¿qué parte se ejecuta solo UNA vez al inicio?',
          options: [
            'La condición',
            'El incremento',
            'La inicialización',
            'El cuerpo del bucle'
          ],
          correctAnswerIndex: 2,
          explanation: 'La inicialización (int i = 0) solo se ejecuta una vez al principio, antes de empezar las iteraciones.',
        ),
        Question(
          id: 'loop_001_q5',
          question: '¿Qué hace este bucle?\nfor (int i = 10; i > 0; i--) { print(i); }',
          options: [
            'Cuenta de 0 a 10',
            'Cuenta de 10 a 0',
            'Produce un error',
            'No hace nada'
          ],
          correctAnswerIndex: 1,
          explanation: 'i-- decrementa (resta 1), entonces cuenta hacia atrás: 10, 9, 8... hasta 1.',
        ),
        Question(
          id: 'loop_001_q6',
          question: '¿Cuándo se detiene un bucle for?',
          options: [
            'Cuando se ejecuta 10 veces',
            'Cuando la condición es falsa',
            'Cuando i llega a 100',
            'Nunca se detiene'
          ],
          correctAnswerIndex: 1,
          explanation: 'El bucle se detiene cuando la condición (segunda parte del for) se vuelve falsa.',
        ),
        Question(
          id: 'loop_001_q7',
          question: '¿Qué valor tiene i después de este bucle?\nfor (int i = 0; i < 5; i++) { }',
          options: ['4', '5', '0', 'Error - i no existe'],
          correctAnswerIndex: 3,
          explanation: 'Después del bucle, la variable i deja de existir (está fuera de alcance). Solo existe dentro del bucle.',
        ),
      ],
      estimatedMinutes: 18,
    ),

    // Lecciones de Funciones
    Lesson(
      id: 'func_001',
      title: 'Introducción a Funciones',
      description: 'Organiza tu código creando funciones reutilizables',
      level: 3,
      category: 'Funciones',
      concepts: ['función', 'parámetros', 'return', 'reutilización'],
      content: '''
Las funciones son bloques de código reutilizable que realizan una tarea específica.

Sintaxis básica:
tipoRetorno nombreFuncion(parámetros) {
    // código de la función
    return valor; // opcional
}

Ejemplo:
int sumar(int a, int b) {
    return a + b;
}

void saludar(String nombre) {
    print("Hola, " + nombre);
}

Ventajas de las funciones:
• Reutilización de código
• Organización mejor
• Fácil mantenimiento
• Menos errores

Llamar una función:
int resultado = sumar(5, 3); // resultado = 8
saludar("Ana"); // imprime "Hola, Ana"
      ''',
      questions: [
        Question(
          id: 'func_001_q1',
          question: '¿Qué devuelve esta función?\nint multiplicar(int x, int y) { return x * y; }\nmultiplicar(4, 3)',
          options: ['7', '12', '1', '43'],
          correctAnswerIndex: 1,
          explanation: 'La función multiplica 4 * 3 = 12 y devuelve ese valor.',
        ),
        Question(
          id: 'func_001_q2',
          question: '¿Qué significa "void" en una función?',
          options: [
            'La función devuelve un número',
            'La función no devuelve nada',
            'La función tiene errores',
            'La función es privada'
          ],
          correctAnswerIndex: 1,
          explanation: '"void" significa que la función no devuelve ningún valor, solo ejecuta código.',
        ),
        Question(
          id: 'func_001_q3',
          question: '¿Cuántos parámetros tiene esta función?\nint sumar(int a, int b, int c) { return a + b + c; }',
          options: ['1', '2', '3', '0'],
          correctAnswerIndex: 2,
          explanation: 'La función tiene 3 parámetros: a, b y c. Los parámetros se cuentan por las variables que recibe.',
        ),
        Question(
          id: 'func_001_q4',
          question: '¿Qué imprime este código?\nvoid saludar() { print("Hola"); }\nsaludar();',
          options: ['Nada', 'Hola', 'saludar', 'Error'],
          correctAnswerIndex: 1,
          explanation: 'La función saludar() ejecuta print("Hola"), por lo que imprime "Hola" cuando la llamas.',
        ),
        Question(
          id: 'func_001_q5',
          question: '¿Qué es un parámetro en una función?',
          options: [
            'El nombre de la función',
            'Un valor que la función recibe',
            'El resultado de la función',
            'Un tipo de bucle'
          ],
          correctAnswerIndex: 1,
          explanation: 'Los parámetros son valores que la función recibe para trabajar con ellos. Son como variables de entrada.',
        ),
        Question(
          id: 'func_001_q6',
          question: 'Si defines: String obtenerNombre() { return "Ana"; }, ¿qué tipo de valor devuelve?',
          options: [
            'Un número entero',
            'Un texto',
            'Un booleano',
            'No devuelve nada'
          ],
          correctAnswerIndex: 1,
          explanation: 'La función devuelve un String (texto) porque su tipo de retorno es String y devuelve "Ana".',
        ),
        Question(
          id: 'func_001_q7',
          question: '¿Cuál es la ventaja principal de usar funciones?',
          options: [
            'Hace el código más largo',
            'Permite reutilizar código',
            'Hace el programa más lento',
            'Es obligatorio en programación'
          ],
          correctAnswerIndex: 1,
          explanation: 'Las funciones permiten reutilizar código sin tener que escribirlo múltiples veces. También mejoran la organización.',
        ),
      ],
      estimatedMinutes: 20,
    ),

    // Lecciones de Arrays
    Lesson(
      id: 'array_001',
      title: 'Arrays y Listas',
      description: 'Almacena múltiples valores en una sola variable',
      level: 3,
      category: 'Arrays',
      concepts: ['array', 'lista', 'índice', 'elementos'],
      content: '''
Los arrays (o listas) permiten almacenar múltiples valores en una sola variable.

Declaración:
List<int> numeros = [1, 2, 3, 4, 5];
List<String> nombres = ["Ana", "Luis", "María"];

Características importantes:
• Los índices empiezan en 0
• Se accede con corchetes: numeros[0] = 1
• Tienen longitud: numeros.length = 5

Operaciones comunes:
• Agregar: numeros.add(6)
• Eliminar: numeros.remove(3)
• Buscar: numeros.contains(4)

Ejemplo de uso:
List<String> frutas = ["manzana", "pera", "uva"];
print(frutas[0]); // imprime "manzana"
frutas.add("naranja");
print(frutas.length); // imprime 4
      ''',
      questions: [
        Question(
          id: 'array_001_q1',
          question: 'Si tienes List<int> nums = [10, 20, 30], ¿qué devuelve nums[1]?',
          options: ['10', '20', '30', '1'],
          correctAnswerIndex: 1,
          explanation: 'Los índices empiezan en 0, por lo que nums[1] es el segundo elemento: 20.',
        ),
        Question(
          id: 'array_001_q2',
          question: '¿Cómo obtienes el número de elementos en una lista?',
          options: ['lista.size', 'lista.count', 'lista.length', 'lista.total'],
          correctAnswerIndex: 2,
          explanation: 'En Dart, se usa .length para obtener el número de elementos en una lista.',
        ),
        Question(
          id: 'array_001_q3',
          question: '¿Cuál es el índice del primer elemento en un array?',
          options: ['1', '0', '-1', 'Depende del lenguaje'],
          correctAnswerIndex: 1,
          explanation: 'En la mayoría de lenguajes de programación, incluyendo Dart, los índices empiezan en 0.',
        ),
        Question(
          id: 'array_001_q4',
          question: 'Si List<String> frutas = ["manzana", "pera"], ¿cómo agregas "uva"?',
          options: [
            'frutas.add("uva")',
            'frutas + "uva"',
            'frutas.insert("uva")',
            'frutas[2] = "uva"'
          ],
          correctAnswerIndex: 0,
          explanation: 'El método .add() agrega un elemento al final de la lista.',
        ),
        Question(
          id: 'array_001_q5',
          question: 'Si tienes List<int> nums = [5, 10, 15], ¿cuál es nums.length?',
          options: ['2', '3', '15', '0'],
          correctAnswerIndex: 1,
          explanation: 'La lista tiene 3 elementos (5, 10, 15), por lo que .length devuelve 3.',
        ),
        Question(
          id: 'array_001_q6',
          question: '¿Qué hace este código?\nList<int> nums = [1, 2, 3];\nnums.remove(2);',
          options: [
            'Elimina el elemento en índice 2',
            'Elimina el número 2 de la lista',
            'Elimina todos los elementos',
            'Produce un error'
          ],
          correctAnswerIndex: 1,
          explanation: 'El método .remove() busca y elimina el valor especificado (el número 2), no el índice.',
        ),
        Question(
          id: 'array_001_q7',
          question: '¿Puedes tener una lista con diferentes tipos de datos?',
          options: [
            'No, nunca',
            'Sí, pero no es recomendado',
            'Solo números y textos',
            'Solo en listas especiales'
          ],
          correctAnswerIndex: 1,
          explanation: 'En Dart puedes usar List<dynamic> para listas mixtas, pero no es recomendado. Es mejor usar listas con un solo tipo para evitar errores.',
        ),
      ],
      estimatedMinutes: 22,
    ),

    // Lección adicional de Variables
    Lesson(
      id: 'var_003',
      title: 'Operaciones con Variables',
      description: 'Aprende a realizar operaciones matemáticas y de texto con variables',
      level: 1,
      category: 'Variables',
      concepts: ['Operadores', 'Concatenación', 'Aritmética'],
      content: '''
Las variables pueden participar en operaciones:

**Operaciones matemáticas:**
int a = 10;
int b = 5;
int suma = a + b;        // 15
int resta = a - b;       // 5
int producto = a * b;    // 50
int division = a / b;    // 2

**Concatenación de strings:**
String nombre = "Juan";
String apellido = "Pérez";
String completo = nombre + " " + apellido;  // "Juan Pérez"

**Incremento y decremento:**
int contador = 0;
contador++;  // ahora es 1
contador--;  // vuelve a 0
      ''',
      questions: [
        Question(
          id: 'var_003_q1',
          question: '¿Qué valor tiene x?\nint x = 10 + 5 * 2;',
          options: ['30', '20', '17', '15'],
          correctAnswerIndex: 1,
          explanation: 'Siguiendo el orden de operaciones, primero 5 * 2 = 10, luego 10 + 10 = 20.',
        ),
        Question(
          id: 'var_003_q2',
          question: '¿Qué hace el operador + con dos strings?\nString a = "Hola";\nString b = "Mundo";\nString c = a + b;',
          options: [
            'Los suma como números',
            'Los concatena (une)',
            'Produce un error',
            'Los compara'
          ],
          correctAnswerIndex: 1,
          explanation: 'El operador + con strings los concatena (une). El resultado sería "HolaMundo".',
        ),
        Question(
          id: 'var_003_q3',
          question: 'Si int n = 5, después de n++, ¿cuánto vale n?',
          options: ['4', '5', '6', '10'],
          correctAnswerIndex: 2,
          explanation: 'n++ incrementa el valor de n en 1, por lo que pasa de 5 a 6.',
        ),
        Question(
          id: 'var_003_q4',
          question: '¿Qué devuelve: int resultado = 15 % 4;',
          options: ['3', '3.75', '4', '15'],
          correctAnswerIndex: 0,
          explanation: 'El operador % (módulo) devuelve el resto de la división. 15 dividido 4 es 3 con resto 3.',
        ),
        Question(
          id: 'var_003_q5',
          question: '¿Cuál es el resultado?\nint x = 10;\nx = x + 5;',
          options: ['10', '5', '15', 'Error'],
          correctAnswerIndex: 2,
          explanation: 'x toma su valor actual (10), le suma 5, y el nuevo valor (15) se asigna a x.',
        ),
      ],
      estimatedMinutes: 10,
    ),

    // Lección adicional de Condicionales
    Lesson(
      id: 'cond_002',
      title: 'Operadores Lógicos',
      description: 'Combina condiciones con AND, OR y NOT',
      level: 2,
      category: 'Condicionales',
      concepts: ['AND', 'OR', 'NOT', 'Condiciones múltiples'],
      content: '''
Los operadores lógicos permiten combinar condiciones:

**AND (&&)**: Ambas condiciones deben ser verdaderas
if (edad >= 18 && tieneLicencia) {
    print("Puede conducir");
}

**OR (||)**: Al menos una condición debe ser verdadera
if (esDiaFestivo || esFinDeSemana) {
    print("No hay clases");
}

**NOT (!)**: Invierte una condición
if (!estaOcupado) {
    print("Disponible");
}

**Tabla de verdad AND:**
true  && true  = true
true  && false = false
false && false = false

**Tabla de verdad OR:**
true  || false = true
false || false = false
      ''',
      questions: [
        Question(
          id: 'cond_002_q1',
          question: '¿Cuándo es verdadero: (edad >= 18 && tiene Licencia)?',
          options: [
            'Si edad >= 18 solamente',
            'Si tieneLicencia solamente',
            'Si ambas son verdaderas',
            'Si alguna es verdadera'
          ],
          correctAnswerIndex: 2,
          explanation: 'El operador && (AND) requiere que AMBAS condiciones sean verdaderas.',
        ),
        Question(
          id: 'cond_002_q2',
          question: '¿Qué imprime si x = 5?\nif (x > 10 || x < 3) { print("Sí"); } else { print("No"); }',
          options: ['Sí', 'No', 'Error', 'Nada'],
          correctAnswerIndex: 1,
          explanation: 'x > 10 es falso (5 no es mayor que 10) y x < 3 es falso (5 no es menor que 3). Como ambas son falsas en OR, el resultado es falso.',
        ),
        Question(
          id: 'cond_002_q3',
          question: '¿Qué hace el operador ! (NOT)?',
          options: [
            'Suma 1',
            'Invierte el valor booleano',
            'Compara valores',
            'Concatena strings'
          ],
          correctAnswerIndex: 1,
          explanation: 'El operador ! invierte: !true se vuelve false, y !false se vuelve true.',
        ),
        Question(
          id: 'cond_002_q4',
          question: '¿Cuándo es verdadero: (true || false)?',
          options: ['Nunca', 'Siempre', 'Solo si ambos son true', 'Error'],
          correctAnswerIndex: 1,
          explanation: 'El operador || (OR) es verdadero si AL MENOS UNA condición es verdadera. Como hay un true, el resultado es true.',
        ),
        Question(
          id: 'cond_002_q5',
          question: 'Si bool activo = true, ¿qué vale !activo?',
          options: ['true', 'false', '1', '0'],
          correctAnswerIndex: 1,
          explanation: 'El operador ! invierte el valor: !true = false.',
        ),
      ],
      estimatedMinutes: 14,
    ),

    // Lección adicional de Bucles
    Lesson(
      id: 'loop_002',
      title: 'Bucle WHILE',
      description: 'Aprende a usar bucles while para repetir código mientras una condición sea verdadera',
      level: 2,
      category: 'Bucles',
      concepts: ['while', 'condición', 'bucle infinito', 'break'],
      content: '''
El bucle WHILE repite código mientras una condición sea verdadera:

**Sintaxis:**
while (condición) {
    // código a repetir
}

**Ejemplo:**
int contador = 0;
while (contador < 5) {
    print(contador);
    contador++;
}
// Imprime: 0, 1, 2, 3, 4

**Diferencia con FOR:**
• FOR: Sabes cuántas veces repetir
• WHILE: Repites mientras una condición sea cierta

**Cuidado con bucles infinitos:**
while (true) {  // ¡Nunca termina!
    print("Hola");
}
      ''',
      questions: [
        Question(
          id: 'loop_002_q1',
          question: '¿Cuántas veces se ejecuta?\nint i = 0;\nwhile (i < 3) { print(i); i++; }',
          options: ['2', '3', '4', 'Infinitas'],
          correctAnswerIndex: 1,
          explanation: 'Se ejecuta mientras i < 3: con i=0, i=1, i=2. Total: 3 veces.',
        ),
        Question(
          id: 'loop_002_q2',
          question: '¿Qué es un bucle infinito?',
          options: [
            'Un bucle que se ejecuta muy rápido',
            'Un bucle que nunca termina',
            'Un bucle que se ejecuta 1000 veces',
            'Un bucle con errores'
          ],
          correctAnswerIndex: 1,
          explanation: 'Un bucle infinito es uno donde la condición nunca se vuelve falsa, por lo que nunca termina.',
        ),
        Question(
          id: 'loop_002_q3',
          question: '¿Cuándo se verifica la condición en un bucle while?',
          options: [
            'Solo al inicio',
            'Solo al final',
            'Antes de cada iteración',
            'Nunca'
          ],
          correctAnswerIndex: 2,
          explanation: 'La condición se verifica ANTES de cada iteración. Si es falsa, el bucle termina.',
        ),
        Question(
          id: 'loop_002_q4',
          question: 'Si la condición del while es falsa desde el inicio, ¿cuántas veces se ejecuta?',
          options: ['1 vez', '0 veces', 'Infinitas veces', 'Produce error'],
          correctAnswerIndex: 1,
          explanation: 'Si la condición es falsa desde el inicio, el código dentro del while nunca se ejecuta (0 veces).',
        ),
        Question(
          id: 'loop_002_q5',
          question: '¿Cuál es la diferencia principal entre for y while?',
          options: [
            'No hay diferencia',
            'for es más rápido',
            'for se usa con contador conocido, while con condición',
            'while es más moderno'
          ],
          correctAnswerIndex: 2,
          explanation: 'FOR se usa cuando sabes cuántas veces repetir. WHILE cuando repites hasta que algo cambie.',
        ),
      ],
      estimatedMinutes: 16,
    ),

    // Lección adicional de Funciones
    Lesson(
      id: 'func_002',
      title: 'Funciones con Retorno',
      description: 'Domina el uso de return y valores de retorno en funciones',
      level: 3,
      category: 'Funciones',
      concepts: ['return', 'valores de retorno', 'tipos de retorno'],
      content: '''
Las funciones pueden devolver valores usando return:

**Función con retorno:**
int calcularEdad(int añoNacimiento) {
    int añoActual = 2024;
    int edad = añoActual - añoNacimiento;
    return edad;
}

**Usando el valor retornado:**
int miEdad = calcularEdad(2000);  // miEdad = 24

**Funciones con diferentes retornos:**
bool esMayorDeEdad(int edad) {
    return edad >= 18;
}

String obtenerSaludo(String nombre) {
    return "Hola, " + nombre;
}

**Return múltiple:**
return puede aparecer en diferentes partes de la función.
      ''',
      questions: [
        Question(
          id: 'func_002_q1',
          question: 'int doble(int x) { return x * 2; }\n¿Qué devuelve doble(7)?',
          options: ['7', '9', '14', '2'],
          correctAnswerIndex: 2,
          explanation: 'La función multiplica 7 * 2 = 14 y lo devuelve.',
        ),
        Question(
          id: 'func_002_q2',
          question: '¿Qué hace la palabra clave return?',
          options: [
            'Reinicia la función',
            'Devuelve un valor y termina la función',
            'Imprime en consola',
            'Declara una variable'
          ],
          correctAnswerIndex: 1,
          explanation: 'return devuelve un valor al código que llamó la función y termina su ejecución inmediatamente.',
        ),
        Question(
          id: 'func_002_q3',
          question: 'bool esPositivo(int n) { return n > 0; }\n¿Qué devuelve esPositivo(-5)?',
          options: ['true', 'false', '-5', 'Error'],
          correctAnswerIndex: 1,
          explanation: '-5 > 0 es falso, por lo que la función devuelve false.',
        ),
        Question(
          id: 'func_002_q4',
          question: '¿Puede una función tener múltiples return?',
          options: [
            'No, solo uno',
            'Sí, pero solo se ejecuta uno',
            'Sí, se ejecutan todos',
            'Solo en funciones void'
          ],
          correctAnswerIndex: 1,
          explanation: 'Una función puede tener varios return, pero solo se ejecuta uno (el primero que se alcance). Después de un return, la función termina.',
        ),
        Question(
          id: 'func_002_q5',
          question: 'Si una función tiene tipo int, ¿qué debe retornar?',
          options: [
            'Un texto',
            'true o false',
            'Un número entero',
            'Nada'
          ],
          correctAnswerIndex: 2,
          explanation: 'Si el tipo de retorno es int, la función DEBE devolver un número entero con return.',
        ),
      ],
      estimatedMinutes: 16,
    ),

    // Lección adicional de Arrays
    Lesson(
      id: 'array_002',
      title: 'Recorriendo Arrays',
      description: 'Aprende a recorrer listas con bucles for',
      level: 3,
      category: 'Arrays',
      concepts: ['for-each', 'iteración', 'recorrido', 'índices'],
      content: '''
Puedes recorrer todos los elementos de una lista:

**Método 1: For tradicional con índice**
List<String> nombres = ["Ana", "Luis", "María"];
for (int i = 0; i < nombres.length; i++) {
    print(nombres[i]);
}

**Método 2: For-each (más simple)**
for (String nombre in nombres) {
    print(nombre);
}

**Recorrer con índice y valor:**
for (int i = 0; i < nombres.length; i++) {
    print("Posición " + i.toString() + ": " + nombres[i]);
}

**Buscar en un array:**
List<int> numeros = [5, 10, 15, 20];
bool encontrado = false;
for (int num in numeros) {
    if (num == 15) {
        encontrado = true;
    }
}
      ''',
      questions: [
        Question(
          id: 'array_002_q1',
          question: 'List<int> nums = [1, 2, 3];\n¿Cuántas veces se ejecuta?\nfor (int i = 0; i < nums.length; i++) { }',
          options: ['2', '3', '4', '0'],
          correctAnswerIndex: 1,
          explanation: 'nums.length es 3, por lo que el bucle se ejecuta 3 veces (i=0, i=1, i=2).',
        ),
        Question(
          id: 'array_002_q2',
          question: '¿Cuál es la ventaja de usar "for-in" en lugar de "for con índice"?',
          options: [
            'Es más rápido',
            'Es más simple y legible',
            'Permite modificar la lista',
            'No tiene ventajas'
          ],
          correctAnswerIndex: 1,
          explanation: 'El for-in es más simple cuando solo necesitas los valores, sin preocuparte por los índices.',
        ),
        Question(
          id: 'array_002_q3',
          question: '¿Qué imprime?\nList<String> colores = ["rojo", "azul"];\nfor (String c in colores) { print(c); }',
          options: [
            'rojo azul (en una línea)',
            'rojo\nazul (en líneas separadas)',
            '0 1',
            'Error'
          ],
          correctAnswerIndex: 1,
          explanation: 'El bucle imprime cada color en una línea separada: rojo, luego azul.',
        ),
        Question(
          id: 'array_002_q4',
          question: '¿Cómo accedes al último elemento de una lista?\nList<int> nums = [10, 20, 30];',
          options: [
            'nums[3]',
            'nums[nums.length]',
            'nums[nums.length - 1]',
            'nums.last()'
          ],
          correctAnswerIndex: 2,
          explanation: 'El último índice es length - 1. Si length es 3, el último índice es 2.',
        ),
        Question(
          id: 'array_002_q5',
          question: '¿Qué hace este código?\nfor (int num in [2, 4, 6]) { print(num * 2); }',
          options: [
            'Imprime 2, 4, 6',
            'Imprime 4, 8, 12',
            'Imprime 2 tres veces',
            'Error'
          ],
          correctAnswerIndex: 1,
          explanation: 'El bucle recorre [2, 4, 6] e imprime cada número multiplicado por 2: 4, 8, 12.',
        ),
      ],
      estimatedMinutes: 18,
    ),
  ];
}
