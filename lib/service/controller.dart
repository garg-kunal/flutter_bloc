
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../model/model.dart';
import 'package:firebase_database/firebase_database.dart';

final FirebaseDatabase database=FirebaseDatabase.instance;

class Controller extends ControllerMVC  {
  // /// Singleton Factory
  factory Controller() {
    if (_this == null)
      _this = Controller._();

    return _this;
  }
  static Controller _this;

  Controller._();

  /// Allow for easy access to 'the Controller' throughout the application.
  static Controller get con => _this;
  Person model=new Person();


  int get count => model.count;

  void incrementCounter() => model.increment();

  Future plain(String name) async{
    model.name=name;
   await database.reference().child("mesaage").push().set({
      "new":name
    }).then((val) async {
            await value();
        });
  }


  @override
  void initState() {
    print("Init");
    database.reference().child("mesaage").once().then((DataSnapshot snapshot) {
      Map<dynamic,dynamic> data=snapshot.value;
      model.myList.clear();
      data.forEach((key, value) {
         print(value['new']);
        model.myList.add(value['new']);
      });
      // print(model.myList);
      // var valueNotifier = ValueNotifier();
    });
  }

  Future value() async{
  await  database.reference().child("mesaage").once().then((DataSnapshot snapshot) {
    Map<dynamic,dynamic> data=snapshot.value;
    model.myList.clear();
    data.forEach((key, value) {
      print(value['new']);
      model.myList.add(value['new']);
    });
  setState((){ });
  });
  }

  List get mylist => model.myList;
  String get Val => model.val;
  String get names => model.getname;
}


