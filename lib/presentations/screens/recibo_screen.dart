import 'package:flutter/material.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/compra.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/home_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/app_bar.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/drawer_menu.dart';

class ReciboScreen extends StatelessWidget {
  static const String name = "recibo_screen";
  final Compra compra;

  const ReciboScreen({required this.compra, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const DrawerMenu(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Usuario: ${compra.usuario.nombreUsuario}', style: const TextStyle(fontSize: 18.0)),
                  const SizedBox(height: 10),
                  Text('ID Compra: ${compra.id}', style: const TextStyle(fontSize: 18.0)),
                  const SizedBox(height: 10),
                  Text('Dirección: ${compra.direccion}', style: const TextStyle(fontSize: 18.0)),
                  const SizedBox(height: 10),
                  Text('Código Postal: ${compra.codigoPostal}', style: const TextStyle(fontSize: 18.0)),
                  const SizedBox(height: 10),
                  Text('Total: \$${compra.total}', style: const TextStyle(fontSize: 18.0)),
                  const SizedBox(height: 20),
                  const Text('Artículos comprados:', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                  ...compra.carteras.map((cartera) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text('${cartera.nombre} x${cartera.cantidad} - \$${cartera.precio * cartera.cantidad}', style: const TextStyle(fontSize: 16.0)),
                  )),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        context.pushNamed(HomeScreen.name);
                      },
                      child: const Text('Aceptar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
