/// Modelo que representa una lección de programación
/// Contiene el contenido educativo y metadatos
class Lesson {
  final String id;
  final String title;
  final String description;
  final int level;
  final String category; // variables, loops, functions, etc.
  final List<String> concepts; // conceptos que enseña
  final String content; // contenido de la lección
  final List<Question> questions; // preguntas/ejercicios
  final int estimatedMinutes;
  final bool isCompleted;
  final List<InteractiveModule>? interactiveModules; // módulos interactivos

  const Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    required this.category,
    required this.concepts,
    required this.content,
    required this.questions,
    required this.estimatedMinutes,
    this.isCompleted = false,
    this.interactiveModules,
  });

  /// Convierte la lección a un mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'level': level,
      'category': category,
      'concepts': concepts,
      'content': content,
      'questions': questions.map((q) => q.toMap()).toList(),
      'estimatedMinutes': estimatedMinutes,
      'isCompleted': isCompleted,
      'interactiveModules': interactiveModules?.map((m) => m.toMap()).toList(),
    };
  }

  /// Crea una lección desde un mapa
  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      level: map['level'] ?? 1,
      category: map['category'] ?? '',
      concepts: List<String>.from(map['concepts'] ?? []),
      content: map['content'] ?? '',
      questions: (map['questions'] as List<dynamic>?)
          ?.map((q) => Question.fromMap(q as Map<String, dynamic>))
          .toList() ?? [],
      estimatedMinutes: map['estimatedMinutes'] ?? 5,
      isCompleted: map['isCompleted'] ?? false,
      interactiveModules: (map['interactiveModules'] as List<dynamic>?)
          ?.map((m) => InteractiveModule.fromMap(m as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Crea una copia de la lección con algunos campos modificados
  Lesson copyWith({
    String? id,
    String? title,
    String? description,
    int? level,
    String? category,
    List<String>? concepts,
    String? content,
    List<Question>? questions,
    int? estimatedMinutes,
    bool? isCompleted,
    List<InteractiveModule>? interactiveModules,
  }) {
    return Lesson(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      level: level ?? this.level,
      category: category ?? this.category,
      concepts: concepts ?? this.concepts,
      content: content ?? this.content,
      questions: questions ?? this.questions,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      isCompleted: isCompleted ?? this.isCompleted,
      interactiveModules: interactiveModules ?? this.interactiveModules,
    );
  }
}

/// Modelo que representa una pregunta o ejercicio dentro de una lección
class Question {
  final String id;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  const Question({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  });

  /// Convierte la pregunta a un mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
      'explanation': explanation,
    };
  }

  /// Crea una pregunta desde un mapa
  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] ?? '',
      question: map['question'] ?? '',
      options: List<String>.from(map['options'] ?? []),
      correctAnswerIndex: map['correctAnswerIndex'] ?? 0,
      explanation: map['explanation'] ?? '',
    );
  }
}

/// Modelo que representa un módulo interactivo dentro de una lección
class InteractiveModule {
  final String id;
  final String title;
  final String explanation; // breve explicación del concepto
  final CodeExample? codeExample; // ejemplo de código
  final List<Activity> activities; // actividades prácticas

  const InteractiveModule({
    required this.id,
    required this.title,
    required this.explanation,
    this.codeExample,
    required this.activities,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'explanation': explanation,
      'codeExample': codeExample?.toMap(),
      'activities': activities.map((a) => a.toMap()).toList(),
    };
  }

  factory InteractiveModule.fromMap(Map<String, dynamic> map) {
    return InteractiveModule(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      explanation: map['explanation'] ?? '',
      codeExample: map['codeExample'] != null 
          ? CodeExample.fromMap(map['codeExample'] as Map<String, dynamic>)
          : null,
      activities: (map['activities'] as List<dynamic>?)
          ?.map((a) => Activity.fromMap(a as Map<String, dynamic>))
          .toList() ?? [],
    );
  }
}

/// Modelo que representa un ejemplo de código
class CodeExample {
  final String code;
  final String language; // dart, javascript, python, etc.
  final String? description; // descripción adicional del código

  const CodeExample({
    required this.code,
    this.language = 'dart',
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'language': language,
      'description': description,
    };
  }

  factory CodeExample.fromMap(Map<String, dynamic> map) {
    return CodeExample(
      code: map['code'] ?? '',
      language: map['language'] ?? 'dart',
      description: map['description'],
    );
  }
}

/// Tipos de actividad interactiva
enum ActivityType {
  fillInBlank,     // completar línea de código
  multipleChoice,  // elegir respuesta correcta
  dragAndDrop,     // arrastrar y soltar bloques
}

/// Modelo que representa una actividad práctica
class Activity {
  final String id;
  final ActivityType type;
  final String question;
  final Map<String, dynamic> data; // datos específicos de cada tipo
  final String correctAnswer; // respuesta correcta
  final String feedback; // retroalimentación

  const Activity({
    required this.id,
    required this.type,
    required this.question,
    required this.data,
    required this.correctAnswer,
    required this.feedback,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.toString(),
      'question': question,
      'data': data,
      'correctAnswer': correctAnswer,
      'feedback': feedback,
    };
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      id: map['id'] ?? '',
      type: _parseActivityType(map['type'] ?? ''),
      question: map['question'] ?? '',
      data: Map<String, dynamic>.from(map['data'] ?? {}),
      correctAnswer: map['correctAnswer'] ?? '',
      feedback: map['feedback'] ?? '',
    );
  }

  static ActivityType _parseActivityType(String typeString) {
    switch (typeString) {
      case 'ActivityType.fillInBlank':
        return ActivityType.fillInBlank;
      case 'ActivityType.multipleChoice':
        return ActivityType.multipleChoice;
      case 'ActivityType.dragAndDrop':
        return ActivityType.dragAndDrop;
      default:
        return ActivityType.multipleChoice;
    }
  }
}
