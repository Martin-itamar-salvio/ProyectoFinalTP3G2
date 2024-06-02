import 'package:proyecto_final_grupo_6/presentations/entities/compra.dart';

class User {
  String nombre;
  String apellido;
  String username;
  String password;
  String rol;
  String? fotoPerfil;
  String email;
  List<Compra>? historialCompras;
  String? direccion;
  String? telefono;

  User({
    required this.nombre,
    required this.apellido,
    required this.username,
    required this.password,
    required this.rol,
    this.fotoPerfil,
    required this.email,
    this.historialCompras,
    this.direccion,
    this.telefono,
  });

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'apellido': apellido,
      'username': username,
      'password': password,
      'rol': rol,
      'fotoPerfil': fotoPerfil,
      'email': email,
      'carroDeCompras': historialCompras,
      'direccion': direccion,
      'telefono' : telefono,
    };
  }
}