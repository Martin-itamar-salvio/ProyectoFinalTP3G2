import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final_grupo_6/core/constants.dart';
import 'package:proyecto_final_grupo_6/core/data/user_datasource.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/user.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/home_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/registro_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/exit.dart';

class LoginScreen extends StatelessWidget {
  static const String name = "login_screen";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Exit()
        ],
        centerTitle: true,
        automaticallyImplyLeading: false
      ),
      body: _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  User? _validateUser(String username, String password) {
    User? usuario;
    bool isValid = false;
    int i = 0;

    while (!isValid && i < users.length) {
      isValid = username == users[i].username && password == users[i].password;
      if(isValid) usuario = users[i];
      i += 1;
    }

    return usuario;
  }

  @override
  Widget build(BuildContext context) {
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
              color: Colors.grey
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                  hintText: "Usuario",
                  fillColor: Color.fromARGB(255, 255, 255, 255), // este permite cambiar el color del fondo
                  filled:
                      true //este es el que permite que el fondo sea o no del color
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
                  fillColor: Color.fromARGB(255, 255, 255,
                      255), // este permite cambiar el color del fondo
                  filled:
                      true //este es el que permite que el fondo sea o no del color
                  ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 247, 224, 20),
                  foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                ),
                onPressed: () {
                  User? usuario = _validateUser(_usernameController.text,_passwordController.text);
                  if(usuario != null){
                    //context.pushNamed(HomeScreen.name, extra: fullName);
                    //context.pushNamed(HomeScreen.name);
                    context.pushNamed(HomeScreen.name, extra: usuario);
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Error al iniciar sesión. Usuario o contraseña incorrectos.'),
                        backgroundColor: Colors.red,
                      )
                    );
                  }
                },
                child: const Text(
                  "Entrar",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
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
              )
            ],
          )
        ],
      ),
    );
  }
}
