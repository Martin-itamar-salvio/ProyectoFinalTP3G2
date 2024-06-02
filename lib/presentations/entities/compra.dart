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
 
}