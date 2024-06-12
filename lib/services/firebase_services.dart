import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/cartera.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/compra.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/user.dart';

// Login
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
  return User.fromMap(userData);
}

// Actualizar datos del perfil
Future<void> updateUserInFirestore(User user) async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(user.username)
      .update(user.toMap());
}

// Agregar compra al historial de compras del usuario y a la colección "Compras"
Future<void> addCompraToUser(User user, Compra compra) async {
  final userDoc = FirebaseFirestore.instance.collection('Users').doc(user.username);
  final compraDoc = FirebaseFirestore.instance.collection('Compras').doc(compra.id);
  
  // Agregar compra a la colección "Compras"
  await compraDoc.set(compra.toMap());
  
  // Agregar compra al historial del usuario
  final snapshot = await userDoc.get();
  if (snapshot.exists) {
    List<dynamic> historial = snapshot.data()?['historialCompras'] ?? [];
    historial.add(compra.toMap());
    await userDoc.update({'historialCompras': historial});
  }
}

// Mostrar historial de compra
Stream<List<Compra>> fetchCompras(User user) {
  return FirebaseFirestore.instance
      .collection('Users')
      .doc(user.username)
      .snapshots()
      .map((snapshot) {
    final data = snapshot.data();
    final List<dynamic> comprasData = data?['historialCompras'] ?? [];
    return comprasData.map((compraData) => Compra.fromMap(compraData)).toList();
  });
}

// Método para obtener todas las compras
Stream<List<Compra>> fetchAllCompras() {
  return FirebaseFirestore.instance
      .collection('Compras')
      .snapshots()
      .map((querySnapshot) {
    return querySnapshot.docs.map((doc) {
      return Compra.fromMap(doc.data());
    }).toList();
  });
}

// Mostrar carteras menu
Stream<List<Cartera>> fetchCarteras() {
  return FirebaseFirestore.instance
      .collection('Carteras')
      .where('estado', isNotEqualTo: 'delete')
      .snapshots()
      .map((querySnapshot) {
    return querySnapshot.docs.map((doc) {
      return Cartera.fromMap(doc.data());
    }).toList();
  });
}

// Conseguir url de firestore
Future<List<String>> getUploadedImages() async {
  final ListResult result = await FirebaseStorage.instance.ref('carteras').listAll();
  final List<String> urls = [];
  for (var ref in result.items) {
    final String url = await ref.getDownloadURL();
    urls.add(url);
  }
  return urls;
}
// Buscador de cartera
 Future<Cartera?> buscarCarteraPorNombre(String nombre) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Carteras')
        .where('nombre', isEqualTo: nombre)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first;
      return Cartera.fromMap(doc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }
// Agregar cartera
Future<void> addCartera(Cartera cartera) async {
  await FirebaseFirestore.instance.collection('Carteras').add(cartera.toMap());
}

// Modificar cartera
Future<void> updateCartera(Cartera cartera) async {
  final collectionRef = FirebaseFirestore.instance.collection('Carteras');
  final querySnapshot = await collectionRef.where('nombre', isEqualTo: cartera.nombre).get();

  if (querySnapshot.docs.isNotEmpty) {
    final docId = querySnapshot.docs.first.id;
    await collectionRef.doc(docId).update({"modelo": cartera.modelo, "precio": cartera.precio, "stock": cartera.stock, "estado": cartera.estado, "descripcion": cartera.descripcion});
  } else {
    throw Exception('Cartera no encontrada');
  }
}
// Eliminar cartera
Future<void> deleteCartera(String nombreCartera) async {
  final collectionRef = FirebaseFirestore.instance.collection('Carteras');
  final querySnapshot = await collectionRef.where('nombre', isEqualTo: nombreCartera).get();

  if (querySnapshot.docs.isNotEmpty) {
    final docId = querySnapshot.docs.first.id;
    await collectionRef.doc(docId).update({'estado': 'delete'});
  } else {
    // Maneja el caso en el que no se encuentra la cartera
    throw Exception('Cartera no encontrada');
  }
}

// Actualizar Stock Cartera
Future<void> updateStockCartera(Cartera cartera) async {
  final collectionRef = FirebaseFirestore.instance.collection('Carteras');
  final querySnapshot = await collectionRef.where('nombre', isEqualTo: cartera.nombre).get();

  if (querySnapshot.docs.isNotEmpty) {
    final docId = querySnapshot.docs.first.id;
    await collectionRef.doc(docId).update({ "stock": cartera.stock, "estado": cartera.estado});
  } else {
    throw Exception('Cartera no encontrada');
  }
}

