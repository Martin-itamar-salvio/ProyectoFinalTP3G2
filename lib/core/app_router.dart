import 'package:go_router/go_router.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/user.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/carga_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/carrito_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/cartera_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/config_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/gestion_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/historial_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/home_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/login_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/perfil_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/recibo_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/registro_screen.dart';

import '../presentations/screens/compra_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      name: LoginScreen.name,
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: HomeScreen.name,
      path: '/inicio',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: PerfilScreen.name,
      path: '/perfil',
      builder: (context, state) => const PerfilScreen(),
    ),
    GoRoute(
      name: GestionScreen.name,
      path: '/gestion',
      builder: (context, state) => const GestionScreen(),
    ),
    GoRoute(
      name: HistorialScreen.name,
      path: '/historial',
      builder: (context, state) => const HistorialScreen(),
    ),
    GoRoute(
      name: ConfigScreen.name, 
      path: '/config',
      builder: (context, state) => const ConfigScreen(),
    ),
    GoRoute(
      name: RegistroScreen.name,
      path: '/registro',
      builder: (context, state) => const RegistroScreen(),
    ),
    GoRoute(
      name: CarritoScreen.name,
      path: '/carrito',
      builder: (context, state) => const CarritoScreen(),
    ),
    GoRoute(
      name: CarteraScreen.name,
      path: '/carteraProducto',
      builder: (context, state) {
        final data = state.extra! as Map<Object, dynamic>;
        return CarteraScreen(product: data["product"]);
      },
    ),
    GoRoute(
      name: CompraScreen.name,
      path: '/compra',
      builder: (context, state) {
        final data = state.extra! as Map<Object, dynamic>;
        return CompraScreen(product: data["product"]);
      },
    ),
    GoRoute(
      name: CargaScreen.name,
      path: '/carga',
      builder: (context, state) {
        final data = state.extra! as Map<Object, dynamic>;
        return CargaScreen(data: data);
      },
    ),
    GoRoute(
      name: ReciboScreen.name,
      path: '/recibo',
      builder: (context, state) {
        final data = state.extra! as Map<Object, dynamic>;
        return ReciboScreen(
          product: data["product"],
          tarjeta: data["tarjeta"],
          codigo: data["codigo"],
          titular: data["titular"],
          email: data["email"],
          pais: data["pais"],
          codigoPostal: data["codigoPostal"],
          direccion: data["direccion"],
        );
      },
    ),
  ],
);
