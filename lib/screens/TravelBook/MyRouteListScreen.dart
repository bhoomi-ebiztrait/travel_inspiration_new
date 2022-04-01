import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/MyTitlebar.dart';
import 'package:travel_inspiration/MyWidget/TIMyBottomLayout.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/screens/TravelBook/ShowMyRouteOnMapScreen.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

class MyRouteListScreen extends StatefulWidget {
  // String travelogueTitle;
  // MyRouteListScreen(this.travelogueTitle);

  @override
  _MyRouteListScreenState createState() => _MyRouteListScreenState();
}

class _MyRouteListScreenState extends State<MyRouteListScreen> {

  MyController myController = Get.put(MyController());



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String,dynamic> param ={
      "userId":MyPreference.getPrefStringValue(key: MyPreference.userId),
      "selectedPlace":myController.selectedPlace.value.name,
    };
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myController.getRouteList(param);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: _bodyContent(),

    ));
  }

  _bodyContent() {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(MyImageURL.login),fit: BoxFit.fill)),
      child: Stack(
        children: [
          Column(
            children: [
              MyTopHeader(
                logoImgUrl: MyImageURL.haudos_logo,
              ),
              MyTitlebar(title: "${myController.selectedPlace.value.name.toUpperCase()}",),
              SizedBox(height: Get.height*0.1,),
              Image.asset(MyImageURL.car,height:60,width: 60,color: MyColors.whiteColor,),
              // SizedBox(height: Get.height*0.04,),
              MyText(
                text_name: "my_routes".tr.toUpperCase(),
                txtcolor: MyColors.whiteColor,
                myFont: MyStrings.courier_prime_bold,
                txtfontsize: MyFontSize.size15,
              ),
              SizedBox(height: Get.height*0.04,),
              buildListview(),
            ],
          ),
          Positioned(
            right: 0,
            bottom: 20,
            child: Padding(
              padding: EdgeInsets.only(
                  top: Get.width * .06, right: Get.width * .06),
              child: GestureDetector(
                  onTap: () {
                    // myController.showFlightAndTrainPopup.value = true;
                  },
                  child: Image.asset(MyImageURL.info_big,height: 40,width: 40,)),
            ),
          ),
        ],
      ),
    );
  }

  buildListview() {
    return Obx((){
      return ListView.builder(
          shrinkWrap: true,
          itemCount: myController.routeList.value.length,
          itemBuilder: (context,index){
            return ListTile(
              contentPadding: EdgeInsets.only(
                left: Get.height * .060,
                right: Get.height * .030,
              ),
              title: GestureDetector(
                onTap: (){
                  myController.selectedRoute.value = myController.routeList.value[index];
                  ScreenTransition.navigateToScreenLeft(
                      screenName: ShowMyRouteOnMapScreen());

                },
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${myController.routeList.value[index].startAddress} - ${myController.routeList.value[index].endAddress}",
                          style: TextStyle(
                            color: MyColors.whiteColor,
                              fontFamily: MyFont.Courier_Prime_Bold,
                              fontSize: MyFontSize.size12),
                        ),
                      ),
                    ),
                    /*GestureDetector(
                      onTap: (){
myController.selectedRoute.value = myController.routeList.value[index];
                        ScreenTransition.navigateToScreenLeft(
                            screenName: ShowMyRouteOnMapScreen());

                      },
                      child: Image.asset(
                        MyImageURL.arrow_right,
                        height: Get.height * .032,
                        width: Get.height * .032,
                        fit: BoxFit.fill,
                      ),
                    )*/
                  ],
                ),
              ),
            //  tileColor:  MyColors.expantionTileBgColor.withOpacity(0.32),
            );
          });
    });
  }
}
