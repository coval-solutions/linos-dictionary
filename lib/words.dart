import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
      body: WordList(),
    );
  }
}

class WordList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection(Document.WORD_DOCUMENT).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          Crashlytics.instance.recordError(snapshot.error, StackTrace.current,
              context: '[WordList] Tried to load some words.');
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Container(
          height: MediaQuery.of(context).size.height -
              ((AdSize.fullBanner.height * 2) + 12),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return _buildList(context, snapshot.data.documents[index]);
            },
          ),
        );
      },
    );
  }
}

Widget _buildList(BuildContext context, DocumentSnapshot snapshot) {
  Document document = Document.fromSnapshot(snapshot);
  return ListTile(
    title: Text(document.getName()),
    subtitle: Text(
      '${document.getPhrases()?.length} phrase(s)',
      style: TextStyle(fontStyle: FontStyle.italic),
    ),
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => PhrasesPage(document)));
    },
  );
}
