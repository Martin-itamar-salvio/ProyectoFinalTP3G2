import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
// ignore: implementation_imports
import 'package:badges/src/badge.dart' as badge;
import 'package:go_router/go_router.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/user.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/carrito_screen.dart';

class ShoppingCart extends StatelessWidget {
  final User usuario;
  const ShoppingCart({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: badge.Badge(
        position: BadgePosition.topEnd(),
        child: IconButton(
          onPressed: () {
            context.pushNamed(CarritoScreen.name, extra: usuario);
          },
          icon: const Icon(Icons.shopping_cart),
        ),
      ),
    );
  }
}