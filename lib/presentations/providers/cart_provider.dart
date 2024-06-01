import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/cartera.dart';

// Inicializa el carrito vacío
final carritoProvider = StateNotifierProvider<CarritoStateNotifier, List<Cartera>>((ref) => CarritoStateNotifier([]));

class CarritoStateNotifier extends StateNotifier<List<Cartera>> {
  CarritoStateNotifier(List<Cartera> state) : super(state);

  void agregarProducto(Cartera producto) {
    List<Cartera> carritoAux = [...state];
    bool encontrado = false;
    for (var e in carritoAux) {
      if (e.nombre == producto.nombre) {
        e.stock++;
        encontrado = true;
        break;
      }
    }
    if (!encontrado) {
      carritoAux.add(Cartera(nombre: producto.nombre, precio: producto.precio, imagen: producto.imagen, modelo: producto.modelo, stock: 1));
    }
    state = carritoAux;
  }

  void eliminarProducto(String nombre) {
    state = state.where((p) => p.nombre != nombre).toList();
  }

  void sumarCantidadProducto(Cartera producto) {
    state = state.map((p) => p.nombre == producto.nombre ? Cartera(nombre: p.nombre, precio: p.precio, imagen: p.imagen, modelo: p.modelo, stock: p.stock + 1) : p).toList();
  }

  void restarCantidadProducto(Cartera producto) {
    state = state.map((p) => p.nombre == producto.nombre && p.stock > 1 ? Cartera(nombre: p.nombre, precio: p.precio, imagen: p.imagen, modelo: p.modelo, stock: p.stock - 1) : p).toList();
  }
}

double calcularSubtotal(List<Cartera> carrito) {
  return carrito.fold(0, (total, producto) => total + producto.precio * producto.stock);
}

final subTotalProvider = StateProvider<double>((ref) {
  final carrito = ref.watch(carritoProvider);
  return calcularSubtotal(carrito);
});
