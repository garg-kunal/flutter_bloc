

class Person {
  List<String> myList=List<String>();

  String name ="Enter first to see";
  String _val="Database";
  int count=0;

  int get counter => count;
  String get getname=>name;
  void increment() => count++;

  String get val=>_val;

  List get myLIST=>myList;
  String setValue(String value) {
    this._val = value;
  }
}
