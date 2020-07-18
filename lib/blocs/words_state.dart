part of 'words_bloc.dart';

@immutable
abstract class WordsState {
  const WordsState();

  List<Object> get props => [];
}

class WordsNotLoaded extends WordsState {}

class WordsLoaded extends WordsState {
  final Stream<QuerySnapshot> snapshots;

  const WordsLoaded(this.snapshots);

  @override
  List<Object> get props => [snapshots];

  @override
  String toString() => 'WordsLoaded { snapshots: $snapshots }';
}
