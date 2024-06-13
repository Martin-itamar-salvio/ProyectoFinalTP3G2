import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/usuario.dart';
import 'package:proyecto_final_grupo_6/services/firebase_services.dart';

final usuarioProvider = StateNotifierProvider<UsuarioNotifier, Usuario?>((ref) {
  return UsuarioNotifier();
});

class UsuarioNotifier extends StateNotifier<Usuario?> {
  UsuarioNotifier() : super(null);

  Future<void> actualizarUsuarioProvider(Usuario usuarioActualizado) async {
    await actualizarUsuario(usuarioActualizado);
    state = usuarioActualizado;
  }

  void setUsuario(Usuario usuario) {
    state = usuario;
  }

  void vaciarUsuario() {
    state = null;
  }
}
