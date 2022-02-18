import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';

class MyFlyMenu extends StatelessWidget {
  VoidCallback homeButtonClick, editCallback, switchCallback;

  MyFlyMenu({this.homeButtonClick, this.editCallback, this.switchCallback});

  MyController myController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            Container(
                width: Get.height * .10,
                height: Get.height * .10,
                child: GestureDetector(
                    onTap: switchCallback,
                    child:myController.isSwitchClicked.value?
                    Image.asset(
                      MyImageURL.home_switch_grey3x,
                      fit: BoxFit.fill,
                    ):
                    Image.asset(
                      MyImageURL.home_switch3x,
                      fit: BoxFit.fill,
                    )
                )),
            SizedBox(
              height: Get.height * .015,
            ),
            Container(
                width: Get.height * .10,
                height: Get.height * .10,
                child: GestureDetector(
                    onTap: editCallback,
                    child: myController.isEditClicked.value?
                    Image.asset(
                      MyImageURL.home_edit_grey3x,
                      fit: BoxFit.fill,
                    ): Image.asset(
                      MyImageURL.home_edit3x,
                      fit: BoxFit.fill,
                    )
                )),
            SizedBox(
              height: Get.height * .015,
            ),
            Container(
                width: Get.height * .10,
                height: Get.height * .10,
                child: GestureDetector(
                    // onTap: () {
                    //   // setState(() {
                    //   //   isFloatingMenuVisible = false;
                    //   //   isSwitchClicked = false;
                    //   //   isEditClicked = false;
                    //   // });
                    // },
                    onTap: homeButtonClick,
                    child: Image.asset(
                      MyImageURL.home_icon3x,
                      fit: BoxFit.fill,
                    ))),
          ],
        ));
  }
}
