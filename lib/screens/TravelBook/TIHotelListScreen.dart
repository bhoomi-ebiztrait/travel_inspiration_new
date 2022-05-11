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
import 'package:travel_inspiration/MyWidget/MyTitlebar.dart';
import 'package:travel_inspiration/MyWidget/TICirculerBox.dart';
import 'package:travel_inspiration/MyWidget/TIMyBottomLayout.dart';
import 'package:travel_inspiration/MyWidget/TISearchBar.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/TIModel/TIDestinationInProgressModel.dart';
import 'package:travel_inspiration/screens/TIPinDestinationToProjectScreen.dart';
import 'package:travel_inspiration/screens/TravelBook/PinListScreen.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

import 'HotelDetailsScreen.dart';

class TIHotelListScreen extends StatefulWidget {

  String travelLougeListTitle;

  TIHotelListScreen({this.travelLougeListTitle});

  @override
  State<TIHotelListScreen> createState() => _TIHotelListScreenState();
}

class _TIHotelListScreenState extends State<TIHotelListScreen> {
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
      if(myController.mHotelList.length > 0){
        myController.mHotelList.clear();

      }
      myController.nextPage_token.value = "";
      myController.getHotels(radious,ApiParameter.hotelType,ApiParameter.hotelType);
    });
  }
  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {

        myController.getHotels(radious,ApiParameter.hotelType,ApiParameter.hotelType);
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
        backgroundColor: MyColors.settingBgColor,
        resizeToAvoidBottomInset: false,
        body:_buildBodyContent(),

      ),
    );
  }

  _buildBodyContent(){
    return  Stack(
      children: [
        NotificationListener(
          onNotification: onNotification,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: Get.height*0.45,
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
                        text_name: "txtRechercherunhotel".tr+"  :",
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
                          imageIcon: MyImageURL.hotel_icon,
                          title: "txtHOTELSEPINGLES".tr,

                        ),
                      ),
                      SizedBox(
                        height: Get.height * .010,
                      ),
                    ],
                  ),
                ),

               /* SizedBox(
                  height: Get.height * .030,
                ),*/

                //_hotelList(),
                Container(
                    padding: const EdgeInsets.only(bottom: 40,top:40),
                    height: Get.height,
                    color: MyColors.buttonBgColorHome.withOpacity(0.30),
                    child:_hotelList()),
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

  _hotelList() {
    return Obx((){
      return ListView.builder(
          itemCount:myController.mHotelList.length,
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            TIDestinationInProgressModel  mData = TIDestinationInProgressModel();

                mData = myController.mHotelList[index];


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
                        // color: MyColors.lightGreenColor,
                        // color: MyColors.whiteColor,
                        child: Image.asset(MyImageURL.pin_brown,fit: BoxFit.fill,)),
                  ),

                ],
              ),
              child: GestureDetector(
                onTap: (){
                  ScreenTransition.navigateToScreenLeft(screenName:
                  HotelDetailsScreen(place_id: myController.mHotelList[index].place_id,name: widget.travelLougeListTitle,photo_ref:myController.mHotelList[index].photo_ref ,));

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
      if(myController.mHotelList.length > 0){
        myController.mHotelList.clear();
        myController.nextPage_token.value = "";
      }
      myController.getHotels(radious,ApiParameter.hotelType,ApiParameter.hotelType);
      return;
    }
    if(text.length <3)
      return;
    if(myController.mHotelList.length > 0){
      myController.mHotelList.clear();
      myController.nextPage_token.value = "";
    }
    myController.getHotels(radious,ApiParameter.hotelType,"$text ${ApiParameter.hotelType}");

   /* if(myController.mHotelList != null && myController.mHotelList.length>0) {
      for (int i = 0; i < myController.mHotelList.length; i++) {
        if(myController.mHotelList[i].name.toLowerCase().contains(text)){
          _searchResult.add(myController.mHotelList[i]);
          setState(() {

          });
        }
      }
    }*/

   /* myController.futureFaqQueAnsList.value.then((faqList) {
      faqList.forEach((faqQueAns) {
        if (faqQueAns.question.toLowerCase().contains(text))
          _searchResult.add(faqQueAns);
        apiManager.futureFaqQueAnsList.refresh();
        print("search list ${_searchResult.length}");
      });
    });*/
  }

   goToPinListScreen() {
    ScreenTransition.navigateToScreenLeft(screenName: PinListScreen(travelLougeListTitle: widget.travelLougeListTitle,title:"txtHOTELSEPINGLES".tr,imgIcon:MyImageURL.hotel_icon ,type: ApiParameter.hotelType,));
  }

  callCreatePinApi(int index) async{
    ApiManager apiManager = ApiManager();

    Map<String,dynamic> param = {
      //"projectId":myController.selectedProject.value.id,
      "userId":MyPreference.getPrefStringValue(key: MyPreference.userId),
      "title":myController.mHotelList[index].name,
      "description":myController.mHotelList[index].description,
      "imgUrl":myController.mHotelList[index].photo_ref != null ? myController.mHotelList[index].photo_ref : myController.mHotelList[index].imgUrl,
      "rating":myController.mHotelList[index].rating,
      "placeId":myController.mHotelList[index].place_id,
      "type":ApiParameter.hotelType,
    };
    await apiManager.createPinAPI(param).then((value) {
      if (value) {

        setState(() {
          isPinned = true;

        });

      }
    });


  }

  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    return true;
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
                onTap: () async{
                  setState(() {
                    isPinned = false;
                  });
                  // await Future.delayed(const Duration(seconds: 2),(){goToPinListScreen();});
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
  }
}
