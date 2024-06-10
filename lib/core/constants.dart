import 'package:flutter/material.dart';
import 'package:proyecto_final_grupo_6/core/menu/menu_item.dart';

const String appName = "BELLIGRAU";
const String roleDefault = "all";

//validar el rol del usuario
final List<MenuItem> menuItems = [
  MenuItem(title: 'Inicio', subtitle: 'Inicio de Aplicacion', icon: Icons.home, link: '/inicio', role: "all", params: true),
  MenuItem(title: 'Perfil', subtitle: 'Perfil de Usuario', icon: Icons.person, link: '/perfil', role: "all", params: false),
  MenuItem(title: 'Historial de Compras', subtitle: 'Historial de Compras', icon: Icons.history, link: '/historial', role: "cliente", params: false),
  MenuItem(title: 'Gestion', subtitle: 'Gestion de Tienda', icon: Icons.content_paste_sharp, link: '/gestion', role: "admin", params: false),
  MenuItem(title: 'Historial de Ventas', subtitle: 'Historial de Ventas', icon: Icons.content_paste_search_sharp, link: '/ventas', role: "admin", params: false),
  MenuItem(title: 'Cerrar Sesion', subtitle: 'Cerrar de Sesion', icon: Icons.logout, link: '/', role: "all", params: false),
];