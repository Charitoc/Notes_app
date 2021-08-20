import 'package:flutter/foundation.dart';

final String tableName = 'note';

class Note with ChangeNotifier {
  String id;
  String title;
  String text;
  bool isLocked;

  Note({this.id, this.title, this.text, this.isLocked});

  Note.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        text = json['text'],
        isLocked = json['isLocked'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'text': text,
        'isLocked': isLocked,
      };

  void toggleLocked() {
    isLocked = !isLocked;
    notifyListeners();
  }
}
