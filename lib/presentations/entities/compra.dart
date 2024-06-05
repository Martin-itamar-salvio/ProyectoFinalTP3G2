import 'package:proyecto_final_grupo_6/presentations/entities/cartera.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/user.dart';

class Compra {
  User usuario;
  String id;
  String direccion;
  String codigoPostal;
  double total;
  List<Cartera> carteras;

  Compra({
    required this.usuario,
    required this.id,
    required this.direccion,
    required this.codigoPostal,
    required this.total,
    required this.carteras,
  });

  Map<String, dynamic> toMap() {
    return {
      'usuario': usuario.toMap(),
      'id': id,
      'direccion': direccion,
      'codigoPostal': codigoPostal,
      'total': total,
      'carteras': carteras.map((c) => c.toMap()).toList(),
    };
  }

  factory Compra.fromMap(Map<String, dynamic> map) {
    return Compra(
      usuario: User.fromMap(map['usuario']),
      id: map['id'],
      direccion: map['direccion'],
      codigoPostal: map['codigoPostal'],
      total: map['total'],
      carteras: (map['carteras'] as List<dynamic>).map((c) => Cartera.fromMap(c)).toList(),
    );
  }
}
