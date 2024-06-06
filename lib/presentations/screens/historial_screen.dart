import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/compra.dart';
import 'package:proyecto_final_grupo_6/presentations/providers/user_provider.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/app_bar.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/drawer_menu.dart';
import 'package:proyecto_final_grupo_6/services/firebase_services.dart';

class HistorialScreen extends ConsumerStatefulWidget {
  static const String name = "historial_screen";

  const HistorialScreen({super.key});

  @override
  _HistorialScreenState createState() => _HistorialScreenState();
}

class _HistorialScreenState extends ConsumerState<HistorialScreen> {
  late Future<List<Compra>> _futureCompras;

  @override
  void initState() {
    super.initState();
    final usuario = ref.read(userProvider);
    if (usuario != null) {
      _futureCompras = getComprasByUser(usuario);
    }
  }

  @override
  Widget build(BuildContext context) {
    final usuario = ref.watch(userProvider);

    if (usuario == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Inicio'),
        ),
        body: const Center(
          child: Text('No se ha iniciado sesión'),
        ),
      );
    }

    return Scaffold(
      appBar: MyAppBar(usuario: usuario),
      drawer: DrawerMenu(usuario: usuario),
      body: _HistorialView(futureCompras: _futureCompras),
    );
  }
}

class _HistorialView extends StatelessWidget {
  final Future<List<Compra>> futureCompras;

  const _HistorialView({required this.futureCompras});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Compra>>(
      future: futureCompras,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar el historial de compras'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay compras en el historial'));
        }

        final compras = snapshot.data!;

        return ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const Text(
              'Lista de compras',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...compras.map((compra) => CompraAccordion(compra: compra)).toList(),
          ],
        );
      },
    );
  }
}

class CompraAccordion extends StatelessWidget {
  final Compra compra;

  const CompraAccordion({required this.compra});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text('Compra ID: ${compra.id}'),
        children: [
          ListTile(
            title: Text('Dirección: ${compra.direccion}'),
          ),
          ListTile(
            title: Text('Código Postal: ${compra.codigoPostal}'),
          ),
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Lista de carteras:', style: TextStyle(fontWeight: FontWeight.bold)),
                ...compra.carteras.map((cartera) => Text(
                  '${cartera.nombre} - Cantidad: ${cartera.cantidad} - Precio: \$${cartera.precio}',
                )),
              ],
            ),
          ),
          ListTile(
            title: Text('Total: \$${compra.total}'),
          ),
        ],
      ),
    );
  }
}
