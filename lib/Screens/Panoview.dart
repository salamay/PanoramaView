import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jhelypanorama/Provider/MyProvider.dart';
import 'package:jhelypanorama/Screens/Widget/ThreeDViewer.dart';
import 'package:panorama/panorama.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../Rotation.dart';

class PanoView extends StatefulWidget {
  dynamic properties;

  PanoView({this.properties});

  @override
  _PanoViewState createState() => _PanoViewState();
}

class _PanoViewState extends State<PanoView> {
  int index;
  int floorindex = 0;
  int roomindex;
  String selectedfloor;
  String imageurl;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    double HEIGHT = MediaQuery.of(context).size.height;
    double WIDTH = MediaQuery.of(context).size.width;
    var floors = List.from(widget.properties['PanoramaFloor']);
    List<dynamic> rooms = floors[floorindex]['PanoramaImages'];
    List<String> dropdownList = [];
    for (int i = 0; i < floors.length; i++) {
      dropdownList.add(floors[i]['floorName']);
    }
    if (rooms.isEmpty) {
    } else {
      roomindex=0;
    }
    print("//////");
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black54,
        leading: Image.asset(
          "assets/ic_launcher_foreground.png",
          fit: BoxFit.contain,
        ),
      ),
      body: SafeArea(
        child: Consumer<MyProvider>(
          builder: (context,myprovider,child){
            return Container(
              padding: EdgeInsets.all(10),
              color: Colors.black,
              height: HEIGHT,
              width: WIDTH,
              child: Stack(
                children: [
                  Positioned(
                    child: ClipRRect(
                      child: Container(
                        height: HEIGHT * 0.65,
                        width: WIDTH,
                        color: Colors.black,
                        child: Panorama(
                          minLatitude: -35,
                          maxLatitude: 35,
                          sensitivity: 4,
                          minZoom: 1,
                          maxZoom: 2,
                          child: Image.network(
                            rooms[myprovider.roomindex]['url'],
                            fit: BoxFit.cover,
                            loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                              if(loadingProgress==null){
                                return child;
                              }else{
                                return Image.asset("assets/loading.gif");
                              }

                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: HEIGHT*0.21,
                    child: DropdownButton(
                      dropdownColor: Colors.black54,
                      icon: Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.white60,
                        size: 14,
                      ),
                      hint: Text(
                        "Change Floor",
                        style: TextStyle(color: Colors.white),
                      ),
                      // Not necessary for Option 1
                      value: selectedfloor,
                      onChanged: (newValue) {
                        int index = dropdownList.indexWhere(
                                (element) => element == newValue, 0);
                        selectedfloor = newValue;
                        floorindex = index;
                        setState(() {});
                      },
                      items: dropdownList.map((value) {
                        return DropdownMenuItem(
                          child: new Text(
                            value,
                            style: TextStyle(color: Colors.white),
                          ),
                          value: value,
                        );
                      }).toList(),
                    ),
                  ),
                  Positioned(
                    bottom: HEIGHT*0.02,
                    child: Container(
                      height: HEIGHT*0.15,
                      width: WIDTH,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: rooms.length,
                          itemBuilder: (context, i) {
                            return Container(
                                padding: EdgeInsets.all(10),
                                height: HEIGHT * 0.15,
                                width: WIDTH*0.4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 9,
                                      child: Container(
                                        height: HEIGHT * 0.1,
                                        width: WIDTH*0.35,
                                        child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            child: GestureDetector(
                                              onTap: (){
                                                //Provider.of<MyProvider>(context,listen: false).changeIndex(i);
                                                Provider.of<MyProvider>(context,listen: false).changeIndex(i);
                                              },
                                              child: Image.network(
                                                rooms[i]['url'],
                                                fit: BoxFit.cover,
                                                loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                                                  if(loadingProgress==null){
                                                    return child;
                                                  }else{
                                                    return Image.asset("assets/loading.gif");
                                                  }                                                },
                                              ),
                                            )
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.center,
                                        color: Colors.black54,
                                        width: WIDTH,
                                        child: Text(
                                          rooms[i]['roomName'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ));
                          }),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Future<File> downloadImage(String url) async {
  //   print(url);
  //   try {
  //     var response = await http.get(Uri.parse(url));
  //     Directory documentDirectory = await getApplicationDocumentsDirectory();
  //     File file = new File(
  //         join(documentDirectory.path, DateTime.now().toString() + ".jpg"));
  //     await file.writeAsBytes(response.bodyBytes);
  //     // This is a sync operation on a real
  //     // app you'd probably prefer to use writeAsByte and handle its Future
  //     File rotatedimage = await fixExifRotation(file.path);
  //     return rotatedimage;
  //   } catch (error) {
  //     print(error);
  //     return null;
  //   }
  // }
// Future<File> getImageFile(BuildContext context, MyProvider myProvider) async {
// //   return myProvider.downloadedImage;
// // }
}

//
