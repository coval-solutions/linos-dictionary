import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:linos_dictionary/app.dart';
import 'package:linos_dictionary/blocs/simple_bloc_observer.dart';
import 'package:linos_dictionary/blocs/words_bloc.dart';
import 'package:linos_dictionary/repos/firestore_words.dart';

Future main() async {
  await DotEnv().load('.env');
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(kReleaseMode);

  Bloc.observer = SimpleBlocObserver();

  final FirestoreWordsRepository firestoreWordsRepository =
      FirestoreWordsRepository();

  runZonedGuarded(() {
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
  }, (error, stackTrace) {
    print('runZonedGuarded: Caught error in my root zone.');
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}
