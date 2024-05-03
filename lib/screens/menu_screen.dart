import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final_grupo_6/core/constants.dart';
import 'package:proyecto_final_grupo_6/entities/cartera.dart';
import 'package:proyecto_final_grupo_6/screens/cartera_screen.dart';

class MenuScreen extends StatelessWidget {
  static const String name = "menu_screen";
  final String fullName;

  const MenuScreen({required this.fullName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _MenuView(fullName: fullName),
    );
  }
}

class _MenuView extends StatelessWidget {
  final String fullName;
  const _MenuView({required this.fullName});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(appName),
          /*  actions: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // Implementa la lógica para abrir/cerrar el menú
              },
              ),
            ],*/
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ProductGrid(
                products: Cartera.carteras,
              ), //Super metodo de grid
              // Aquí puedes agregar otros elementos de la pantalla
              // como la lista de productos, por ejemplo
            ],
          ),
        ),
        drawer: Drawer(
          width: 180,
          // Contenido del menú desplegable
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 239, 255, 16),
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage('https://imgs.search.brave.com/iUabDJIyP6xS6dHnqUao3W0RVVaVmwu2k8pB2ZHfNb4/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL0kv/NTFJK1NxTlZsakwu/anBn'), // Cambia por la ruta de tu imagen de perfil
                        // O usa una imagen de red: backgroundImage: NetworkImage('URL_DE_LA_IMAGEN'),
                    ),
                    Text(
                      fullName,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: const Text("Inicio"),
                onTap: () {
                  // Navegar a la pantalla 1
                },
              ),
              ListTile(
                title: const Text("Perfil"),
                onTap: () {
                  // Navegar a la pantalla 1
                },
              ),
              ListTile(
                title: const Text("Favoritos"),
                onTap: () {
                  // Navegar a la pantalla 1
                },
              ),
              ListTile(
                title: const Text("Historial"),
                onTap: () {
                  // Navegar a la pantalla 1
                },
              ),
              ListTile(
                title: const Text("Configuracion"),
                onTap: () {
                  // Navegar a la pantalla 1
                },
              ),
              // Agrega más ListTile según sea necesario para más opciones
            ],
          ),
        ),
      )
    );
  }
}

//Tocar aca para modificar la grilla
class ProductGrid extends StatelessWidget {
  final List<Cartera> products;

  const ProductGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //definir columnas
          crossAxisSpacing: 10, //margin y
          mainAxisSpacing: 10, //margin x
        ),
        itemBuilder: (context, index) {
          //crea los item dentro de la grilla
          final product = products[index];
          return ProductCard(product: product);
        },
      ),
    );
  }
}

//Tocar aca para modificar las carteras
class ProductCard extends StatelessWidget {
  final Cartera product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(CarteraScreen.name, extra: product);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                product.poster,
                width: double.infinity,
                fit: BoxFit.cover,
                height: 110,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.titulo,
                    style: const TextStyle(
                        fontSize: 12, color: Color.fromARGB(255, 61, 61, 61)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "\$${product.precio}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
