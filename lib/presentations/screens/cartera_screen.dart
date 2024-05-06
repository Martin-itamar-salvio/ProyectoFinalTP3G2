import 'package:flutter/material.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/cartera.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/app_bar.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/drawer_menu.dart';

class CarteraScreen extends StatelessWidget {
  static const String name = "cartera_screen";

  final Cartera cartera;

  const CarteraScreen({super.key, required this.cartera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const DrawerMenu(),
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
            child: Image.network(
              cartera.poster,
              width: 300,
              height: 300,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(" ${cartera.titulo}"),
          Text("Precio: ${cartera.precio}"),
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