import 'package:flutter/material.dart';
import 'package:proyecto_final_grupo_6/entities/cartera.dart';

class CarteraScreen extends StatelessWidget {
  static const String name = "carteraProducto";

  final Cartera cartera;

  const CarteraScreen({super.key, required this.cartera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BELLIGRAU"),
        centerTitle: true,
      ),
      body: _CarteraScreenView(
        cartera: cartera,
      ),
      drawer: Drawer(
        width: 180,
        // Contenido del menú desplegable
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 239, 255, 16),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        'https://imgs.search.brave.com/iUabDJIyP6xS6dHnqUao3W0RVVaVmwu2k8pB2ZHfNb4/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL0kv/NTFJK1NxTlZsakwu/anBn'), // Cambia por la ruta de tu imagen de perfil
                    // O usa una imagen de red: backgroundImage: NetworkImage('URL_DE_LA_IMAGEN'),
                  ),
                  Text(
                    "Usuario",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text("Perfil"),
              onTap: () {
                // Navegar a la pantalla 1
              },
            ),
            ListTile(
              title: const Text('Pantalla 2'),
              onTap: () {
                // Navegar a la pantalla 2
              },
            ),
            // Agrega más ListTile según sea necesario para más opciones
          ],
        ),
      ),
    );
  }
}

class _CarteraScreenView extends StatelessWidget {
  final Cartera cartera;
  const _CarteraScreenView({required this.cartera});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ClipRRect(
            child: Image.network(
              cartera.poster,
              width: 300,
              height: 300,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(" ${cartera.titulo}"),
          Text("Precio: ${cartera.precio}"),
          ElevatedButton(
            onPressed: (
                //crear la pestaña de carga o recibo de compra
                ) {},
            child: const Text("Comprar"),
          )
        ],
      ),
    );
  }
}
