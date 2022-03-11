import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyCommonMethods.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

class MyTextFieldWithImage extends StatelessWidget {

  TextEditingController mycontroller;
  final VoidCallback onTap;
  final VoidCallback suffixOnTap;
  String addlabel;
  String edError;
  Color color;
  Color labelColor = MyColors.lightGreenColor;
  String imageUrl;
  String suffixImageUrl;
  TextInputType edinputType;
  double txtfontsize;
  bool obscureText = false;
  bool readonly= false;
  int maxlimit;
  double leftPadding;
  double rightPadding;
  String myFont;
  final FormFieldValidator<String> validator;

  int myMaxLine;
  //ValueChanged<String> onChanged;
  // this.onChanged
  MyTextFieldWithImage(
      {this.onTap,
        this.suffixOnTap,
        this.mycontroller,
        this.imageUrl,
        this.suffixImageUrl,
        this.color,
        this.labelColor,
        this.edinputType,
        this.addlabel,
        this.edError,
        this.validator,
        this.obscureText,
        this.txtfontsize,this.maxlimit,
        this.readonly,this.leftPadding = 40.0,this.rightPadding = 40,this.myFont});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20,right: 10),
      child: Padding(
        padding:  EdgeInsets.only(left: leftPadding, top: 0, right: rightPadding),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.transparent,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
            borderRadius: BorderRadius.circular((30)),
          ),
          child: TextFormField(
            readOnly: readonly,
            controller: mycontroller,
            maxLength: maxlimit,
            decoration: InputDecoration(
              counterText: "",
              prefixIcon: imageUrl != null
                  ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: (18)),
                child:Image.asset(
                  imageUrl,
                  width: 22,
                ),
              )
                  : null,
              suffixIcon: suffixImageUrl != null
                  ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: (18)),
                child: GestureDetector(
                  onTap: suffixOnTap,
                  child: Image.asset(
                    suffixImageUrl,
                    width: 25,
                  ),
              ))
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular((25)),
                borderSide: const BorderSide(width: 0, style: BorderStyle.none),
              ),
              filled: true,
              fillColor: MyColors.whiteColor,
              contentPadding: EdgeInsets.all((20)),
              hintText: addlabel,
              hintStyle:
              const TextStyle(color: Colors.black38, fontWeight: FontWeight.w300),
              // labelText: labelText,
            ),
             style: TextStyle(color: MyColors.textColor, fontSize: MyFontSize.size13,fontFamily: myFont,),
            obscureText: obscureText,
            validator: validator,
            keyboardType: edinputType,
            minLines: 1,
            maxLines: obscureText == true ? 1 :  5,
            cursorColor: Colors.black45,
          ),
        )
       /* child: TextFormField(
          onTap: onTap,
          textAlignVertical: TextAlignVertical.center,
          minLines: 1,
          maxLines: obscureText == true ? 1 :  5,
          readOnly: readonly,
          obscureText: obscureText,
          controller: mycontroller,
          maxLength: maxlimit,
          style: TextStyle(color: MyColors.textColor, fontSize: MyFontSize.size13,fontFamily: myFont,
          ),
          cursorColor: Colors.black45,
          keyboardType: edinputType,
          decoration: InputDecoration(
            errorMaxLines: 2,
            enabledBorder:UnderlineInputBorder(
              borderSide:BorderSide(color: MyColors.lineColor),
            ),
            focusedBorder:UnderlineInputBorder(
              borderSide: BorderSide(color: MyColors.lineColor),
            ),
            border:UnderlineInputBorder(
                borderSide:BorderSide(
                    color: MyColors.lineColor
                )
            ),
            fillColor: MyColors.whiteColor,
              isDense: true,
            // contentPadding: const EdgeInsets.only(left: 10, right:10),
            labelText: addlabel,
            labelStyle: TextStyle(color: labelColor),
            alignLabelWithHint: true,
            // hintText: addlabel,
            // hintStyle: TextStyle(color: MyColors.lightGreenColor),
            counterText: "",
            filled: true,
            prefixIcon: imageUrl != null ?new Container(
              padding: const EdgeInsets.only(top: 16,bottom: 12),
              child: Image.asset(
                imageUrl,
                height: Get.height * 0.02,
              ),
            ):null,
            suffixIcon:
            suffixImageUrl != null ?GestureDetector(
              onTap: suffixOnTap,
              child: new Container(

                padding: const EdgeInsets.only(top: 16,bottom: 12),
                child: Image.asset(
                  suffixImageUrl,
                  height: Get.height * 0.02,
                ),
              ),
            ):null,

          ),
          validator: validator,
        ),*/
      ),
    );
  }
}

