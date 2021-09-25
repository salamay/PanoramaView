import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jhelypanorama/Provider/MyProvider.dart';
import 'package:panorama/panorama.dart';
import 'package:provider/provider.dart';
class PanoView extends StatefulWidget {
  dynamic properties;
  PanoView({this.properties});

  @override
  _PanoViewState createState() => _PanoViewState();
}

class _PanoViewState extends State<PanoView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double HEIGHT=MediaQuery.of(context).size.height;
    double WIDTH=MediaQuery.of(context).size.width;
    var floors=List.from(widget.properties['PanoramaFloor']);
    print(widget.properties);
    print("//////");
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: Image.asset("assets/ic_launcher_foreground.png",fit: BoxFit.contain,),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.black,
          height: HEIGHT,
          width: WIDTH,
          child: Stack(
            children: [
              Consumer<MyProvider>(
                builder: (context,myprovider,widget){
                  print(myprovider.url);
                  return  ClipRRect(
                    child: Container(
                      height: HEIGHT*0.55,
                      width: WIDTH,
                      child: myprovider.url!=null?CachedNetworkImage(
                        imageUrl: myprovider.url,
                        imageBuilder: (context, imageProvider) => Container(
                          child: Panorama(
                            maxZoom: 2.0,
                            minZoom: 1.0,
                            latitude: 0,
                            animSpeed: 5,
                            sensitivity: 2.5,
                            longitude: 0,
                            maxLatitude: 40,
                            minLatitude: -40,
                            child: Image(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => SpinKitSpinningLines(color: Colors.amber),
                        errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.red,),
                      ):Container(
                        height: HEIGHT,
                        width: WIDTH,
                        child: Center(
                          child: Text(
                            "Select a room to preview",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                bottom: HEIGHT*0.1,
                left: 10,
                child: Container(
                  height: HEIGHT*0.2,
                  width: WIDTH,
                  child: ListView.builder(
                      itemCount: floors.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                        var rooms=List.from( floors[index]['PanoramaImages']);
                        print(rooms);
                        return Container(
                          height: HEIGHT*0.2,
                          width: WIDTH,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:rooms.length,
                              itemBuilder: (context,i){
                                return Container(
                                    padding: EdgeInsets.all(10),
                                    height: HEIGHT*0.1,
                                    width: WIDTH*0.5,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex:1,
                                          child: Container(
                                            alignment: Alignment.center,
                                            color: Colors.black54,
                                            width:WIDTH*0.5,
                                            child: Text(
                                              floors[index]['floorName'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Expanded(
                                          flex:9,
                                          child: GestureDetector(
                                            onTap: (){
                                              Provider.of<MyProvider>(context,listen: false).changeUrl(rooms[i]['url']);
                                            },
                                            child: Container(
                                              width: WIDTH*0.5,
                                              height: HEIGHT*0.2,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl: rooms[i]['url'],
                                                  placeholder: (context, url) => SpinKitSpinningLines(
                                                    color: Colors.amber,
                                                    size: 10,
                                                  ),
                                                  errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.red,),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Expanded(
                                          flex:1,
                                          child: Container(
                                            alignment: Alignment.center,
                                            color: Colors.black54,
                                            width: WIDTH*0.5,
                                            child: Text(
                                              rooms[i]['roomName'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                      ],
                                    )
                                );
                              }
                          ),
                        );
                      }
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
