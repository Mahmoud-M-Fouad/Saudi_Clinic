
import 'package:app_clinic/model/model.dart';
import 'package:flutter/material.dart';

import 'db.dart';
class MyProvider with ChangeNotifier {
  int _count = 0;
  int length = 0;
  bool isLoading = true;
  var list;
  late Clinic c;

  int get count => _count;
  bool get loading => isLoading;
  int get lengthList => length;
  get getList => list;

  setindex(int i) {
    _count = i;
    notifyListeners();
  }

  void increment() {
    _count++;
    notifyListeners();
  }

  void changeLoading(bool f) {
    isLoading = f;
    notifyListeners();
  }
  void refresh()
  {
    notifyListeners();
  }
  void addReservation(BuildContext ctx)
  {
    insertDor(c,ctx);
    notifyListeners();
  }
   allReservation(String date)
  {
     list = allDorWithDate(date);
     length = list.length;
     changeLoading(false);
    notifyListeners();
     return list;
  }



}