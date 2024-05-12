import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/cartera.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/user.dart';
import 'package:proyecto_final_grupo_6/presentations/providers/cart_provider.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/app_bar.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/drawer_menu.dart';

class CarritoScreen extends ConsumerWidget {
  static const String name = "carrito_screen";
  final User usuario;
  const CarritoScreen({super.key, required this.usuario});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: MyAppBar(usuario: usuario),
      drawer: DrawerMenu(usuario: usuario),
      body: const _CarritoView()
    );
  }
}

class _CarritoView extends ConsumerWidget {
  const _CarritoView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Cartera> carritoProv = ref.watch(carritoProvider);
    final double subTotal = ref.watch(subTotalProvider);

    if(carritoProv.isEmpty){
      return const Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                'El carrito esta vacio',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              )
            )
          )
        ],
      );
    }else{
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: carritoProv.length,
              itemBuilder: (context, index) {
                final Cartera producto = carritoProv[index];
                return _ProductView(producto: producto);
              }
            )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Wrap(
              children: [
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Sub-Total:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$$subTotal',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: (){
                    context.pop();
                  },
                  child: Container(
                    color: Colors.yellow.shade300,
                    alignment: Alignment.center,
                    height: 50.0,
                    child: const Text(
                      'Volver',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ),
                TextButton(
                  onPressed: (){},
                  child: Container(
                    color: Colors.yellow.shade300,
                    alignment: Alignment.center,
                    height: 50.0,
                    child: const Text(
                      'Pagar',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                )
              ],
            )
          )
        ]
      );
    }
  }
}

class _ProductView extends ConsumerWidget {
  final Cartera producto;
  const _ProductView({required this.producto});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: Colors.yellow.shade300,
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(producto.poster, width: 70, height: 70),
            SizedBox(
              width: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5.0,
                  ),
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    text: TextSpan(
                      text: '${producto.titulo}\n',
                      style: const TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    text: TextSpan(
                      text: '${producto.tipo}\n',
                      style: const TextStyle(color: Colors.black, fontSize: 16.0),
                    ),
                  ),
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    text: TextSpan(
                      text: '\$${producto.precio.round()}\n',
                      style: const TextStyle(color: Colors.black, fontSize: 16.0),
                    ),
                  ),
                ],
              )
            ),
            _CantidadBotonesView(producto: producto)
          ],
        ),
      ),
    );
  }
}

class _CantidadBotonesView extends ConsumerWidget {
  final Cartera producto;
  const _CantidadBotonesView({required this.producto});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            ref.read(carritoProvider.notifier).restarCantidadProducto(producto);
            ref.read(subTotalProvider.notifier).state = calcularSubtotal(ref.watch(carritoProvider));
          },
          icon: const Icon(Icons.remove)
        ),
        Text('${producto.cantidad}'),
        IconButton(
          onPressed: () {
            ref.read(carritoProvider.notifier).sumarCantidadProducto(producto);
            ref.read(subTotalProvider.notifier).state = calcularSubtotal(ref.watch(carritoProvider));
          },
          icon: const Icon(Icons.add)
        ),
        IconButton(
          onPressed: () {
            ref.read(carritoProvider.notifier).eliminarProducto(producto.titulo);
            ref.read(subTotalProvider.notifier).state = calcularSubtotal(ref.watch(carritoProvider));
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.black,
          )
        ),
      ],
    );
  }
}

double calcularSubtotal(List<Cartera> carrito){
  double retorno = 0;
  for (var e in carrito) {
    retorno += e.precio * e.cantidad;
  }
  return retorno;
}
