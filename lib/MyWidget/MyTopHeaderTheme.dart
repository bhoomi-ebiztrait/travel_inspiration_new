import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyTitlebar.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

import 'MyText.dart';

class MyTopHeaderTheme extends StatelessWidget {
  String headerName;
  String headerImgUrl;
  String networkImgUrl;
  String logoImgUrl;
  double imgHeight, topSpace, leftSpace;
  Function logoCallback;
  Function backArrowCallback;
  File croppedImg;

  MyTopHeaderTheme(
      {this.headerName,
      this.headerImgUrl,
      this.networkImgUrl,
      this.logoImgUrl,
      this.imgHeight,
      this.logoCallback,
        this.backArrowCallback,
      this.croppedImg});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: imgHeight == null ? Get.height * 0.30 : imgHeight,
      width: Get.width,
      decoration: BoxDecoration(
          image: DecorationImage(
        //image: AssetImage(headerImgUrl),
        fit: BoxFit.fill,
        image: croppedImg == null
            ? networkImgUrl != null
                ? NetworkImage(networkImgUrl)
                : AssetImage(headerImgUrl)
            : FileImage(
                croppedImg,
              ),
      )),
      child: Stack(
        children: [
          Center(
            child:MyTitlebar(title: headerName,),
            /*MyText(
              text_name: headerName,
              txtcolor: MyColors.whiteColor,
              txtfontsize: MyFontSize.size23,
              myFont: MyStrings.cagliostro,
              // txtAlign: TextAlign.right,
            ),*/
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: backArrowCallback,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset(MyImageURL.back,
                    width: 25,),
                ),
              ),
              logoImgUrl != null
                  ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GestureDetector(
                          onTap: logoCallback, child: Image.asset(logoImgUrl)),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
