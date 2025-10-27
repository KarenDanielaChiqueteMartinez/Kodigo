import 'package:flutter/material.dart';
import '../models/lesson.dart';

/// Widget que muestra una pregunta con opciones arrastrables
/// El usuario debe arrastrar la respuesta correcta a una zona de respuesta
class DraggableQuestionCard extends StatefulWidget {
  final Question question;
  final VoidCallback onCorrectAnswer;
  final int questionNumber;
  final int totalQuestions;

  const DraggableQuestionCard({
    super.key,
    required this.question,
    required this.onCorrectAnswer,
    required this.questionNumber,
    required this.totalQuestions,
  });

  @override
  State<DraggableQuestionCard> createState() => _DraggableQuestionCardState();
}

class _DraggableQuestionCardState extends State<DraggableQuestionCard> {
  String? _droppedAnswer;
  bool _hasSubmitted = false;
  bool _isCorrect = false;
  List<String> _availableOptions = [];

  @override
  void initState() {
    super.initState();
    _availableOptions = List<String>.from(widget.question.options);
    _resetState();
  }

  @override
  void didUpdateWidget(DraggableQuestionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Si cambió la pregunta, resetear el estado
    if (oldWidget.question.id != widget.question.id) {
      _resetState();
      _availableOptions = List<String>.from(widget.question.options);
    }
  }

  void _resetState() {
    _droppedAnswer = null;
    _hasSubmitted = false;
    _isCorrect = false;
  }

  @override
  Widget build(BuildContext context) {
    final correctAnswer = widget.question.options[widget.question.correctAnswerIndex];

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado con número de pregunta
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Pregunta ${widget.questionNumber}/${widget.totalQuestions}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Pregunta
            Text(
              widget.question.question,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),

            // Zona de respuesta (drop zone)
            Text(
              'Arrastra la respuesta correcta aquí:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),

            DragTarget<String>(
              onAccept: (data) {
                if (!_hasSubmitted) {
                  setState(() {
                    // Si ya había una respuesta, devolverla a opciones disponibles
                    if (_droppedAnswer != null) {
                      _availableOptions.add(_droppedAnswer!);
                    }
                    // Quitar la nueva respuesta de opciones disponibles
                    _availableOptions.remove(data);
                    // Establecer la nueva respuesta
                    _droppedAnswer = data;
                  });
                }
              },
              builder: (context, candidateData, rejectedData) {
                final bool isHovering = candidateData.isNotEmpty;
                
                Color? backgroundColor;
                Color? borderColor;
                IconData? icon;
                
                if (_hasSubmitted && _droppedAnswer != null) {
                  if (_isCorrect) {
                    backgroundColor = Colors.green[50];
                    borderColor = Colors.green;
                    icon = Icons.check_circle;
                  } else {
                    backgroundColor = Colors.red[50];
                    borderColor = Colors.red;
                    icon = Icons.cancel;
                  }
                } else if (isHovering) {
                  backgroundColor = Colors.blue[50];
                  borderColor = Colors.blue;
                } else if (_droppedAnswer != null) {
                  backgroundColor = Colors.blue[50];
                  borderColor = Colors.blue[300];
                }

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: backgroundColor ?? Colors.grey[50],
                    border: Border.all(
                      color: borderColor ?? Colors.grey[300]!,
                      width: 3,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _droppedAnswer != null
                      ? Draggable<String>(
                          data: _droppedAnswer!,
                          feedback: Material(
                            elevation: 6,
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              width: MediaQuery.of(context).size.width - 80,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                _droppedAnswer!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          childWhenDragging: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onDragStarted: () {
                            if (_hasSubmitted) return;
                          },
                          onDragCompleted: () {
                            if (!_hasSubmitted) {
                              setState(() {
                                _droppedAnswer = null;
                              });
                            }
                          },
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (!_hasSubmitted)
                                  const Icon(Icons.drag_indicator, size: 20),
                                if (!_hasSubmitted)
                                  const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    _droppedAnswer!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                if (icon != null) ...[
                                  const SizedBox(width: 8),
                                  Icon(
                                    icon,
                                    color: _isCorrect ? Colors.green : Colors.red,
                                    size: 28,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                isHovering ? Icons.arrow_downward : Icons.touch_app,
                                size: 32,
                                color: isHovering ? Colors.blue : Colors.grey[400],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                isHovering ? 'Suelta aquí' : 'Zona de respuesta',
                                style: TextStyle(
                                  color: isHovering ? Colors.blue : Colors.grey[500],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                );
              },
            ),

            const SizedBox(height: 24),

            // Opciones disponibles para arrastrar
            if (_availableOptions.isNotEmpty) ...[
              Text(
                'Opciones disponibles:',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: _availableOptions.map((option) {
                  return Draggable<String>(
                    data: option,
                    feedback: Material(
                      elevation: 6,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          option,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    childWhenDragging: Opacity(
                      opacity: 0.3,
                      child: _buildOptionChip(option, context),
                    ),
                    child: _buildOptionChip(option, context),
                  );
                }).toList(),
              ),
            ],

            const SizedBox(height: 24),

            // Botón de verificar o mensaje de retroalimentación
            if (!_hasSubmitted)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _droppedAnswer != null ? _submitAnswer : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Verificar respuesta',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            else ...[
              // Retroalimentación
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _isCorrect ? Colors.green[50] : Colors.orange[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _isCorrect ? Colors.green : Colors.orange,
                    width: 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _isCorrect ? Icons.check_circle : Icons.info,
                          color: _isCorrect ? Colors.green : Colors.orange,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _isCorrect ? '✅ ¡Correcto!' : '❌ Respuesta incorrecta',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: _isCorrect ? Colors.green[900] : Colors.orange[900],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.question.explanation,
                      style: TextStyle(
                        fontSize: 15,
                        color: _isCorrect ? Colors.green[800] : Colors.orange[800],
                        height: 1.4,
                      ),
                    ),
                    if (!_isCorrect) ...[
                      const SizedBox(height: 12),
                      Text(
                        'Respuesta correcta: $correctAnswer',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              
              // Botón para continuar (si es correcta) o reintentar (si es incorrecta)
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isCorrect ? widget.onCorrectAnswer : _retry,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: _isCorrect ? Colors.green : Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _isCorrect ? 'Continuar ➜' : 'Intentar de nuevo',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildOptionChip(String option, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!, width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.drag_indicator, size: 18, color: Colors.blue),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              option,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitAnswer() {
    final correctAnswer = widget.question.options[widget.question.correctAnswerIndex];
    
    setState(() {
      _hasSubmitted = true;
      _isCorrect = _droppedAnswer == correctAnswer;
    });
  }

  void _retry() {
    setState(() {
      // Devolver la respuesta incorrecta a las opciones disponibles
      if (_droppedAnswer != null) {
        _availableOptions.add(_droppedAnswer!);
      }
      _droppedAnswer = null;
      _hasSubmitted = false;
      _isCorrect = false;
    });
  }
}

