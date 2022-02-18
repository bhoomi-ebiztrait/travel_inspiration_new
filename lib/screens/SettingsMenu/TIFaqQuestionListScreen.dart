import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/TICommonPopup.dart';
import 'package:travel_inspiration/MyWidget/TINoRecordFound.dart';
import 'package:travel_inspiration/MyWidget/TISearchBar.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/TIModel/TIFAQQuestionListModel.dart';
import 'package:travel_inspiration/TIModel/TIFaqQuestionAnswerModel.dart';
import 'package:travel_inspiration/utils/Loading.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIPrint.dart';

class TIFaqQuestionListScreen extends StatefulWidget {
  String title;
  int title_id;

  TIFaqQuestionListScreen({this.title, this.title_id});

  @override
  _TIFaqQuestionListScreenState createState() =>
      _TIFaqQuestionListScreenState();
}

class _TIFaqQuestionListScreenState extends State<TIFaqQuestionListScreen> {
  String selectedQuestion = "", selectedAns = "";
  MyController myController = Get.put(MyController());

  ApiManager apiManager = Get.put(ApiManager());
  List<TIFaqQuestionAnswerModel> _searchResult = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    apiManager.futureFaqQueAnsListApiCall(titleId: widget.title_id);
  }

  @override
  Widget build(BuildContext context) {
    TIPrint(tag: "Title_id", value: widget.title_id.toString());
    return Scaffold(body: _buildBodyContent());
  }

  _buildBodyContent() {
    return Obx(
      () => SafeArea(
          child: Stack(
        children: [
          Container(
            width: Get.width,
            child: Column(
              children: [
                Stack(
                  children: [
                    _topImageWithText(),
                    _buildProfileImage(),
                  ],
                ),
                SizedBox(
                  height: Get.height * .020,
                ),
                _searchBar(),
                SizedBox(
                  height: Get.height * .020,
                ),
                Expanded(child: _faqQuestionList()),
              ],
            ),
          ),
          _buildQuestionPopup(),
        ],
      )),
    );
  }

  _searchBar() {
    return TISearchBar(
      textFormField: TextFormField(
        style: TextStyle(
            fontSize: MyFontSize.size12, fontFamily: MyFont.Courier_Prime),
        //cursorHeight: Get.height * .030,
        cursorColor: MyColors.textColor,
        onChanged: onSearchTextChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }

  _topImageWithText() {
    return Container(
      height: Get.height * .25,
      width: Get.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(MyImageURL.faq_top), fit: BoxFit.fill)),
      child: Stack(
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: Get.width * .30, top: 15, bottom: 12),
            child: MyText(
              text_name: widget.title,
              txtcolor: MyColors.whiteColor,
              txtfontsize: MyFontSize.size23,
              myFont: MyStrings.cagliostro,
              txtAlign: TextAlign.center,
            ),
          ),
          _buildBackArrowLogo(),
        ],
      ),
    );
  }

  _buildBackArrowLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset(MyImageURL.back,
              width: 25,),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Image.asset(MyImageURL.haudos_logo),
        ),
      ],
    );
  }

  _buildProfileImage() {
    return Padding(
      padding: EdgeInsets.only(left: Get.height * .02, top: Get.height * .13),
      child: Container(
        height: Get.height * .24,
        width: Get.height * .24,
        child: Image.asset(
          MyImageURL.profile_Image,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  _buildQuestionPopup() {
    return Visibility(
      visible: myController.showQuestionPopup.value,
      child: BackdropFilter(
        filter: myController.showQuestionPopup.value
            ? ImageFilter.blur(sigmaX: 5, sigmaY: 5)
            : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            child: TICommonPopup(
              childWidget: Container(
                padding: EdgeInsets.only(
                    left: Get.width * .050, right: Get.width * .030),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: Get.height * .025, right: Get.height * .008),
                        child: GestureDetector(
                          onTap: () {
                            myController.showQuestionPopup.value = false;
                          },
                          child: Image.asset(
                            MyImageURL.cross3x,
                            height: Get.height * .050,
                            width: Get.height * .050,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * .010,
                    ),
                    MyText(
                      text_name: selectedQuestion,
                      txtfontsize: MyFontSize.size14,
                      txtcolor: MyColors.textColor,
                      txtAlign: TextAlign.left,
                      myFont: MyFont.Courier_Prime_Bold,
                    ),
                    SizedBox(
                      height: Get.height * .030,
                    ),
                    MyText(
                      text_name: selectedAns,
                      txtfontsize: MyFontSize.size12,
                      txtcolor: MyColors.textColor,
                      txtAlign: TextAlign.left,
                      myFont: MyFont.Courier_Prime,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _faqQuestionList() {
    return GetX(
        init: ApiManager(),
        builder: (controller) {
          return FutureBuilder<List<TIFaqQuestionAnswerModel>>(
            builder: (index,
                AsyncSnapshot<List<TIFaqQuestionAnswerModel>> snapShot) {
              if (!snapShot.hasData) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return Loading();
                }
              }

              if (snapShot.data == null) {
                return TINoRecordFound();
              }

              if(_searchResult.length != 0) {
                return ListView.builder(
                    itemCount: _searchResult.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          selectedQuestion =
                              _searchResult[index].question + "?";
                          selectedAns = _searchResult[index].answer;
                          myController.showQuestionPopup.value = true;
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: Get.width * .050, right: Get.width * .020),
                          padding: EdgeInsets.all(Get.height * .020),
                          child: Text(
                            _searchResult[index].question + "?",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: MyFont.Courier_Prime_Bold,
                                fontSize: MyFontSize.size14,
                                color: MyColors.textColor),
                          ),
                        ),
                      );
                    });
              } else{
                return ListView.builder(
                    itemCount: snapShot.data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          selectedQuestion =
                              snapShot.data[index].question + "?";
                          selectedAns = snapShot.data[index].answer;
                          myController.showQuestionPopup.value = true;
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: Get.width * .050, right: Get.width * .020),
                          padding: EdgeInsets.all(Get.height * .020),
                          child: Text(
                            snapShot.data[index].question + "?",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: MyFont.Courier_Prime_Bold,
                                fontSize: MyFontSize.size14,
                                color: MyColors.textColor),
                          ),
                        ),
                      );
                    });
              }

            },
            future: apiManager.futureFaqQueAnsList.value,
          );
        });
  }

  onSearchTextChanged(String text)async{
    print("search text $text");
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    apiManager.futureFaqQueAnsList.value.then((faqList) {
      faqList.forEach((faqQueAns) {
        if (faqQueAns.question.toLowerCase().contains(text))
          _searchResult.add(faqQueAns);
        apiManager.futureFaqQueAnsList.refresh();
        print("search list ${_searchResult.length}");
      });
    });
  }
}
