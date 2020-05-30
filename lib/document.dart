import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recase/recase.dart';

class Document {
  final String _name;
  final List<dynamic> _phrases;

  static const WORD_DOCUMENT = 'words';

  Document(this._name, this._phrases);

  static Document fromSnapshot(DocumentSnapshot snapshot) {
    return Document(
      snapshot['name'],
      snapshot['phrases'],
    );
  }

  Map<String, Object> toDocument() => {
        'name': this.getName(),
        'phrases': this.getPhrases(),
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
