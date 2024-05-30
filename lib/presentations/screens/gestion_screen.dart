import 'package:flutter/material.dart';

class GestionScreen extends StatelessWidget {
  static const String name = "gestion_screen";
  // final User usuario;

  const GestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: MyAppBar(usuario: usuario),
      // drawer: DrawerMenu(usuario: usuario),
      body: _GestionView(),
    );
  }
}

class _GestionView extends StatelessWidget {
  const _GestionView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ExpansionTile(
            title: const Text('Usuarios'),
            children: [
              ExpansionTile(
                title: const Text('Agregar Usuario'),
                children: <Widget>[
                  ListTile(
                    title: const Text('Formulario Agregar Usuario'),
                    onTap: () {
                      // Acción para agregar usuario
                    },
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text('Modificar Usuario'),
                children: <Widget>[
                  ListTile(
                    title: const Text('Formulario Modificar Usuario'),
                    onTap: () {
                      // Acción para modificar usuario
                    },
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text('Ocultar Usuario'),
                children: <Widget>[
                  ListTile(
                    title: const Text('Formulario Ocultar Usuario'),
                    onTap: () {
                      // Acción para ocultar usuario
                    },
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text('Mostrar Usuario'),
                children: <Widget>[
                  ListTile(
                    title: const Text('Formulario Mostrar Usuario'),
                    onTap: () {
                      // Acción para mostrar usuario
                    },
                  ),
                ],
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('Cartera'),
            children: [
              ExpansionTile(
                title: const Text('Agregar Cartera'),
                children: <Widget>[
                  ListTile(
                    title: const Text('Formulario Agregar Cartera'),
                    onTap: () {
                      // Acción para agregar cartera
                    },
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text('Modificar Cartera'),
                children: <Widget>[
                  ListTile(
                    title: const Text('Formulario Modificar Cartera'),
                    onTap: () {
                      // Acción para modificar cartera
                    },
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text('Eliminar Cartera'),
                children: <Widget>[
                  ListTile(
                    title: const Text('Formulario Eliminar Cartera'),
                    onTap: () {
                      // Acción para eliminar cartera
                    },
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text('Mostrar Cartera'),
                children: <Widget>[
                  ListTile(
                    title: const Text('Formulario Mostrar Cartera'),
                    onTap: () {
                      // Acción para mostrar cartera
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
