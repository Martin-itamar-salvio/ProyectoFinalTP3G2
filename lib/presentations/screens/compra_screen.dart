import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final_grupo_6/presentations/providers/cart_provider.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/app_bar.dart';
import 'package:proyecto_final_grupo_6/presentations/providers/user_provider.dart';
import 'package:proyecto_final_grupo_6/services/firebase_services.dart';
import '../entities/compra.dart';
import '../widgets/drawer_menu.dart';
import 'carga_screen.dart';

class CompraScreen extends ConsumerWidget {
  static const String name = "compra_screen";

  CompraScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usuario = ref.watch(userProvider);
    final carrito = ref.watch(carritoProvider);
    final subTotal = ref.watch(subTotalProvider);

    if (usuario == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Compra'),
        ),
        body: const Center(
          child: Text('No se ha iniciado sesión'),
        ),
      );
    }

    final tarjetaController = TextEditingController();
    final codigoController = TextEditingController();
    final titularController = TextEditingController();
    final emailController = TextEditingController();
    final paisController = TextEditingController();
    final codigoPostalController = TextEditingController();
    final direccionController = TextEditingController();

    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const DrawerMenu(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Tarjeta de Detalles del Carrito
                Card(
                  elevation: 5.0,
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Detalles del Carrito',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(),
                        ...carrito.map((producto) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${producto.nombre} x${producto.cantidad}', style: const TextStyle(fontSize: 16.0)),
                              Text('\$${producto.precio * producto.cantidad}', style: const TextStyle(fontSize: 16.0)),
                            ],
                          ),
                        )),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Precio Total:',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$$subTotal',
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: tarjetaController,
                  decoration: const InputDecoration(
                    labelText: 'Número de tarjeta',
                    hintText: '1234 5678 9012 3456',
                  ),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 16.0),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese el número de tarjeta';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: codigoController,
                  decoration: const InputDecoration(
                    labelText: 'Código verificador',
                    hintText: '123',
                  ),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 16.0),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese el código verificador';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: titularController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre del titular',
                    hintText: 'Nombre y apellido',
                  ),
                  style: const TextStyle(fontSize: 16.0),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese el nombre del titular';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'correo@example.com',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(fontSize: 16.0),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese su email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: paisController,
                  decoration: const InputDecoration(
                    labelText: 'País',
                    hintText: 'Nombre del país',
                  ),
                  style: const TextStyle(fontSize: 16.0),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese el país';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: codigoPostalController,
                  decoration: const InputDecoration(
                    labelText: 'Código postal',
                    hintText: 'Código postal',
                  ),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 16.0),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese el código postal';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: direccionController,
                  decoration: const InputDecoration(
                    labelText: 'Dirección',
                    hintText: 'Dirección de facturación',
                  ),
                  style: const TextStyle(fontSize: 16.0),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese la dirección';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final compra = Compra(
                        usuario: usuario,
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        direccion: direccionController.text,
                        codigoPostal: codigoPostalController.text,
                        total: subTotal,
                        carteras: carrito,
                      );

                      try {

                        // Actualizar stock de las carteras
                        

                        // Agregar a usuarios
                        await addCompraToUser(usuario, compra);
                        
                        // Vaciar el carrito
                        ref.read(carritoProvider.notifier).vaciarCarrito();

                        // Ir a la pantalla de carga
                        context.goNamed(CargaScreen.name, extra: compra);
                      } catch (e) {
                        // Manejar error si falla la compra
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error al realizar la compra: $e')),
                        );
                      }
                    }
                  },
                  child: const Text('Realizar compra'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
