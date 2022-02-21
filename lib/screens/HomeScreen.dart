import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyButton.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/screens/LoginScreen.dart';
import 'package:travel_inspiration/screens/SignUpScreen.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';
import 'package:video_player/video_player.dart';

import 'CreateProfileScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  VideoPlayerController _controller;
  bool _visible = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeVideo();
  }

  initializeVideo(){

    super.initState();
    _controller = VideoPlayerController.asset(MyImageURL.bg_video);

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
    // _controller = VideoPlayerController.network(
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
    //   ..initialize().then((_) {
    //     _controller.play();
    //     _visible = true;
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
  /*  _controller = VideoPlayerController.asset(MyImageURL.bg_video,videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));
    _controller.initialize().then((_) {
      _controller.setLooping(true);
      Timer(Duration(milliseconds: 100), () {
        setState(() {
          _controller.play();
          _visible = true;
        });
      });
    });*/
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_controller != null) {
      _controller.dispose();
      _controller = null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return
        Scaffold(
          body: Stack(
            children: [
              VideoPlayer(_controller),
              buildContent(),
            ],
          ),
        );
  }

   buildContent() {
    return Container(
      height: Get.height,
          width: Get.width,
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical:Get.height*0.15,horizontal: Get.height*0.03),
            child: Column(
              children: [
                MyText(text_name: "application_pour_des".tr,txtcolor: MyColors.whiteColor,txtfontsize: MyFontSize.size23,myFont: MyStrings.cagliostro,),
                SizedBox(height: Get.height*0.06,),
                MyText(text_name: "laisse_tes_pas".tr,txtcolor: MyColors.whiteColor,txtfontsize: MyFontSize.size14),
                SizedBox(height: Get.height*0.15,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.08),
                  child:MyButton(btn_name: "je_suis_haudosseen".tr,
                    bgColor: MyColors.buttonBgColorHome,
                    opacity:1.0,txtcolor: MyColors.whiteColor,
                    txtfont: MyFontSize.size10,
                    onClick: (){
                    ScreenTransition.navigateToScreenLeft(
                        screenName: LoginScreen());
                  },),
                ),
                SizedBox(height: Get.height*0.03,),
                Padding(
                  padding:EdgeInsets.symmetric(horizontal: Get.width*0.08),
                  child:MyButton(btn_name: "devenir_haudosseen".tr,
                    bgColor: MyColors.buttonBgColorHome,
                    opacity:1.0,txtcolor: MyColors.whiteColor,
                    txtfont: MyFontSize.size10,onClick: (){
                    // ScreenTransition.navigateToScreenLeft(
                    //     screenName: SignUpScreen());
                      ScreenTransition.navigateToScreenLeft(screenName: CreateProfileScreen());
                    },),
                ),
              ]
            ),
          ),
        );
  }
}
