import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';

class AlertDialogSignIn extends StatelessWidget {
  String title;
  String myContent;
  AlertDialogSignIn({Key key, this.title,this.myContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(MyImageURL.login),
              fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            GestureDetector(
              onTap: () {
                Get.back(result: true);
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(
                  MyImageURL.back,
                  width: 25,
                ),
              ),
            ),
            Center(
              child: Image.asset(
                MyImageURL.haudos_splash,
                width: 200,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child:Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/4.5,left: 40,right: 40),
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: MyColors.whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            MyImageURL.cross,
                            width: 30,
                          )),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    myContent != "" ?
                    Html(
                      data: myContent.tr,
                    ):
                    MyText(text_name: title.tr,
                      txtcolor: MyColors.textColor,
                      txtfontsize: MyFontSize.size13,
                      txtAlign: TextAlign.start,
                      myFont: MyFont.Courier_Prime,)

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
