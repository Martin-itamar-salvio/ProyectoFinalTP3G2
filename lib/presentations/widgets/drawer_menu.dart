import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final_grupo_6/core/constants.dart';
import 'package:proyecto_final_grupo_6/core/menu/menu_item.dart'; // Asegúrate de importar MenuItem
import 'package:proyecto_final_grupo_6/presentations/providers/user_provider.dart';

class DrawerMenu extends ConsumerStatefulWidget {
  const DrawerMenu({super.key});

  @override
  ConsumerState<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends ConsumerState<DrawerMenu> {
  int selectedScreen = 0;

  @override
  Widget build(BuildContext context) {
    final usuario = ref.watch(userProvider);
    
    // Filtrar los elementos del menú según el rol del usuario
    final List<MenuItem> filteredMenuItems = menuItems.where((item) {
      return item.role == roleDefault || item.role == usuario?.rol;
    }).toList();

    return SafeArea(
      child: NavigationDrawer(
        selectedIndex: selectedScreen,
        onDestinationSelected: (value) {
          final menuItemsAux = filteredMenuItems;
          selectedScreen = value;
          setState(() {});
          if (menuItemsAux[value].params) {
            final Object? param = menuItemsAux[value].title == "Inicio" ? usuario : Object();
            context.push(menuItemsAux[value].link, extra: param);
          } else {
            context.push(menuItemsAux[value].link);
          }
        },
        children: [
          DrawerHeader(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 239, 255, 16),
            ),
            child: Column(
              children: [
                const Icon(Icons.person, size: 100),
                Text(
                  '${usuario?.apellido}, ${usuario?.nombre}',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          ...filteredMenuItems.map((item) => NavigationDrawerDestination(
            icon: Icon(item.icon),
            label: Text(item.title),
          )),
        ],
      ),
    );
  }
}
