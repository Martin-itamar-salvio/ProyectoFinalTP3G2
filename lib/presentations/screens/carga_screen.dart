import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/user.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/app_bar.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/drawer_menu.dart';
import 'recibo_screen.dart';

class CargaScreen extends StatelessWidget {
  static const String name = "carga_screen";
  final Map<Object, dynamic> data;

  const CargaScreen({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = data["usuario"] as User;

    return Scaffold(
      appBar: MyAppBar(usuario: usuario),
      drawer: DrawerMenu(usuario: usuario),
      body: _CargaView(data: data),
    );
  }
}

class _CargaView extends StatefulWidget {
  final Map<Object, dynamic> data;

  const _CargaView({required this.data});

  @override
  __CargaViewState createState() => __CargaViewState();
}

class __CargaViewState extends State<_CargaView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      context.goNamed(ReciboScreen.name, extra: widget.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          const Text("Procesando compra", style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
