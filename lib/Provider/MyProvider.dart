import 'dart:io';
import 'dart:io';

import 'package:flutter/cupertino.dart';

class MyProvider extends ChangeNotifier{
  int roomindex=0;
  void changeIndex(int index){
    this.roomindex=index;
    notifyListeners();
  }
}