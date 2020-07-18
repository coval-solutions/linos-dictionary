part of 'words_bloc.dart';

@immutable
abstract class WordsEvent {
  List<Object> get props => [];
}

class LoadWords extends WordsEvent {
  @override
  List<Object> get props => [];
}