class MyTextFieldHintWithImageInfo extends StatelessWidget {

  TextEditingController mycontroller;
  final VoidCallback onTap;
  final VoidCallback suffixOnTap;
  String addlabel;
  String edError;
  Color color;
  Color labelColor = MyColors.lightGreenColor;
  String imageUrl;
  String suffixImageUrl;
  TextInputType edinputType;
  double txtfontsize;
  bool obscureText = false;
  bool readonly= false;
  int maxlimit;
  double leftPadding;
  double rightPadding;
  String myFont;
  final FormFieldValidator<String> validator;

  int myMaxLine;
  //ValueChanged<String> onChanged;
  // this.onChanged
  MyTextFieldHintWithImageInfo(
      {this.onTap,
        this.suffixOnTap,
        this.mycontroller,
        this.imageUrl,
        this.suffixImageUrl,
        this.color,
        this.labelColor,
        this.edinputType,
        this.addlabel,
        this.edError,
        this.validator,
        this.obscureText,
        this.txtfontsize,this.maxlimit,
        this.readonly,this.leftPadding = 35.0,this.rightPadding = 35,this.myFont});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: leftPadding, top: 0, right: rightPadding),
      child: TextFormField(
        onTap: onTap,
        textAlignVertical: TextAlignVertical.center,
        minLines: 1,
        maxLines: obscureText == true ? 1 :  5,
        readOnly: readonly,
        obscureText: obscureText,
        controller: mycontroller,
        maxLength: maxlimit,
        style: TextStyle(color: MyColors.textColor, fontSize: MyFontSize.size13,fontFamily: myFont,
        ),
        cursorColor: Colors.black45,
        keyboardType: edinputType,
        decoration: InputDecoration(
          errorMaxLines: 2,
          enabledBorder:UnderlineInputBorder(
            borderSide:BorderSide(color: MyColors.lineColor),
          ),
          focusedBorder:UnderlineInputBorder(
            borderSide: BorderSide(color: MyColors.lineColor),
          ),
          border:UnderlineInputBorder(
              borderSide:BorderSide(
                  color: MyColors.lineColor
              )
          ),
          fillColor: MyColors.whiteColor,
          isDense: true,
          // contentPadding: const EdgeInsets.only(left: 10, right:10),
          labelText: "mot_de_passe".tr,
          labelStyle: TextStyle(color: labelColor),
          alignLabelWithHint: true,
          // hintText: addlabel,
          // hintStyle: TextStyle(color: MyColors.lightGreenColor),
          counterText: "",
          filled: true,
          prefixIcon: imageUrl != null ?new Container(
            padding: const EdgeInsets.only(top: 16,bottom: 12),
            child: Image.asset(
              imageUrl,
              height: Get.height * 0.02,
            ),
          ):null,
          suffixIcon:
          suffixImageUrl != null ?Container(
            width: 70,
            padding: const EdgeInsets.only(top: 16,bottom: 12),
            // color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap:suffixOnTap,
                  child: Image.asset(
                    suffixImageUrl,
                    height: Get.height * 0.03,
                  ),
                ),
                SizedBox(width: 10,),
                GestureDetector(
                  onTap: (){
                    MyCommonMethods.showInfoCenterDialog(msgContent: "password_rules".tr,myFont: MyStrings.courier_prime_bold);
                  },
                  child: Image.asset(
                    MyImageURL.info,
                    height: Get.height * 0.03,
                  ),
                ),
              ],
            ),
          ):null,


        ),
        validator: validator,
      ),
    );
  }
}

class MyTextFieldHintWithImage extends StatelessWidget {

  TextEditingController mycontroller;
  final VoidCallback onTap;
  final VoidCallback suffixOnTap;
  String addHint;
  String edError;
  Color color;
  Color labelColor = MyColors.lightGreenColor;
  String imageUrl;
  String suffixImageUrl;
  TextInputType edinputType;
  double txtfontsize;
  bool obscureText = false;
  bool readonly= false;
  int maxlimit;
  double leftPadding;
  double iconPadding;
  double rightPadding;
  String myFont;
  final FormFieldValidator<String> validator;

