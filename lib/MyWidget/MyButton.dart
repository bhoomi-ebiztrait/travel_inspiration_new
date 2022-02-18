import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

class MyButton extends StatelessWidget {

  final VoidCallback onClick;
  String btn_name;
  double txtfont=MyFontSize.size13;
  Color txtcolor;
  Color bgColor;
  FontWeight fontWeight;
  double opacity;

  MyButton({this.onClick,@required this.btn_name,this.txtcolor,this.bgColor,this.txtfont,this.fontWeight,this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        color: bgColor.withOpacity(opacity),

      ),
      //margin: EdgeInsets.all(20),
      child: MaterialButton(onPressed: onClick,
        minWidth: Get.width*0.50,
        child: MyText(text_name: btn_name,txtcolor: txtcolor,txtfontsize:txtfont),
        /*shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),*/
      ),
    );
  }
}

class MyButtonWithOnesideRadious extends StatelessWidget {

  final VoidCallback onClick;
  String btn_name;
  String myFont;
  double txtfont=MyFontSize.size13;
  Color txtcolor;
  Color btnBgcolor;
  FontWeight fontWeight;

  MyButtonWithOnesideRadious({this.onClick,@required this.btn_name,this.myFont,this.txtcolor,this.txtfont,this.btnBgcolor,this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30)),
        color: btnBgcolor.withOpacity(1),

      ),
      //margin: EdgeInsets.all(20),
      child: MaterialButton(onPressed: onClick,
        minWidth: Get.width*0.50,
        child: MyText(text_name: btn_name,txtcolor: txtcolor,txtfontsize:txtfont,myFont: myFont,),
        /*shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),*/
      ),
    );
  }
}
class MyButtonWithIcon extends StatelessWidget {

  final VoidCallback onClick;
  String btn_name;
  String myFont;
  double txtfont=MyFontSize.size13;
  Color txtcolor;
  FontWeight fontWeight;

  MyButtonWithIcon({this.onClick,@required this.btn_name,this.myFont,this.txtcolor,this.txtfont,this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomRight: Radius.circular(30)),
        color: MyColors.whiteColor,
        border: Border.all(color:MyColors.buttonBgColor),
          boxShadow: [BoxShadow(
            color: MyColors.buttonBgColor,
            blurRadius: 1.0,
          ),]

      ),
      //margin: EdgeInsets.all(20),
      child:MaterialButton(onPressed: onClick,
      minWidth: Get.width*0.50,
      child: Row(
        children: [
          Image.asset(MyImageURL.google,height: Get.height * 0.04),
          MyText(text_name: btn_name,txtcolor: txtcolor,txtfontsize:txtfont,myFont: myFont,txtAlign: TextAlign.start,),
        ],
      ),
      /*shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),*/
    ),
    );
  }
}

class MyButtonWithoutIcon extends StatelessWidget {

  final VoidCallback onClick;
  String btn_name;
  String myFont;
  double txtfont=MyFontSize.size13;
  Color txtcolor;
  Color bgcolor;
  FontWeight fontWeight;

  MyButtonWithoutIcon({this.onClick,@required this.btn_name,this.myFont,this.txtcolor,this.bgcolor,this.txtfont,this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomRight: Radius.circular(30)),
          color: bgcolor,
          border: Border.all(color:MyColors.buttonBgColor),
          boxShadow: [BoxShadow(
            color: MyColors.buttonBgColor,
            blurRadius: 1.0,
          ),]

      ),
      //margin: EdgeInsets.all(20),
      child:MaterialButton(onPressed: onClick,
        minWidth: Get.width*0.50,
        child: Row(
          children: [

            MyText(text_name: btn_name,txtcolor: txtcolor,txtfontsize:txtfont,myFont: myFont,txtAlign: TextAlign.start,),
          ],
        ),
        /*shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),*/
      ),
    );
  }
}


class MyButtonRight extends StatelessWidget {
  final VoidCallback onClick;
  String btn_name;
  String myFont;
  double txtfont=MyFontSize.size13;
  Color txtcolor;
  String imgeUrl;

  MyButtonRight({this.onClick,@required this.btn_name,this.myFont,this.txtcolor,this.txtfont,this.imgeUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: Get.height * .050,
          width: Get.width * .45,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Get.width * .045),
                bottomLeft: Radius.circular(Get.width * .045),
              ),
              border: Border.all(
                color: MyColors.expantionTileBgColor,
              ),
              boxShadow: [
                BoxShadow(
                    color: MyColors.expantionTileBgColor,
                    offset:Offset(1,1)
                )
              ]
          ),
          child: MaterialButton(onPressed: onClick,
            minWidth: Get.width*0.50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(imgeUrl,height: Get.height * 0.04,),
                MyText(text_name: btn_name,txtcolor: txtcolor,txtfontsize:txtfont,myFont: myFont,txtAlign: TextAlign.start,),
              ],
            ),
            /*shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),*/
          ),
        ),
      ],
    );
  }
}


class MyButtonSmall extends StatelessWidget {

  final VoidCallback onClick;
  String btn_name;
  double txtfont=MyFontSize.size13;
  Color txtcolor;
  FontWeight fontWeight;
  double btnWidth = 0.5;

  MyButtonSmall({this.onClick,@required this.btn_name,this.txtcolor,this.txtfont,this.fontWeight,this.btnWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: Get.width*btnWidth,
      height: Get.height*0.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color: MyColors.whiteColor,
          boxShadow: [
            BoxShadow(
            color: MyColors.dialog_shadowColor,
            blurRadius: 2.0,
          ),]
      ),
      //margin: EdgeInsets.all(20),
      child: MaterialButton(onPressed: onClick,
        // minWidth: Get.width*0.4,
        child: MyText(text_name: btn_name,
            txtcolor: txtcolor,txtfontsize:txtfont),
        /*shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),*/
      ),
    );
  }
}