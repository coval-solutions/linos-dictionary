import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linos_dictionary/app.dart';
import 'package:linos_dictionary/blocs/words_bloc.dart';
import 'package:linos_dictionary/document.dart';
import 'package:linos_dictionary/phrases.dart';

class WordsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final bloc = context.bloc<WordsBloc>();

    return BlocBuilder<WordsBloc, WordsState>(
        cubit: bloc,
        builder: (context, state) {
          if (state is WordsNotLoaded) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return StreamBuilder(
              stream: bloc.state.props.first,
              builder: (context, snapshot) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(MyApp.APP_NAME),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          showSearch(
                              context: context, delegate: WordSearch(snapshot));
                        },
                      ),
                    ],
                  ),
                  body: WordList(snapshot),
                );
              });
        });
  }
}

class WordList extends StatelessWidget {
  final AsyncSnapshot _snapshot;

  const WordList(this._snapshot);

  @override
  Widget build(BuildContext context) {
    if (_snapshot.hasError) {
      FirebaseCrashlytics.instance.recordError(
          _snapshot.error, StackTrace.current,
          reason: '[WordList] Tried to load some words.');
    }

    if (!_snapshot.hasData) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Container(
      height: MediaQuery.of(context).size.height -
          ((AdSize.fullBanner.height * 2) + 12),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _snapshot.data.documents.length,
        itemBuilder: (context, index) {
          return _buildList(context, _snapshot.data.documents[index]);
        },
      ),
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

class WordSearch extends SearchDelegate<String> {
  final AsyncSnapshot _snapshot;

  WordSearch(this._snapshot);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    if (_snapshot.hasError) {
      FirebaseCrashlytics.instance.recordError(
          _snapshot.error, StackTrace.current,
          reason: '[WordList] Tried to load some words for search.');
    }

    if (!_snapshot.hasData) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    final List<DocumentSnapshot> results = _snapshot.data.documents
        .where((DocumentSnapshot documentSnapshot) => documentSnapshot
            .data()[Document.FIELD_NAME]
            .toLowerCase()
            .toString()
            .contains(query.toLowerCase()))
        .toList();
    return Container(
      height: MediaQuery.of(context).size.height -
          ((AdSize.fullBanner.height * 2) + 12),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: results.length,
        itemBuilder: (context, index) {
          return _buildList(context, results[index]);
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (_snapshot.hasError) {
      FirebaseCrashlytics.instance.recordError(
          _snapshot.error, StackTrace.current,
          reason: '[WordList] Tried to load some words for suggestion.');
    }

    if (!_snapshot.hasData) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    final List<DocumentSnapshot> results = _snapshot.data.documents
        .where((DocumentSnapshot documentSnapshot) => documentSnapshot
            .data()[Document.FIELD_NAME]
            .toLowerCase()
            .toString()
            .startsWith(query.toLowerCase()))
        .toList();
    return Container(
      height: MediaQuery.of(context).size.height -
          ((AdSize.fullBanner.height * 2) + 12),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: results.length,
        itemBuilder: (context, index) {
          return _buildList(context, results[index]);
        },
      ),
    );
  }
}
