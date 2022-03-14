import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyDropDownButton.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/TIMyBottomLayout.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/TIModel/TIMyAccountLanguageModel.dart';
import 'package:travel_inspiration/utils/Loading.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/MyUtility.dart';
import 'package:travel_inspiration/utils/TIStrings.dart';

import '../../MyWidget/MyGradientBottomMenu.dart';
import '../../MyWidget/MySettingTop.dart';

class TIMyAccountLanguageScreen extends StatefulWidget {
  @override
  _TIMyAccountLanguageScreenState createState() =>
      _TIMyAccountLanguageScreenState();
}

class _TIMyAccountLanguageScreenState extends State<TIMyAccountLanguageScreen>
    with SingleTickerProviderStateMixin {

  MyController myController = Get.put(MyController());

  AnimationController animationController;
  ApiManager apiManager=Get.put(ApiManager());
  bool loader=true;
  List<TIMyAccountLanguageModel> listLanguage = [];


  @override
  void initState() {
    // TODO: implement initState
    animationController = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    super.initState();

    listLanguage.add(TIMyAccountLanguageModel(isSelected:  MyPreference.getPrefStringValue(key: MyPreference.language_code)=="fr"?true:false,language_name: "txtlangFranlang".tr,local: Locale('fr', 'FR')));
    listLanguage.add(TIMyAccountLanguageModel(isSelected:  MyPreference.getPrefStringValue(key: MyPreference.language_code)=="en"?true:false,language_name: "txtLangAnglais".tr,local: Locale('en','US')));

    /*WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _callGetLanguageApiCall();
    });*/


  }

  _callGetLanguageApiCall()async{
    try {
      Get.dialog(Loading());
      List<TIMyAccountLanguageModel> lngList=await apiManager.getLanguageApiCall();
      if(lngList!=null){
        setState(() {
          loader=false;
        });
        apiManager.languageList.value=lngList;
        for(int i=0;i<apiManager.languageList.value.length;i++){
          if(apiManager.languageList.value[i].id==1){
            if(myController.updatedLanguage.value!=null){
              myController.selectedLanguage.value=
                  myController.updatedLanguage.value;
            }else{
              myController.selectedLanguage.value=
                  apiManager.languageList.
                  value[i].language_name;
            }

          }
        }
      }
    } finally {
      Get.back();
    }

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myController.isExapanded.value=false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.settingBgColor,
      bottomNavigationBar:  MyGradientBottomMenu(iconList: [MyImageURL.profile_icon,MyImageURL.galerie,MyImageURL.home_menu,MyImageURL.world_icon,MyImageURL.setting_selected],bgImg: MyImageURL.change_pw_bottom,bgColor: MyColors.buttonBgColorHome.withOpacity(0.7),),
        body:_buildBodyContent(),
);
  }

  _buildBodyContent(){
    return  SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          MySettingTop(title: "txtmyCompte".tr,),

          SizedBox(
            height: Get.height * .040,
          ),
          Padding(
            padding: EdgeInsets.only(left: Get.height * .030),
            child: Row(
              children: [
                Text(
                  "txtLangue".tr,
                  style: TextStyle(
                      color: MyColors.textColor,
                      fontFamily: MyFont.Courier_Prime_Bold,
                      fontSize: MyFontSize.size15),
                ),
                _buildRotateArrowWidget(),

              ],
            ),
          ),
          SizedBox(
            height: Get.height * .030,
          ),
          _languages(),

          /*Expanded(child: loader?
          Container():_langaugeList()),*/
        ],
      ),
    );
  }


  _buildRotateArrowWidget(){
    return Obx(() => Padding(
      padding: EdgeInsets.only(left: Get.width * .25),
      child: myController.rotateArrow.value
          ? RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(
          animationController,
        ),
        child: Image.asset(
          MyImageURL.arrow3x,
          height: Get.height * .050,
          width: Get.height * .050,
          fit: BoxFit.fill,
        ),
      )
          : Container(),
    ));
  }

  Widget _languages(){
    return   Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return RadioListTile(
            value: listLanguage[index].isSelected,
            activeColor: MyColors.textColor.withOpacity(0.55),

            groupValue: true,
            onChanged: (ind) {

              setState(() {
                listLanguage.forEach((element) {
                  element.isSelected = false;
                });
                listLanguage[index].isSelected = true;

                Get.updateLocale(listLanguage[index].local);

                MyPreference.setPrefStringValue(key: MyPreference.language_code, value: listLanguage[index].local.languageCode);
                MyPreference.setPrefStringValue(key: MyPreference.country_code, value: listLanguage[index].local.countryCode);
              });

            },
            title: MyTextStart(text_name: listLanguage[index].language_name,
              myFont: MyStrings.courier_prime,
              txtfontsize: MyFontSize.size15,
              txtcolor: MyColors.textColor,
            ),
            // Text(listLanguage[index].language_name),
          );
        },
        itemCount: listLanguage.length,
      ),
    );
  }

  _langaugeList() {
    return Obx(() => Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.only(
                left: Get.height * .040,
                right: Get.height * .040,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    myController.selectedLanguage.value,
                    style: TextStyle(
                        color: MyColors.textColor,
                        fontFamily: MyFont.Courier_Prime_Bold,
                        fontSize: MyFontSize.size13),
                  ),
                  GestureDetector(
                    onTap: () {
                      myController.isExapanded.value =
                          !myController.isExapanded.value;
                    },
                    child: Image.asset(
                      myController.isExapanded.value
                          ? MyImageURL.arrow_dropdown_up
                          : MyImageURL.arrow_dropdown_down,
                      height: Get.height * .040,
                      width: Get.height * .040,
                      fit: BoxFit.fill,
                    ),
                  )
                ],
              ),
              tileColor: MyColors.expantionTileBgColor.withOpacity(0.32),
            ),
            Divider(
              height: 1,
              thickness: 2,
            ),
            Visibility(
              visible: myController.isExapanded.value,
              child: Expanded(child: _expandebleList()),
            )
          ],
        ));
  }

  _expandebleList() {

    // //for duplicate item removal
    // for(int i=0;i<apiManager.languageList.value.length;i++){
    //   if(apiManager.languageList.value[i].language_name.
    //   contains(myController.selectedLanguage.value)){
    //     apiManager.languageList.removeAt(i);
    //   }
    // }

    return ListView.builder(
        itemCount: apiManager.languageList.value.length,
        itemBuilder:(context,index){
          return Column(
            children:[
              ListTile(
                  onTap: () {
                    if (!apiManager.languageList.value[index].isSelected) {
                      apiManager.languageList.value[index].isSelected=true;
                      apiManager.languageList.refresh();
                      myController.rotateArrow.value = true;
                      animationController.reset();
                      animationController.forward();

                      //update language api call
                      _updateLanguageApiCall(index:index,
                      langId: apiManager.languageList.value[index].id.toString());


                    }
                  },
                  contentPadding: EdgeInsets.only(
                    left: Get.height * .040,
                    right: Get.height * .040,
                  ),
                  title: Text(
                    apiManager.languageList.value[index].language_name,
                    style:TextStyle(
                        color: MyColors.textColor,
                        fontFamily: MyFont.Courier_Prime_Bold,
                        fontSize: MyFontSize.size13),
                  ),
                  tileColor: apiManager.languageList.value[index].isSelected
                      ? MyColors.tileColor
                      : MyColors.expantionTileBgColor.withOpacity(0.32)),
              Divider(
                height: 1,
                thickness: 2,
              ),
            ],
          );

    });

  }

  _getParam(String langId){
    Map param={
      ApiParameter.userId:MyPreference.getPrefStringValue(key:MyPreference.userId),
      ApiParameter.languageId:langId
    };
    return param;
  }

  _updateLanguageApiCall({int index,String langId})async{
       apiManager.updateLanguageApiCall(_getParam(langId)).then((response){

         if(response.isSuccess()){
           myController.rotateArrow.value = false;
           myController.isExapanded.value = false;
           apiManager.languageList.value[index].isSelected=false;
           myController.selectedLanguage.value =
               apiManager.languageList.value[index].language_name;
           myController.updatedLanguage.value=apiManager.languageList.value[index].language_name;

             MyUtility.showSuccessMsg(response.getMessage());
           }else{
           myController.rotateArrow.value = false;
           myController.isExapanded.value = false;
           apiManager.languageList.value[index].isSelected=false;
             MyUtility.showErrorMsg(response.getMessage());
           }
       });
  }
}
