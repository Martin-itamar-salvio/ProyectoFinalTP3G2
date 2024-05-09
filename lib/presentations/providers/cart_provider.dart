
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final_grupo_6/core/carrito.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/cartera.dart';

final StateNotifierProvider<CarritoStateNotifier, List<Cartera>> carritoProvider = StateNotifierProvider<CarritoStateNotifier, List<Cartera>>((ref) => CarritoStateNotifier(carrito));

class CarritoStateNotifier extends StateNotifier<List<Cartera>> {
  CarritoStateNotifier(state) : super(state ?? []);
  
  void eliminarProducto(String titulo) {
    state = state.where((p) => p.titulo != titulo).toList();
  }

  void sumarCantidadProducto(Cartera producto) {
    List<Cartera> carritoAux = [...state];
    for (var e in carritoAux) {
      if(e.titulo == producto.titulo){
        e.cantidad++;
      }
    }
    state = carritoAux;
  }

  void restarCantidadProducto(Cartera producto) {
    List<Cartera> carritoAux = [...state];
    for (var e in carritoAux) {
      if(e.titulo == producto.titulo && e.cantidad > 1){
        e.cantidad--;
      }
    }
    state = carritoAux;
  }
}

StateProvider<double> subTotalProvider = StateProvider<double>((ref) => subTotal);
