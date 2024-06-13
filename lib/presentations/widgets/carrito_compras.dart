import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
// ignore: implementation_imports
import 'package:badges/src/badge.dart' as badge;
import 'package:go_router/go_router.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/carrito_screen.dart';

class CarritoCompras extends StatelessWidget {
  const CarritoCompras({super.key});

  @override
  Widget build(BuildContext context) {

    return Align(
      child: badge.Badge(
        position: BadgePosition.topEnd(),
        child: IconButton(
          onPressed: () {
            context.pushNamed(CarritoScreen.name);
          },
          icon: const Icon(Icons.shopping_cart),
        ),
      ),
    );
  }
}