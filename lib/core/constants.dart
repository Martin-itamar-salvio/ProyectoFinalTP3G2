import 'package:flutter/material.dart';
import 'package:proyecto_final_grupo_6/core/menu/menu_item.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/user.dart';

const String appName = "BELLIGRAU";
const String roleDefault = "USUARIO";

final List<MenuItem> menuItems = [
  MenuItem(title: 'Inicio', subtitle: 'Inicio de Aplicacion', icon: Icons.home, link: '/inicio', role: "USUARIO", params: true),
  MenuItem(title: 'Perfil', subtitle: 'Perfil de Usuario', icon: Icons.person, link: '/perfil', role: "USUARIO", params: false),
  MenuItem(title: 'Favoritos', subtitle: 'Productos Favoritos', icon: Icons.favorite, link: '/favoritos', role: "USUARIO", params: false),
  MenuItem(title: 'Historial de Compras', subtitle: 'Historial de Compras', icon: Icons.history, link: '/historial', role: "CLIENTE", params: false),
  MenuItem(title: 'Historial de Ventas', subtitle: 'Historial de Ventas', icon: Icons.history, link: '/historial', role: "VENDEDOR", params: false),
  MenuItem(title: 'Publicar', subtitle: 'Publicar Producto / Renovar Stock', icon: Icons.plus_one, link: '/publicar', role: "VENDEDOR", params: false),
  MenuItem(title: 'Configuracion', subtitle: 'Configuracion de Aplicacion', icon: Icons.settings, link: '/config', role: "USUARIO", params: false),
];