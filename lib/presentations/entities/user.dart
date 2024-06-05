import 'package:proyecto_final_grupo_6/presentations/entities/compra.dart';

class User {
  String nombre;
  String apellido;
  String username;
  String password;
  String rol;
  String? fotoPerfil;
  String email;
  List<Compra> historialCompras;
  String direccion;
  String telefono;

  User({
    required this.nombre,
    required this.apellido,
    required this.username,
    required this.password,
    required this.rol,
    this.fotoPerfil,
    required this.email,
    required this.historialCompras,
    required this.direccion,
    required this.telefono,
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
      'historialCompras': historialCompras.map((c) => c.toMap()).toList(),
      'direccion': direccion,
      'telefono': telefono,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      nombre: map['nombre'],
      apellido: map['apellido'],
      username: map['username'],
      password: map['password'],
      rol: map['rol'],
      fotoPerfil: map['fotoPerfil'],
      email: map['email'],
      historialCompras: (map['historialCompras'] as List<dynamic>)
          .map((item) => Compra.fromMap(item))
          .toList(),
      direccion: map['direccion'],
      telefono: map['telefono'],
    );
  }
}
