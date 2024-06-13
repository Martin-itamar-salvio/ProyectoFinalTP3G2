import 'package:flutter/material.dart';

class MenuItem {
  final String titulo;
  final String subtitulo;
  final IconData icono;
  final String link;
  final String rol;
  final bool parametros;

  MenuItem({
    required this.titulo,
    required this.subtitulo,
    required this.icono,
    required this.link,
    required this.rol,
    required this.parametros,
  });
}
