import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../models/user_progress.dart';
import '../../services/auth_service.dart';
import '../../services/progress_service.dart';
import 'edit_profile_screen.dart';

/// Pantalla de perfil del usuario
/// Muestra información personal, estadísticas y opciones de configuración
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? _currentUser;
  List<UserProgress> _userProgress = [];
  ProgressStats? _stats;
  bool _isLoading = true;
  int _currentStreak = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  /// Carga los datos del usuario
  Future<void> _loadData() async {
    try {
      final authService = AuthService();
      final progressService = ProgressService();

      _currentUser = await authService.getCurrentUser();
      
      if (_currentUser != null) {
        _userProgress = await progressService.getUserProgress(_currentUser!.id);
        _stats = await progressService.getUserStats(_currentUser!.id);
        _currentStreak = _calculateCurrentStreak();
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error cargando datos: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Calcula la racha actual de días consecutivos
  int _calculateCurrentStreak() {
    if (_userProgress.isEmpty) return 0;
    
    Map<DateTime, int> activityByDay = {};
    for (var progress in _userProgress) {
      DateTime date = DateTime(
        progress.completedAt.year,
        progress.completedAt.month,
        progress.completedAt.day,
      );
      activityByDay[date] = (activityByDay[date] ?? 0) + 1;
    }

    DateTime today = DateTime.now();
    DateTime checkDate = DateTime(today.year, today.month, today.day);
    int streak = 0;
    
    while (activityByDay.containsKey(checkDate) && activityByDay[checkDate]! > 0) {
      streak++;
      checkDate = checkDate.subtract(const Duration(days: 1));
    }
    
    return streak;
  }

  /// Comparte el progreso del usuario
  void _shareProgress() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Compartir Progreso'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.share, size: 48, color: Theme.of(context).primaryColor),
            const SizedBox(height: 16),
            Text(
              '¡Mira mi progreso en Programming Tutor!',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              '🔥 Racha: $_currentStreak días\n'
              '📚 Lecciones: ${_stats?.totalLessons ?? 0}\n'
              '⭐ Puntos: ${_currentUser?.totalScore ?? 0}',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
          ElevatedButton(
            onPressed: () {
              // Aquí iría la lógica de compartir real
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('¡Progreso compartido!')),
              );
            },
            child: const Text('Compartir'),
          ),
        ],
      ),
    );
  }

  /// Muestra diálogo para agregar amigos
  void _addFriends() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Añadir Amigos'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.people, size: 48, color: Colors.blue),
            SizedBox(height: 16),
            Text(
              'Funcionalidad de amigos próximamente',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'Podrás conectar con otros estudiantes y comparar tu progreso',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }

  /// Muestra configuración del perfil
  void _showSettings() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Editar perfil'),
              onTap: () {
                Navigator.pop(context);
                _editProfile();
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notificaciones'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Configuración próximamente')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Idioma'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Ayuda'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Cerrar sesión', style: TextStyle(color: Colors.red)),
              onTap: () async {
                Navigator.pop(context);
                await AuthService().logout();
                if (mounted) {
                  Navigator.of(context).pushReplacementNamed('/login');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Editar perfil
  void _editProfile() async {
    if (_currentUser == null) return;
    
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(user: _currentUser!),
      ),
    );
    
    // Si hubo cambios, recargar datos
    if (result == true) {
      _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0F4F0),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black87),
            onPressed: _showSettings,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Sección de perfil
                  _buildProfileSection(),
                  
                  const SizedBox(height: 16),
                  
                  // Estadísticas
                  _buildStatsSection(),
                  
                  const SizedBox(height: 16),
                  
                  // Botón compartir
                  _buildShareButton(),
                  
                  const SizedBox(height: 16),
                  
                  // Sección de amigos
                  _buildFriendsSection(),
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
    );
  }

  /// Construye la sección del perfil
  Widget _buildProfileSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Avatar
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                _currentUser?.name.isNotEmpty == true 
                    ? _currentUser!.name[0].toUpperCase()
                    : 'U',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Nombre
          Text(
            _currentUser?.name ?? 'Estudiante',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          
          // Biografía
          Text(
            'Añadir biografía',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  /// Construye la sección de estadísticas
  Widget _buildStatsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Estadísticas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  Icons.local_fire_department,
                  '$_currentStreak',
                  'Racha diaria',
                  Colors.orange,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  Icons.stars,
                  '${_currentUser?.totalScore ?? 0}',
                  'XP total',
                  Colors.purple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Construye una tarjeta de estadística
  Widget _buildStatCard(IconData icon, String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 36,
            color: color,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Construye el botón de compartir
  Widget _buildShareButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _shareProgress,
        icon: const Icon(Icons.share),
        label: const Text('Compartir mi progreso'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1976D2),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  /// Construye la sección de amigos
  Widget _buildFriendsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Amigos',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Aún sin amigos/as',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          
          OutlinedButton.icon(
            onPressed: _addFriends,
            icon: const Icon(Icons.add),
            label: const Text('Añadir amigos'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF1976D2),
              side: const BorderSide(color: Color(0xFF1976D2)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            ),
          ),
        ],
      ),
    );
  }
}
