import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';

import 'MyRatingBar.dart';

class MyListRowWithStar extends StatelessWidget {

  String imageUrl,heading,title,subTitle;
  int starNumber;
  double starIconSize,horizontalPadding,myRate;
  MyListRowWithStar({this.imageUrl,this.heading,this.title,
  this.subTitle,this.starNumber,this.starIconSize,this.horizontalPadding,this.myRate});

  @override
  Widget build(BuildContext context) {
    return Container(
            margin: EdgeInsets.only(left: Get.width*.020,
                bottom: Get.width*.020),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Get.height * .10,
                  width: Get.height * .12,
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(Get.width*.08)),
                      image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.fill
                      )
                  ),
                ),
                Container(
                  width: Get.width * .65,
                  padding:EdgeInsets.only(left: Get.width*.030),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width:Get.width*.35,
                            child: Text(
                              heading,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: MyFont.Courier_Prime_Bold,
                                fontSize: MyFontSize.size11,
                                color: MyColors.textColor,
                              ),
                            ),
                          ),
                          MyRatingBar(
                            itemCount:starNumber,
                            initialRating:myRate,
                            iconSize:starIconSize,
                            horizontalPaddong:horizontalPadding,
                           onRateUpdate: null,
                           /* onRateUpdate: (value){
                              print("rating $value");
                            },*/
                          )
                        ],
                      ),
                      SizedBox(height: Get.height*.005,),
                      Text(
                         title,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: MyFont.Courier_Prime,
                          fontSize: MyFontSize.size9,
                          color: MyColors.textColor,
                        ),
                      ),
                      SizedBox(height: Get.height*.005,),
                      Text(
                        subTitle,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: MyFont.Courier_Prime_Bold,
                          fontSize: MyFontSize.size9,
                          color: MyColors.textColor,
                        ),
                      ),

                    ],
                  ),
                )
              ],
            ),
          );

  }
}
