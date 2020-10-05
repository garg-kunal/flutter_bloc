import 'dart:developer';

import 'package:stacked/stacked.dart';

class HomeView extends BaseViewModel {
  String _title = "Main PageS";
  String get title => '$_title';

  int counter = 0;
  int get count => counter;

  void updatecount() {
    counter++;
    notifyListeners();
  }
}
