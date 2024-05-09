import 'package:flutter/material.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/app_bar.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/drawer_menu.dart';

class ReciboScreen extends StatelessWidget {
  static const String name = "recibo";

  const ReciboScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: DrawerMenu(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ReciboCard(),
        ),
      ),
    );
  }
}

class ReciboCard extends StatelessWidget {
  const ReciboCard();

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
