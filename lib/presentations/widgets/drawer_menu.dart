import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final_grupo_6/core/constants.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/user.dart';

class DrawerMenu extends StatefulWidget {
  final User usuario;
  const DrawerMenu({required this.usuario, super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  int selectedScreen = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NavigationDrawer(
        selectedIndex: selectedScreen,
        onDestinationSelected: (value) {
          selectedScreen = value;
          setState(() { });
          if(menuItems[value].params){
            Object param = menuItems[value].title == "Inicio" ? widget.usuario
                            : Object();
            context.push(menuItems[value].link, extra: param);
          }else{
            context.push(menuItems[value].link);
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
                /*
                const CircleAvatar(
                  child: const Icon(Icons.person),
                  radius: 50,
                  backgroundImage: NetworkImage('https://imgs.search.brave.com/iUabDJIyP6xS6dHnqUao3W0RVVaVmwu2k8pB2ZHfNb4/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL0kv/NTFJK1NxTlZsakwu/anBn'), // Cambia por la ruta de tu imagen de perfil
                  // O usa una imagen de red: backgroundImage: NetworkImage('URL_DE_LA_IMAGEN'),
                ),*/
                const Icon(Icons.person, size: 100),
                Text(
                  '${widget.usuario.apellido}, ${widget.usuario.nombre}',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          ...menuItems.where((e) => e.role == roleDefault || e.role == widget.usuario.role).map((item) => NavigationDrawerDestination(
            icon: Icon(item.icon),
            label: Text(item.title)
          )),
        ],
      )
    );
  }
}