import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class RegistroScreen extends StatelessWidget {
  static const String name = "registro";
  const RegistroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _RegistroView(),
    );
  }
}

class _RegistroView extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Registracion",
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  hintText: "Confirmar contraseña",
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
                  hintText: "Email",
                  fillColor: Color.fromARGB(255, 255, 255,
                      255), // este permite cambiar el color del fondo
                  filled:
                      true //este es el que permite que el fondo sea o no del color
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 5),
            child: Row(
              children: [
                Checkbox(
                  value:
                      false, // El valor inicial del Checkbox, puedes cambiarlo según sea necesario
                  onChanged: (value) {
                    // Aquí puedes manejar el cambio en el estado del Checkbox
                    // Por ejemplo, puedes guardar el estado en una variable
                  },
                ),
                const Text(
                  "No soy un robot",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              foregroundColor: const Color.fromARGB(255, 247, 224, 20),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            ),
            onPressed: () {
              // Validar usuario y contraseña
              //final String enteredUsername = _usernameController.text;
              //final String enteredPassword = _passwordController.text;

              context.pop();
            },
            child: const Text(
              "Registrarse",
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
