import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/cartera.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/user.dart';
import 'package:proyecto_final_grupo_6/presentations/providers/user_provider.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/home_screen.dart';

class ReciboScreen extends ConsumerWidget {
  static const String name = "recibo_screen";
  final Cartera product;
  final String tarjeta;
  final String codigo;
  final String titular;
  final String email;
  final String pais;
  final String codigoPostal;
  final String direccion;

  const ReciboScreen({
    super.key,
    required this.product,
    required this.tarjeta,
    required this.codigo,
    required this.titular,
    required this.email,
    required this.pais,
    required this.codigoPostal,
    required this.direccion,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usuario = ref.watch(userProvider);

    if (usuario == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Recibo de compra'),
        ),
        body: const Center(
          child: Text('No se ha iniciado sesión'),
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ReciboCard(
            usuario: usuario,
            product: product,
            tarjeta: tarjeta,
            codigo: codigo,
            titular: titular,
            email: email,
            pais: pais,
            codigoPostal: codigoPostal,
            direccion: direccion,
          ),
        ),
      ),
    );
  }
}

class ReciboCard extends StatelessWidget {
  final User usuario;
  final Cartera product;
  final String tarjeta;
  final String codigo;
  final String titular;
  final String email;
  final String pais;
  final String codigoPostal;
  final String direccion;

  const ReciboCard({
    super.key,
    required this.usuario,
    required this.product,
    required this.tarjeta,
    required this.codigo,
    required this.titular,
    required this.email,
    required this.pais,
    required this.codigoPostal,
    required this.direccion,
  });

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
            Text(
              'Usuario: ${usuario.nombre} ${usuario.apellido}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Producto: ${product.nombre}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Precio: ${product.precio}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Número de tarjeta: $tarjeta',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Código verificador: $codigo',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Nombre del titular: $titular',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Email: $email',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'País: $pais',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Código postal: $codigoPostal',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Dirección: $direccion',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.goNamed(HomeScreen.name, extra: usuario);
              },
              child: const Text('Aceptar'),
            ),
          ],
        ),
      ),
    );
  }
}
