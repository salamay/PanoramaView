import 'package:flutter/material.dart';
import 'package:jhelypanorama/Provider/MyProvider.dart';
import 'package:jhelypanorama/Screens/Panoview.dart';
import 'package:provider/provider.dart';

import 'Screens/PanoHome.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/panohome":(context)=>PanoHome(),
        "/panoview":(context)=>PanoView(),
      },
      initialRoute: "/panohome",
    );
  }
}