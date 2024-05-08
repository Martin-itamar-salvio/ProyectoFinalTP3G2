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
  const _CarritoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Cartera> carrito = ref.watch(carritoProvider);
    double subTotal = ref.watch(subTotalProvider);

    if(carrito.isEmpty){
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
              itemCount: carrito.length,
              itemBuilder: (context, index) {
                final Cartera producto = carrito[index];
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
                    //ref.read(subTotalProvider.notifier).state++;
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

class _ProductView extends StatelessWidget {
  final Cartera producto;
  const _ProductView({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
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
            _CantidadBotonesView(producto: producto),
            IconButton(
              onPressed: () { },
              icon: const Icon(
                Icons.delete,
                color: Colors.black,
              )
            ),
          ],
        ),
      ),
    );

    /*
    return ListTile(
      title: Text(producto.titulo),
      subtitle: Text(producto.tipo),
      leading: Image.network(producto.poster, width: 70, height: 70),
      trailing: const Icon(Icons.delete),
      onTap: (){ /*No hace nada, porque solo puede eliminar el item*/ }
    );
    */
  }
}

class _CantidadBotonesView extends StatelessWidget {
  final Cartera producto;
  const _CantidadBotonesView({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
   return Row(
     children: [
       IconButton(onPressed: () {}, icon: const Icon(Icons.remove)),
       Text('${producto.cantidad}'),
       IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
     ],
   );
  }
}