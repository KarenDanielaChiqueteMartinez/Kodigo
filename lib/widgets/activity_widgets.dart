import 'package:flutter/material.dart';
import '../models/lesson.dart';

/// Widget base para actividades interactivas
abstract class ActivityWidget extends StatefulWidget {
  final Activity activity;
  final Function(bool isCorrect) onAnswerSubmit;

  const ActivityWidget({
    super.key,
    required this.activity,
    required this.onAnswerSubmit,
  });
}

/// Widget para actividades de completar espacios en blanco (Fill in the Blank)
class FillInBlankActivity extends StatefulWidget {
  final Activity activity;
  final Function(bool isCorrect) onAnswerSubmit;

  const FillInBlankActivity({
    super.key,
    required this.activity,
    required this.onAnswerSubmit,
  });

  @override
  State<FillInBlankActivity> createState() => _FillInBlankActivityState();
}

class _FillInBlankActivityState extends State<FillInBlankActivity> {
  String? _selectedOption;
  bool _hasSubmitted = false;
  bool _isCorrect = false;

  @override
  Widget build(BuildContext context) {
    // Datos esperados: { "codeTemplate": "...", "options": ["op1", "op2"...], "blankPosition": "word to replace" }
    final data = widget.activity.data;
    final String codeTemplate = data['codeTemplate'] ?? '';
    final List<String> options = List<String>.from(data['options'] ?? []);
    final String blankPosition = data['blankPosition'] ?? '___';

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título de actividad
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.edit_note,
                    color: Colors.orange[700],
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Completa el código',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Pregunta
            Text(
              widget.activity.question,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),

            // Código con espacio en blanco
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontFamily: 'Courier',
                    fontSize: 14,
                    color: Color(0xFFD4D4D4),
                    height: 1.5,
                  ),
                  children: _buildCodeSpans(codeTemplate, blankPosition),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Opciones para completar
            Text(
              'Selecciona el valor correcto:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),

            // Botones de opciones
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: options.map((option) {
                final bool isSelected = _selectedOption == option;
                final bool isCorrectOption = option == widget.activity.correctAnswer;
                
                Color? backgroundColor;
                Color? borderColor;
                
                if (_hasSubmitted) {
                  if (isCorrectOption) {
                    backgroundColor = Colors.green[50];
                    borderColor = Colors.green;
                  } else if (isSelected && !isCorrectOption) {
                    backgroundColor = Colors.red[50];
                    borderColor = Colors.red;
                  }
                } else if (isSelected) {
                  backgroundColor = Colors.blue[50];
                  borderColor = Colors.blue;
                }

                return InkWell(
                  onTap: _hasSubmitted ? null : () {
                    setState(() {
                      _selectedOption = option;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: backgroundColor ?? Colors.white,
                      border: Border.all(
                        color: borderColor ?? Colors.grey[300]!,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          option,
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        if (_hasSubmitted && isCorrectOption)
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(Icons.check_circle, color: Colors.green, size: 18),
                          ),
                        if (_hasSubmitted && isSelected && !isCorrectOption)
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(Icons.cancel, color: Colors.red, size: 18),
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Botón de enviar / retroalimentación
            if (!_hasSubmitted)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedOption != null ? _submitAnswer : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Verificar respuesta'),
                ),
              )
            else
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _isCorrect ? Colors.green[50] : Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _isCorrect ? Colors.green : Colors.orange,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _isCorrect ? Icons.check_circle : Icons.info,
                      color: _isCorrect ? Colors.green : Colors.orange,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _isCorrect ? '✅ ¡Correcto!' : '❌ Inténtalo de nuevo',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _isCorrect ? Colors.green[900] : Colors.orange[900],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.activity.feedback,
                            style: TextStyle(
                              color: _isCorrect ? Colors.green[800] : Colors.orange[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // Botón reintentar
            if (_hasSubmitted && !_isCorrect)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _retry,
                    child: const Text('Intentar de nuevo'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<TextSpan> _buildCodeSpans(String codeTemplate, String blankPosition) {
    final parts = codeTemplate.split(blankPosition);
    final List<TextSpan> spans = [];

    for (int i = 0; i < parts.length; i++) {
      spans.add(TextSpan(text: parts[i]));
      
      if (i < parts.length - 1) {
        // Agregar el espacio en blanco o la opción seleccionada
        spans.add(
          TextSpan(
            text: _selectedOption ?? '___',
            style: TextStyle(
              backgroundColor: _hasSubmitted
                  ? (_isCorrect ? Colors.green[700] : Colors.red[700])
                  : Colors.blue[700],
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
    }

    return spans;
  }

  void _submitAnswer() {
    setState(() {
      _hasSubmitted = true;
      _isCorrect = _selectedOption == widget.activity.correctAnswer;
    });
    widget.onAnswerSubmit(_isCorrect);
  }

  void _retry() {
    setState(() {
      _selectedOption = null;
      _hasSubmitted = false;
      _isCorrect = false;
    });
  }
}

/// Widget para actividades de opción múltiple
class MultipleChoiceActivity extends StatefulWidget {
  final Activity activity;
  final Function(bool isCorrect) onAnswerSubmit;

  const MultipleChoiceActivity({
    super.key,
    required this.activity,
    required this.onAnswerSubmit,
  });

  @override
  State<MultipleChoiceActivity> createState() => _MultipleChoiceActivityState();
}

class _MultipleChoiceActivityState extends State<MultipleChoiceActivity> {
  String? _selectedOption;
  bool _hasSubmitted = false;
  bool _isCorrect = false;

  @override
  Widget build(BuildContext context) {
    // Datos esperados: { "options": ["op1", "op2", "op3", "op4"] }
    final data = widget.activity.data;
    final List<String> options = List<String>.from(data['options'] ?? []);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título de actividad
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.purple[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.quiz,
                    color: Colors.purple[700],
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Pregunta de opción múltiple',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Pregunta
            Text(
              widget.activity.question,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),

            // Opciones
            ...options.map((option) {
              final bool isSelected = _selectedOption == option;
              final bool isCorrectOption = option == widget.activity.correctAnswer;
              
              Color? backgroundColor;
              Color? borderColor;
              IconData? icon;
              
              if (_hasSubmitted) {
                if (isCorrectOption) {
                  backgroundColor = Colors.green[50];
                  borderColor = Colors.green;
                  icon = Icons.check_circle;
                } else if (isSelected && !isCorrectOption) {
                  backgroundColor = Colors.red[50];
                  borderColor = Colors.red;
                  icon = Icons.cancel;
                }
              } else if (isSelected) {
                backgroundColor = Colors.blue[50];
                borderColor = Colors.blue;
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: _hasSubmitted ? null : () {
                    setState(() {
                      _selectedOption = option;
                    });
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: backgroundColor ?? Colors.white,
                      border: Border.all(
                        color: borderColor ?? Colors.grey[300]!,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            option,
                            style: TextStyle(
                              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                            ),
                          ),
                        ),
                        if (icon != null)
                          Icon(
                            icon,
                            color: isCorrectOption ? Colors.green : Colors.red,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),

            const SizedBox(height: 8),

            // Botón de enviar / retroalimentación
            if (!_hasSubmitted)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedOption != null ? _submitAnswer : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Verificar respuesta'),
                ),
              )
            else
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _isCorrect ? Colors.green[50] : Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _isCorrect ? Colors.green : Colors.orange,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _isCorrect ? Icons.check_circle : Icons.info,
                      color: _isCorrect ? Colors.green : Colors.orange,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _isCorrect ? '✅ ¡Correcto!' : '❌ Inténtalo de nuevo',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _isCorrect ? Colors.green[900] : Colors.orange[900],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.activity.feedback,
                            style: TextStyle(
                              color: _isCorrect ? Colors.green[800] : Colors.orange[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // Botón reintentar
            if (_hasSubmitted && !_isCorrect)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _retry,
                    child: const Text('Intentar de nuevo'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _submitAnswer() {
    setState(() {
      _hasSubmitted = true;
      _isCorrect = _selectedOption == widget.activity.correctAnswer;
    });
    widget.onAnswerSubmit(_isCorrect);
  }

  void _retry() {
    setState(() {
      _selectedOption = null;
      _hasSubmitted = false;
      _isCorrect = false;
    });
  }
}

/// Widget para actividades de arrastrar y soltar
class DragDropActivity extends StatefulWidget {
  final Activity activity;
  final Function(bool isCorrect) onAnswerSubmit;

  const DragDropActivity({
    super.key,
    required this.activity,
    required this.onAnswerSubmit,
  });

  @override
  State<DragDropActivity> createState() => _DragDropActivityState();
}

class _DragDropActivityState extends State<DragDropActivity> {
  List<String> _availableBlocks = [];
  List<String?> _droppedBlocks = [];
  bool _hasSubmitted = false;
  bool _isCorrect = false;

  @override
  void initState() {
    super.initState();
    // Datos esperados: { "blocks": ["block1", "block2"...], "slots": 3 }
    final data = widget.activity.data;
    _availableBlocks = List<String>.from(data['blocks'] ?? []);
    final int slots = data['slots'] ?? 3;
    _droppedBlocks = List<String?>.filled(slots, null);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título de actividad
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.teal[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.drag_indicator,
                    color: Colors.teal[700],
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Ordena los bloques',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Pregunta
            Text(
              widget.activity.question,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),

            // Zonas de soltar (slots)
            Text(
              'Arrastra los bloques aquí:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),

            Column(
              children: List.generate(_droppedBlocks.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: DragTarget<String>(
                    onAccept: (data) {
                      if (!_hasSubmitted) {
                        setState(() {
                          // Remover el bloque de bloques disponibles
                          _availableBlocks.remove(data);
                          // Si ya hay algo en este slot, devolverlo a disponibles
                          if (_droppedBlocks[index] != null) {
                            _availableBlocks.add(_droppedBlocks[index]!);
                          }
                          // Colocar el nuevo bloque
                          _droppedBlocks[index] = data;
                        });
                      }
                    },
                    builder: (context, candidateData, rejectedData) {
                      final bool isHovering = candidateData.isNotEmpty;
                      final String? block = _droppedBlocks[index];
                      
                      Color? backgroundColor;
                      Color? borderColor;
                      
                      if (_hasSubmitted && block != null) {
                        // Verificar si el bloque está en la posición correcta
                        final correctSequence = widget.activity.correctAnswer.split(',');
                        if (index < correctSequence.length && block == correctSequence[index]) {
                          backgroundColor = Colors.green[50];
                          borderColor = Colors.green;
                        } else {
                          backgroundColor = Colors.red[50];
                          borderColor = Colors.red;
                        }
                      } else if (isHovering) {
                        backgroundColor = Colors.blue[50];
                        borderColor = Colors.blue;
                      }

                      return Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          color: backgroundColor ?? Colors.grey[100],
                          border: Border.all(
                            color: borderColor ?? Colors.grey[300]!,
                            width: 2,
                            style: block == null ? BorderStyle.solid : BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: block != null
                            ? Draggable<String>(
                                data: block,
                                feedback: Material(
                                  elevation: 4,
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    width: 200,
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      block,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Courier',
                                      ),
                                    ),
                                  ),
                                ),
                                childWhenDragging: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onDragStarted: () {
                                  if (_hasSubmitted) return;
                                },
                                onDragCompleted: () {
                                  if (!_hasSubmitted) {
                                    setState(() {
                                      _droppedBlocks[index] = null;
                                    });
                                  }
                                },
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (!_hasSubmitted)
                                        const Icon(Icons.drag_indicator, size: 16),
                                      if (!_hasSubmitted)
                                        const SizedBox(width: 4),
                                      Text(
                                        block,
                                        style: const TextStyle(
                                          fontFamily: 'Courier',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Center(
                                child: Text(
                                  'Bloque ${index + 1}',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                      );
                    },
                  ),
                );
              }),
            ),

            const SizedBox(height: 16),

            // Bloques disponibles
            if (_availableBlocks.isNotEmpty) ...[
              Text(
                'Bloques disponibles:',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _availableBlocks.map((block) {
                  return Draggable<String>(
                    data: block,
                    feedback: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          block,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Courier',
                          ),
                        ),
                      ),
                    ),
                    childWhenDragging: Opacity(
                      opacity: 0.3,
                      child: _buildBlockChip(block),
                    ),
                    child: _buildBlockChip(block),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],

            // Botón de enviar / retroalimentación
            if (!_hasSubmitted)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _canSubmit() ? _submitAnswer : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Verificar orden'),
                ),
              )
            else
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _isCorrect ? Colors.green[50] : Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _isCorrect ? Colors.green : Colors.orange,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _isCorrect ? Icons.check_circle : Icons.info,
                      color: _isCorrect ? Colors.green : Colors.orange,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _isCorrect ? '✅ ¡Correcto!' : '❌ Inténtalo de nuevo',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _isCorrect ? Colors.green[900] : Colors.orange[900],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.activity.feedback,
                            style: TextStyle(
                              color: _isCorrect ? Colors.green[800] : Colors.orange[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // Botón reintentar
            if (_hasSubmitted && !_isCorrect)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _retry,
                    child: const Text('Intentar de nuevo'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlockChip(String block) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.drag_indicator, size: 16),
          const SizedBox(width: 4),
          Text(
            block,
            style: const TextStyle(
              fontFamily: 'Courier',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  bool _canSubmit() {
    return !_droppedBlocks.contains(null);
  }

  void _submitAnswer() {
    final userAnswer = _droppedBlocks.join(',');
    setState(() {
      _hasSubmitted = true;
      _isCorrect = userAnswer == widget.activity.correctAnswer;
    });
    widget.onAnswerSubmit(_isCorrect);
  }

  void _retry() {
    final data = widget.activity.data;
    setState(() {
      _availableBlocks = List<String>.from(data['blocks'] ?? []);
      _droppedBlocks = List<String?>.filled(data['slots'] ?? 3, null);
      _hasSubmitted = false;
      _isCorrect = false;
    });
  }
}

