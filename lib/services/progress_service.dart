import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user_progress.dart';

/// Servicio que maneja el progreso del usuario
/// Guarda y recupera datos de progreso usando SharedPreferences
class ProgressService {
  static const String _progressKey = 'user_progress';

  /// Guarda el progreso de una lección completada
  Future<bool> saveProgress(UserProgress progress) async {
    try {
      print('📦 ProgressService: Iniciando guardado...');
      final prefs = await SharedPreferences.getInstance();
      print('📦 SharedPreferences obtenido');
      
      // Obtener progreso existente
      List<UserProgress> existingProgress = await getAllProgress();
      print('📦 Progreso existente: ${existingProgress.length} registros');
      
      // Agregar nuevo progreso
      existingProgress.add(progress);
      print('📦 Nuevo progreso agregado. Total: ${existingProgress.length}');
      
      // Guardar en SharedPreferences
      List<Map<String, dynamic>> progressList = 
          existingProgress.map((p) => p.toMap()).toList();
      String progressJson = json.encode(progressList);
      print('📦 JSON generado: ${progressJson.length} caracteres');
      
      bool saved = await prefs.setString(_progressKey, progressJson);
      print('📦 Guardado en SharedPreferences: $saved');
      
      // Verificar que se guardó correctamente
      String? verification = prefs.getString(_progressKey);
      if (verification != null) {
        print('✅ Verificación exitosa: Datos guardados correctamente');
        return true;
      } else {
        print('❌ Verificación falló: No se encontraron los datos');
        return false;
      }
    } catch (e, stackTrace) {
      print('❌ Error guardando progreso: $e');
      print('Stack trace: $stackTrace');
      return false;
    }
  }

  /// Obtiene todo el progreso guardado
  Future<List<UserProgress>> getAllProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? progressJson = prefs.getString(_progressKey);
      
      if (progressJson == null) return [];
      
