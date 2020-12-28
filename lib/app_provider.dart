import 'package:flutter/material.dart';
import 'package:provider_ass/task_model.dart';

class AppProvider extends ChangeNotifier {
  List<Task2> list;
  setValues(List<Task2> list) {
    this.list = list;
    notifyListeners();
  }

  notify() {
    notifyListeners();
  }
}
