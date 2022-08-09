import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/screens/CreateProjectScreen.dart';
import 'package:travel_inspiration/screens/SettingsMenu/DeleteDestinationScreen.dart';
import 'package:travel_inspiration/screens/TIPinDestinationToProjectScreen.dart';
import 'package:travel_inspiration/screens/TravelBook/TIMyFavoriteCitiesScreen.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIPrint.dart';

class MyFlyMenus extends StatefulWidget {

  var flyMenusList;
  String fromWhere;

  double itemWidth,itemHeight;
  MyFlyMenus({this.flyMenusList,this.itemWidth,this.itemHeight,this.fromWhere});

  @override
  State<MyFlyMenus> createState() => _MyFlyMenusState();
}

class _MyFlyMenusState extends State<MyFlyMenus> {
  MyController myController=Get.find();
  int selectedIndex=-1;
  var flyMenusSelectedList = [
    // MyImageURL.cross_grey_icon,
    MyImageURL.favor_grey,
    MyImageURL.pin_grey_icon,
    MyImageURL.edit_medium_grey,
    MyImageURL.arrowUp3x,
  ];

  // bool isFav = false;



  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Stack(
        children: [
          ListView.builder(
              itemCount:widget.flyMenusList.length,
              itemBuilder: (context,index){
                return Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedIndex = index;
                        });
                        switch(index){
                         /* case 0:Get.to(()=>DeleteDestinationScreen());
                          break;*/
                          case 0:

                            widget.fromWhere == MyStrings.fromHaudos ? callFavApi():callRemoveFavApi();

                            break;
                          case 1:
                            callpinDestinationAPI();
                            // Get.to(()=>TIPinDestinationToProjectScreen(travelLougeTitle: MyStrings.txtPinDestination,));
                          break;
                          case 2:
                           /* myController.showPrepareProjectPopup.value = true;
                            myController.showPrepareProjectMenu.value=false;
                            myController.isFavMenu.value=false;*/
                            Get.to(()=>CreateProjectScreen());
                            break;
                          case 3:myController.showPrepareProjectMenu.value=false;
                          myController.showPrepareProjectPopup.value=false;
                          myController.isFavMenu.value=false;
                          break;
                        }
                      },
                      child:Container(
                          width:widget.itemWidth,
                          height:widget.itemHeight,
                          padding:EdgeInsets.all(0.0),
                          child: Image.asset(
                            selectedIndex == index ? flyMenusSelectedList[index] : ((widget.fromWhere == MyStrings.fromFavCity) && index == 0) ?MyImageURL.favor_white :widget.flyMenusList[index],
                            // selectedIndex == index ? MyImageURL.cross_gray2x: widget.flyMenusList[index],
                            // color: selectedIndex == index ? MyColors.buttonBgColor : MyColors.lineColor,
                            fit: BoxFit.contain,)),
                    ),

                  ],
                );

              }),
         getFavContainer(),
        ],
      );
    });
  }

   getFavContainer() {
     return Visibility(
       visible: myController.isFavMenu.value,
       // visible: true,
       child: Align(
                 alignment: Alignment.topCenter,
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Column(
                     children: [
                       Container(
                         height: 190,
                         width: 190,
                         child: Image.asset(
                           MyImageURL.favor_grey,
                           fit: BoxFit.contain,),
                       ),
                       MyText(
                         text_name: "txtfav".tr,
                         txtfontsize: MyFontSize.size25,
                         txtcolor: MyColors.whiteColor,
                         myFont: MyStrings.bodoni72_Bold,
                       ),

                     ],
                   ),
                 ),
               ),
     );
   }
  void callFavApi() async {


    ApiManager apiManager = ApiManager();
    Map<String, String> param = {
      "userId": MyPreference.getPrefStringValue(key: MyPreference.userId),
      //"projectId": myController.selectedProject.value.id.toString(),
      "city": myController.selectedPlace.value.name,
      "km":myController.selectedPlace.value.km.toStringAsFixed(2),
      "placeId":myController.selectedPlace.value.place_id,
      "image": myController.selectedPlace.value.photo_ref != null ?(myController.selectedPlace.value.photo_ref) : myController.selectedPlace.value.imgUrl,
      // "userId": "43",
    };
    TIPrint(tag: "param", value: param.toString());
    await apiManager.createFavAPI(param).then((value) {
      if (value == true) {
        myController.isFavMenu.value = true;
        Future.delayed(const Duration(milliseconds: 2000), () {
          myController.showPrepareProjectPopup.value = false;
          myController.showPrepareProjectMenu.value=false;
          myController.isFavMenu.value = false;
          Get.to(()=>TIMyFavoriteCitiesScreen(
            travelLougeTitle: "txtMesvilles".tr,
          ));

        });
      } else {}
    });
  }

  void callRemoveFavApi() async {


    ApiManager apiManager = ApiManager();
    Map<String, String> param = {
      "userId": MyPreference.getPrefStringValue(key: MyPreference.userId),
      "bookmarkedId": myController.selectedFavPlace.value.id.toString(),

      // "userId": "43",
    };
    TIPrint(tag: "param", value: param.toString());
    await apiManager.deleteFavAPI(param).then((value) {
      if (value == true){
        myController.showPrepareProjectPopup.value = false;
      myController.showPrepareProjectMenu.value=false;
        myController.isFavMenu.value = false;
      Get.back();
        myController.isFavMenu.value = true;

      } else {}
    });
  }


  callpinDestinationAPI() async {
    ApiManager apiManager = ApiManager();
    Map<String, dynamic> param = {
      "userId": MyPreference.getPrefStringValue(key: MyPreference.userId),
      "project_id": myController.selectedProject.value.id,
      "pin_destination": myController.selectedPlace.value.name,
      "end_lat":myController.selectedPlace.value.lat,
      "end_long":myController.selectedPlace.value.lng,
    };

    await apiManager.pinDestinationAPI(param).then((value) {
      if (value) {
        Get.to(()=>TIPinDestinationToProjectScreen(travelLougeTitle: "txtPinDestination".tr,));
      }
    });
  }
}
