import 'package:flutter/material.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/compra.dart';
import 'package:proyecto_final_grupo_6/presentations/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/home_screen.dart';

class ReciboScreen extends ConsumerWidget {
  static const String name = "recibo_screen";
  final Compra compra;

  const ReciboScreen({required this.compra, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usuario = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recibo de Compra'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Usuario: ${usuario!.username}', style: const TextStyle(fontSize: 18.0)),
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
              child: Text('${cartera.nombre} x${cartera.stock} - \$${cartera.precio * cartera.stock}', style: const TextStyle(fontSize: 16.0)),
            )).toList(),
            const Spacer(),
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
    );
  }
}
