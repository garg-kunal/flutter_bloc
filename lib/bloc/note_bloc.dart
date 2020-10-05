import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/model/ServiceNote.dart';
import 'package:navigation/model/note.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final sendData senddata;

  NoteBloc(this.senddata) : super(NoteInitial());

  @override
  Stream<NoteState> mapEventToState(
    NoteEvent event,
  ) async* {
    if (event is getData) {
      yield NoteLoading();
      print(event.data);
      final Note note = await senddata.fetchNote(event.data);
      print("Check Here");
      print(note);
      yield NoteLoaded(note);
    }
  }
}
