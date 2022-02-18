import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/TITranslaion/TILanguages.dart';
import 'package:travel_inspiration/screens/CreateProfileScreen.dart';
import 'package:travel_inspiration/screens/LoginScreen.dart';
import 'package:travel_inspiration/screens/NotificationScreen.dart';
import 'package:travel_inspiration/screens/ReflectMode/ReflectModeCreateProjectScreen.dart';
import 'package:travel_inspiration/screens/SplashScreen.dart';
import 'package:travel_inspiration/screens/TIChoseRouteModeScreen.dart';
import 'package:travel_inspiration/screens/TIPinDestinationToProjectScreen.dart';
import 'package:travel_inspiration/screens/TravelBook/TIAvailableFlightScreen.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  MyPreference.sharedPreferences=await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  FirebaseMessaging.instance.requestPermission();


  // await DotEnv().load(fileName: '.env');
  /*if (defaultTargetPlatform == TargetPlatform.android) {

    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }*/
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceToken();

   firebaseCloudMessaging_Listeners();
  }

  Future<void> firebaseCloudMessaging_Listeners() async {
    //  var android = new AndroidInitializationSettings('app_icon'); //app_icon
    //  final IOSInitializationSettings initializationSettingsIOS =
    //  IOSInitializationSettings();
    //  var platform = new InitializationSettings(
    //      android: android, iOS: initializationSettingsIOS);
    //  flutterLocalNotificationsPlugin.initialize(platform);
    //
    // if (Platform.isIOS) iOS_Permission();
    /*firebaseMessaging.getToken().then((token) {
      print("device token $token");
      // commonService.setDeviceToken(token);
      MyPreference.setPrefStringValue(key: MyPreference.deviceToken, value: token);
    });*/

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      print("onMessageOpenedApp: onMessage  ${notification.title}");
     // var res  = json.decode(notification.body);
     //  print("onMessageOpenedApp: ${res['msg']}");
     //  fcmMessageHandler(res['msg']);
     //  Get.to(()=>TIPinDestinationToProjectScreen());
      // showNotification(notification);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      print("onMessageOpenedApp: onMessageOpenedApp ${notification.title}");
      Map result = message.data;
      // Reflective == 1, Inspired == 0
      if(result[ApiParameter.mode] == "1"){
        if(result[ApiParameter.type] == CommonMethod.reflective_mode){
          Get.to(NotificationScreen(data:message.data));
        }else if(result[ApiParameter.type] == CommonMethod.vacation){
          Get.to(NotificationScreen(data:message.data));
        }else{
          Get.to(NotificationScreen(data:message.data));
        }
      }else{
        if(result[ApiParameter.type] == CommonMethod.inspired_mode){
          Get.to(NotificationScreen(data:message.data));
        }else if(result[ApiParameter.type] == CommonMethod.vacation){
          Get.to(NotificationScreen(data:message.data));
        }else{
          Get.to(NotificationScreen(data:message.data));
        }
      }


    });

    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      print("onMessageOpenedApp: ${notification.title}");
      // var res  = json.decode(notification.body);
      // print("onMessageOpenedApp: ${res['msg']}");
      // fcmMessageHandler(res['msg']);
      print("onBackgroundMessage: $message");
    });

    /*firebaseMessaging.configure(

      onMessage: (Map<String, dynamic> message) async {
        print(message["data"]["open_val"]);
        fcmMessageHandler(message["data"]["open_val"], navigatorKey);
      },
      // onBackgroundMessage: myBackgroundMessageHandler,
      onResume: (Map<String, dynamic> message) async {
        print('on resume.................. $message');
        fcmMessageHandler(message["data"]["open_val"], navigatorKey);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch..................... $message');
        fcmMessageHandler(message["data"]["open_val"], navigatorKey);
      },
    );*/
  }

  fcmMessageHandler(msg) async {
    print("fcmMessage Handle........");
    String mes="Getting New notification..";
    //  ToastUtils.showSuccess(message: msg);
    // return navigatorKey.currentState
    //              .push(MaterialPageRoute(builder: (_) => DashboardPage(3)));
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => OrderScreen()));

    // String loginId = await commonService.getLoginId();
    // int planId = await commonService.getPlanId();
    // print(loginId);
    // print(msg);
    //
    // if (loginId != null && loginId !="") {
    //   switch (msg) {
    //     case "home_student":
    //       {
    //         return navigatorKey.currentState
    //             .push(MaterialPageRoute(builder: (_) => DashBoardPage(index: 4)));
    //       }
    //       break;
    //     case "student_plan":
    //       {
    //         return navigatorKey.currentState
    //             .push(MaterialPageRoute(builder: (_) => Plans()));
    //       }
    //       break;
    //     case "home_tutor":
    //       {
    //         print("dfdffdhhdf............");
    //         return navigatorKey.currentState
    //             .push(MaterialPageRoute(builder: (_) => TutorDashBoardPage(index:0)));
    //       }
    //       break;
    //   }
    // }
  }


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder:()=>GetMaterialApp(
        /*localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: [
          Locale("fr"),
        ],*/
        locale: Locale(MyPreference.sharedPreferences.getString(MyPreference.language_code)!=null?MyPreference.sharedPreferences.getString(MyPreference.language_code):'en', MyPreference.sharedPreferences.getString(MyPreference.country_code)!=null?MyPreference.sharedPreferences.getString(MyPreference.country_code):'US'),
        // locale: Locale('fr', 'FR'),
        //locale:Locale('fr'),
        translations: TILanguages(),
        title:'Travel Inspiration',
        debugShowCheckedModeBanner: false,
        navigatorKey: Get.key,
        theme:ThemeData(fontFamily:MyStrings.courier_prime,
          // primarySwatch: Color(0xFF213A4C),
          scaffoldBackgroundColor: MyColors.whiteColor,
        ),
        home:SplashScreen(),
          //TIAvailableFlightScreen()
        // home:CreateProfileScreen(),
      ),
    );
  }
}