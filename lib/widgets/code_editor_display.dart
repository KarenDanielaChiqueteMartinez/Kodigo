import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Widget que muestra código en un formato tipo editor
/// con resaltado de sintaxis básico y funcionalidad de copiar
class CodeEditorDisplay extends StatelessWidget {
  final String code;
  final String language;
  final String? description;

  const CodeEditorDisplay({
    super.key,
    required this.code,
    this.language = 'dart',
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: const Color(0xFF1E1E1E), // Color oscuro tipo VS Code
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Barra superior con lenguaje y botón copiar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D30),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                // Icono de archivo
                Icon(
                  _getLanguageIcon(),
                  color: _getLanguageColor(),
                  size: 18,
                ),
                const SizedBox(width: 8),
                // Nombre del lenguaje
                Text(
                  language.toUpperCase(),
                  style: TextStyle(
                    color: _getLanguageColor(),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const Spacer(),
                // Botón copiar
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _copyToClipboard(context),
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.copy,
                            color: Colors.grey[400],
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Copiar',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Código con scroll
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: SelectableText(
                  code.trim(),
                  style: const TextStyle(
                    fontFamily: 'Courier',
                    fontSize: 14,
                    color: Color(0xFFD4D4D4), // Color de texto claro
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ),

          // Descripción (opcional)
          if (description != null && description!.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: Colors.blue[700],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      description!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Copia el código al portapapeles
  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text('Código copiado al portapapeles'),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Obtiene el icono según el lenguaje
  IconData _getLanguageIcon() {
    switch (language.toLowerCase()) {
      case 'dart':
        return Icons.code;
      case 'javascript':
      case 'js':
        return Icons.javascript;
      case 'python':
        return Icons.code;
      case 'java':
        return Icons.coffee;
      default:
        return Icons.code;
    }
  }

  /// Obtiene el color según el lenguaje
  Color _getLanguageColor() {
    switch (language.toLowerCase()) {
      case 'dart':
        return const Color(0xFF00B4AB);
      case 'javascript':
      case 'js':
        return const Color(0xFFF7DF1E);
      case 'python':
        return const Color(0xFF3776AB);
      case 'java':
        return const Color(0xFFED8B00);
      default:
        return Colors.grey;
    }
  }
}

