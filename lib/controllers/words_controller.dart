import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:linos_dictionary/models/word.dart';

class WordsController extends GetxController {
  var isLoading = false;
  var wordList = <Word>[];

  Future<void> getData() async {
    try {
      QuerySnapshot words = await FirebaseFirestore.instance
          .collection('words')
          .orderBy('name')
          .get();
      wordList.clear();
      words.docs.map((e) => wordList.add(Word(e.id, e['name'], e['phrases'])));
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
