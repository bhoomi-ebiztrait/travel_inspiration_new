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

class TIRestaurantListScreen extends StatefulWidget {

  String travelLougeListTitle;

  TIRestaurantListScreen({this.travelLougeListTitle});

  @override
  State<TIRestaurantListScreen> createState() => _TIRestaurantListScreenState();
}

class _TIRestaurantListScreenState extends State<TIRestaurantListScreen> {


  MyController myController = Get.put(MyController());
  bool isPinned = false;

  double radious;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // radious = myController.selectedPlace.value.km)*1000
    radious = 40000;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(myController.mRestaurantList.length > 0){
        myController.mRestaurantList.clear();

      }
      myController.nextPage_token.value = "";
      myController.getRestaurantList(radious,ApiParameter.resturantType,ApiParameter.resturantType);
    });
  }

  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {

        myController.getRestaurantList(radious,ApiParameter.resturantType,ApiParameter.resturantType);
      } else {
        // MyPrint(tag: "CallAPI", value: "Not Call NOW");
      }
    }
    return true;
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: false,
          backgroundColor: MyColors.settingBgColor,
          body:_buildBodyContent(),

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
                        text_name: "txtRechercherunrestaurant".tr+"  :",
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
                          imageIcon: MyImageURL.restaurant_icon,
                          title: "txtRESTAURANTSEPINGLES".tr,

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
          itemCount:myController.mRestaurantList.length,
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            TIDestinationInProgressModel  mData = TIDestinationInProgressModel();

            mData = myController.mRestaurantList[index];


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
                  HotelDetailsScreen(place_id: myController.mRestaurantList[index].place_id,name: widget.travelLougeListTitle,photo_ref:myController.mRestaurantList[index].photo_ref ,));

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
      if(myController.mRestaurantList.length > 0){
        myController.mRestaurantList.clear();
        myController.nextPage_token.value = "";
      }
      myController.getRestaurantList(radious,ApiParameter.resturantType,ApiParameter.resturantType);
      return;
    }
    if(text.length <3)
      return;
    if(myController.mRestaurantList.length > 0){
      myController.mRestaurantList.clear();
      myController.nextPage_token.value = "";
    }
    myController.getRestaurantList(radious,ApiParameter.resturantType,"$text ${ApiParameter.resturantType}");


  }
  goToPinListScreen() {
    ScreenTransition.navigateToScreenLeft(screenName: PinListScreen(travelLougeListTitle: widget.travelLougeListTitle,title:"txtRESTAURANTSEPINGLES".tr,imgIcon:MyImageURL.restaurant_icon ,type: ApiParameter.resturantType));
  }
  callCreatePinApi(int index) async{
    ApiManager apiManager = ApiManager();

    Map<String,dynamic> param = {
     // "projectId":myController.selectedProject.value.id,
      "userId":MyPreference.getPrefStringValue(key: MyPreference.userId),
      "title":myController.mRestaurantList[index].name,
      "description":myController.mRestaurantList[index].description,
      "imgUrl":myController.mRestaurantList[index].photo_ref != null ? myController.mRestaurantList[index].photo_ref : myController.mRestaurantList[index].imgUrl,
      "rating":myController.mRestaurantList[index].rating,
      "placeId":myController.mRestaurantList[index].place_id,
      "type":ApiParameter.resturantType,
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
       // color: MyColors.buttonBgColor.withOpacity(0.46),
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
  }
}
