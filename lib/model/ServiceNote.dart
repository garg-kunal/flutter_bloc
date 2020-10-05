import 'package:flutter/widgets.dart';

import './note.dart';
import 'package:firebase_database/firebase_database.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;

abstract class send {
  Future<Note> fetchNote(String data);
}

class sendData extends send {
  List<String> ls = List();
  @override
  Future<Note> fetchNote(String data) async {
    print(data);
    await database
        .reference()
        .child("message")
        .push()
        .set({"new": data}).then((value) async {
      await database
          .reference()
          .child("message")
          .once()
          .then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> data = snapshot.value;
        data.forEach((key, value) {
          // print(value['new']);
          ls.add(value['new']);
        });
        // print("Servic efile");
        // print(ls);
      });
      return Note(list: ls);
    });
  }
}
