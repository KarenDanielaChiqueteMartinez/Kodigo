import 'package:flutter/material.dart';
import '../models/lesson.dart';
import 'code_editor_display.dart';
import 'activity_widgets.dart';

/// Widget que representa un módulo interactivo completo dentro de una lección
/// Incluye explicación, ejemplo de código y actividades
class InteractiveLessonModule extends StatefulWidget {
  final InteractiveModule module;
  final Function(int correctAnswers, int totalActivities) onModuleComplete;

  const InteractiveLessonModule({
    super.key,
    required this.module,
    required this.onModuleComplete,
  });

  @override
  State<InteractiveLessonModule> createState() => _InteractiveLessonModuleState();
}

class _InteractiveLessonModuleState extends State<InteractiveLessonModule> {
  int _currentActivityIndex = 0;
  final List<bool> _activityResults = [];
  bool _showingActivities = false;
  bool _moduleCompleted = false;

  @override
  void initState() {
    super.initState();
    _activityResults.addAll(List.filled(widget.module.activities.length, false));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Encabezado del módulo
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.8),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.school,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.module.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (_moduleCompleted)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
              ],
            ),
          ),

          // Contenido del módulo
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sección 1: Explicación del concepto
                _buildSection(
                  icon: Icons.lightbulb_outline,
                  iconColor: Colors.amber,
                  title: '💡 Concepto',
                  child: Text(
                    widget.module.explanation,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Sección 2: Ejemplo de código
                if (widget.module.codeExample != null) ...[
                  _buildSection(
                    icon: Icons.code,
                    iconColor: Colors.blue,
                    title: '📝 Ejemplo de código',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.module.codeExample!.description != null) ...[
                          Text(
                            widget.module.codeExample!.description!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                        CodeEditorDisplay(
                          code: widget.module.codeExample!.code,
                          language: widget.module.codeExample!.language,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                // Sección 3: Actividades prácticas
                if (widget.module.activities.isNotEmpty) ...[
                  _buildSection(
                    icon: Icons.assignment,
                    iconColor: Colors.green,
                    title: '✍️ Práctica',
                    child: _showingActivities
                        ? _buildActivitySection()
                        : Center(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  _showingActivities = true;
                                });
                              },
                              icon: const Icon(Icons.play_arrow),
                              label: const Text('Comenzar actividades'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required Color iconColor,
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  Widget _buildActivitySection() {
    if (_moduleCompleted) {
      return _buildCompletionSummary();
    }

    final activity = widget.module.activities[_currentActivityIndex];

    return Column(
      children: [
        // Indicador de progreso
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: (_currentActivityIndex + 1) / widget.module.activities.length,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${_currentActivityIndex + 1}/${widget.module.activities.length}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Actividad actual
        _buildActivityWidget(activity),
      ],
    );
  }

  Widget _buildActivityWidget(Activity activity) {
    switch (activity.type) {
      case ActivityType.fillInBlank:
        return FillInBlankActivity(
          activity: activity,
          onAnswerSubmit: _onActivityComplete,
        );
      case ActivityType.multipleChoice:
        return MultipleChoiceActivity(
          activity: activity,
          onAnswerSubmit: _onActivityComplete,
        );
      case ActivityType.dragAndDrop:
        return DragDropActivity(
          activity: activity,
          onAnswerSubmit: _onActivityComplete,
        );
    }
  }

  void _onActivityComplete(bool isCorrect) {
    print('🎯 Actividad ${_currentActivityIndex + 1}/${widget.module.activities.length} completada');
    print('   Respuesta correcta: $isCorrect');
    
    setState(() {
      _activityResults[_currentActivityIndex] = isCorrect;
    });

    if (isCorrect) {
      // Esperar un momento para que el usuario vea la retroalimentación
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          if (_currentActivityIndex < widget.module.activities.length - 1) {
            // Pasar a la siguiente actividad
            print('   ➡️ Avanzando a actividad ${_currentActivityIndex + 2}');
            setState(() {
              _currentActivityIndex++;
            });
          } else {
            // Completar el módulo
            print('   ✅ Todas las actividades del módulo completadas');
            setState(() {
              _moduleCompleted = true;
            });
            
            final correctAnswers = _activityResults.where((r) => r).length;
            print('   📊 Enviando callback onModuleComplete: $correctAnswers/${_activityResults.length}');
            widget.onModuleComplete(correctAnswers, _activityResults.length);
          }
        }
      });
    }
  }

  Widget _buildCompletionSummary() {
    final correctAnswers = _activityResults.where((r) => r).length;
    final totalActivities = _activityResults.length;
    final percentage = (correctAnswers / totalActivities * 100).round();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green[50]!,
            Colors.green[100]!,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green, width: 2),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.celebration,
            color: Colors.green,
            size: 48,
          ),
          const SizedBox(height: 16),
          const Text(
            '¡Módulo completado!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Has completado todas las actividades de este módulo',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.green[900],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStat(
                  label: 'Respuestas correctas',
                  value: '$correctAnswers/$totalActivities',
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),
                _buildStat(
                  label: 'Porcentaje',
                  value: '$percentage%',
                  icon: Icons.percent,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[700],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

