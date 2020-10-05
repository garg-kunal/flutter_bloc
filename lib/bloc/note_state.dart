part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

class Add extends NoteState {}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteLoaded extends NoteState {
  final Note note;

  const NoteLoaded(
    @required this.note,
  );

  NoteLoaded copyWith({
    Note note,
  }) {
    return NoteLoaded(
      note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'note': note?.toMap(),
    };
  }

  factory NoteLoaded.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return NoteLoaded(
      Note.fromMap(map['note']),
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteLoaded.fromJson(String source) =>
      NoteLoaded.fromMap(json.decode(source));

  @override
  String toString() => 'NoteLoaded(note: $note)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is NoteLoaded && o.note == note;
  }

  @override
  int get hashCode => note.hashCode;
}
