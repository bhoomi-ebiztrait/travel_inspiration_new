import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/MyWidget/MyQuotedText.dart';
import 'package:travel_inspiration/TIModel/TIChooseRouteModel.dart';
import 'package:travel_inspiration/screens/ReflectMode/ReflectModeCreateProjectScreen.dart';
import 'package:travel_inspiration/screens/TICreateNewProjectInInspireModeScreen.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIPrint.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

import 'TIInsireModeScreen.dart';

class TIChoseRouteModeScreen extends StatefulWidget {
  @override
  _TIChoseRouteModeScreenState createState() => _TIChoseRouteModeScreenState();
}

class _TIChoseRouteModeScreenState extends State<TIChoseRouteModeScreen> {
  int currentPageValue = 0;
  List<TIChoseRouteModel> pageViewList = [
    TIChoseRouteModel(MyImageURL.info_white3x, MyImageURL.choseroutecircle1,
        "txtInspireMode".tr, true),
    TIChoseRouteModel(MyImageURL.info_white3x, MyImageURL.choseroutecircle2,
        "txtModeReflechi".tr, true)
  ];

  int infoItemFirstClicked = 2;
  ApiManager apiManager = ApiManager();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MyPreference.setPrefIntValue(
        key: MyPreference.APPMODE, value: currentPageValue);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
          Scaffold(backgroundColor: Colors.black12, body: _buildBodyContent()),
    );
  }

  _buildBodyContent() {
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildPageView(),
        _buildPopup(),
      ],
    );
  }

  _buildPageView() {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(MyImageURL.chooseroutebg), fit: BoxFit.fill)),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: Get.width,
                height: Get.height * .30,
                margin: EdgeInsets.only(top: Get.height * .020),
                child: PageView.builder(
                  onPageChanged: (int page) {
                    getChangedPageAndMoveBar(page);
                  },
                  itemCount: pageViewList.length,
                  itemBuilder: (context, index) {
                    return Container(

                      decoration: BoxDecoration(
                        border: Border.all(
                        color: Colors.white,
                        width: 4.0,),
                          image: DecorationImage(
                              image: AssetImage(pageViewList[index].bgPath)),
                          shape: BoxShape.circle),
                    );
                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: Get.width * .24,
                        top: Get.width * .08,
                        bottom: Get.height * .04),
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            currentPageValue == 0
                                ? infoItemFirstClicked = 0
                                : infoItemFirstClicked = 1;
                            print("index clicked $currentPageValue");
                          });
                        },
                        child: Image.asset(
                            pageViewList[currentPageValue].iconPath)),
                  ),
                  Container(
                    width: Get.width * .42,
                    child: Text(
                      pageViewList[currentPageValue].centerText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MyFontSize.size25,
                          fontFamily: MyFont.Courier_Prime_Bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Get.height * .035),
                    child: GestureDetector(
                        onTap: () {
                          callSelectModeAPI();
                        },
                        child: Image.asset(
                          MyImageURL.arrow3x,
                          fit: BoxFit.contain,
                        )),
                  ),
                ],
              ),
            ],
          ),
          Container(
            //margin: EdgeInsets.only(bottom: 35),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (int i = 0; i < pageViewList.length; i++)
                  if (i == currentPageValue) ...[circleBar(true)] else
                    circleBar(false),
              ],
            ),
          ),
          SizedBox(
            height: Get.height * .020,
          ),
          Container(
            width: Get.width,
            height: Get.height * .18,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    MyImageURL.bgchoose_your_curveshape,
                  ),
                  fit: BoxFit.fill),
            ),
            child: Center(
                child: Text(
              "txtChoisie".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: MyFontSize.size23,
                  fontFamily: MyFont.Cagliostro_reguler),
            )),
          ),
          SizedBox(
            height: Get.height * .060,
          ),
          MyQuotedText(
            myText: "txtLeplus".tr,
            txtColor: MyColors.buttonBgColor,
            txtFontSize: MyFontSize.size14,
          ),
          SizedBox(
            height: Get.height * .050,
          ),
          Center(
              child: Container(
            margin: EdgeInsets.only(
                left: Get.width * .040, right: Get.width * .040),
            child: Text(
              "txtBouddha".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: MyColors.buttonBgColor,
                  fontSize: MyFontSize.size14,
                  fontFamily: MyFont.Courier_Prime_Bold),
            ),
          )),
        ],
      ),
    );
  }

  _buildPopup() {
    return Visibility(
      visible: infoItemFirstClicked == 0 || infoItemFirstClicked == 1,
      child: BackdropFilter(
        filter: infoItemFirstClicked == 0 || infoItemFirstClicked == 1
            ? ImageFilter.blur(sigmaX: 5, sigmaY: 5)
            : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: Get.height * .28,
            height: Get.height * .28,
            margin: EdgeInsets.all(Get.width * .050),
            decoration: BoxDecoration(
              // The child of a round Card should be in round shape
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 2.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * .010,
                ),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        infoItemFirstClicked = 2;
                      });
                    },
                    child: Image.asset(
                      MyImageURL.cross3x,
                      height: Get.height * .050,
                      width: Get.height * .050,
                      fit: BoxFit.contain,
                    )),
                SizedBox(
                  height: Get.height * .008,
                ),
                Text(
                  infoItemFirstClicked == 0
                      ? "txtInspireMode".tr
                      : "txtModeReflechi".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: MyColors.textColor,
                      fontSize: MyFontSize.size13,
                      fontFamily: MyFont.Courier_Prime_Bold),
                ),
                SizedBox(
                  height: Get.height * .008,
                ),
                Container(
                  height: Get.height * .010,
                  width: Get.height * 0.16,
                  decoration: BoxDecoration(
                      color: MyColors.lightGreenColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                SizedBox(
                  height: Get.height * .008,
                ),
                Container(
                  width: Get.width * .42,
                  child: Text(
                    infoItemFirstClicked == 0
                        ? "txtLeModeInspire".tr
                        : "txtLeModeReflechi".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        letterSpacing: 1.0,
                        color: MyColors.textColor,
                        fontSize: MyFontSize.size10,
                        fontFamily: MyFont.Courier_Prime),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 12,
      width: isActive ? 12 : 12,
      decoration: BoxDecoration(
          color: isActive ? MyColors.buttonBgColor : Colors.grey[300],
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  void getChangedPageAndMoveBar(int page) {
    currentPageValue = page;
    MyPreference.setPrefIntValue(
        key: MyPreference.APPMODE, value: currentPageValue);

    setState(() {});
  }

  callSelectModeAPI() async {
    print("pageVal : $currentPageValue");
    Map param = {
      "userId" : MyPreference.getPrefStringValue(key: MyPreference.userId),
      // "userId" : "43",
      "mode": currentPageValue.toString()
     // "mode":currentPageValue.toString()
    };

    TIPrint(tag: "param",value: param.toString());
    await apiManager.selectModeAPI(param).then((value) {
      if (value) {
        currentPageValue == 1
            ? ScreenTransition.navigateToScreenLeft(
                screenName: ReflectModeCreateProjectScreen())
            : ScreenTransition.navigateToScreenLeft(
                screenName: TIInspireModeScreen());
      }
    });
  }
}
