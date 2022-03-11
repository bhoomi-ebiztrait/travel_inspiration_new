import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/Models/UserInfo.dart';
import 'package:travel_inspiration/MyWidget/MyBottomMenu.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/MyTextButton.dart';
import 'package:travel_inspiration/MyWidget/MyTitlebar.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/screens/TIPinDestinationToProjectScreen.dart';
import 'package:travel_inspiration/screens/TIPremiumInfoScreen.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/Loading.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIPrint.dart';

import '../MyWidget/MyGradientBottomMenu.dart';
import 'PhotoPreviewScreen.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key key}) : super(key: key);

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  File croppedImg;
  MyController profileController = Get.put(MyController());

  UserInfo userInfo;

  @override
  void initState() {
    userInfo = profileController.userInfo.value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.getProfile();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          maintainBottomViewPadding: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildProfileHeader(),
              SizedBox(height: Get.height*0.02,),
              buildProfileSubTitle(),
              SizedBox(height: Get.height*0.001,),
              buildProjInfo(),
              SizedBox(height: Get.height*0.02,),
              buildBottomLayout(),
              // MyGradientBottomMenu(),
              SizedBox(height: Get.height*0.02,),
            ],
          ),
        ),
      ),
     bottomNavigationBar:  MyGradientBottomMenu(iconList: [MyImageURL.profile_selected,MyImageURL.galerie,MyImageURL.home_menu,MyImageURL.world_icon,MyImageURL.setting_icon],bgImg: MyImageURL.button_bg_img,),
    );
  }

  buildProfileHeader() {
    return Container(
      height: Get.height * 0.30,
      width: Get.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(MyImageURL.profile_bg,), fit: BoxFit.fill,),
      ),
      child:
      Stack(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //buildProfileImage(),
                Container(
                    width: Get.width,
                    child: MyTitlebar(title: "       ${"profile".tr}",)),
              ],
            ),
          ),
          buildProfileImage(),

        ],
      ),
      //buildProfileSubTitle(),

    );
    // if(profileController.userInfo.value != null && profileController.userInfo.value.userId != null) {
      /*return Obx(() {
        userInfo = profileController.userInfo.value;



      });*/

  }
  buildProjInfo(){
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: 30,right: 30,top: 60),
          width: Get.width,
          height: Get.height*0.3,
          decoration: BoxDecoration(
            color: MyColors.buttonBgColor,
            borderRadius: BorderRadius.all(Radius.circular(37))
          ),
          child: buildProjectCounter(),
        ),
    buildPremiumAccount(),


      ],
    );
  }


  buildBottomLayout() {

    return Container(
      height: Get.height * 0.23,
      margin: EdgeInsets.only(right: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Container(
                width: Get.width * 0.60,
                height: Get.height * 0.23,
                child: SfCircularChart(margin: EdgeInsets.all(0), palette: [
                  MyColors.lineColor,
                  MyColors.lightGreenColor,
                ], annotations: <CircularChartAnnotation>[
                  CircularChartAnnotation(
                    height: "80%",
                    width: "80%",
                    widget: Container(
                      child: MyText(
                        text_name: userInfo != null
                            ? getProjectRatio()
                            : "",
                        txtcolor: ((MyPreference.getPrefIntValue(
                            key: MyPreference.APPMODE)) ==
                            ApiParameter.REFLECT_MODE)
                            ? MyColors.lightGreenColor
                            : MyColors.lineColor,
                        txtfontsize: MyFontSize.size16,
                        myFont: MyStrings.courier_prime_bold,
                      ),
                    ),
                  ),
                ],
                    /*  legend: Legend(isVisible: true,orientation: LegendItemOrientation.horizontal,position: LegendPosition.bottom,
                      alignment: ChartAlignment.center,
                      textStyle: TextStyle(fontSize: MyFontSize.size10)),*/
                    series: <DoughnutSeries<_PieData, String>>[
                      DoughnutSeries<_PieData, String>(

// innerRadius: "30" ,
                        // strokeWidth: 40,
                          animationDuration: 0,
// strokeWidth: 35,
                          explode: false,
                          dataSource: <_PieData>[
                            _PieData(
                                "inspire".tr,
                                userInfo != null
                                    ? userInfo.noOfCreateProjInsp
                                    : 0,
                                ""),
                            _PieData(
                                "reflect".tr,
                                userInfo != null
                                    ? userInfo.noOfCreatedProjReflect
                                    : 0,
                                ""),
                          ],
                          xValueMapper: (_PieData data, _) => data.xData,
                          yValueMapper: (_PieData data, _) => data.yData,
                          dataLabelMapper: (_PieData data, _) => data.text,
                          dataLabelSettings:
                          DataLabelSettings(isVisible: true)),
                    ]),
              ),

            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              showLegendRow(MyColors.lineColor, "inspire".tr),
              showLegendRow(MyColors.lightGreenColor, "reflect".tr),
            ],
          ),
        ],
      ),
    );
   // if(profileController.userInfo.value != null && profileController.userInfo.value.userId != null) {
      /*return Obx(() {
        //userInfo = profileController.userInfo.value;
        //rint("userrrrr11 : ${userInfo.userId}");
        return Container(
          height: Get.height * 0.23,
          margin: EdgeInsets.only(right: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Container(
                    width: Get.width * 0.60,
                    height: Get.height * 0.23,
                    child: SfCircularChart(margin: EdgeInsets.all(0), palette: [
                      MyColors.lineColor,
                      MyColors.lightGreenColor,
                    ], annotations: <CircularChartAnnotation>[
                      CircularChartAnnotation(
                        height: "80%",
                        width: "80%",
                        widget: Container(
                          child: MyText(
                            text_name: userInfo != null
                                ? getProjectRatio()
                                : "",
                            txtcolor: ((MyPreference.getPrefIntValue(
                                key: MyPreference.APPMODE)) ==
                                ApiParameter.REFLECT_MODE)
                                ? MyColors.lightGreenColor
                                : MyColors.lineColor,
                            txtfontsize: MyFontSize.size16,
                            myFont: MyStrings.courier_prime_bold,
                          ),
                        ),
                      ),
                    ],
                        *//*  legend: Legend(isVisible: true,orientation: LegendItemOrientation.horizontal,position: LegendPosition.bottom,
                      alignment: ChartAlignment.center,
                      textStyle: TextStyle(fontSize: MyFontSize.size10)),*//*
                        series: <DoughnutSeries<_PieData, String>>[
                          DoughnutSeries<_PieData, String>(

// innerRadius: "30" ,
                            // strokeWidth: 40,
                              animationDuration: 0,
// strokeWidth: 35,
                              explode: false,
                              dataSource: <_PieData>[
                                _PieData(
                                    "inspire".tr,
                                    userInfo != null
                                        ? userInfo.noOfCreateProjInsp
                                        : 0,
                                    ""),
                                _PieData(
                                    "reflect".tr,
                                    userInfo != null
                                        ? userInfo.noOfCreatedProjReflect
                                        : 0,
                                    ""),
                              ],
                              xValueMapper: (_PieData data, _) => data.xData,
                              yValueMapper: (_PieData data, _) => data.yData,
                              dataLabelMapper: (_PieData data, _) => data.text,
                              dataLabelSettings:
                              DataLabelSettings(isVisible: true)),
                        ]),
                  ),

                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  showLegendRow(MyColors.lineColor, "inspire".tr),
                  showLegendRow(MyColors.lightGreenColor, "reflect".tr),
                ],
              ),
            ],
          ),
        );
      });*/
   /* }else {
      return Container();
    }*/
  }

  showLegendRow(mColor, title) {
    return Row(
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(shape: BoxShape.circle, color: mColor),
        ),
        SizedBox(
          width: Get.width * 0.02,
        ),
        MyTextStart(
          text_name: title,
          txtcolor: mColor,
          txtfontsize: MyFontSize.size13,
          myFont: MyStrings.courier_prime_bold,
        )
      ],
    );
  }

  /*buildBottomLayout() {
    Map<String, double> dataMap = {
      "Inspiré": 5,
      "Réfléchi": 3,
    };
    List<Color> colorList = [
      MyColors.lineColor,
      MyColors.lightGreenColor,
    ];

    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: Get.height * 0.28,
            width: Get.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(MyImageURL.profile_bottom),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Get.height*0.02,),
                  Container(
                    height: Get.height * 0.18,
                    width: Get.width,
                    child: PieChart(
                      chartType: ChartType.ring,
                      dataMap: dataMap,
                      colorList: colorList,
                      centerText: "6.5%",
                      ringStrokeWidth: 35,
                      chartLegendSpacing: 70,
                      legendOptions: LegendOptions(
                        showLegends: false,
                        legendPosition: LegendPosition.bottom,
                        showLegendsInRow: true,
                        // legendTextStyle: TextStyle(color: ),
                      ),

  */
  buildProjectCounter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
