import 'dart:io';

import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';

class ThreeDViewer extends StatelessWidget {
  String roomlabel;
  File imagefile;
  ThreeDViewer({this.roomlabel,this.imagefile});

  @override
  Widget build(BuildContext context) {
    double HEIGHT = MediaQuery.of(context).size.height;
    double WIDTH = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Image.asset(
          "assets/ic_launcher_foreground.png",
          fit: BoxFit.contain,
        ),
        title: Text(
          roomlabel,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: ClipRRect(
          child: Container(
            height: HEIGHT,
            width: WIDTH,
            child: Panorama(
              latitude: 0,
              longitude: 0,
              minLatitude: -30,
              maxLatitude: 30,
              latSegments: 10,
              sensitivity: 2,
              minZoom: 1,
              maxZoom: 2,
              child: Image.file(
                imagefile,
                fit: BoxFit.cover,
                // loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                //   if (loadingProgress == null) {
                //     return child;
                //   }else{
                //     return Container(color:Colors.black,child: Image.asset("assets/loading.gif"));
                //   }
                // },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
