part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class getData extends NoteEvent {
  final String data;
  getData({
    @required this.data,
  });
}
