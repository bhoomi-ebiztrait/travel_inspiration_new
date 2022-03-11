import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/MyWidget/MyCommonMethods.dart';
import 'package:travel_inspiration/MyWidget/MyTitlebar.dart';
import 'package:travel_inspiration/TIModel/FaqListTitleModel.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/TIMyBottomLayout.dart';
import 'package:travel_inspiration/MyWidget/TINoRecordFound.dart';
import 'package:travel_inspiration/MyWidget/TISearchBar.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/Loading.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

import 'TIFaqQuestionListScreen.dart';

class TIFaqListScreen extends StatefulWidget {
  @override
  _TIFaqListScreenState createState() => _TIFaqListScreenState();
}

class _TIFaqListScreenState extends State<TIFaqListScreen> {
  ApiManager apiManager = Get.put(ApiManager());
  List<FaqListTitleModel> _searchResult = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiManager.futureFaqListApiCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.settingBgColor,
      body: SafeArea(child: _buildBodyContent()),
    );
  }

  _buildBodyContent() {
    return Container(
      width: Get.width,
      height: Get.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(MyImageURL.login), fit: BoxFit.fill),
      ),
      child: Column(
        children: [
          Container(
            height: Get.height * 0.40,
            width: Get.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(MyImageURL.faq_topbg), fit: BoxFit.fill),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    MyTopHeader(),
                    MyTitlebar(title: "    ${"txtFAQASKISTYA".tr}",),
                    buildText(),
                    SizedBox(
                      height: Get.height * .020,
                    ),
                    _searchBar(),
                    SizedBox(
                      height: Get.height * .030,
                    ),
                    _text(),
                    SizedBox(
                      height: Get.height * .010,
                    ),
                  ],
                ),
                Positioned(
                    top: Get.height * 0.05,
                    left: Get.width * 0.05,
                    child: Container(
                      height: 140,
                      width: 140,
                      child: Image.asset(
                        MyImageURL.profile_Image,
                        fit: BoxFit.fill,
                      ),
                    ),),
              ],
            ),
          ),
          Expanded(
            child: Container(
              //height: Get.height*0.60,
              width: Get.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(MyImageURL.faq_bottombg),
                    fit: BoxFit.fill),
              ),
              child: _faqMenuList(),
//             color: MyColors.settingBgColor,
            ),
          ),
          /* Stack(children: [
            _topImageWithText(),
            _buildProfileWithText(),
          ]),
          SizedBox(
            height: Get.height * .010,
          ),
          _searchBar(),
          SizedBox(
            height: Get.height * .020,
          ),
          _text(),
          SizedBox(
            height: Get.height * .020,
          ),
          Expanded(child:_faqMenuList()),*/
        ],
      ),
    );
  }

   buildText() {
    return Padding(
                padding: const EdgeInsets.only(top:20.0,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyText(
                      text_name: "txtTu".tr,
                      myFont: MyFont.Cagliostro_reguler,
                      txtcolor: MyColors.textColor,
                      txtfontsize: MyFontSize.size10,
                    ),
                  ],
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
                EdgeInsets.only(left: Get.width * .30, top: 14, bottom: 14),
            child: MyText(
              text_name: "txtFAQASKISTYA".tr,
              txtcolor: MyColors.whiteColor,
              txtfontsize: MyFontSize.size23,
              myFont: MyStrings.cagliostro,
              txtAlign: TextAlign.right,
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
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Image.asset(MyImageURL.logo_icon),
          ),
        ),
      ],
    );
  }

  _buildProfileWithText() {
    return Stack(
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: Get.height * .03, top: Get.height * .13),
          child: Container(
            height: Get.height * .23,
            width: Get.height * .23,
            child: Image.asset(
              MyImageURL.profile_Image,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(left: Get.height * .16, top: Get.height * .34),
          child: MyText(
            text_name: "txtTu".tr,
            myFont: MyFont.Courier_Prime_Bold,
            txtAlign: TextAlign.center,
            txtcolor: MyColors.textColor,
            txtfontsize: MyFontSize.size10,
          ),
        )
      ],
    );
  }

  _text() {
    return MyText(
      text_name: "txtSelectionneuntheme".tr,
      myFont: MyFont.Cagliostro_reguler,
      txtAlign: TextAlign.center,
      txtcolor: MyColors.textColor,
      txtfontsize: MyFontSize.size14,
    );
  }

  _searchBar() {
    return TISearchBar(
      textFormField: TextFormField(
        style: TextStyle(
            fontSize: MyFontSize.size12, fontFamily: MyFont.Courier_Prime),
        //cursorHeight: Get.height*.030,
        cursorColor: MyColors.textColor,
        onChanged: onSearchTextChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }

  _faqMenuList() {
    return GetX(
        init: ApiManager(),
        builder: (controller) {
          return FutureBuilder<List<FaqListTitleModel>>(
            builder: (index, AsyncSnapshot<List<FaqListTitleModel>> snapShot) {
              if (!snapShot.hasData) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return Loading();
                }
              }

              if (snapShot.data == null) {
                return TINoRecordFound();
              }

              return _searchResult.length != 0
                  ? ListView.builder(
                      itemCount: _searchResult.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            ScreenTransition.navigateToScreenLeft(
                                screenName: TIFaqQuestionListScreen(
                              title: _searchResult[index].title,
                              title_id: _searchResult[index].titleId,
                            ));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            // left: Get.width * .050,
                            // right: Get.width * .020),
                            padding: EdgeInsets.only(top: 15),
                            child: Row(children: [
                              Image.network(_searchResult[index].image,height: 30,width: 30,),
                              /*CircleAvatar(
                                radius: Get.width * .04,
                                backgroundImage: NetworkImage(
                                  _searchResult[index].image,
                                ),
                              ),*/
                              SizedBox(
                                width: Get.width * .030,
                              ),
                              Text(
                                _searchResult[index].title,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: MyFont.Courier_Prime,
                                  color: MyColors.textColor,
                                  fontSize: MyFontSize.size13,
                                ),
                              )
                            ]),
                          ),
                        );
                      })
                  : ListView.builder(
                      itemCount: snapShot.data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            ScreenTransition.navigateToScreenLeft(
                                screenName: TIFaqQuestionListScreen(
                              title: snapShot.data[index].title,
                              title_id: snapShot.data[index].titleId,
                            ));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                                // left: Get.width * .050,
                                // right: Get.width * .020),
                            padding: EdgeInsets.only(top: 15),
                            child: Row(children: [
                              Image.network(snapShot.data[index].image,height: 30,width: 30,),
                              /*CircleAvatar(
                                radius: Get.width * .04,
                                backgroundImage: NetworkImage(
                                  snapShot.data[index].image,
                                ),
                              ),*/
                              SizedBox(
                                width: Get.width * .030,
                              ),
                              Text(
                                snapShot.data[index].title,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: MyFont.Courier_Prime,
                                  color: MyColors.textColor,
                                  fontSize: MyFontSize.size13,
                                ),
                              )
                            ]),
                          ),
                        );
                      });
            },
            future: apiManager.futureFaqList.value,
          );
        });
  }

  onSearchTextChanged(String text) async {
    print("search text $text");
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    apiManager.futureFaqList.value.then((faqTitleList) {
      faqTitleList.forEach((faqTitle) {
        if (faqTitle.title.toLowerCase().contains(text))
          _searchResult.add(faqTitle);
        apiManager.futureFaqList.refresh();
        print("search list ${_searchResult.length}");
      });
    });
  }
}
