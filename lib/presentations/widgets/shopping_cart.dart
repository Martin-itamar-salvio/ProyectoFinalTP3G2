import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
// ignore: implementation_imports
import 'package:badges/src/badge.dart' as badge;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final_grupo_6/presentations/providers/user_provider.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/carrito_screen.dart';

class ShoppingCart extends ConsumerWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usuario = ref.watch(userProvider);

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