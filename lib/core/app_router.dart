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
    path: '/perfil',
    builder: (context, state) {
      final User usuario = User(
          nombre: 'Juan',
          apellido: 'Pérez',
          username: 'juanperez',
          password: 'contraseña',
          rol: 'usuario',
          fotoPerfil: 'Foto',
          email: 'email');
      return PerfilScreen(usuario: usuario);
    },
  ),
  GoRoute(
    name: GestionScreen.name, 
    path: '/gestion',
    builder: (context, state) => const GestionScreen(),
  ),
  GoRoute(
    name: HistorialScrenn.name,
    path: '/historial',
    builder: (context, state) => const HistorialScrenn(),
  ),

  GoRoute(
    name: ConfigScreen.name, //vemos
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
    builder: (context, state) => CarritoScreen(usuario: state.extra as User),
  ),
  GoRoute(
    name: CarteraScreen.name,
    path: '/carteraProducto',
    builder: (context, state) {
      final data = state.extra! as Map<Object, dynamic>;
      return CarteraScreen(product: data["product"], usuario: data["usuario"]);
    },
  ),
  GoRoute(
    name: CompraScreen.name,
    path: '/compra',
    builder: (context, state) {
      final data = state.extra! as Map<Object, dynamic>;
      return CompraScreen(usuario: data["usuario"], product: data["product"]);
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
        usuario: data["usuario"],
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
]);