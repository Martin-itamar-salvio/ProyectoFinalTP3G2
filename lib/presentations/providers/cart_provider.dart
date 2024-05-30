
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final_grupo_6/core/carrito.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/cartera.dart';
//logica
final StateNotifierProvider<CarritoStateNotifier, List<Cartera>> carritoProvider = StateNotifierProvider<CarritoStateNotifier, List<Cartera>>((ref) => CarritoStateNotifier(carrito));

class CarritoStateNotifier extends StateNotifier<List<Cartera>> {
  CarritoStateNotifier(state) : super(state ?? []);
  
  void eliminarProducto(String titulo) {
    state = state.where((p) => p.nombre != titulo).toList();
  }

  void sumarCantidadProducto(Cartera producto) {
    List<Cartera> carritoAux = [...state];
    for (var e in carritoAux) {
      if(e.nombre == producto.nombre){
        e.stock++;
      }
    }
    state = carritoAux;
  }

  void restarCantidadProducto(Cartera producto) {
    List<Cartera> carritoAux = [...state];
    for (var e in carritoAux) {
      if(e.nombre == producto.nombre && e.stock > 1){
        e.stock--;
      }
    }
    state = carritoAux;
  }
}

StateProvider<double> subTotalProvider = StateProvider<double>((ref) => subTotal);