  int myMaxLine;
  //ValueChanged<String> onChanged;
  // this.onChanged
  MyTextFieldHintWithImage(
      {this.onTap,
        this.suffixOnTap,
        this.mycontroller,
        this.imageUrl,
        this.suffixImageUrl,
        this.color,
        this.labelColor,
        this.edinputType,
        this.addHint,
        this.edError,
        this.validator,
        this.obscureText,
        this.txtfontsize,this.maxlimit,
        this.readonly,this.leftPadding = 35.0,this.iconPadding = 0 ,this.rightPadding = 35,this.myFont});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: leftPadding, top: 0, right: rightPadding),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        minLines: 1,
        maxLines: obscureText == true ? 1 :  5,
        // textAlign: TextAlign.center,
        onTap: onTap,
        readOnly: readonly,
        obscureText: obscureText,
        controller: mycontroller,
        maxLength: maxlimit,
        style: TextStyle(color: MyColors.textColor, fontSize: MyFontSize.size13,fontFamily: myFont,
        ),
        cursorColor: Colors.black45,
        keyboardType: edinputType,
        decoration: InputDecoration(
          errorMaxLines: 2,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MyColors.lineColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MyColors.lineColor),
          ),
          border: new UnderlineInputBorder(
              borderSide: new BorderSide(
                  color: MyColors.lineColor
              )
          ),
          fillColor: MyColors.whiteColor,
          isDense: true,

          alignLabelWithHint: true,
          hintText: addHint,
          hintStyle: TextStyle(color: MyColors.textColor.withOpacity(0.35)),
          counterText: "",
          filled: true,
          prefixIcon: imageUrl != null ?new Container(
            padding:  EdgeInsets.only(left: iconPadding,),
            child: Image.asset(
              imageUrl,
              height: Get.height * 0.02,
            ),
          ):null,
          suffixIcon: suffixImageUrl != null ?GestureDetector(
            onTap: suffixOnTap,
            child: new Container(

              padding: const EdgeInsets.only(top: 16,bottom: 12),
              child: Image.asset(
                suffixImageUrl,
                height: Get.height * 0.02,
              ),
            ),
          ):null,


        ),
        validator: validator,
      ),
    );
  }
}
class MyTextFieldHint extends StatelessWidget {

  TextEditingController mycontroller;
  final VoidCallback onTap;
  final VoidCallback suffixOnTap;
  String addHint;
  String edError;
  Color color;
  Color labelColor = MyColors.lightGreenColor;
  String imageUrl;
  String suffixImageUrl;
  TextInputType edinputType;
  double txtfontsize;
  bool obscureText = false;
  bool readonly= false;
  int maxlimit;
  double leftPadding;
  double rightPadding;
  String myFont;
  final FormFieldValidator<String> validator;

  int myMaxLine;
  //ValueChanged<String> onChanged;
  // this.onChanged
  MyTextFieldHint(
      {this.onTap,
        this.suffixOnTap,
        this.mycontroller,
        this.imageUrl,
        this.suffixImageUrl,
        this.color,
        this.labelColor,
        this.edinputType,
        this.addHint,
        this.edError,
        this.validator,
        this.obscureText,
        this.txtfontsize,this.maxlimit,
        this.readonly,this.leftPadding = 35.0,this.rightPadding = 35,this.myFont});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: leftPadding, top: 0, right: rightPadding),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        // textAlign: TextAlign.center,
        onTap: onTap,
        readOnly: readonly,
        obscureText: obscureText,
        controller: mycontroller,
        maxLength: maxlimit,
        style: TextStyle(color: MyColors.textColor, fontSize: MyFontSize.size13,fontFamily: myFont,
        ),
        cursorColor: Colors.black45,
        keyboardType: edinputType,
        decoration: InputDecoration(
          errorMaxLines: 2,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MyColors.lineColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MyColors.lineColor),
          ),
          border: new UnderlineInputBorder(
              borderSide: new BorderSide(
                  color: MyColors.lineColor
              )
          ),
          fillColor: MyColors.whiteColor,
          isDense: true,

          alignLabelWithHint: true,
          hintText: addHint,
          hintStyle: TextStyle(color: MyColors.textColor.withOpacity(0.35)),
          counterText: "",
          filled: true,
          prefixIcon: imageUrl != null ?new Container(
            // padding: const EdgeInsets.only(left: 40,),
            child: Image.asset(
              imageUrl,
              height: Get.height * 0.02,
            ),
          ):null,


        ),
        // validator: validator,
      ),
    );
  }
}
