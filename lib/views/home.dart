import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linos_dictionary/controllers/words_controller.dart';

class HomePage extends StatelessWidget {
  final String title;

  HomePage({super.key, required this.title});

  final WordsController _wordsController = Get.put(WordsController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordsController>(
      init: WordsController(),
      initState: (_) {},
      builder: (controller) {
        _wordsController.getData();
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
