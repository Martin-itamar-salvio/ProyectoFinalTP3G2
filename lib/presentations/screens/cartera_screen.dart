import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/cartera.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/app_bar.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/drawer_menu.dart';
import 'package:proyecto_final_grupo_6/presentations/providers/user_provider.dart';
import 'package:proyecto_final_grupo_6/presentations/providers/cart_provider.dart';
import 'carrito_screen.dart';

class CarteraScreen extends ConsumerWidget {
  static const String name = "cartera_screen";
  final Cartera product;

  const CarteraScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usuario = ref.watch(userProvider);

    if (usuario == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cartera'),
        ),
        body: const Center(
          child: Text('No se ha iniciado sesión'),
        ),
      );
    }

    return Scaffold(
      appBar: MyAppBar(usuario: usuario),
      drawer: DrawerMenu(usuario: usuario),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20), // Margen superior para la imagen
            Padding(
              padding: const EdgeInsets.all(5),
              child: Center(
                child: ClipRRect(
                  child: Image.network(
                    product.imagen,
                    width: 300,
                    height: 300,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10), // Espacio entre imagen y título
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  const SizedBox(width: 10), // Espacio entre icono y título
                  Text(
                    product.nombre,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {
                      // Lógica para agregar a favoritos
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Precio: ${product.precio}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 99, 99, 99),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(carritoProvider.notifier).agregarProducto(product);
                    ref.read(subTotalProvider.notifier).state = calcularSubtotal(ref.watch(carritoProvider));
                    
                    context.pushNamed(
                      CarritoScreen.name,
                    );
                  },
                  child: const Text("Comprar"),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(carritoProvider.notifier).agregarProducto(product);
                    ref.read(subTotalProvider.notifier).state = calcularSubtotal(ref.watch(carritoProvider));

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Producto añadido al carrito"),
                      ),
                    );
                  },
                  child: const Text("Añadir al carrito"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              color: Colors.brown.shade200, // Fondo marrón claro
              padding: const EdgeInsets.all(20),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Descripción",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Texto personalizado de la descripción del producto...",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 60),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
