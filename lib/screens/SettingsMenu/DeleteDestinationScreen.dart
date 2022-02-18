import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/screens/TravelBook/TITravelougeScreen.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

class DeleteDestinationScreen extends StatefulWidget {
  @override
  State<DeleteDestinationScreen> createState() => _DeleteDestinationScreenState();
}

class _DeleteDestinationScreenState extends State<DeleteDestinationScreen> with SingleTickerProviderStateMixin{
  MyController myController = Get.put(MyController());
  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState

    animationController = AnimationController(
        duration: const Duration(seconds: 2), vsync: this);
    super.initState();



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            MyTopHeader(
              headerName: "delete_destination".tr.toUpperCase(),
              headerImgUrl: MyImageURL.travel_book_top,
              logoImgUrl: MyImageURL.logo_icon,
              logoCallback: (){
                CommonMethod.getAppMode();
              },
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: MyText(text_name: "delete_destination_msg".tr,txtfontsize: MyFontSize.size13,txtcolor: MyColors.textColor,),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            MyText(text_name: "remove".tr,txtfontsize: MyFontSize.size13,txtcolor: MyColors.textColor,myFont: MyStrings.courier_prime_bold,),
            SizedBox(
              height: Get.height * 0.02,
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    myController.showPrepareProjectMenu.value=false;
                    myController.isFavMenu.value=false;
                    Get.back();
                  },
                    child: Image.asset(MyImageURL.cross3x)),
                SizedBox(
                  width: Get.width * 0.2,
                ),
                GestureDetector(
                  onTap: (){
                    // _buildRotateArrowWidget();
                    myController.showPrepareProjectPopup.value = false;
                    myController.showPrepareProjectMenu.value=false;
                    myController.isFavMenu.value=false;
                    Get.back();
                    // Get.off(TITravelougeScreen());
                  },
                    child: Image.asset(MyImageURL.check_circle,height: 40,width: 40,)),
              ],
            ),

            Spacer(),
            buildBottomImage(),

          ],
        ),
      ),
    );
  }

  buildBottomImage() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            width: Get.width,
            child: Image.asset(
              MyImageURL.travel_book_bottom,
              fit: BoxFit.fitWidth,
            )));
  }

  _buildRotateArrowWidget(){

    /* myController.rotateArrow.value = true on check circle click and call api and myController.rotateArrow.value = false after getting api response*/
    return Obx(() => Padding(
      padding: EdgeInsets.only(left: Get.width * .25),
      child: myController.rotateArrow.value
          ? RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(
          animationController,
        ),
        child: Image.asset(
          MyImageURL.arrow3x,
          height: Get.height * .050,
          width: Get.height * .050,
          fit: BoxFit.fill,
        ),
      )
          : Container(),
    ));
  }
}
