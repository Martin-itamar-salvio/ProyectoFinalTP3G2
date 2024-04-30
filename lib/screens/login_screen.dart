import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final_grupo_6/data/user_datasource.dart';
import 'package:proyecto_final_grupo_6/screens/menu_screen.dart';
import 'package:proyecto_final_grupo_6/screens/registro_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String name = "login";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();



  String _validateUser(String username, String password) {
    String fullName = '';
    bool isValid = false;
    int i = 0;

    while (!isValid && i < users.length) {
      isValid = username == users[i].username && password == users[i].password;
      if(isValid) fullName = '${users[i].nombre}, ${users[i].apellido}';
      i += 1;
    }

    return fullName;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Ingresa aqui",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                  hintText: "Usuario",
                  fillColor: Color.fromARGB(255, 255, 255,
                      255), // este permite cambiar el color del fondo
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
                  String fullName = _validateUser(_usernameController.text,_passwordController.text);
                  if(fullName != ''){
                    context.pushNamed(MenuScreen.name, extra: fullName);
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
                  // Validar usuario y contraseña
                  //final String enteredUsername = _usernameController.text;
                  //final String enteredPassword = _passwordController.text;

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
