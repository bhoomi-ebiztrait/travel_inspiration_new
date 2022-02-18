import 'package:flutter/material.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';

class MyTextButton extends StatelessWidget {
  final VoidCallback onClick;
  String btn_name;
  String myFont;
  double txtfont=MyFontSize.size13;
  Color txtcolor;
  FontWeight fontWeight;

  MyTextButton({this.onClick,@required this.btn_name,this.myFont,this.txtcolor,this.txtfont,this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onClick, child: MyText(text_name: btn_name,txtfontsize: txtfont,txtcolor:txtcolor,fontWeight: fontWeight,myFont: myFont,));
  }
}

class MyTextButtonStart extends StatelessWidget {
  final VoidCallback onClick;
  String btn_name;
  String myFont;
  double txtfont=MyFontSize.size13;
  Color txtcolor;
  FontWeight fontWeight;

  MyTextButtonStart({this.onClick,@required this.btn_name,this.myFont,this.txtcolor,this.txtfont,this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onClick, child: MyTextStart(text_name: btn_name,txtfontsize: txtfont,txtcolor:txtcolor,fontWeight: fontWeight,myFont: myFont,));
  }
}
