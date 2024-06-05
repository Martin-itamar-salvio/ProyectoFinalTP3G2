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

  factory Cartera.fromMap(Map<String, dynamic> map) {
    return Cartera(
      nombre: map['nombre'] ?? '',
      precio: map['precio']?.toDouble() ?? 0.0,
      imagen: map['imagen'] ?? '',
      stock: map['stock'] ?? 0,
      modelo: map['modelo'] ?? '',
      descripcion: map['descripcion'],
      estado: map['estado'],
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
      'estado': estado,
    };
  }
}
