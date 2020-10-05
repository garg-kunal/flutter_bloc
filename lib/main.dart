import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:navigation/bloc/note_bloc.dart';
import 'package:navigation/model/ServiceNote.dart';
import 'package:navigation/ui/view/home/home_view.dart';
import './service/controller.dart';
import 'package:firebase_database/firebase_database.dart';

import 'model/note.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;

void main() {
  runApp(new MaterialApp(
    home: BlocProvider<NoteBloc>(
      create: (context) => NoteBloc(sendData()),
      child: MyNote(),
    ),
  ));
}

class MyNote extends StatefulWidget {
  @override
  _MyNoteState createState() => _MyNoteState();
}

class _MyNoteState extends State<MyNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Text("Note App"),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MainEdit()));
                })
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: BlocConsumer<NoteBloc, NoteState>(
            builder: (context, state) {
              if (state is NoteInitial) {
                return new MainEdit();
              } else if (state is NoteLoading) {
                return loader();
              } else if (state is NoteLoaded) {
                print(state.note);
                return showData(state.note);
              } else {
                return new MainEdit();
              }
            },
            listener: (context, state) {
              if (state is NoteInitial) {
                print("Inotaial state");
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Wait"),
                  ),
                );
              }
            },
          ),
        ));
  }
}

Widget loader() {
  return Center(
    child: new Text("Loading......"),
  );
}

Widget showData(Note note) {
  print("JOb");
  print(note.list.length);
  print(note);
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: note.list.length == 0
                        ? new Text("Loading")
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: note.list.length,
                            padding: EdgeInsets.all(10.0),
                            // physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int i) {
                              // if(i.isOdd) return Divider();
                              // final pos=i~/2;
                              return new ListTile(
                                title: new Text(note.list[i]),
                                leading: new CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: new Text('${i}'),
                                ),
                              );
                            }),
                  ),
                ),
                MainEdit(),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

class MainEdit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyEdit();
  }
}

class MyEdit extends State<MainEdit> {
  TextEditingController name = new TextEditingController();
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Add Note"),
            TextField(
              controller: name,
              decoration: InputDecoration(
                labelText: 'Enter your note',
                hintText: "Note",
              ),
            ),
            show ? new Text("Please fill it") : new Text(""),
            RaisedButton(
                child: new Text("Add"),
                onPressed: () => run(context, name.text)),
          ],
        ),
      ),
    );
  }
}

void run(BuildContext context, String data) {
  print(data);
  if (data.length == 0) {
  } else {
    final weatherBloc = context.bloc<NoteBloc>();
    weatherBloc.add(getData(data: data));
    Navigator.of(context).pop();
  }
}
