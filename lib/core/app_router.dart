import 'package:go_router/go_router.dart';
import 'package:proyecto_final_grupo_6/entities/cartera.dart';
import 'package:proyecto_final_grupo_6/screens/cartera_screen.dart';
import 'package:proyecto_final_grupo_6/screens/login_screen.dart';
import 'package:proyecto_final_grupo_6/screens/menu_screen.dart';
import 'package:proyecto_final_grupo_6/screens/registro_screen.dart';

final appRouter = GoRouter(routes: [
  GoRoute(
    name: LoginScreen.name,
    path: '/',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    name: MenuScreen.name,
    path: '/menu',
    builder: (context, state) => MenuScreen(fullName: state.extra as String),
  ),
  GoRoute(
    name: RegistroScreen.name,
    path: '/registro',
    builder: (context, state) => const RegistroScreen(),
  ),
  GoRoute(
    name: CarteraScreen.name,
    path: '/carteraProducto',
    builder: (context, state) => CarteraScreen(cartera: state.extra as Cartera),
  ),
]);