SizedBox(
  height: (userInfo.isPremium != null && userInfo.isPremium) ?Get.height *0.03 :0.0,
),
        Padding(
          padding: const EdgeInsets.only(top:12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => TIPinDestinationToProjectScreen(
                        travelLougeTitle: "txtMesprojets".tr,
                      ));
                },
                child: Column(
                  children: [
                    MyText(
                      text_name: userInfo.totalNoOfCreatedProject != null
                          ? userInfo.totalNoOfCreatedProject.toString()
                          : "0",
                      txtfontsize: MyFontSize.size28,
                      txtcolor: MyColors.whiteColor,
                      myFont: MyStrings.courier_prime_bold,
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    MyText(
                      text_name: "projects".tr,
                      txtfontsize: MyFontSize.size10,
                      txtcolor: MyColors.buttonBgColor,
                      myFont: MyStrings.courier_prime_bold,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  MyText(
                    text_name:
                        userInfo.totalKm != null ? "${userInfo.totalKm}KM" : "0.02",
                    txtfontsize: MyFontSize.size23,
                    txtcolor: MyColors.whiteColor,
                    myFont: MyStrings.courier_prime_bold,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  MyText(
                    text_name: "total_km".tr,
                    txtfontsize: MyFontSize.size10,
                    txtcolor: MyColors.whiteColor,
                    myFont: MyStrings.courier_prime_bold,
                  ),
                ],
              ),
            ],
          ),
        ),
       // SizedBox(height: Get.height*0.07,),
      ],
    );
  }

  buildPremiumAccount() {
     if (userInfo.isPremium != null && userInfo.isPremium) {
      return  GestureDetector(
       onTap: () {
         Get.to(TIPremiumInfoScreen());
       },
       child: Container(
         width: Get.width,
         height: Get.height * 0.3,
         // color: Colors.red,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             /*SizedBox(
              height: Get.height * 0.02,
            ),*/
             Image.asset(MyImageURL.premium, height: 120, width: 120,),
             /*SizedBox(
              height: Get.height * 0.01,
            ),*/
             MyText(
               text_name: "premium_account".tr,
               txtfontsize: MyFontSize.size13,
               txtcolor: MyColors.whiteColor,
               myFont: MyStrings.courier_prime_bold,
             ),
           ],
         ),
       ),
     );
    }
    else {
      return Container();
    }

  }

  buildProfileSubTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        MyText(
          text_name: userInfo.country != null ? userInfo.country : "",
          txtfontsize: MyFontSize.size13,
          txtcolor: MyColors.textColor,
        ),
        buildVerticalLine(),
        MyText(
          text_name: userInfo.userName != null ? userInfo.userName : "",
          txtfontsize: MyFontSize.size13,
          txtcolor: MyColors.textColor,
        ),
        buildVerticalLine(),
        MyText(
          text_name: userInfo.age != null ? "${userInfo.age} ans" : "",
          txtfontsize: MyFontSize.size13,
          txtcolor: MyColors.textColor,
        ),
      ],
    );
  }

  buildVerticalLine() {
    return Container(
      color: MyColors.lineColor.withOpacity(0.9),
      height: Get.height * 0.05,
      width: Get.width * 0.003,
    );
  }

 /* buildHeaderText() {
    return Positioned(
        top: Get.height * 0.12,
        right: Get.width * 0.1,
        child: MyText(
          text_name: "profile".tr,
          myFont: MyStrings.cagliostro,
          txtfontsize: MyFontSize.size23,
          txtcolor: MyColors.whiteColor,
        ));
  }*/

  buildProfileImage() {
   // print("avtar: ${userInfo.avatar}");
    //print("avtar: ${croppedImg}");

    return Obx((){
      userInfo = profileController.userInfo.value;
      if(userInfo != null) {
        return Positioned(
          top: Get.height * 0.07,
          left: Get.width * 0.05,
          child: GestureDetector(
            onTap: () {
              showImageOptionDialog();
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(300.0),
              child: Container(
                height: 130,
                width: 130,
                child: croppedImg == null
                    ? (userInfo != null && userInfo.avatar != null &&
                    userInfo.avatar != "")
                    ? Image.network(
                  userInfo.avatar,
                  fit: BoxFit.fill,
                )
                    : Image.asset(
                  MyImageURL.profile_avtar,
                  fit: BoxFit.fill,
                )
                    : Image.file(
                  croppedImg,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        );
      }else{
        return Container();
      }
    });
  }

  showImageOptionDialog() {
    return Get.dialog(AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyText(
                text_name: "choose_option".tr,
                txtcolor: MyColors.textColor,
                txtfontsize: MyFontSize.size16,
                myFont: MyStrings.courier_prime_bold,
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              InkWell(
                  onTap: () async {
                    // _openGallery();
                    croppedImg = await Get.to(
                        () => PhotoPreviewScreen("gallery".tr));
                    if (croppedImg != null) {
                      print("crop ${croppedImg.path}");
                      updateAvtar();
                    } else {
                      setState(() {
                        Get.back();
                      });
                    }
                    /* setState(() {
                        Get.back();

                      });*/
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: MyText(
                      text_name: "gallery".tr,
                      txtcolor: MyColors.textColor,
                      txtfontsize: MyFontSize.size13,
                    ),
                  )),
              SizedBox(
                height: Get.height * 0.02,
              ),
              InkWell(
                  onTap: () async {
                    croppedImg = await Get.to(
                        () => PhotoPreviewScreen("camera".tr));
                    if (croppedImg != null) {
                      print("crop ${croppedImg.path}");
                      updateAvtar();
                    } else {
                      setState(() {
                        Get.back();
                      });
                    }
                    /*    setState(() {
                        Get.back();

                      });*/
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: MyText(
                      text_name: "camera".tr,
                      txtcolor: MyColors.textColor,
                      txtfontsize: MyFontSize.size13,
                    ),
                  )),
            ],
          ),
        )));
  }

  getProjectRatio() {
    int appMode = MyPreference.getPrefIntValue(key: MyPreference.APPMODE);

    if (userInfo.noOfCreatedProjReflect != null &&
        userInfo.noOfCreateProjInsp != null) {
      if (appMode == ApiParameter.REFLECT_MODE) {
        var ratio = (((userInfo.noOfCreatedProjReflect) +
                (userInfo.noOfCreateProjInsp)) /
            (userInfo.noOfCreatedProjReflect));
        print("mRat: $ratio");
        return "${ratio.toStringAsFixed(2)}%";
      } else {
        var ratio = (((userInfo.noOfCreateProjInsp) +
                (userInfo.noOfCreatedProjReflect)) /
            (userInfo.noOfCreateProjInsp));
        print("mRat: $ratio");
        return "${ratio.toStringAsFixed(2)}%";
      }
    } else{
      print("mRatel: ");
      return "0%";
    }
  }

  updateAvtar() async {
    ApiManager apiManager = ApiManager();
    Map<String, String> param = {
      // "userID": MyPreference.getPrefStringValue(key: MyPreference.userId),
      "userId": MyPreference.getPrefStringValue(key: MyPreference.userId),
    };
    TIPrint(tag: "param", value: param.toString());
    await apiManager.updateAvtarAPI(param, croppedImg.path).then((value) {
      setState(() {
        Get.back();
      });
      if (value != null) {
      } else {}
    });
  }
}

class _PieData {
  _PieData(this.xData, this.yData, [this.text]);

  final String xData;
  final num yData;

  final String text;
}
