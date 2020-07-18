import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreRepository {
  final Firestore firestore = Firestore.instance;

  Stream<QuerySnapshot> getSnapshots(String collection);
}
