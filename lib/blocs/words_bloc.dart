import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linos_dictionary/document.dart';
import 'package:linos_dictionary/repos/firestore_words.dart';
import 'package:meta/meta.dart';

part 'words_event.dart';
part 'words_state.dart';

class WordsBloc extends Bloc<WordsEvent, WordsState> {
  final FirestoreWordsRepository _firestoreWordsRepository;

  WordsBloc({@required FirestoreWordsRepository firestoreWordsRepository})
      : assert(firestoreWordsRepository != null),
        _firestoreWordsRepository = firestoreWordsRepository,
        super(WordsNotLoaded());

  @override
  Stream<WordsState> mapEventToState(
    WordsEvent event,
  ) async* {
    if (event is LoadWords) {
      yield* _mapLoadWordsToState();
    }
  }

  Stream<WordsState> _mapLoadWordsToState() async* {
    try {
      Stream<QuerySnapshot> snapshots =
          _firestoreWordsRepository.getSnapshots(Document.WORD_DOCUMENT);
      yield WordsLoaded(snapshots);
    } catch (_) {
      yield WordsNotLoaded();
    }
  }
}
