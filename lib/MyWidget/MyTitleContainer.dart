import 'package:flutter/material.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';

class MyContainerWithOnesideRadious extends StatelessWidget {

  String title;
  String myFont;
  double txtfont=MyFontSize.size13;
  Color txtcolor;
  Color btnBgcolor;
  FontWeight fontWeight;

  MyContainerWithOnesideRadious({@required this.title,this.myFont,this.txtcolor,this.txtfont,this.btnBgcolor,this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40),bottomLeft: Radius.circular(40)),
        color: btnBgcolor,

      ),
      margin: EdgeInsets.only(top: 40,left: 60),
      height: 80,
      child: MyText(text_name: title,txtcolor: txtcolor,txtfontsize:txtfont,myFont: myFont,),
    );
  }
}