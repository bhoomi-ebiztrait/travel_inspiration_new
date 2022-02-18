import 'dart:developer';

import 'package:flutter/cupertino.dart';

class TIPrint{
  TIPrint({@required String tag,@required String value}){
    log(tag+"==>"+value);
  }
}