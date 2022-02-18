import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/TIModel/TIDestinationInProgressModel.dart';
import 'package:travel_inspiration/screens/MapScreen.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:url_launcher/url_launcher.dart';

class MyCustomRowViewWithImage extends StatelessWidget {
  TIDestinationInProgressModel mList;
  MyCustomRowViewWithImage(this.mList);



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Get.width*.020,
          bottom: Get.width*.020),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Get.height * .09,
            width: Get.height * .11,
            decoration: BoxDecoration(
                borderRadius:
                BorderRadius.all(Radius.circular(Get.width*.08)),
                image: DecorationImage(
                    image: NetworkImage(mList.photo_ref != null ?getPhotoImage(mList.photo_ref) : mList.imgUrl),
                    fit: BoxFit.fill
                )
            ),
          ),
          Container(
            width: Get.width * .68,
            padding:EdgeInsets.only(left: Get.width*.030),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  mList.name,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: MyFont.Courier_Prime_Bold,
                    fontSize: MyFontSize.size11,
                    color: MyColors.textColor,
                  ),
                ),
                SizedBox(height: Get.height*.005,),
                Text(
                  mList.description,
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  style: TextStyle(
                    fontFamily: MyFont.Courier_Prime,
                    fontSize: MyFontSize.size10,
                    color: MyColors.textColor,
                  ),
                ),
                SizedBox(height: Get.height*.005,),
                GestureDetector(
                  onTap: (){
                    goToGoogleDir();
                   // Get.to(()=>MapScreen(mList));
                  },
                  child: Text(
                    mList.content,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: MyFont.Courier_Prime_Bold,
                      fontSize: MyFontSize.size10,
                      color: MyColors.textColor,
                    ),
                  ),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
  void goToGoogleDir() async{
    MyController myController = Get.put(MyController());
    myController.stopTracking();
    Position _getCurrentPosition = await determineCurrentPosition();
    String url = 'https://www.google.com/maps/dir/?api=1&origin=${_getCurrentPosition.latitude},${_getCurrentPosition.longitude}&destination=${mList.lat},${mList.lng}&travelmode=driving&dir_action=navigate';
    print("google dir url $url");
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
