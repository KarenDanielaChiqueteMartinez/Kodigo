import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../services/auth_service.dart';
import '../../widgets/custom_text_field.dart';

/// Pantalla de edición de perfil
/// Permite al usuario editar su nombre, biografía y ver su email
class EditProfileScreen extends StatefulWidget {
  final User user;

  const EditProfileScreen({
    super.key,
    required this.user,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.name;
    // Aquí cargaríamos la bio si la tuviéramos en el modelo
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  /// Guarda los cambios del perfil
  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final authService = AuthService();
      
      // Actualizar usuario con nuevo nombre
      User updatedUser = widget.user.copyWith(
        name: _nameController.text.trim(),
      );

      bool success = await authService.updateCurrentUser(updatedUser);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Perfil actualizado correctamente'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true); // Retornar true para indicar cambios
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al actualizar el perfil'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      appBar: AppBar(
        title: const Text('Ajustes'),
        backgroundColor: const Color(0xFFE8F5E9),
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Avatar con botón de edición
                _buildAvatarSection(),
                
                const SizedBox(height: 24),
                
                // Formulario de edición
                _buildEditForm(),
                
                const SizedBox(height: 24),
                
                // Sección de ajustes de la app
                _buildAppSettingsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Construye la sección del avatar
  Widget _buildAvatarSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              // Avatar
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFF81C784).withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: const Color(0xFF66BB6A),
                  ),
                ),
              ),
              // Botón de editar
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7E57C2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.edit,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Construye el formulario de edición
  Widget _buildEditForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Campo de nombre
          Text(
            'Tu nombre',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Tu nombre',
              filled: true,
              fillColor: const Color(0xFFE8F5E9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu nombre';
              }
              return null;
            },
          ),
          
          const SizedBox(height: 20),
          
          // Campo de biografía
          Text(
            'Sobre ti',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _bioController,
            decoration: InputDecoration(
              hintText: 'Cuéntanos algo sobre ti',
              filled: true,
              fillColor: const Color(0xFFE8F5E9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              suffixIcon: const Icon(Icons.chevron_right),
            ),
            maxLines: 1,
          ),
          
          const SizedBox(height: 20),
          
          // Campo de email (solo lectura)
          Text(
            'Email',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: widget.user.email,
            enabled: false,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFE8F5E9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              suffixIcon: const Icon(Icons.lock, size: 20),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Botón de guardar
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _saveChanges,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'Guardar cambios',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  /// Construye la sección de ajustes de la app
  Widget _buildAppSettingsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ajustes De La App',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Idioma de la app
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(
              Icons.language,
              color: Color(0xFF7E57C2),
            ),
            title: const Text('Idioma de la App'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Español',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Selección de idioma próximamente'),
                ),
              );
            },
          ),
          
          const Divider(),
          
          // Apariencia
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(
              Icons.palette_outlined,
              color: Color(0xFF7E57C2),
            ),
            title: const Text('Apariencia'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cambio de tema próximamente'),
                ),
              );
            },
          ),
          
          const Divider(),
          
          // Efectos de sonido
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(
              Icons.volume_up_outlined,
              color: Color(0xFF7E57C2),
            ),
            title: const Text('Efectos de sonido'),
            trailing: Switch(
              value: true,
              onChanged: (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(value ? 'Sonidos activados' : 'Sonidos desactivados'),
                  ),
                );
              },
              activeColor: const Color(0xFF7E57C2),
            ),
          ),
        ],
      ),
    );
  }
}
