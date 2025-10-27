import 'package:flutter/material.dart';
import '../../models/lesson.dart';
import '../../models/user_progress.dart';
import '../../services/progress_service.dart';
import '../../services/auth_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/interactive_lesson_module.dart';
import '../../widgets/draggable_question_card.dart';

/// Pantalla de detalles de una lección
/// Muestra el contenido y permite realizar ejercicios interactivos
class LessonDetailScreen extends StatefulWidget {
  final Lesson lesson;

  const LessonDetailScreen({
    super.key,
    required this.lesson,
  });

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  int _currentQuestionIndex = 0;
  bool _isCompleted = false;
  int _score = 0;
  int _attempts = 0;
  DateTime? _startTime;
  List<bool> _questionResults = [];
  bool _showingInteractiveModules = true;
  int _currentModuleIndex = 0;
  final List<int> _moduleScores = [];

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    _questionResults = List.filled(widget.lesson.questions.length, false);
    
    // Si hay módulos interactivos, mostrarlos primero
    if (widget.lesson.interactiveModules != null && 
        widget.lesson.interactiveModules!.isNotEmpty) {
      _showingInteractiveModules = true;
      _moduleScores.addAll(List.filled(widget.lesson.interactiveModules!.length, 0));
    } else {
      _showingInteractiveModules = false;
    }
  }

  /// Maneja la finalización de un módulo interactivo
  void _onModuleComplete(int correctAnswers, int totalActivities) {
    setState(() {
      _moduleScores[_currentModuleIndex] = correctAnswers;
      
      // Calcular puntos del módulo (máximo 20 puntos por módulo)
      double moduleScore = (correctAnswers / totalActivities) * 20;
      _score += moduleScore.round();
    });

    // Avanzar al siguiente módulo o a las preguntas tradicionales
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          if (_currentModuleIndex < widget.lesson.interactiveModules!.length - 1) {
            _currentModuleIndex++;
          } else {
            // Terminar módulos interactivos, pasar a preguntas tradicionales
            _showingInteractiveModules = false;
            if (widget.lesson.questions.isEmpty) {
              // Si no hay preguntas, completar la lección
              _completeLesson();
            }
          }
        });
      }
    });
  }


  /// Avanza a la siguiente pregunta o completa la lección
  void _nextQuestion() {
    if (_currentQuestionIndex < widget.lesson.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _attempts++;
      });
    } else {
      _completeLesson();
    }
  }

  /// Marca la lección como completada y guarda el progreso
  Future<void> _completeLesson() async {
    if (_isCompleted) return;

    setState(() {
      _isCompleted = true;
    });

    try {
      final authService = AuthService();
      final progressService = ProgressService();
      final currentUser = await authService.getCurrentUser();

      if (currentUser != null && _startTime != null) {
        // Calcular tiempo transcurrido
        double timeSpent = DateTime.now().difference(_startTime!).inMinutes.toDouble();
        if (timeSpent < 1) timeSpent = 1; // Mínimo 1 minuto

        // Crear registro de progreso
        UserProgress progress = UserProgress(
          userId: currentUser.id,
          lessonId: widget.lesson.id,
          score: _score,
          timeSpent: timeSpent,
          attempts: _attempts,
          completedAt: DateTime.now(),
          level: currentUser.currentLevel,
          category: widget.lesson.category,
        );

        // Guardar progreso
        await progressService.saveProgress(progress);

        // Actualizar estadísticas del usuario
        int newTotalScore = currentUser.totalScore + _score;
        int newLessonsCompleted = currentUser.lessonsCompleted + 1;
        
        // Calcular nuevo promedio de tiempo
        double newAverageTime = currentUser.lessonsCompleted > 0
            ? ((currentUser.averageTimePerLesson * currentUser.lessonsCompleted) + timeSpent) / newLessonsCompleted
            : timeSpent;

        // Calcular nuevo nivel (cada 500 puntos = 1 nivel)
        int newLevel = (newTotalScore / 500).floor() + 1;

        // Actualizar usuario
        var updatedUser = currentUser.copyWith(
          totalScore: newTotalScore,
          lessonsCompleted: newLessonsCompleted,
          averageTimePerLesson: newAverageTime,
          currentLevel: newLevel,
          lastActivity: DateTime.now(),
        );

        await authService.updateCurrentUser(updatedUser);
      }

      // Mostrar diálogo de felicitaciones
      _showCompletionDialog();
    } catch (e) {
      print('Error guardando progreso: $e');
      _showCompletionDialog();
    }
  }

  /// Muestra el diálogo de felicitaciones al completar la lección
  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.celebration,
              color: Colors.orange,
              size: 28,
            ),
            const SizedBox(width: 8),
            const Text('¡Felicidades!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Has completado la lección "${widget.lesson.title}"'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Puntuación:'),
                      Text(
                        '$_score/100',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Respuestas correctas:'),
                      Text(
                        '${_questionResults.where((r) => r).length}/${_questionResults.length}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          CustomButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar diálogo
              Navigator.of(context).pop(); // Volver a lecciones
            },
            child: const Text('Continuar'),
          ),
        ],
      ),
    );
  }

  /// Construye la vista para módulos interactivos
  Widget _buildInteractiveModuleView() {
    final modules = widget.lesson.interactiveModules!;
    final currentModule = modules[_currentModuleIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lesson.title),
        actions: [
          // Progreso de módulos
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Módulo ${_currentModuleIndex + 1}/${modules.length}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de progreso
          LinearProgressIndicator(
            value: (_currentModuleIndex + 1) / modules.length,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          ),

          // Contenido del módulo
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Información de la lección (solo en el primer módulo)
                  if (_currentModuleIndex == 0) ...[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Acerca de esta lección',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(widget.lesson.description),
                            const SizedBox(height: 12),
                            Text(
                              'Conceptos que aprenderás:',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: widget.lesson.concepts.map((concept) {
                                return Chip(
                                  label: Text(concept),
                                  backgroundColor: Colors.blue[50],
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Módulo interactivo actual
                  InteractiveLessonModule(
                    module: currentModule,
                    onModuleComplete: _onModuleComplete,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mostrar módulos interactivos si están disponibles y aún no se han completado
    if (_showingInteractiveModules && 
        widget.lesson.interactiveModules != null &&
        widget.lesson.interactiveModules!.isNotEmpty) {
      return _buildInteractiveModuleView();
    }

    // Si no hay preguntas ni módulos, mostrar mensaje
    if (widget.lesson.questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.lesson.title),
        ),
        body: const Center(
          child: Text('Esta lección no tiene ejercicios disponibles'),
        ),
      );
    }

    Question currentQuestion = widget.lesson.questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lesson.title),
        actions: [
          // Progreso
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                '${_currentQuestionIndex + 1}/${widget.lesson.questions.length}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de progreso
          LinearProgressIndicator(
            value: (_currentQuestionIndex + 1) / widget.lesson.questions.length,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          ),

          // Contenido de la lección
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Información de la lección (solo en la primera pregunta)
                  if (_currentQuestionIndex == 0) ...[
                    Card(
                      margin: const EdgeInsets.all(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Contenido de la lección',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(widget.lesson.content),
                            const SizedBox(height: 12),
                            Text(
                              'Conceptos clave:',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: widget.lesson.concepts.map((concept) {
                                return Chip(
                                  label: Text(concept),
                                  backgroundColor: Colors.blue[50],
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  // Pregunta actual con drag & drop
                  DraggableQuestionCard(
                    question: currentQuestion,
                    questionNumber: _currentQuestionIndex + 1,
                    totalQuestions: widget.lesson.questions.length,
                    onCorrectAnswer: () {
                      setState(() {
                        _questionResults[_currentQuestionIndex] = true;
                        _score += (100 / widget.lesson.questions.length).round();
                      });
                      _nextQuestion();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
