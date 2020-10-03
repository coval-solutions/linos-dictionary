import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getSnapshots(String collection);
}
