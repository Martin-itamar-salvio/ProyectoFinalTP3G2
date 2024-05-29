import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/cartera.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/user.dart';

Stream<List<Cartera>> fetchCarteras() {
  return FirebaseFirestore.instance
      .collection('Carteras')
      .snapshots()
      .map((querySnapshot) {
    return querySnapshot.docs.map((doc) {
      return Cartera.fromFirestore(doc);
    }).toList();
  });
}

Future<void> registerUser(User user) async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(user.username)
      .set(user.toMap());
}

Future<User?> getUser(String username, String password) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('Users')
      .where('username', isEqualTo: username)
      .where('password', isEqualTo: password)
      .get();

  if (querySnapshot.docs.isEmpty) {
    return null;
  }

  final userData = querySnapshot.docs.first.data();
  return User(
    nombre: userData['nombre'],
    apellido: userData['apellido'],
    username: userData['username'],
    password: userData['password'],
    rol: userData['rol'],
    fotoPerfil: userData['fotoPerfil'],
    email: userData['email'],
    carroDeCompras: userData['carroDeCompras'],
  );
}