import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Get{
  String token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3ODUwOGMyLTZiNDktNDI2Zi04NWQyLTMyZGZmMWNhNzBhYSIsImNyZWF0ZWRBdCI6bnVsbCwidXBkYXRlZEF0IjpudWxsLCJuYW1lIjoiYXlvdHVuZGUiLCJwaWN0dXJlIjpudWxsLCJlbWFpbCI6ImF5b3R1bmRlc2FsYW0xNkBnbWFpbC5jb20iLCJhY3RpdmUiOnRydWUsInJlZmVycmFsIjpudWxsLCJwYXNzd29yZCI6bnVsbCwicmVzZXRUb2tlbiI6bnVsbCwibmlja25hbWUiOm51bGwsImxvY2tlZCI6MCwibGFuZ3VhZ2UiOiJlbiIsInZlcmlmaWNhdGlvblRva2VuIjoiNjdkOTI3NDMtNGU0OS00NThlLWE2ZjUtOWEwZDM5NWE2NmVkIiwidmVyaWZpY2F0aW9uRGF0ZVNlbnQiOiIyMDIxLTA4LTI2VDEzOjQ4OjMzLjAwMFoiLCJ2ZXJpZmllZCI6ZmFsc2UsImNvdW50cnkiOiJibyIsImFnZW50IjpudWxsLCJpYXQiOjE2MzMwMzMwMjR9.ZYcc3eCyWb4-LHeM_rtmgxlvwaJoTcg_YpCWLIQexzI";
  static const platform= MethodChannel("com.jhely.a3dtour");
  Future<http.Response> MakeGetRequest(String url)async{
    //Get token
    try{
      //final String result=await platform.invokeMethod("getToken");
      http.Response response= await get(url,token);
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