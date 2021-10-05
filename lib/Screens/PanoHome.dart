import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jhelypanorama/Api/Get.dart';
import 'package:http/http.dart' as http;
import 'package:jhelypanorama/Provider/MyProvider.dart';
import 'package:jhelypanorama/Screens/Panoview.dart';
import 'package:provider/provider.dart';

class PanoHome extends StatefulWidget {
  @override
  _PanoHomeState createState() => _PanoHomeState();
}

class _PanoHomeState extends State<PanoHome> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double HEIGHT=MediaQuery.of(context).size.height;
    double WIDTH=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Image.asset("assets/ic_launcher_foreground.png",fit: BoxFit.contain,),
    ),
      body: SafeArea(
        child: Container(
          width: WIDTH,
          height: HEIGHT,
          child: FutureBuilder<http.Response>(
            future: Get().MakeGetRequest("https://api-dev.jhely.bo/api/panorama"),
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.done&&snapshot.hasData){
                http.Response response=snapshot.data;
                if(response.statusCode==200){
                  var ggg = json.decode(response.body);
                 var list =List.from(ggg);
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context,index){
                      return InkWell(
                        child: ListTile(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context){
                                  return ChangeNotifierProvider.value(
                                      value: MyProvider(),
                                      child: PanoView(properties: list[index])
                                  );
                                }
                            ));
                          },
                          title: Text(
                            list[index]['name'],
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text(
                            list[index]['address'],
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }else{
                  return error("Server return "+response.statusCode.toString());
                }
              }else if(snapshot.connectionState==ConnectionState.done&&snapshot.data==null){
                return error("Connection error, try again.");
              }else if(snapshot.connectionState==ConnectionState.waiting){
                return Center(
                  child: SpinKitSpinningLines(
                    color: Colors.amber,
                    size: 40,
                  ),
                );
              }
              else{
                return error("An error occur, please refresh.");
              }
            },
          ),
        ),
      ),
    );
  }
  Widget error(String message){
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "oops",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 20,),
          Icon(
            Icons.error_outline,
            color: Colors.black12,
            size: 60,
          ),
          SizedBox(height: 10,),
          Text(
            message,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 10,),
          FlatButton(
            color: Colors.amber,
              onPressed: (){
                setState(() {

                });
              },
              child: Text(
                "Refresh",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              )
          )
        ],
      ),
    );
  }
}
