import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/user.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/exit.dart';
import 'package:proyecto_final_grupo_6/services/firebase_services.dart';

class RegistroScreen extends StatelessWidget {
  static const String name = "registro_screen";
  const RegistroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [Exit()],
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: _RegistroView(),
    );
  }
}

class _RegistroView extends StatefulWidget {
  @override
  State<_RegistroView> createState() => __RegistroViewState();
}

class __RegistroViewState extends State<_RegistroView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Registrarse",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: "Nombre",
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su nombre';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  hintText: "Apellido",
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su apellido';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  hintText: "Usuario",
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su usuario';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Contraseña",
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su contraseña';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Confirmar contraseña",
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor confirme su contraseña';
                  }
                  if (value != _passwordController.text) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: "Email",
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su email';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 247, 224, 20),
                    foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text(
                    "Volver",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    foregroundColor: const Color.fromARGB(255, 247, 224, 20),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final newUser = User(
                          nombre: _nameController.text,
                          apellido: _lastNameController.text,
                          username: _usernameController.text,
                          password: _passwordController.text,
                          rol: 'cliente',
                          fotoPerfil:
                              'https://firebasestorage.googleapis.com/v0/b/belligrau-e8c3a.appspot.com/o/perfil%20default.png?alt=media&token=44b0e6ca-bb58-4aa7-be36-e9edea117564',
                          email: _emailController.text,
                          historialCompras: [],
                          telefono: '',
                          direccion: '');

                      try {
                        await registerUser(newUser);
                        context.pop();
                      } catch (e) {
                        // Mostrar mensaje de error si la operación falla
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error al registrar usuario: $e')),
                        );
                      }
                    }
                  },
                  child: const Text(
                    "Registrarse",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ]
            ),            
          ],
        ),
      ),
    ));
  }
}
