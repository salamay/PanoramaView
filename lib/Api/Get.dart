import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Get{

  static const platform= MethodChannel("com.jhely.a3dtour");
  Future<http.Response> MakeGetRequest(String url)async{
    //Get token
    try{
      final String result=await platform.invokeMethod("getToken");
      http.Response response= await get(url,result);
      if(response!=null){
        return response;
      }else{
        return null;
      }
    }on PlatformException catch(e){
      print(e);
      return null;
    }
  }
  Future<http.Response> get(String endpoint,String token)async{
    try{
      var url = Uri.parse(endpoint);
      var response=await http.get(url,headers: {
        "Authorization":"Bearer "+token
      });
      print(response.statusCode);
      return response;
    }catch(e){
      print(e);
      return null;
    }
  }
}