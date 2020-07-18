import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recase/recase.dart';

class Document {
  final String _name;
  final List<dynamic> _phrases;

  static const WORD_DOCUMENT = 'words';
  static const FIELD_NAME = 'name';
  static const FIELD_PHRASES = 'phrases';

  Document(this._name, this._phrases);

  static Document fromSnapshot(DocumentSnapshot snapshot) {
    return Document(
      snapshot[FIELD_NAME],
      snapshot[FIELD_PHRASES],
    );
  }

  Map<String, Object> toDocument() => {
        FIELD_NAME: this.getName(),
        FIELD_PHRASES: this.getPhrases(),
      };

  String getName() {
    return this._name;
  }

  String getTitleCasedName() {
    return this._name.titleCase;
  }

  List<dynamic> getPhrases() {
    return this._phrases;
  }
}
