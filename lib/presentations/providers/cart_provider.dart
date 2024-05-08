
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final_grupo_6/core/carrito.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/cartera.dart';

final Provider<List<Cartera>> carritoProvider = Provider((ref) => carrito);

StateProvider<double> subTotalProvider = StateProvider<double>((ref) => subTotal);
