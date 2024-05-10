import 'package:flutter/material.dart';

class ReciboScreen extends StatelessWidget {
  static const String name = "recibo";

  const ReciboScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
    //  appBar: MyAppBar(usuario: usuario),
    //  drawer: DrawerMenu(usuario: usuario),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: ReciboCard(),
        ),
      ),
    );
  }
}

class ReciboCard extends StatelessWidget {
  const ReciboCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Recibo de compra',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Nombre y Apellido del Usuario',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para aceptar el recibo
              },
              child: const Text('Aceptar'),
            ),
          ],
        ),
      ),
    );
  }
}
