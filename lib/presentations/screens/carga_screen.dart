import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/compra.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/app_bar.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/drawer_menu.dart';
import 'recibo_screen.dart';

class CargaScreen extends StatelessWidget {
  static const String name = "carga_screen";
  final Compra compra;

  const CargaScreen({required this.compra, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const DrawerMenu(),
      body: _CargaView(compra: compra),
    );
  }
}

class _CargaView extends StatefulWidget {
  final Compra compra;

  const _CargaView({required this.compra});

  @override
  __CargaViewState createState() => __CargaViewState();
}

class __CargaViewState extends State<_CargaView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      context.goNamed(ReciboScreen.name, extra: widget.compra);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text("Procesando compra", style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

