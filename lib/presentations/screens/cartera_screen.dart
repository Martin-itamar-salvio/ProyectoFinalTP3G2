import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/cartera.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/user.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/app_bar.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/drawer_menu.dart';

import 'compra_screen.dart';

class CarteraScreen extends StatelessWidget {
  static const String name = "cartera_screen";
  final Cartera cartera;
  final User usuario;

  const CarteraScreen({super.key, required this.cartera, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(usuario: usuario),
      drawer: DrawerMenu(usuario: usuario),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20), // Margen superior para la imagen
            Padding(
              //imagen
              padding: const EdgeInsets.all(5),
              child: Center(
                child: ClipRRect(
                  child: Image.asset(
                    cartera.poster,
                    width: 300,
                    height: 300,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10), // Espacio entre imagen y título
            Padding(
              //titulo
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  const SizedBox(width: 10), // Espacio entre icono y título
                  Text(
                    cartera.titulo,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 200,
                  ),
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
                  "Precio: ${cartera.precio}",
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
                    // Lógica para comprar
                    context.pushNamed(CompraScreen.name, extra: usuario);
                  },
                  child: const Text("Comprar"),
                ),
                ElevatedButton(
                  onPressed: () {
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
            const SizedBox(
              height: 20,
            ),
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

/*
      body: _CarteraScreenView(
        cartera: cartera,
      )
    );
  }
}

class _CarteraScreenView extends StatelessWidget {
  final Cartera cartera;
  const _CarteraScreenView({required this.cartera});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ClipRRect(
            child: Image.asset(
              cartera.poster,
              width: 300,
              height: 300,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(" ${cartera.titulo}"),
          Text("Precio: \$${cartera.precio.round()}"),
          Text("Cantida: ${cartera.cantidad}"),
          Text("Tipo de Cartera: ${cartera.tipo}"),
          ElevatedButton(
            onPressed: (
                //crear la pestaña de carga o recibo de compra
                ) {},
            child: const Text("Comprar"),
          )
        ],
      ),
    );
  }
}
*/