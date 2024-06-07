import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/compra.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/user.dart';
import 'package:proyecto_final_grupo_6/presentations/providers/user_provider.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/app_bar.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/drawer_menu.dart';
import 'package:proyecto_final_grupo_6/services/firebase_services.dart';

class VentasScreen extends ConsumerWidget {
  static const String name = "ventas_screen";

  const VentasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usuario = ref.watch(userProvider);

    if (usuario == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Historial de Ventas'),
        ),
        body: const Center(
          child: Text('No se ha iniciado sesión'),
        ),
      );
    }

    return Scaffold(
      appBar: MyAppBar(usuario: usuario),
      drawer: DrawerMenu(usuario: usuario),
      body: _VentasView(usuario: usuario),
    );
  }
}

class _VentasView extends ConsumerWidget {
  final User usuario;
  const _VentasView({required this.usuario});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Lista de ventas',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<List<Compra>>(
              stream: fetchAllCompras(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No hay ventas disponibles'));
                } else {
                  List<Compra> compras = snapshot.data!;
                  return ListView.builder(
                    itemCount: compras.length,
                    itemBuilder: (context, index) {
                      final compra = compras[index];
                      return ExpansionTile(
                        title: Text('Venta ID: ${compra.id}'),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                Text('Usuario: ${compra.usuario.username}'),
                                const SizedBox(height: 5),
                                Text('Dirección: ${compra.direccion}'),
                                const SizedBox(height: 5),
                                Text('Código Postal: ${compra.codigoPostal}'),
                                const SizedBox(height: 5),
                                const Text('Lista de Carteras:'),
                                const SizedBox(height: 5),
                                ...compra.carteras.map((cartera) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                                    child: Text(
                                      '${cartera.nombre} - Cantidad: ${cartera.cantidad} - Precio: \$${cartera.precio}',
                                    ),
                                  );
                                }),
                                const SizedBox(height: 5),
                                Text('Total: \$${compra.total}'),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
