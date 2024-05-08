import 'package:flutter/material.dart';
import 'package:proyecto_final_grupo_6/core/constants.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/user.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/shopping_cart.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final User usuario;
  const MyAppBar({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(appName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 239, 255, 16),
      actions: [
        ShoppingCart(usuario: usuario)
      ],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}