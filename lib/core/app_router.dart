import 'package:go_router/go_router.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/user.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/carrito_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/cartera_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/config_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/favorito_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/historial_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/home_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/login_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/perfil_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/publicar_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/recibo_screen.dart';
import 'package:proyecto_final_grupo_6/presentations/screens/registro_screen.dart';

import '../presentations/screens/compra_screen.dart';

final appRouter = GoRouter(routes: [
  GoRoute(
    name: LoginScreen.name,
    path: '/',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    name: HomeScreen.name,
    path: '/inicio',
    builder: (context, state) => HomeScreen(usuario: state.extra as User),
  ),
  GoRoute(
    name: PerfilScreen.name,
    path: '/perfil',
    builder: (context, state) => const PerfilScreen(),
  ),
  GoRoute(
    name: FavoritoScreen.name,
    path: '/favoritos',
    builder: (context, state) => const FavoritoScreen(),
  ),
  GoRoute(
    name: HistorialScrenn.name,
    path: '/historial',
    builder: (context, state) => const HistorialScrenn(),
  ),
  GoRoute(
    name: PublicarScreen.name,
    path: '/publicar',
    builder: (context, state) => const PublicarScreen(),
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
    name: CarteraScreen.name,
    path: '/carteraProducto',
    builder: (context, state) {
      final data = state.extra! as Map<Object,dynamic>;
      return CarteraScreen(cartera: data["product"], usuario: data["usuario"]);
    }//=> {CarteraScreen(cartera: state.extra as Cartera),
  ),
  GoRoute(
    name: CarritoScreen.name,
    path: '/carrito',
    builder: (context, state) => CarritoScreen(usuario: state.extra as User),
  ),
    GoRoute(
    name: ReciboScreen.name,
    path: '/recibo',
    builder: (context, state) => const ReciboScreen(),
  ),
   GoRoute(
    name: CompraScreen.name,
    path: '/compra',
    builder: (context, state) =>  CompraScreen(state.extra as User),
  ),
]);
