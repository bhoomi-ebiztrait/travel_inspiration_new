import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/TIPrint.dart';
import 'package:http/http.dart' as http;

import 'MyResponse.dart';

class ApiCall{


 /* Future<MyResponse> CallPostAPI({url,payload})async{
    var url1 = Uri.parse(url);
    TIPrint(tag:"URL==>",value:url);
    // TIPrint(tag: "REQUEST PARAM==>",value: payload.toString());
    Response response = await http.post(url1,
        headers: {"Content-Type": "application/json"},
        body:payload
    );
    TIPrint(tag:"Response body:",value:response.body);
    return new MyResponse(json.decode(response.body),response.statusCode);
  }*/


  Future<dynamic> CallPostAPI({url,payload})async{
    var url1 = Uri.parse(url);
    TIPrint(tag:url,value:url);
    TIPrint(tag:"REQ PARAM",value:payload.toString());
    var response = await http.post(url1,
        headers: {"Content-Type": "application/json"},
        body: json.encode(payload)
    );
    TIPrint(tag:"Response body:",value:response.body);
    return  MyResponse(json.decode(response.body),
        response.statusCode);
  }

  Future<dynamic> CallGetAPI({url})async{
    var url1 = Uri.parse(url);
    TIPrint(tag:"URL",value:url);
    Response response = await http.get(url1,
        headers: {"Content-Type": "application/json"},
        // body: json.encode(payload)
    );
    TIPrint(tag:"Response body:",value:response.body);
    return new MyResponse(json.decode(response.body),response.statusCode);
  }

  Future<dynamic> CallGetWithParamAPI({authority,url,param})async{
    var url1 = Uri.https(authority,url,param);
    TIPrint(tag:"URL",value:url);
    Response response = await http.get(url1,
      headers: {"Content-Type": "application/json"},
      // body: json.encode(param),
    );
    TIPrint(tag:"Response body:",value:response.body);
    return new MyResponse(json.decode(response.body),response.statusCode);
  }
  Future<dynamic> CallPostWithImageAPI(url,fields,image ,imageKey)async{
    var url1 = Uri.parse(url);
    // String key = "i3WMCIwugRPJE41c0AP5F8WqstviDuOeEzRnK9feWwTCYjBYBPEA6jon3BVTsQnc";
    String key = MyPreference.getPrefStringValue(key: MyPreference.accessToken);
    TIPrint(tag:"url",value:url);
    TIPrint(tag:"token",value:key);
    Map<String, String> headers ={"Content-Type": "application/json",'token': '$key'};
    var  request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll(fields);
    request.headers.addAll(headers);
    if( image !=""){
      request.files.add(await http.MultipartFile.fromPath(imageKey,image));
    }
    var response = await request.send();
    final res = await http.Response.fromStream(response);
    TIPrint(tag:"Response body:",value:res.body);

    return new MyResponse(json.decode(res.body), res.statusCode);
  }


  Future<dynamic> CallPostWithTokenAPI(url)async{
    var url1 = Uri.parse(url);
    String key = MyPreference.getPrefStringValue(key:MyPreference.accessToken);
    //String key = "SoqAJWzL5QXReSnuhFwBqLxOXYYmCJRJswlty66Vxx4SQDQvYfdpsRj0B7fO1rDN";
    TIPrint(tag:"url",value:url);
    TIPrint(tag:"token",value:key);
    Response response = await http.post(url1,
      headers: {"Content-Type": "application/json",'Authorization': '$key'},
    );
    TIPrint(tag:"Response body:",value:response.body);
    return new MyResponse(json.decode(response.body), response.statusCode);
  }
  Future<dynamic> CallPostWithParamTokenAPI({url,param})async{
    var url1 = Uri.parse(url);
    String key = MyPreference.getPrefStringValue(key:MyPreference.accessToken);
   // String key = "SoqAJWzL5QXReSnuhFwBqLxOXYYmCJRJswlty66Vxx4SQDQvYfdpsRj0B7fO1rDN";

    TIPrint(tag:"url",value:url);
    TIPrint(tag:"keyToken",value:key);
    TIPrint(tag:"REQ PARAM",value:param.toString());
    //  MyPrint(tag:"token",value:key);
    Response response = await http.post(url1,   body: json.encode(param),
      headers: {"Content-Type": "application/json" ,'token': '$key'},
    );
    TIPrint(tag:"Response body:",value:response.body);
    return new MyResponse(json.decode(response.body), response.statusCode);
  }
  Future<dynamic> CallGetWithTokenAPI(url)async{
    var url1 = Uri.parse(url);
   // String key = "i3WMCIwugRPJE41c0AP5F8WqstviDuOeEzRnK9feWwTCYjBYBPEA6jon3BVTsQnc";
   //  String key = MyPreference.getPrefStringValue(key:MyPreference.accessToken);
    TIPrint(tag:url,value:url);
    String key = MyPreference.getPrefStringValue(key:MyPreference.accessToken);
    TIPrint(tag:"url",value:url);
    TIPrint(tag:"token",value:key);
    Response response = await http.get(url1,
      headers: {"Content-Type":
      "application/json",'token':'$key'},
    );
    TIPrint(tag:"Response body:",value:response.body);
    return new MyResponse(json.decode(response.body), response.statusCode);
  }

  Future<dynamic> CallGetWithVerifyTokenAPI(url)async{
    var url1 = Uri.parse(url);
    // String key = "i3WMCIwugRPJE41c0AP5F8WqstviDuOeEzRnK9feWwTCYjBYBPEA6jon3BVTsQnc";
    //  String key = MyPreference.getPrefStringValue(key:MyPreference.accessToken);
    TIPrint(tag:url,value:url);
    String key = MyPreference.getPrefStringValue(key:MyPreference.accessToken);
    TIPrint(tag:"url",value:url);
    TIPrint(tag:"token",value:key);
    Response response = await http.get(url1,
      headers: {"Content-Type": "application/json",},
    );
    TIPrint(tag:"Response body:",value:response.body);
    return new MyResponse(json.decode(response.body), response.statusCode);
  }
  
}