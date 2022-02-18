import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/TIMyBottomLayout.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/screens/TravelBook/ShowMyRouteOnMapScreen.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

class MyRouteListScreen extends StatefulWidget {
  const MyRouteListScreen({Key key}) : super(key: key);

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
      bottomNavigationBar:  MyBottomLayout(
        imgUrl: MyImageURL.travel_book_bottom,
      ),
    ));
  }

  _bodyContent() {
    return Column(
      children: [

        MyTopHeader(
          // headerName:_centerTitle(),
          headerName:
          "${myController.selectedPlace.value.name.toUpperCase()}",
          headerImgUrl: MyImageURL.travel_book_top,
          logoImgUrl: MyImageURL.haudos_logo,
          logoCallback: (){
            CommonMethod.getAppMode();
          },
        ),
        SizedBox(height: Get.height*0.05,),
        buildListview(),
      ],
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
                left: Get.height * .030,
                right: Get.height * .030,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${myController.routeList.value[index].startAddress} - ${myController.routeList.value[index].endAddress}",
                        style: TextStyle(
                            fontFamily: MyFont.Courier_Prime_Bold,
                            fontSize: MyFontSize.size13),
                      ),
                    ),
                  ),
                  GestureDetector(
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
                  )
                ],
              ),
              tileColor:  MyColors.expantionTileBgColor.withOpacity(0.32),
            );
          });
    });
  }
}
