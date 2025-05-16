import 'package:flutter/material.dart';

class AppData extends ChangeNotifier {
  int _counter = 0;
  String name = "";
  bool isResetEnabled = false;

  int get counter => _counter;


  void resetCounter() { 
    _counter = 0;
    notifyListeners();
  }

  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    _counter--;
    notifyListeners();
  }

  void setName(String newName) {
    name = newName;
    notifyListeners();
  }
  void setResetEnabled(bool value) {
    isResetEnabled = value;
    notifyListeners();
  }



}