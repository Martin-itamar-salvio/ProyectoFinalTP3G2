import 'package:flutter/material.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/user.dart';

class PerfilScreen extends StatelessWidget {
  static const String name = "perfil_screen";
  final User usuario;

  const PerfilScreen({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
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
            _buildEditableField('Nombre', usuario.nombre),
            _buildEditableField('Apellido', usuario.apellido),
            _buildEditableField('Nombre de usuario', usuario.username),
            _buildEditableField('Rol', usuario.rol),
            _buildEditableField('Correo electrónico', usuario.email),
            _buildEditableField('Dirección', usuario.direccion ?? 'No disponible'),
            _buildEditableField('Teléfono', usuario.telefono ?? 'No disponible'),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField(String title, String value) {
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
              Text(value),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Acción para editar el campo
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
