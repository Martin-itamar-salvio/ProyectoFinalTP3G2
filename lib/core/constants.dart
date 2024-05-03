import 'package:flutter/material.dart';
import 'package:proyecto_final_grupo_6/core/menu/menu_item.dart';

const String appName = "BELLIGRAU";

final List<MenuItem> menuItems = [
  MenuItem(title: 'Inicio', subtitle: 'Inicio de Aplicacion', icon: Icons.home, link: '/'),
  MenuItem(title: 'Perfil', subtitle: 'Perfil de Usuario', icon: Icons.person, link: '/perfil'),
  MenuItem(title: 'Favoritos', subtitle: 'Productos Favoritos', icon: Icons.favorite, link: '/favoritos'),
  MenuItem(title: 'Historial', subtitle: 'Historial de Compras/Ventas', icon: Icons.history, link: '/historial'),
  MenuItem(title: 'Configuracion', subtitle: 'Configuracion de Aplicacion', icon: Icons.settings, link: '/config'),
];