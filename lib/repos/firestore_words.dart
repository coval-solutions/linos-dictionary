import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linos_dictionary/repos/firestore.dart';

class FirestoreWordsRepository implements FirestoreRepository {
  @override
  Firestore get firestore => Firestore.instance;

  @override
  Stream<QuerySnapshot> getSnapshots(String collection) {
    return firestore.collection(collection).snapshots();
  }
}
