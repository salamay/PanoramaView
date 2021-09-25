import 'package:flutter/cupertino.dart';

class MyProvider extends ChangeNotifier{
  String url;
  void changeUrl(String url){
    this.url=url;
    notifyListeners();
  }
}