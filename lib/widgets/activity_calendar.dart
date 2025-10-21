import 'package:flutter/material.dart';
import '../models/user_progress.dart';

/// Widget que muestra un calendario de actividad mensual
/// Similar al gráfico de contribuciones de GitHub
/// Visualiza los días en que el usuario ha estudiado lecciones
class ActivityCalendar extends StatelessWidget {
  final List<UserProgress> userProgress;
  final DateTime? currentMonth;

  const ActivityCalendar({
    super.key,
    required this.userProgress,
    this.currentMonth,
  });

  @override
  Widget build(BuildContext context) {
    // Usar mes actual si no se proporciona
    final DateTime month = currentMonth ?? DateTime.now();
    
    // Calcular actividad por día
    Map<DateTime, int> activityByDay = _calculateActivityByDay();
    
    // Obtener días del mes actual
    List<DateTime> daysInMonth = _getDaysInMonth(month);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título del calendario
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  'Actividad de Estudio',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              _getMonthYearText(month),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            
            // Días de la semana
            _buildWeekdayHeaders(),
            const SizedBox(height: 8),
            
            // Calendario con días
            _buildCalendarGrid(daysInMonth, activityByDay, context),
            const SizedBox(height: 16),
            
            // Leyenda
            _buildLegend(),
            const SizedBox(height: 8),
            
            // Estadísticas del mes
            _buildMonthStats(activityByDay),
          ],
        ),
      ),
    );
  }

  /// Calcula la actividad (número de lecciones) por día
  Map<DateTime, int> _calculateActivityByDay() {
    Map<DateTime, int> activityByDay = {};
    
    for (var progress in userProgress) {
      DateTime date = DateTime(
        progress.completedAt.year,
        progress.completedAt.month,
        progress.completedAt.day,
      );
      
      activityByDay[date] = (activityByDay[date] ?? 0) + 1;
    }
    
    return activityByDay;
  }

  /// Obtiene todos los días del mes actual
  List<DateTime> _getDaysInMonth(DateTime month) {
    List<DateTime> days = [];
    DateTime firstDay = DateTime(month.year, month.month, 1);
    DateTime lastDay = DateTime(month.year, month.month + 1, 0);
    
    for (int i = 0; i < lastDay.day; i++) {
      days.add(firstDay.add(Duration(days: i)));
    }
    
    return days;
  }

  /// Construye los encabezados de días de la semana
  Widget _buildWeekdayHeaders() {
    const weekdays = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekdays.map((day) => SizedBox(
        width: 36,
        child: Center(
          child: Text(
            day,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ),
      )).toList(),
    );
  }

  /// Construye la cuadrícula del calendario
  Widget _buildCalendarGrid(
    List<DateTime> daysInMonth,
    Map<DateTime, int> activityByDay,
    BuildContext context,
  ) {
    // Calcular el día de la semana del primer día (1=Lunes, 7=Domingo)
    int firstWeekday = daysInMonth.first.weekday;
    
    // Crear lista con espacios vacíos al inicio
    List<Widget> calendarCells = [];
    
    // Agregar celdas vacías para alinear el primer día
    for (int i = 1; i < firstWeekday; i++) {
      calendarCells.add(_buildEmptyCell());
    }
    
    // Agregar días del mes
    for (var day in daysInMonth) {
      int activity = activityByDay[day] ?? 0;
      calendarCells.add(_buildDayCell(day, activity, context));
    }
    
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: calendarCells,
    );
  }

  /// Construye una celda vacía
  Widget _buildEmptyCell() {
    return const SizedBox(
      width: 36,
      height: 36,
    );
  }

  /// Construye una celda de día con indicador de actividad
  Widget _buildDayCell(DateTime day, int activity, BuildContext context) {
    bool isToday = _isToday(day);
    Color cellColor = _getActivityColor(activity, context);
    
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: cellColor,
        borderRadius: BorderRadius.circular(6),
        border: isToday ? Border.all(
          color: Theme.of(context).primaryColor,
          width: 2,
        ) : null,
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              '${day.day}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                color: activity > 0 ? Colors.white : Colors.grey[800],
              ),
            ),
          ),
          // Indicador de actividad
          if (activity > 0)
            Positioned(
              top: 2,
              right: 2,
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Obtiene el color según el nivel de actividad
  Color _getActivityColor(int activity, BuildContext context) {
    if (activity == 0) return Colors.grey[200]!;
    if (activity == 1) return Colors.green[200]!;
    if (activity == 2) return Colors.green[400]!;
    if (activity >= 3) return Colors.green[600]!;
    return Colors.grey[200]!;
  }

  /// Verifica si una fecha es hoy
  bool _isToday(DateTime date) {
    DateTime now = DateTime.now();
    return date.year == now.year &&
           date.month == now.month &&
           date.day == now.day;
  }

  /// Construye la leyenda del calendario
  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Menos',
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(width: 8),
        _buildLegendBox(Colors.grey[200]!),
        const SizedBox(width: 4),
        _buildLegendBox(Colors.green[200]!),
        const SizedBox(width: 4),
        _buildLegendBox(Colors.green[400]!),
        const SizedBox(width: 4),
        _buildLegendBox(Colors.green[600]!),
        const SizedBox(width: 8),
        Text(
          'Más',
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  /// Construye una caja de la leyenda
  Widget _buildLegendBox(Color color) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  /// Construye estadísticas del mes
  Widget _buildMonthStats(Map<DateTime, int> activityByDay) {
    // Calcular estadísticas
    int activeDays = activityByDay.values.where((count) => count > 0).length;
    int totalLessons = activityByDay.values.fold(0, (sum, count) => sum + count);
    int currentStreak = _calculateCurrentStreak(activityByDay);
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Días activos', '$activeDays', Icons.calendar_today),
          _buildStatItem('Lecciones', '$totalLessons', Icons.school),
          _buildStatItem('Racha', '$currentStreak días', Icons.local_fire_department),
        ],
      ),
    );
  }

  /// Construye un item de estadística
  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Colors.blue[700]),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue[700],
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  /// Calcula la racha actual de días consecutivos estudiando
  int _calculateCurrentStreak(Map<DateTime, int> activityByDay) {
    DateTime today = DateTime.now();
    DateTime checkDate = DateTime(today.year, today.month, today.day);
    int streak = 0;
    
    // Verificar días consecutivos hacia atrás desde hoy
    while (activityByDay.containsKey(checkDate) && activityByDay[checkDate]! > 0) {
      streak++;
      checkDate = checkDate.subtract(const Duration(days: 1));
    }
    
    return streak;
  }

  /// Obtiene el texto del mes y año
  String _getMonthYearText(DateTime date) {
    const months = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];
    
    return '${months[date.month - 1]} ${date.year}';
  }
}
