import 'package:flutter/material.dart';
import 'package:proyecto_final_grupo_6/core/constants.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(appName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 239, 255, 16),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}