      List<dynamic> progressList = json.decode(progressJson);
      return progressList
          .map((progressMap) => UserProgress.fromMap(progressMap))
          .toList();
    } catch (e) {
      print('Error obteniendo progreso: $e');
      return [];
    }
  }

  /// Obtiene el progreso de un usuario específico
  Future<List<UserProgress>> getUserProgress(String userId) async {
    List<UserProgress> allProgress = await getAllProgress();
    return allProgress.where((progress) => progress.userId == userId).toList();
  }

  /// Obtiene el progreso de una lección específica para un usuario
  Future<UserProgress?> getLessonProgress(String userId, String lessonId) async {
    List<UserProgress> userProgress = await getUserProgress(userId);
    try {
      return userProgress.firstWhere(
        (progress) => progress.lessonId == lessonId,
      );
    } catch (e) {
      return null;
    }
  }

  /// Obtiene estadísticas de progreso para un usuario
  Future<ProgressStats> getUserStats(String userId) async {
    List<UserProgress> userProgress = await getUserProgress(userId);
    
    if (userProgress.isEmpty) {
      return ProgressStats(
        totalLessons: 0,
        averageScore: 0.0,
        averageTime: 0.0,
        totalScore: 0,
        bestCategory: '',
        worstCategory: '',
        completionRate: 0.0,
      );
    }

    // Calcular estadísticas
    int totalLessons = userProgress.length;
    double averageScore = userProgress
        .map((p) => p.score)
        .reduce((a, b) => a + b) / totalLessons;
    double averageTime = userProgress
        .map((p) => p.timeSpent)
        .reduce((a, b) => a + b) / totalLessons;
    int totalScore = userProgress
        .map((p) => p.score)
        .reduce((a, b) => a + b);

    // Estadísticas por categoría
    Map<String, List<UserProgress>> progressByCategory = {};
    for (var progress in userProgress) {
      if (!progressByCategory.containsKey(progress.category)) {
        progressByCategory[progress.category] = [];
      }
      progressByCategory[progress.category]!.add(progress);
    }

    String bestCategory = '';
    String worstCategory = '';
    double bestAverage = 0.0;
    double worstAverage = 100.0;

    for (var entry in progressByCategory.entries) {
      String category = entry.key;
      List<UserProgress> categoryProgress = entry.value;
      
      double categoryAverage = categoryProgress
          .map((p) => p.score)
          .reduce((a, b) => a + b) / categoryProgress.length;

      if (categoryAverage > bestAverage) {
        bestAverage = categoryAverage;
        bestCategory = category;
      }
      
      if (categoryAverage < worstAverage) {
        worstAverage = categoryAverage;
        worstCategory = category;
      }
    }

    // Calcular tasa de completación (asumiendo que hay 6 lecciones totales)
    double completionRate = (totalLessons / 6.0).clamp(0.0, 1.0);

    return ProgressStats(
      totalLessons: totalLessons,
      averageScore: averageScore,
      averageTime: averageTime,
      totalScore: totalScore,
      bestCategory: bestCategory,
      worstCategory: worstCategory,
      completionRate: completionRate,
    );
  }

  /// Genera datos de progreso de ejemplo para otros usuarios
  /// Esto simula datos de otros usuarios para el algoritmo KNN
  Future<void> generateSampleProgress() async {
    final prefs = await SharedPreferences.getInstance();
    String? existing = prefs.getString(_progressKey);
    
    // Solo generar si no hay datos existentes
    if (existing != null) return;

    List<UserProgress> sampleProgress = [
      // Usuario 1 - Principiante con buen rendimiento
      UserProgress(
        userId: 'user_001',
        lessonId: 'var_001',
        score: 85,
        timeSpent: 10.0,
        attempts: 1,
        completedAt: DateTime.now().subtract(const Duration(days: 5)),
        level: 1,
        category: 'Variables',
      ),
      UserProgress(
        userId: 'user_001',
        lessonId: 'var_002',
        score: 90,
        timeSpent: 12.0,
        attempts: 1,
        completedAt: DateTime.now().subtract(const Duration(days: 4)),
        level: 1,
        category: 'Variables',
      ),
      
      // Usuario 2 - Intermedio con rendimiento variable
      UserProgress(
        userId: 'user_002',
        lessonId: 'var_001',
        score: 70,
        timeSpent: 15.0,
        attempts: 2,
        completedAt: DateTime.now().subtract(const Duration(days: 10)),
        level: 2,
        category: 'Variables',
      ),
      UserProgress(
        userId: 'user_002',
        lessonId: 'cond_001',
        score: 95,
        timeSpent: 8.0,
        attempts: 1,
        completedAt: DateTime.now().subtract(const Duration(days: 8)),
        level: 2,
        category: 'Condicionales',
      ),
      UserProgress(
        userId: 'user_002',
        lessonId: 'loop_001',
        score: 80,
        timeSpent: 18.0,
        attempts: 2,
        completedAt: DateTime.now().subtract(const Duration(days: 6)),
        level: 2,
        category: 'Bucles',
      ),

      // Usuario 3 - Avanzado con excelente rendimiento
      UserProgress(
        userId: 'user_003',
        lessonId: 'func_001',
        score: 95,
        timeSpent: 12.0,
        attempts: 1,
        completedAt: DateTime.now().subtract(const Duration(days: 3)),
        level: 3,
        category: 'Funciones',
      ),
      UserProgress(
        userId: 'user_003',
        lessonId: 'array_001',
        score: 100,
        timeSpent: 15.0,
        attempts: 1,
        completedAt: DateTime.now().subtract(const Duration(days: 1)),
        level: 3,
        category: 'Arrays',
      ),

      // Usuario 4 - Principiante con dificultades
      UserProgress(
        userId: 'user_004',
        lessonId: 'var_001',
        score: 60,
        timeSpent: 25.0,
        attempts: 3,
        completedAt: DateTime.now().subtract(const Duration(days: 7)),
        level: 1,
        category: 'Variables',
      ),
    ];

    // Guardar datos de ejemplo
    List<Map<String, dynamic>> progressList = 
        sampleProgress.map((p) => p.toMap()).toList();
    String progressJson = json.encode(progressList);
    await prefs.setString(_progressKey, progressJson);
  }
}

/// Clase para estadísticas de progreso del usuario
class ProgressStats {
  final int totalLessons;
  final double averageScore;
  final double averageTime;
  final int totalScore;
  final String bestCategory;
  final String worstCategory;
  final double completionRate;

  ProgressStats({
    required this.totalLessons,
    required this.averageScore,
    required this.averageTime,
    required this.totalScore,
    required this.bestCategory,
    required this.worstCategory,
    required this.completionRate,
  });
}
