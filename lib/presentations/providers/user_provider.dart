import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/user.dart';
import 'package:proyecto_final_grupo_6/services/firebase_services.dart';

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  Future<void> updateUser(User updatedUser) async {
    await updateUserInFirestore(updatedUser);
    state = updatedUser;
  }

  void setUser(User user) {
    state = user;
  }

  void clearUser() {
    state = null;
  }
}
