import 'package:flutter/material.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/cartera.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/user.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/app_bar.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/drawer_menu.dart';

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
