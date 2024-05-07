import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final_grupo_6/core/data/cartera_datasource.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/cartera.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/user.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/cartera_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/app_bar.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/drawer_menu.dart';

class HomeScreen extends StatelessWidget {
  static const String name = "home_screen";
  final User usuario;

  const HomeScreen({required this.usuario, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: DrawerMenu(usuario: usuario),
      body: _MenuView(usuario: usuario),
    );
  }
}

class _MenuView extends StatelessWidget {
  final User usuario;
  const _MenuView({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _ProductGrid(
              products: carteras,
              usuario: usuario,
            ),
          ],
        ),
      ),
    );
  }
}

//Tocar aca para modificar la grilla
class _ProductGrid extends StatelessWidget {
  final List<Cartera> products;
  final User usuario;

  const _ProductGrid({super.key, required this.products, required this.usuario});

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
          return ProductCard(product: product, usuario: usuario);
        },
      ),
    );
  }
}

//Tocar aca para modificar las carteras
class ProductCard extends StatelessWidget {
  final Cartera product;
  final User usuario;

  const ProductCard({super.key, required this.product, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(CarteraScreen.name, extra: {"product": product, "usuario": usuario});
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
