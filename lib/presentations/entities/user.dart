class User {
  String nombre;
  String apellido;
  String username;
  String password;
  String rol;
  String? fotoPerfil;
  String email;
  String? carroDeCompras;
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
    this.carroDeCompras,
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
      'carroDeCompras': carroDeCompras,
      'direccion': direccion,
      'telefono' : telefono,
    };
  }
}