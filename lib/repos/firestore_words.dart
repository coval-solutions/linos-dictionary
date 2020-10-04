import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linos_dictionary/repos/firestore.dart';

class FirestoreWordsRepository implements FirestoreRepository {
  @override
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  @override
  Stream<QuerySnapshot> getSnapshots(String collection) {
    return firestore.collection(collection).snapshots();
  }
}
