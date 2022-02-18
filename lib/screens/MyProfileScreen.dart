import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/Models/UserInfo.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/MyTextButton.dart';
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
          //maintainBottomViewPadding: true,
          child: buildProfileHeader(),
        ),
      ),
      bottomNavigationBar: buildBottomLayout(),
    );
  }

  buildProfileHeader() {
    return Obx(() {
      userInfo = profileController.userInfo.value;
      return Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                MyImageURL.profile_top,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: Get.height * 0.10,
              ),
              buildBodyContent(),
            ],
          ),
          Positioned(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(MyImageURL.back,
                      width: 25,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        CommonMethod.getAppMode();
                      },
                      child: Image.asset(MyImageURL.logo_icon)),
                ),
              ],
            ),
          ),
          buildProfileImage(),
          buildHeaderText(),
        ],
      );
    });
  }

  buildBodyContent() {
    print("profile ${profileController.userInfo.value.userName}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        buildProfileSubTitle(),
        buildPremiumAccount(),
        SizedBox(
          height: Get.height * 0.04,
        ),
        buildProjectCounter(),
        SizedBox(
          height: Get.height * 0.05,
        ),
        // buildBottomLayout(),
      ],
    );
  }

  buildBottomLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: Get.width,
          height: Get.height * 0.27,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(MyImageURL.profile_bottom),
              fit: BoxFit.fill,
            ),
          ),
          child: Obx(() {
            userInfo = profileController.userInfo.value;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: Get.width,
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
                          text_name: userInfo != null ? getProjectRatio() : "",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    showLegendRow(MyColors.lineColor, "inspire".tr),
                    showLegendRow(MyColors.lightGreenColor, "reflect".tr),
                  ],
                ),
              ],
            );
          }),
        ),
      ],
    );
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
    return Row(
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
                    : "",
                txtfontsize: MyFontSize.size28,
                txtcolor: MyColors.buttonBgColor,
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
                  userInfo.totalKm != null ? "${userInfo.totalKm}KM" : "",
              txtfontsize: MyFontSize.size23,
              txtcolor: MyColors.buttonBgColor,
              myFont: MyStrings.courier_prime_bold,
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            MyText(
              text_name: "total_km".tr,
              txtfontsize: MyFontSize.size10,
              txtcolor: MyColors.buttonBgColor,
              myFont: MyStrings.courier_prime_bold,
            ),
          ],
        ),
      ],
    );
  }

  buildPremiumAccount() {
    if (userInfo.isPremium != null && userInfo.isPremium) {
      return GestureDetector(
        onTap: () {
          Get.to(TIPremiumInfoScreen());
        },
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.02,
            ),
            Image.asset(MyImageURL.diamant),
            SizedBox(
              height: Get.height * 0.02,
            ),
            MyText(
              text_name: "premium_account".tr,
              txtfontsize: MyFontSize.size13,
              txtcolor: MyColors.textColor,
              myFont: MyStrings.courier_prime_bold,
            ),
          ],
        ),
      );
    } else {
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

  buildHeaderText() {
    return Positioned(
        top: Get.height * 0.12,
        right: Get.width * 0.1,
        child: MyText(
          text_name: "profile".tr,
          myFont: MyStrings.cagliostro,
          txtfontsize: MyFontSize.size23,
          txtcolor: MyColors.whiteColor,
        ));
  }

  buildProfileImage() {
    print("avtar: ${userInfo.avatar}");
    print("avtar: ${croppedImg}");
    return Positioned(
      top: Get.height * 0.14,
      left: Get.width * 0.05,
      child: GestureDetector(
        onTap: () {
          showImageOptionDialog();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(300.0),
          child: Container(
            height: 160,
            width: 160,
            child: croppedImg == null
                ? userInfo.avatar != ""
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
