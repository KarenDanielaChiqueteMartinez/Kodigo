import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Widget de loader animado personalizado
/// Diseño moderno y llamativo con múltiples animaciones
class CustomLoader extends StatefulWidget {
  final double size;
  final Color? color;
  final String? message;

  const CustomLoader({
    super.key,
    this.size = 80.0,
    this.color,
    this.message,
  });

  @override
  State<CustomLoader> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader> with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    
    // Animación de rotación continua
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    // Animación de escala pulsante
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    // Animación de fade para el mensaje
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loaderColor = widget.color ?? const Color(0xFF1976D2);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Loader animado
          SizedBox(
            width: widget.size,
            height: widget.size,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Círculo exterior rotando
                AnimatedBuilder(
                  animation: _rotationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _rotationController.value * 2 * math.pi,
                      child: Container(
                        width: widget.size,
                        height: widget.size,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: loaderColor.withOpacity(0.3),
                            width: 3,
                          ),
                        ),
                        child: CustomPaint(
                          painter: _LoaderPainter(
                            color: loaderColor,
                            progress: _rotationController.value,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // Círculo pulsante central
                AnimatedBuilder(
                  animation: _scaleController,
                  builder: (context, child) {
                    final scale = 0.3 + (_scaleController.value * 0.2);
                    return Transform.scale(
                      scale: scale,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              loaderColor,
                              loaderColor.withOpacity(0.6),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: loaderColor.withOpacity(0.5),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // Icono central
                Icon(
                  Icons.school_rounded,
                  color: Colors.white,
                  size: widget.size * 0.3,
                ),
              ],
            ),
          ),

          // Mensaje animado
          if (widget.message != null) ...[
            const SizedBox(height: 24),
            FadeTransition(
              opacity: _fadeController,
              child: Text(
                widget.message!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: loaderColor,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Painter personalizado para el loader
class _LoaderPainter extends CustomPainter {
  final Color color;
  final double progress;

  _LoaderPainter({
    required this.color,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Dibujar arcos animados
    for (int i = 0; i < 3; i++) {
      final startAngle = (progress * 2 * math.pi) + (i * 2 * math.pi / 3);
      const sweepAngle = math.pi / 3;
      
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_LoaderPainter oldDelegate) => true;
}

/// Loader simple con puntos animados
class DotLoader extends StatefulWidget {
  final Color? color;
  final double size;

  const DotLoader({
    super.key,
    this.color,
    this.size = 50.0,
  });

  @override
  State<DotLoader> createState() => _DotLoaderState();
}

class _DotLoaderState extends State<DotLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dotColor = widget.color ?? const Color(0xFF1976D2);

    return SizedBox(
      width: widget.size,
      height: widget.size / 3,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              final delay = index * 0.2;
              final value = (_controller.value - delay).clamp(0.0, 1.0);
              final scale = math.sin(value * math.pi);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Transform.scale(
                  scale: 0.5 + (scale * 0.5),
                  child: Container(
                    width: widget.size / 6,
                    height: widget.size / 6,
                    decoration: BoxDecoration(
                      color: dotColor.withOpacity(0.5 + (scale * 0.5)),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

/// Loader tipo spinner circular
class CircularLoader extends StatefulWidget {
  final Color? color;
  final double size;
  final double strokeWidth;

  const CircularLoader({
    super.key,
    this.color,
    this.size = 50.0,
    this.strokeWidth = 4.0,
  });

  @override
  State<CircularLoader> createState() => _CircularLoaderState();
}

class _CircularLoaderState extends State<CircularLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _CircularLoaderPainter(
              color: widget.color ?? const Color(0xFF1976D2),
              progress: _controller.value,
              strokeWidth: widget.strokeWidth,
            ),
          );
        },
      ),
    );
  }
}

class _CircularLoaderPainter extends CustomPainter {
  final Color color;
  final double progress;
  final double strokeWidth;

  _CircularLoaderPainter({
    required this.color,
    required this.progress,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Arco principal
    final startAngle = progress * 2 * math.pi;
    final sweepAngle = math.pi * 1.5;

    // Gradiente de opacidad
    for (int i = 0; i < 3; i++) {
      final opacity = 1.0 - (i * 0.3);
      paint.color = color.withOpacity(opacity);
      
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - (i * 2)),
        startAngle + (i * 0.1),
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_CircularLoaderPainter oldDelegate) => true;
}

/// Overlay de loading para pantalla completa
class LoadingOverlay extends StatelessWidget {
  final String? message;
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({
    super.key,
    required this.child,
    this.isLoading = false,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: CustomLoader(
              message: message ?? 'Cargando...',
            ),
          ),
      ],
    );
  }
}
