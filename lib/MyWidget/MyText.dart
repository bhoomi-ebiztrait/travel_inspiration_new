import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class MyText extends StatelessWidget {
  String text_name;
  double txtfontsize;
  Color txtcolor;
  FontWeight fontWeight;
  double height;
  String myFont;
  TextAlign txtAlign;

  MyText(
      {this.text_name,
      this.txtcolor,
      this.txtfontsize,
      this.fontWeight,
      this.height,
      this.myFont,
  this.txtAlign=TextAlign.center});

  @override
  Widget build(BuildContext context) {

    return Container(
        child: Center(
            child:Text(
      text_name,

      textAlign: txtAlign,
      // textAlign: TextAlign.center,

      style: TextStyle(
          decoration: TextDecoration.none,
          color: txtcolor,
          fontSize: txtfontsize,
          fontWeight: fontWeight,
          fontFamily: myFont,
          height: height),
    )));
  }
}

class MyTextwithMaxLine extends StatelessWidget {
  String text_name;
  double txtfontsize;
  Color txtcolor;
  FontWeight fontWeight;
  double height;
  String myFont;
  TextAlign txtAlign;
  int maxLine;

  MyTextwithMaxLine(
      {this.text_name,
        this.txtcolor,
        this.txtfontsize,
        this.fontWeight,
        this.height,
        this.myFont,
        this.txtAlign=TextAlign.center,this.maxLine});

  @override
  Widget build(BuildContext context) {

    return Container(
        child: Center(
            child:Text(
              text_name,
maxLines: maxLine ,
              textAlign: txtAlign,
              // textAlign: TextAlign.center,

              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: txtcolor,
                  fontSize: txtfontsize,
                  fontWeight: fontWeight,
                  fontFamily: myFont,
                  height: height),
            )));
  }
}

class MyTextStart extends StatelessWidget {
  String text_name;
  double txtfontsize;
  Color txtcolor;
  FontWeight fontWeight;
  double height;
  String myFont;
  // TextAlign txtAlign;

  MyTextStart(
      {this.text_name,
        this.txtcolor,
        this.txtfontsize,
        this.fontWeight,
        this.height,
        this.myFont,
        });

  @override
  Widget build(BuildContext context) {

    return Container(
        child: Text(
          text_name,
          // textAlign: txtAlign,
          textAlign: TextAlign.start,
          style: TextStyle(
              decoration: TextDecoration.none,
              color: txtcolor,
              fontSize: txtfontsize,
              fontWeight: fontWeight,
              fontFamily: myFont,
              ),
        ));
  }
}

class MyTextEnd extends StatelessWidget {
  String text_name;
  double txtfontsize;
  Color txtcolor;
  FontWeight fontWeight;
  double height;
  String myFont;
  // TextAlign txtAlign;

  MyTextEnd(
      {this.text_name,
        this.txtcolor,
        this.txtfontsize,
        this.fontWeight,
        this.height,
        this.myFont,
      });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: Get.width *0.40,

        alignment: Alignment.topRight,
        child: Text(
          text_name,
          // textAlign: txtAlign,
          textAlign: TextAlign.end,
          maxLines: 4,
          style: TextStyle(
              decoration: TextDecoration.none,
              color: txtcolor,
              fontSize: txtfontsize,
              fontWeight: fontWeight,
              fontFamily: myFont,
              height: height),
        ));
  }
}
