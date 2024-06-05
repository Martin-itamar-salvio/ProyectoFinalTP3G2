import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final_grupo_6/presentations/providers/user_provider.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/user.dart';

class PerfilScreen extends ConsumerWidget {
  static const String name = "perfil_screen";
  
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usuario = ref.watch(userProvider);

    if (usuario == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Perfil'),
        ),
        body: const Center(
          child: Text('No se ha iniciado sesión'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(usuario.fotoPerfil ?? ''),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Acción para cambiar la foto de perfil
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildEditableField(context, 'Nombre', usuario.nombre, (value) {
              usuario.nombre = value;
              _updateUser(context, ref, usuario);
            }),
            _buildEditableField(context, 'Apellido', usuario.apellido, (value) {
              usuario.apellido = value;
              _updateUser(context, ref, usuario);
            }),
            _buildEditableField(context, 'Nombre de usuario', usuario.username, null), // No editable

            _buildEditableField(context, 'Correo electrónico', usuario.email, (value) {
              usuario.email = value;
              _updateUser(context, ref, usuario);
            }),
            _buildEditableField(context, 'Dirección', usuario.direccion, (value) {
              usuario.direccion = value;
              _updateUser(context, ref, usuario);
            }),
            _buildEditableField(context, 'Teléfono', usuario.telefono, (value) {
              usuario.telefono = value;
              _updateUser(context, ref, usuario);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField(BuildContext context, String title, String value, Function(String)? onSave) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(value)),
              if (onSave != null)
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    final newValue = await _showEditDialog(context, title, value);
                    if (newValue != null) {
                      onSave(newValue);
                    }
                  },
                ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Future<String?> _showEditDialog(BuildContext context, String title, String currentValue) async {
    TextEditingController controller = TextEditingController(text: currentValue);

    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar $title'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Ingrese $title'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(controller.text);
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  Future<void> _updateUser(BuildContext context, WidgetRef ref, User updatedUser) async {
    try {
      await ref.read(userProvider.notifier).updateUser(updatedUser);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil actualizado')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar el perfil: $e')),
      );
    }
  }
}
