import 'package:proyecto_final_grupo_6/presentations/entities/compra.dart';

class Usuario {
  String nombre;
  String apellido;
  String nombreUsuario;
  String contrasenia;
  String rol;
  String? fotoPerfil;
  String email;
  List<Compra> historialCompras;
  String direccion;
  String telefono;

  Usuario({
    required this.nombre,
    required this.apellido,
    required this.nombreUsuario,
    required this.contrasenia,
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
      'nombreUsuario': nombreUsuario,
      'contrasenia': contrasenia,
      'rol': rol,
      'fotoPerfil': fotoPerfil,
      'email': email,
      'historialCompras': historialCompras.map((c) => c.toMap()).toList(),
      'direccion': direccion,
      'telefono': telefono,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      nombre: map['nombre'],
      apellido: map['apellido'],
      nombreUsuario: map['nombreUsuario'],
      contrasenia: map['contrasenia'],
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
