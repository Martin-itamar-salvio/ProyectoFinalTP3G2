import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/app_bar.dart';

import '../entities/user.dart';
import '../widgets/drawer_menu.dart';

// ignore: must_be_immutable
class CompraScreen extends ConsumerWidget {
  static const String name = "compra_screen";
   User usuario;
   CompraScreen(this.usuario,   {super.key});

  @override
 Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: MyAppBar(usuario: usuario),
      drawer: DrawerMenu(usuario: usuario),
     body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/CARTERA_1_1.jpg', // Aca la imagen deberia salir de la cartera enviada en la pagina anterior, 
                //tenes q mandarme el objeto cartera, o la imagen, o algo como extra y yo tratarlo aca
                width: 200, // Ajusta el ancho según sea necesario
              ),
              const SizedBox(height: 20), // Espacio entre la imagen y el formulario
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Número de tarjeta',
                  hintText: '1234 5678 9012 3456',
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 10), // Espacio entre los campos
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Código verificador',
                  hintText: '123',
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 10), // Espacio entre los campos
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nombre del titular',
                  hintText: 'Nombre y apellido',
                ),
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 10), // Espacio entre los campos
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'correo@example.com',
                ),
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 10), // Espacio entre los campos
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'País',
                  hintText: 'Nombre del país',
                ),
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 10), // Espacio entre los campos
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Código postal',
                  hintText: 'Código postal',
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 10), // Espacio entre los campos
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Dirección',
                  hintText: 'Dirección de facturación',
                ),
                style: const TextStyle(fontSize: 16.0),
              ),
             const  SizedBox(height: 20), // Espacio entre el formulario y el botón
              ElevatedButton(
                onPressed: () {
                  // Aca deberia ir la logica q mande a la base de datos y ejecute la compra
                },
                child: const Text('Realizar compra'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}