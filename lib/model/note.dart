// TODO Implement this library.import 'dart:convert';

import 'dart:convert';

import 'package:flutter/foundation.dart';

class Note {
  final List<String> list;

  Note({
    @required this.list,
  });

  Note copyWith({
    List<String> list,
  }) {
    return Note(
      list: list ?? this.list,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'list': list,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Note(
      list: List<String>.from(map['list']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source));

  @override
  String toString() => 'Note(list: $list)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Note && listEquals(o.list, list);
  }

  @override
  int get hashCode => list.hashCode;
}
