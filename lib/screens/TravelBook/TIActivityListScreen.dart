import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyCustomListWithStar.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyRatingBar.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/TICirculerBox.dart';
import 'package:travel_inspiration/MyWidget/TIMyBottomLayout.dart';
import 'package:travel_inspiration/MyWidget/TISearchBar.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/TIModel/TIDestinationInProgressModel.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

import '../../MyWidget/MyTitlebar.dart';
import 'HotelDetailsScreen.dart';
import 'PinListScreen.dart';

class TIActivityListScreen extends StatefulWidget {

  String travelLougeListTitle;

  TIActivityListScreen({this.travelLougeListTitle});

  @override
  State<TIActivityListScreen> createState() => _TIActivityListScreenState();
}

class _TIActivityListScreenState extends State<TIActivityListScreen> {


  MyController myController = Get.put(MyController());

  double radious;

  bool isPinned = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // radious = myController.selectedPlace.value.km)*1000
    radious = 40000;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(myController.mActivityList.length > 0){
        myController.mActivityList.clear();

      }
      myController.nextPage_token.value = "";
      myController.getActivityList(radious,ApiParameter.activityType,ApiParameter.activityType);
    });
  }

  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {

        myController.getActivityList(radious,ApiParameter.activityType,ApiParameter.activityType);
      } else {
        // MyPrint(tag: "CallAPI", value: "Not Call NOW");
      }
    }
    return true;
  }


  @override
  Widget build(BuildContext context) {

    if(isPinned){
      Timer(
          Duration(seconds: 5),
              () {
            setState(() {
              isPinned = false;
              goToPinListScreen();
            });

          });

    }

    return SafeArea(
        child: Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: false,
          body:_buildBodyContent(),
          backgroundColor: MyColors.settingBgColor,
        ));
  }

  _buildBodyContent(){
    return  Stack(
      children: [
        NotificationListener(
          onNotification: onNotification,
          child: SingleChildScrollView(
            child: Column(
              children: [

                Container(
                  height: Get.height*0.42,
                  width: Get.width,
                  color: MyColors.buttonBgColorHome.withOpacity(0.7),
                  child: Column(
                    children: [
                      MyTopHeader(
                        logoImgUrl: MyImageURL.haudos_logo,
                        logoCallback: (){
                          CommonMethod.getAppMode();
                        },
                      ),
                      MyTitlebar(title:widget.travelLougeListTitle ,),
                      SizedBox(
                        height: Get.height * .020,
                      ),
                      MyText(
                        text_name: "txtRechercherunactivity".tr+"  :",
                        myFont: MyFont.Courier_Prime_Bold,
                        txtfontsize: MyFontSize.size13,
                        txtcolor: MyColors.textColor,
                        txtAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: Get.height * .020,
                      ),
                      TISearchBar(
                        textFormField: TextFormField(
                          style: TextStyle(
                              fontSize: MyFontSize.size10,
                              fontFamily: MyFont.Courier_Prime),
                          //cursorHeight: Get.height * .030,
                          cursorColor: MyColors.searchBorderColor,
                          onChanged: onSearchTextChanged,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * .024,
                      ),
                      GestureDetector(
                        onTap: (){
                          goToPinListScreen();
                        },
                        child: TICirculerBox(
                          imageIcon: MyImageURL.activites3x_icon,
                          title: "txtACTIVITYSEPINGLES".tr,

                        ),
                      ),
                      SizedBox(
                        height: Get.height * .010,
                      ),
                    ],
                  ),
                ),

                Container(
                    padding: const EdgeInsets.only(bottom: 40,top:40),
                    height: Get.height,
                    color: MyColors.buttonBgColorHome.withOpacity(0.30),
                    child:_restaurantList()),
                SizedBox(
                  height: Get.height * .30,
                ),



              ],
            ),
          ),
        ),

        buildPinMsg(),
      ],
    );
  }

  _restaurantList() {
    return Obx((){
      return ListView.builder(
          itemCount:myController.mActivityList.length,
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            TIDestinationInProgressModel  mData = TIDestinationInProgressModel();

            mData = myController.mActivityList[index];


            return Slidable(
              key: ValueKey(mData),

              endActionPane:ActionPane(
                extentRatio: 0.25,
                motion: ScrollMotion(),
                children: [
                  GestureDetector(
                    onTap: (){
                      callCreatePinApi(index);
                    },
                    child: Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(bottom: 10),
                        height: Get.height*0.06,
                        // color: MyColors.whiteColor,
                        child: Image.asset(MyImageURL.pin_brown,fit: BoxFit.fill,)),
                  ),

                ],
              ),
              child: GestureDetector(
                onTap: (){
                  ScreenTransition.navigateToScreenLeft(screenName:
                  HotelDetailsScreen(place_id: myController.mActivityList[index].place_id,name: widget.travelLougeListTitle,photo_ref:myController.mActivityList[index].photo_ref ,));

                },
                child: MyListRowWithStar(
                  heading:mData.name,
                  title: mData.description,
                  subTitle:"Lire la suite",
                  imageUrl:mData.photo_ref != null ?getPhotoImage(mData.photo_ref) : mData.imgUrl,
                  starNumber:5,
                  myRate: mData.rating,
                  starIconSize: Get.width*.05,
                  horizontalPadding: 0.0,
                ),
              ),
            );
          });
    });
  }

  onSearchTextChanged(String text)async{
    ApiManager apiManager = ApiManager();
    print("search text $text");

    if (text.isEmpty) {
      // setState(() {});
      if(myController.mActivityList.length > 0){
        myController.mActivityList.clear();
        myController.nextPage_token.value = "";
      }
      myController.getActivityList(radious,ApiParameter.activityType,ApiParameter.activityType);
      return;
    }
    if(text.length <3)
      return;
    if(myController.mActivityList.length > 0){
      myController.mActivityList.clear();
      myController.nextPage_token.value = "";
    }
    myController.getActivityList(radious,ApiParameter.activityType,"$text ${ApiParameter.activityType}");


  }
  goToPinListScreen() {
    ScreenTransition.navigateToScreenLeft(screenName: PinListScreen(travelLougeListTitle: widget.travelLougeListTitle,title:"txtACTIVITYSEPINGLES".tr,imgIcon:MyImageURL.activites3x_icon ,type: ApiParameter.activityType));
  }

   callCreatePinApi(int index) async{
    ApiManager apiManager = ApiManager();

    Map<String,dynamic> param = {
      //"projectId":myController.selectedProject.value.id,
      "userId":MyPreference.getPrefStringValue(key: MyPreference.userId),
      "title":myController.mActivityList[index].name,
      "description":myController.mActivityList[index].description,
      "imgUrl":myController.mActivityList[index].photo_ref != null ? myController.mActivityList[index].photo_ref : myController.mActivityList[index].imgUrl,
      "rating":myController.mActivityList[index].rating,
      "placeId":myController.mActivityList[index].place_id,
      "type":ApiParameter.activityType,
    };
    await apiManager.createPinAPI(param).then((value) {
    if (value) {

      setState(() {
        isPinned = true;

      });

    }
    });


   }

   buildPinMsg() {
     return Visibility(
       visible: isPinned,
       child: Container(
         //color: MyColors.buttonBgColorHome.withOpacity(0.46),
         height: Get.height,
         width: Get.width,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             SizedBox(height: Get.height *0.2,),
             GestureDetector(
                 onTap: (){
                   setState(() {
                     isPinned = false;
                   });
                   goToPinListScreen();
                 },
                 child: Image.asset(MyImageURL.check_pinned)),
             SizedBox(height: Get.height *0.07,),
             MyText(
               text_name: "pinned".tr,
               txtcolor: MyColors.whiteColor,
               myFont: MyStrings.bodoni72_Bold,
               txtfontsize: MyFontSize.size25,
             ),
           ],
         ),
       ),
     );
    /*return Visibility(
      visible: isPinned,
      child: Container(
        color: MyColors.buttonBgColor.withOpacity(0.46),
        height: Get.height,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: (){
                 setState(() {
                   isPinned = false;
                 });
                 goToPinListScreen();
                },
                child: Image.asset(MyImageURL.check_pinned)),
            SizedBox(height: Get.height *0.1,),
            MyText(
              text_name: "pinned".tr,
              txtcolor: MyColors.whiteColor,
              myFont: MyStrings.courier_prime_bold,
              txtfontsize: MyFontSize.size20,
            ),
          ],
        ),
      ),
    );*/
   }
}
