import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/cartera.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/app_bar.dart';
import '../entities/user.dart';
import '../widgets/drawer_menu.dart';
import 'carga_screen.dart';

// ignore: must_be_immutable
class CompraScreen extends ConsumerWidget {
  static const String name = "compra_screen";
  final User usuario;
  final Cartera product;

  CompraScreen({required this.usuario, required this.product});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tarjetaController = TextEditingController();
    final codigoController = TextEditingController();
    final titularController = TextEditingController();
    final emailController = TextEditingController();
    final paisController = TextEditingController();
    final codigoPostalController = TextEditingController();
    final direccionController = TextEditingController();

    return Scaffold(
      appBar: MyAppBar(usuario: usuario),
      drawer: DrawerMenu(usuario: usuario),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(
                  product.imagen,
                  width: 200,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: tarjetaController,
                  decoration: const InputDecoration(
                    labelText: 'Número de tarjeta',
                    hintText: '1234 5678 9012 3456',
                  ),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 16.0),
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
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: titularController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre del titular',
                    hintText: 'Nombre y apellido',
                  ),
                  style: const TextStyle(fontSize: 16.0),
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
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: paisController,
                  decoration: const InputDecoration(
                    labelText: 'País',
                    hintText: 'Nombre del país',
                  ),
                  style: const TextStyle(fontSize: 16.0),
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
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: direccionController,
                  decoration: const InputDecoration(
                    labelText: 'Dirección',
                    hintText: 'Dirección de facturación',
                  ),
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.goNamed(CargaScreen.name, extra: {
                        "usuario": usuario,
                        "product": product,
                        "tarjeta": tarjetaController.text,
                        "codigo": codigoController.text,
                        "titular": titularController.text,
                        "email": emailController.text,
                        "pais": paisController.text,
                        "codigoPostal": codigoPostalController.text,
                        "direccion": direccionController.text,
                      });
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
