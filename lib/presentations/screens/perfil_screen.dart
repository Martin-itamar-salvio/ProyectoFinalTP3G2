import 'package:flutter/material.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/user.dart'; // Asegúrate de importar la clase User si aún no lo has hecho

class PerfilScreen extends StatelessWidget {
  static const String name = "perfil_screen";
  final User usuario;

  // ignore: use_super_parameters
  const PerfilScreen({Key? key, required this.usuario}) : super(key: key);

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
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(''),
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
            _buildEditableField('Correo electrónico', 'ejemplo@correo.com'),
            _buildEditableField('Dirección', 'Calle Principal 123'),
            _buildEditableField('Teléfono', '123456789'),
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
