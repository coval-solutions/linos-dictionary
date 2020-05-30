import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:linos_dictionary/document.dart';
import 'package:linos_dictionary/main.dart';
import 'package:linos_dictionary/phrases.dart';

class WordsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.APP_NAME),
      ),
      body: Center(
        child: WordList(),
      ),
    );
  }
}

class WordList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream:
            Firestore.instance.collection(Document.WORD_DOCUMENT).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return _buildList(context, snapshot.data.documents[index]);
            },
          );
        },
      ),
    );
  }
}

Widget _buildList(BuildContext context, DocumentSnapshot document) {
  return ListTile(
    title: Text(document['name']),
    subtitle: Text(
      '${document['phrases'].length} phrase(s)',
      style: TextStyle(fontStyle: FontStyle.italic),
    ),
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PhrasesPage(document['name'], document['phrases'])));
    },
  );
}
