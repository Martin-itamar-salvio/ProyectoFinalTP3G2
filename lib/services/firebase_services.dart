import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/cartera.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/compra.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/usuario.dart';

// Login
Future<void> registrarUsuario(Usuario usuario) async {
  await FirebaseFirestore.instance
      .collection('Usuarios')
      .doc(usuario.nombreUsuario)
      .set(usuario.toMap());
}

Future<Usuario?> getUsuario(String nombreUsuario, String contrasenia) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('Usuarios')
      .where('nombreUsuario', isEqualTo: nombreUsuario)
      .where('contrasenia', isEqualTo: contrasenia)
      .get();

  if (querySnapshot.docs.isEmpty) {
    return null;
  }

  final userData = querySnapshot.docs.first.data();
  return Usuario.fromMap(userData);
}

// Actualizar datos del perfil
Future<void> actualizarUsuario(Usuario usuario) async {
  await FirebaseFirestore.instance
      .collection('Usuarios')
      .doc(usuario.nombreUsuario)
      .update(usuario.toMap());
}

// Agregar compra al historial de compras del usuario y a la colección "Compras"
Future<void> agregarCompraAlUsuario(Usuario usuario, Compra compra) async {
  final usuarioDoc = FirebaseFirestore.instance.collection('Usuarios').doc(usuario.nombreUsuario);
  final compraDoc = FirebaseFirestore.instance.collection('Compras').doc(compra.id);
  
  // Agregar compra a la colección "Compras"
  await compraDoc.set(compra.toMap());
  
  // Agregar compra al historial del usuario
  final snapshot = await usuarioDoc.get();
  if (snapshot.exists) {
    List<dynamic> historial = snapshot.data()?['historialCompras'] ?? [];
    historial.add(compra.toMap());
    await usuarioDoc.update({'historialCompras': historial});
  }
}

// Mostrar historial de compra
Stream<List<Compra>> listarComprasDeUsuario(Usuario usuario) {
  return FirebaseFirestore.instance
      .collection('Usuarios')
      .doc(usuario.nombreUsuario)
      .snapshots()
      .map((snapshot) {
    final data = snapshot.data();
    final List<dynamic> comprasData = data?['historialCompras'] ?? [];
    return comprasData.map((compraData) => Compra.fromMap(compraData)).toList();
  });
}

// Método para obtener todas las compras
Stream<List<Compra>> listarCompras() {
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
Stream<List<Cartera>> listarCarteras() {
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
Future<List<String>> getImagenesCargadas() async {
  final ListResult listaImagenes = await FirebaseStorage.instance.ref('carteras').listAll();
  final List<String> urls = [];
  for (var imagen in listaImagenes.items) {
    final String url = await imagen.getDownloadURL();
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
Future<void> agregarCartera(Cartera cartera) async {
  await FirebaseFirestore.instance.collection('Carteras').add(cartera.toMap());
}

// Modificar cartera
Future<void> actualizarCartera(Cartera cartera) async {
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
Future<void> eliminarCartera(String nombreCartera) async {
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
Future<void> actualizarStockCartera(Cartera cartera) async {
  final collectionRef = FirebaseFirestore.instance.collection('Carteras');
  final querySnapshot = await collectionRef.where('nombre', isEqualTo: cartera.nombre).get();

  if (querySnapshot.docs.isNotEmpty) {
    final docId = querySnapshot.docs.first.id;
    await collectionRef.doc(docId).update({ "stock": cartera.stock, "estado": cartera.estado});
  } else {
    throw Exception('Cartera no encontrada');
  }
}

