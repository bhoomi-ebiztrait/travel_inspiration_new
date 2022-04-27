import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/TIBioMatric/TILocalAuthApi.dart';
import 'package:travel_inspiration/screens/Gallery/GalleryScreen.dart';
import 'package:travel_inspiration/screens/HomeScreen.dart';
import 'package:travel_inspiration/screens/LoginScreen.dart';
import 'package:travel_inspiration/screens/MyProfileScreen.dart';
import 'package:travel_inspiration/screens/NotificationScreen.dart';
import 'package:travel_inspiration/screens/ReflectMode/ReflectModeScreen.dart';
import 'package:travel_inspiration/screens/SettingsMenu/DeleteAcConfirmScreen.dart';
import 'package:travel_inspiration/screens/SignUpScreen.dart';
import 'package:travel_inspiration/screens/SingupConfirmScreen.dart';
import 'package:travel_inspiration/screens/TIStartNewAdventureScreen.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

import 'CreateProfileScreen.dart';
import 'InspiredMode/InspredModeScreen.dart';
import 'ReflectMode/ReflectModeCreateProjectScreen.dart';
import 'SettingsMenu/ChangePwConfirmScreen.dart';
import 'TIChoseRouteModeScreen.dart';
import 'TIInsireModeScreen.dart';
import 'TravelBook/TraveloguePopupScreen.dart';
import 'TravelBook/VacationProjectFileScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin ,WidgetsBindingObserver{
  AnimationController rotationController;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    rotationController = AnimationController(duration: Duration(milliseconds: 2000), vsync: this);
    super.initState();
    setState(() {
      rotationController.reset();
      if (rotationController.value != null) {
        rotationController.forward(from: 0.0);
      }
    });
    // _callbiomatric();

    _mockCheckForSession().then((status)async {
      if (status) {
      /*  //Get.to(VacationProjectFileScreen());
        // Get.to(ReflectModeCreateProjectScreen());
        // Get.to(InspredModeScreen());
        final hasbioMatric = await  TILocalAuthApi.hasBiometrics();
        if(hasbioMatric){
          final isAuthenticated = await TILocalAuthApi.authenticate();
          if (isAuthenticated) {
            _CallFirstmathod();
          }
        }else{
          _CallFirstmathod();
        }*/
        _CallFirstmathod();


      }
    });

  }

  void _callbiomatric(){
    _mockCheckForSession().then((status)async {
      if (status) {
        //Get.to(VacationProjectFileScreen());
        // Get.to(ReflectModeCreateProjectScreen());
        // Get.to(InspredModeScreen());
         final hasbioMatric = await  TILocalAuthApi.hasBiometrics();
         if(hasbioMatric){
           final isAuthenticated = await TILocalAuthApi.authenticate();
           if (isAuthenticated) {
             _CallFirstmathod();
           }
         }else{
           _CallFirstmathod();
         }


      }
    });
  }

  void _CallFirstmathod(){
   // ScreenTransition.navigateOff(screenName: HomeScreen());
    String userId = MyPreference.getPrefStringValue(
        key: MyPreference.userId);
    if (userId != null) {

        int mode = MyPreference.getPrefIntValue(key: MyPreference.APPMODE);
        mode == 1
            ? ScreenTransition.navigateOffAll(
          // screenName: NotificationScreen())
            screenName: ReflectModeScreen())
            : ScreenTransition.navigateOffAll(
            // screenName: DeleteAcConfirmScreen());
            screenName: InspredModeScreen());
        MyPreference.setPrefIntValue(
            key: MyPreference.APPMODE, value: mode);

    } else {
      // ScreenTransition.navigateOff(screenName: DeleteAcConfirmScreen());
      ScreenTransition.navigateOff(screenName: HomeScreen());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    rotationController.stop();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // _callbiomatric();
    /*setState(() {
      print("CheckStatee");
      print(state);
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: RotationTransition(
              turns: Tween(begin: 0.0, end: 1.0).animate(rotationController),
              child: Image.asset(
                MyImageURL.clock,
                height: Get.height * 0.15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              MyImageURL.haudos_splash,
              height: Get.height * 0.05,
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    return true;
  }
}
