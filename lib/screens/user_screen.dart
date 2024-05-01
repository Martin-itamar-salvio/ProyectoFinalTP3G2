import 'package:flutter/material.dart';
import 'package:proyecto_final_grupo_6/entities/user.dart';

class UserDataScreen extends StatefulWidget {
  static const String name = "user_data";

  @override
  _UserDataScreenState createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración de Datos Personales'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            ElevatedButton(
              onPressed: () {
                // Guarda los datos personales y navega a la pantalla de menú
                UserData userData = UserData(
                  name: _nameController.text,
                  email: _emailController.text,
                );
                //Navigator.pushNamed(context, MenuScreen.name, arguments: userData);
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}