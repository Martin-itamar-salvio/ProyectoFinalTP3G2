
import 'package:firebase_storage/firebase_storage.dart';
import "package:cloud_firestore/cloud_firestore.dart";


final storage = FirebaseStorage.instance;

FirebaseFirestore db = FirebaseFirestore.instance;
// parametro en getCarteras para conseguir X cantidad o las que hay, asi no bajamos toda la info.
Future<List>getCarteras() async{
  List Carteras = [];
  CollectionReference collectionReferenceCarteras = db.collection('Carteras');

  QuerySnapshot queryCarteras = await collectionReferenceCarteras.get();
  queryCarteras.docs.forEach((element) {
    Carteras.add(element.data());

  });

  return Carteras;
}