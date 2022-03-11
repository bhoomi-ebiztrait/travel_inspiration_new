import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyCommonMethods.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/TIModel/TIChooseRouteModel.dart';
import 'package:travel_inspiration/screens/InspiredMode/ChooseProjectNameScreen.dart';
import 'package:travel_inspiration/screens/ReflectMode/ReflectModeCreateProjectScreen.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

import 'PopScreen/ShowAlertDialogCircular.dart';
import 'TICreateNewProjectInInspireModeScreen.dart';
import 'TIInsireModeScreen.dart';

class TIStartNewAdventureScreen extends StatefulWidget {
  @override
  _TIStartNewAdventureScreenState createState() =>
      _TIStartNewAdventureScreenState();
}

class _TIStartNewAdventureScreenState extends State<TIStartNewAdventureScreen> {
  int currentPageValue = 0, infoItemFirstClicked = 2, index1 = 0;
  PageController _sliderController = PageController(initialPage: 0);
  List<TIChoseRouteModel> pageViewList = [
    TIChoseRouteModel(MyImageURL.info_white3x, MyImageURL.bgchoose_your_circle1,
        "Repartiede".tr, true),
    TIChoseRouteModel(MyImageURL.info_white3x, MyImageURL.bgchoose_your_circle2,
        "Comulermes".tr, true)
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBodyContent());
  }

  _buildBodyContent() {
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildPageView(),
          /*_buildPopup(),*/
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
                  height: Get.height * .05,
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
                  height: Get.height * .020,
                ),
                Container(
                  width: Get.width * .42,
                  child: Text(
                    infoItemFirstClicked == 0
                        ? "txtRademaree".tr
                        : "txtReprendre".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
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
    return GestureDetector(
      onTap: () {
        print("pageVal : $currentPageValue");
        MyPreference.setPrefIntValue(
            key: MyPreference.pageVal, value: currentPageValue);

        if (currentPageValue == 0) {
          index1 = 1;
          getChangedPageAndMoveBar(1);
        } else {
          index1 = 0;
          getChangedPageAndMoveBar(0);
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 4),
        height: isActive ? 12 : 12,
        width: isActive ? 12 : 12,
        decoration: BoxDecoration(
            color: isActive ? MyColors.whiteColor : Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(12))),
      ),
    );
  }

  _buildPageView() {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(MyImageURL.bgchoose_your_route),
              fit: BoxFit.cover)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                GestureDetector(
                    onTap: () {
                      CommonMethod.getAppMode();
                    },
                    child: Image.asset(
                      MyImageURL.home_icon,
                      width: 60,
                    )),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 60),
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  bottomLeft: Radius.circular(40)),
              color: MyColors.buttonBgColor,
            ),
            //margin: EdgeInsets.all(20),
            child: MyText(
              text_name: "txtComencer".tr,
              txtcolor: MyColors.whiteColor,
              txtfontsize: MyFontSize.size23,
              myFont: MyStrings.bodoni72_Bold,
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Container(
                  width: Get.width,
                  height: Get.height * .37,
                  margin: EdgeInsets.only(
                      top: Get.height * .10, left: 6, bottom: 20),
                  child: PageView.builder(
                    controller: _sliderController,
                    onPageChanged: (int page) {
                      print("PageIndex: ${page}");
                      getChangedPageAndMoveBar(page);
                    },
                    itemCount: pageViewList.length,
                    itemBuilder: (context, index) {
                      index1 = index;
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(pageViewList[index1]
                                  .bgPath),fit: BoxFit.contain), shape: BoxShape.circle,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 50, top: 60, bottom: 10),
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            currentPageValue == 0
                                ? infoItemFirstClicked = 0
                                : infoItemFirstClicked = 1;
                            print("index clicked: $currentPageValue");
                            if (currentPageValue == 0) {
                              Get.to(() =>
                                  AlertDialogCircular(title: "txtRademaree"));
                            } else {
                              Get.to(() =>
                                  AlertDialogCircular(title: "txtReprendre"));
                            }
                          });
                        },
                        child: Image.asset(
                            pageViewList[currentPageValue].iconPath)),
                  ),
                  Container(
                    width: Get.width * .43,
                    margin: EdgeInsets.only(top: 10, bottom: 20),
                    child: Text(
                      pageViewList[currentPageValue].centerText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MyFontSize.size23,
                          fontFamily: MyFont.Courier_Prime_Bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("pageVal : $currentPageValue");
                      MyPreference.setPrefIntValue(
                          key: MyPreference.pageVal, value: currentPageValue);
                      currentPageValue == 0
                          ? ScreenTransition.navigateToScreenLeft(
                              screenName: (MyPreference.getPrefIntValue(
                                          key: MyPreference.APPMODE)) ==
                                      0
                                  ? TICreateNewProjectInInspireModeScreen()
                                  : ReflectModeCreateProjectScreen())
                          : ScreenTransition.navigateToScreenLeft(
                              screenName: (MyPreference.getPrefIntValue(
                                          key: MyPreference.APPMODE)) ==
                                      0
                                  ? TICreateNewProjectInInspireModeScreen()
                                  : ReflectModeCreateProjectScreen());
                    },
                    child: Image.asset(
                      MyImageURL.arrow3x,
                      fit: BoxFit.contain,
                    ),
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
          /*ClipRect(
              child: Container(
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
                  "txtComencer".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MyFontSize.size23,
                      fontFamily: MyFont.Cagliostro_reguler),
                )),
              ),
            ),
            SizedBox(
              height: Get.height * .060,
            ),*/
          Container(
            margin: EdgeInsets.only(
                left: Get.width * .040, right: Get.width * .040),
            child: Text.rich(
              TextSpan(children: [
                WidgetSpan(
                    child: Padding(
                  padding: EdgeInsets.only(right: Get.width * .030),
                  child: Image.asset(MyImageURL.choose_your_leftquote),
                )),
                TextSpan(
                  text: "txtLeplus".tr,
                  style: TextStyle(
                      color: MyColors.whiteColor,
                      fontSize: MyFontSize.size16,
                      fontFamily: MyFont.Courier_Prime_Italic),
                ),
                WidgetSpan(
                    child: Padding(
                  padding: EdgeInsets.only(left: Get.width * .030),
                  child: Image.asset(MyImageURL.choose_your_rightquote),
                )),
              ]),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: Get.height * .050,
          ),
          Center(
              child: Container(
            margin: EdgeInsets.only(
                left: Get.width * .040, right: Get.width * .040),
            child: Text(
              "txtLoick".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: MyColors.whiteColor,
                  fontSize: MyFontSize.size16,
                  fontFamily: MyFont.Courier_Prime_Bold),
            ),
          )),
        ],
      ),
    );
  }

  void getChangedPageAndMoveBar(int page) {
    currentPageValue = page;
    _sliderController.animateToPage(currentPageValue,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
    MyPreference.setPrefIntValue(
        key: MyPreference.pageVal, value: currentPageValue);
    print("currrrr::: $currentPageValue");

    setState(() {});
  }
}
