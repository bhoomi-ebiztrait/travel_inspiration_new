import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyQuotedText.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/TICommonPopup.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/screens/InspiredMode/InspredModeScreen.dart';
import 'package:travel_inspiration/screens/ReflectMode/ReflectModeScreen.dart';
import 'package:travel_inspiration/screens/TIGAIAArticleScreen.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/Loading.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:flutter_html/flutter_html.dart';

import '../MyWidget/MyGradientBottomMenu.dart';
import '../MyWidget/MyTitlebar.dart';


class TIGiaListScreen extends StatefulWidget {
  @override
  _TIGiaListScreenState createState() => _TIGiaListScreenState();
}

class _TIGiaListScreenState extends State<TIGiaListScreen> {
  MyController myController = Get.put(MyController());

  ApiManager apiManager = Get.put(ApiManager());
  bool loader = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myController.showPopup.value=false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getArticleList();
    });
  }

  _getArticleList() async {
    Get.dialog(Loading());
    apiManager.articleListApiCall().then((result) {
      if (result != null) {
        apiManager.articleListObs.value = result;
        Get.back();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      bottomNavigationBar: myController.showPopup.value == true ? Container(width: Get.width * 0.85,
        height: Get.height * 0.11,):MyGradientBottomMenu(selString:MyStrings.gaia,
        iconList: [
          MyImageURL.profile_icon,
          MyImageURL.galerie,
          MyImageURL.home_menu,
          MyImageURL.world_selected,
          MyImageURL.setting_icon
        ],
        bgImg: MyImageURL.botom_bg,
      ),

      body: SafeArea(child: _buildBodyContent()),
    ));
  }

  _buildBodyContent() {
    return Stack(children: [
      Column(
        children: [
          Stack(
            children: [
              MyHeader(),

              Padding(
                padding: EdgeInsets.only(top: Get.height * .23),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child:GestureDetector(
                        onTap: () {
                          //myController.showPopup.value = true;
                          _callGaiaInfoApi();
                          ;
                        },
                        child:Image.asset(MyPreference.getPrefStringValue(key: MyPreference.language_code) == "fr" ?MyImageURL.gia_moicircle :MyImageURL.gia_mecircle,height: 120,width: 120,))),
              ),
            ],
          ),
          MyText(
            text_name: "txtVoyagede".tr.toUpperCase(),
            txtcolor: MyColors.buttonBgColorHome.withOpacity(1),
            txtfontsize: MyFontSize.size16,
            myFont: MyFont.Cagliostro_reguler,
          ),
          SizedBox(
            height: Get.height * .030,
          ),
          myController.showPopup.value
              ? Container()
              : Expanded(child: _gialist()),
        ],
      ),
      Visibility(
          visible: myController.showPopup.value,
          child: BackdropFilter(
            filter: myController.showPopup.value
                ? ImageFilter.blur(sigmaX: 5, sigmaY: 5)
                : ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Stack(alignment: Alignment.topCenter, children: [
              Container(
                margin:EdgeInsets.only(top:  Get.height * .15),
                child: TICommonPopup(
                  childWidget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.all(Get.height * .020),
                          child: GestureDetector(
                            onTap: () {
                              myController.showPopup.value = false;
                            },
                            child: Image.asset(
                              MyImageURL.cross3x,
                              height: Get.height * .045,
                              width: Get.height * .045,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(
                                // top: Get.height * .020,
                                left: Get.height * .020,
                                right: Get.height * .020),
                            child:Html(
                              data:apiManager.gaiaInfo.value,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: Get.height * .09,
                ),
                child: Image.asset(MyPreference.getPrefStringValue(key: MyPreference.language_code) == "fr" ?MyImageURL.giai_blue_fr :MyImageURL.giai_blue_en,height: 120,width: 120,),
              ),
            ]),
          ))
    ]);
  }

  _gialist() {
    return GetX(
        init: ApiManager(),
        builder: (controller) {
          return  Padding(
            padding: const EdgeInsets.all(30.0),
            child: ListView.builder(
                itemCount: apiManager.articleListObs.value.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Card(
                      //margin: EdgeInsets.all(Get.width * .020),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(Get.width * .060))),
                      elevation: Get.width * .020,
                      child: Container(
                        padding: EdgeInsets.all(Get.width * .030),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: Get.width*0.5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child:Text(apiManager.articleListObs.value[index].title != null ?
                                    apiManager.articleListObs.value[index].title
                                        :"",
                                      maxLines: 2,
                                      textAlign:TextAlign.left,
                                      style:TextStyle(
                                          fontFamily: MyFont.Cagliostro_reguler,
                                          fontSize: MyFontSize.size15,
                                          color: MyColors.lightGreenColor),
                                    ),
                                    margin: EdgeInsets.only(left:Get.width*.015),
                                  ),
                                  Html(
                                    data:apiManager.articleListObs.
                                    value[index].detail != null ?apiManager.articleListObs.
                                    value[index].detail:"",
                                    style: {
                                      '#': Style(
                                        fontSize: FontSize(15),
                                        maxLines:2,
                                      ),
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Get.to(() => TIGAIAArticleScreen(articalListModel:
                                      apiManager.articleListObs.value[index],));
                                    },
                                    child:Container(
                                      child:Text(
                                        "read_more".tr,
                                        style:TextStyle(
                                          fontFamily: MyFont.Courier_Prime_Bold,
                                          fontSize: MyFontSize.size12,
                                        ),
                                      ),
                                      margin: EdgeInsets.only(left:Get.width*.022),
                                    ),
                                  )


                                ],
                              ),
                            ),
                            /*SizedBox(
                              width: Get.width * .010,
                            ),*/
                            Container(
                                height: 100,
                                width: 100,

                                child:ClipRRect(
                                  borderRadius:BorderRadius.all(
                                      Radius.circular(25)),
                                  child:FadeInImage.assetNetwork(
                                    fit:BoxFit.fill,
                                    placeholder:MyImageURL.loading,
                                    image:apiManager.articleListObs.
                                    value[index].image,
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
        });
  }

  _callGaiaInfoApi(){
    Get.dialog(Loading(),
        barrierDismissible:false);
    apiManager.getGaiaInfo().then((response){
      Get.back();
      if(response.isSuccess()){
        apiManager.gaiaInfo.value=response.getDATAJSONArray1()
        [ApiParameter.data]["gaiaInfo"];
        myController.showPopup.value=true;
      }
    });
  }

  MyHeader() {
    return Container(
      height: Get.height * 0.30,
      width: Get.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            MyImageURL.gaia_bg,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        child: myController.showPopup.value
            ? Container():MyTitlebar(
          title: "txtGaia".tr.toUpperCase(),
        ),
      ),
    );
  }
}
