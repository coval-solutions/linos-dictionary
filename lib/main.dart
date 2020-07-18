import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:linos_dictionary/app.dart';
import 'package:linos_dictionary/blocs/simple_bloc_observer.dart';
import 'package:linos_dictionary/blocs/words_bloc.dart';
import 'package:linos_dictionary/repos/firestore_words.dart';

Future main() async {
  Crashlytics.instance.enableInDevMode = false;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  await DotEnv().load('.env');

  Bloc.observer = SimpleBlocObserver();

  final FirestoreWordsRepository firestoreWordsRepository =
      FirestoreWordsRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<WordsBloc>(
          create: (BuildContext context) => WordsBloc(
            firestoreWordsRepository: firestoreWordsRepository,
          )..add(LoadWords()),
        ),
      ],
      child: BlocBuilder<WordsBloc, WordsState>(builder: (context, state) {
        return MyApp();
      }),
    ),
  );
}
