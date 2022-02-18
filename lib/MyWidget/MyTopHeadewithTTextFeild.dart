import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyTextFieldWithImage.dart';
import 'package:travel_inspiration/TIController/MyValidatorController.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

import 'MyText.dart';

class MyTopHeadewithTTextFeild extends StatelessWidget {
 String headerName;
 String headerImgUrl;

 MyValidatorController myValidatorController = Get.put(MyValidatorController());

 TextEditingController projNameController;

 MyTopHeadewithTTextFeild({this.headerName,this.headerImgUrl,this.projNameController});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.30,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(headerImgUrl),
              fit: BoxFit.fill)),
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyHeaderText(),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(MyImageURL.back,
                width: 25,),
            ),
          ),
        ],
      ),
    );
  }

  MyHeaderText(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 60,vertical: 50),
      child: TextFormField(
        onTap: (){},
        textAlign: TextAlign.center,
        controller: projNameController,
        style: TextStyle(color: MyColors.whiteColor, fontSize: MyFontSize.size23,fontFamily: MyStrings.cagliostro,decoration: TextDecoration.none,
        ),
        cursorColor: Colors.black45,
        // keyboardType: edinputType,
        decoration: InputDecoration(
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
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.only(left: 10, right:10),
          hintText: "name_of_project".tr,
          hintStyle: TextStyle(color: MyColors.whiteColor),
          counterText: "",
          filled: true,
        ),
        validator: myValidatorController.validateProjName,
      ),
    );
  }
}
