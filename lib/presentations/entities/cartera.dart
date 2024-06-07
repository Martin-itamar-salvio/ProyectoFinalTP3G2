class Cartera {
  String nombre;
  double precio;
  String imagen;
  int cantidad;
  String modelo;
  String? descripcion;
  String? estado;
  int stock;

  Cartera({
    required this.nombre,
    required this.precio,
    required this.imagen,
    required this.cantidad,
    required this.modelo,
    this.descripcion,
    this.estado,
    required this.stock,
  });

  factory Cartera.fromMap(Map<String, dynamic> map) {
    return Cartera(
      nombre: map['nombre'] ?? '',
      precio: map['precio']?.toDouble() ?? 0.0,
      imagen: map['imagen'] ?? '',
      cantidad: map['cantidad'] ?? 0,
      modelo: map['modelo'] ?? '',
      descripcion: map['descripcion'],
      estado: map['estado'],
      stock: map['stock'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'precio': precio,
      'imagen': imagen,
      'cantidad': cantidad,
      'modelo': modelo,
      'descripcion': descripcion,
      'estado': estado,
      'stock' : stock,
    };
  }
}
