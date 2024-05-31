import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final_grupo_6/core/constants.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/home_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/registro_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/exit.dart';
import 'package:proyecto_final_grupo_6/services/firebase_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final_grupo_6/presentations/providers/user_provider.dart';

class LoginScreen extends ConsumerWidget {
  static const String name = "login_screen";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: const [Exit()],
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: _LoginView(),
    );
  }
}

class _LoginView extends ConsumerWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context, WidgetRef ref) async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final usuario = await getUser(username, password);
    if (usuario != null) {
      ref.read(userProvider.notifier).state = usuario;
      context.pushNamed(HomeScreen.name);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al iniciar sesión. Usuario o contraseña incorrectos.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "¡Bienvenido a $appName!",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Ingrese Aqui",
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                hintText: "Usuario",
                fillColor: Color.fromARGB(255, 255, 255, 255),
                filled: true,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Contraseña",
                fillColor: Color.fromARGB(255, 255, 255, 255),
                filled: true,
              ),
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
                onPressed: () => _login(context, ref),
                child: const Text(
                  "Entrar",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  foregroundColor: const Color.fromARGB(255, 247, 232, 21),
                ),
                onPressed: () {
                  context.pushNamed(RegistroScreen.name);
                },
                child: const Text(
                  "Registrarse",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
