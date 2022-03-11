import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/MyColors.dart';
import 'MyLoginHeader.dart';
import 'MyTitlebar.dart';

class MySettingTop extends StatelessWidget {
String title;

MySettingTop({this.title});
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: Get.height * 0.30,
      width: Get.width,
      color: MyColors.buttonBgColorHome.withOpacity(0.7),

      child: Column(
        children: [
          MyTopHeader(),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: MyTitlebar(
              title: title.toUpperCase(),
            ),
          ),
        ],
      ),
    );
  }
}
