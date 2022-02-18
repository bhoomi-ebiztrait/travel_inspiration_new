import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

import 'MyText.dart';

class MyTopHeader extends StatelessWidget {
 String headerName;
 String headerImgUrl;
 String logoImgUrl;
 double imgHeight,topSpace,leftSpace;
 Function logoCallback;

 MyTopHeader({this.headerName,this.headerImgUrl,this.logoImgUrl,
   this.imgHeight,this.logoCallback});
  @override
  Widget build(BuildContext context) {
    return Container(
      height:imgHeight==null?Get.height * 0.34:imgHeight,
      width: Get.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(headerImgUrl),
              fit:BoxFit.fill
          )
      ),
      child: Stack(
         children: [
           Center(
             child: MyText(
               text_name: headerName,
               txtcolor: MyColors.whiteColor,
               txtfontsize: MyFontSize.size23,
               myFont: MyStrings.cagliostro,
               // txtAlign: TextAlign.right,
             ),
           ),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back(result: true);
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset(MyImageURL.back,
                    width: 25,),
                ),
              ),
              logoImgUrl != null ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                    onTap: logoCallback,
                    child: Image.asset(logoImgUrl)),
              ):Container(),
            ],
          ),

        ],
      ),
    );
  }
}
