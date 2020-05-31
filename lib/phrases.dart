import 'package:flutter/material.dart';
import 'package:linos_dictionary/document.dart';

class PhrasesPage extends StatelessWidget {
  final Document document;

  PhrasesPage(this.document);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.document.getTitleCasedName()} phrase(s)'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: this.document.getPhrases().length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Text(this.document.getPhrases()[index].toString()),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
