import 'package:go_router/go_router.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/cartera.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/cartera_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/home_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/login_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/recibo_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/registro_screen.dart';

final appRouter = GoRouter(routes: [
  GoRoute(
    name: LoginScreen.name,
    path: '/',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    name: HomeScreen.name,
    path: '/inicio',
    //builder: (context, state) => HomeScreen(fullName: state.extra as String),
    builder: (context, state) => const HomeScreen(),
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
    GoRoute(
    name: ReciboScreen.name,
    path: '/recibo',
    builder: (context, state) => const ReciboScreen(),
  ),
]);
