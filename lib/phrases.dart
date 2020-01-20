import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class PhrasesPage extends StatelessWidget {
  final String word;
  final List<dynamic> phrases;

  PhrasesPage(this.word, this.phrases);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phrases for ' + this.word.titleCase),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: phrases.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Text(phrases[index].toString()),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
