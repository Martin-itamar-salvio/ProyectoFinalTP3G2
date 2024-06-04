import 'package:cloud_firestore/cloud_firestore.dart';

class Cartera {
  String nombre;
  double precio;
  String imagen;
  int stock;
  String modelo;
  String? descripcion;
  String? estado;

  Cartera({
    required this.nombre,
    required this.precio,
    required this.imagen,
    required this.stock,
    required this.modelo,
    this.descripcion,
    this.estado,
  });

  factory Cartera.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Cartera(
      nombre: data['nombre'] ?? '',
      precio: data['precio']?.toDouble() ?? 0.0,
      imagen: data['imagen'] ?? '',
      stock: data['stock'] ?? 0,
      modelo: data['modelo'] ?? '',
      descripcion: data['descripcion'] ?? '',
      
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'precio': precio,
      'imagen': imagen,
      'stock': stock,
      'modelo': modelo,
      'descripcion': descripcion,
    };
  }
}


