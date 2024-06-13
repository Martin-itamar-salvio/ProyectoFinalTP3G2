import 'package:flutter/material.dart';
import 'package:proyecto_final_grupo_6/core/menu/menu_item.dart';

const String appName = "BELLIGRAU";
const String roleDefault = "todos";

//Items de menu limitados por el rol
final List<MenuItem> menuItems = [
  MenuItem(titulo: 'Inicio', subtitulo: 'Inicio de Aplicacion', icono: Icons.home, link: '/inicio', rol: "todos", parametros: true),
  MenuItem(titulo: 'Perfil', subtitulo: 'Perfil de Usuario', icono: Icons.person, link: '/perfil', rol: "todos", parametros: false),
  MenuItem(titulo: 'Historial de Compras', subtitulo: 'Historial de Compras', icono: Icons.history, link: '/historial', rol: "todos", parametros: false),
  MenuItem(titulo: 'Gestion', subtitulo: 'Gestion de Tienda', icono: Icons.content_paste_sharp, link: '/gestion', rol: "admin", parametros: false),
  MenuItem(titulo: 'Historial de Ventas', subtitulo: 'Historial de Ventas', icono: Icons.content_paste_search_sharp, link: '/ventas', rol: "admin", parametros: false),
  MenuItem(titulo: 'Cerrar Sesion', subtitulo: 'Cerrar de Sesion', icono: Icons.logout, link: '/', rol: "todos", parametros: false),
];