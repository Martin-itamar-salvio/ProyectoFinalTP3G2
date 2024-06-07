import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/cartera.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/compra.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/user.dart';


//login
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


Stream<List<Compra>> getComprasByUserStream(User user) {
  final userDocStream = FirebaseFirestore.instance
      .collection('Users')
      .doc(user.username)
      .snapshots();

  return userDocStream.map((snapshot) {
    final data = snapshot.data();
    final List<dynamic> comprasData = data?['historialCompras'] ?? [];
    return comprasData.map((compraData) => Compra.fromMap(compraData)).toList();
  });
}


//mostrar carteras menu
Stream<List<Cartera>> fetchCarteras() {
  return FirebaseFirestore.instance
      .collection('Carteras')
      .where('estado', isNotEqualTo: 'delete')
      .snapshots()
      .map((querySnapshot) {
    return querySnapshot.docs.map((doc) {
      return Cartera.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  });
}

// Crear Cartera - Gestion
Future<void> createCartera(Cartera cartera) async {
  await FirebaseFirestore.instance.collection('Carteras').add({
    'nombre': cartera.nombre,
    'precio': cartera.precio,
    'imagen': cartera.imagen,
    'cantidad': cartera.cantidad,
    'modelo': cartera.modelo,
    'descripcion': cartera.descripcion,
    'estado': cartera.estado,
  });
}

// Modificar Cartera
Future<void> updateCarteraByName(String nombre, Cartera cartera) async {
  final collectionRef = FirebaseFirestore.instance.collection('Carteras');
  final querySnapshot = await collectionRef.where('nombre', isEqualTo: nombre).get();

  if (querySnapshot.docs.isNotEmpty) {
    final docId = querySnapshot.docs.first.id;
    await collectionRef.doc(docId).update({
      'nombre': cartera.nombre,
      'precio': cartera.precio,
      'imagen': cartera.imagen,
      'cantidad': cartera.cantidad,
      'modelo': cartera.modelo,
      'descripcion': cartera.descripcion,
      'estado': cartera.estado,
    });
  } else {
    // Maneja el caso en el que no se encuentra la cartera
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




// Manejo de Storage
Future<String?> uploadImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  if (image == null) {
    return null;
  }

  final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  final Reference storageRef = FirebaseStorage.instance.ref().child('carteras/$fileName');
  final UploadTask uploadTask = storageRef.putFile(File(image.path));
  final TaskSnapshot taskSnapshot = await uploadTask;

  return await taskSnapshot.ref.getDownloadURL();
}
