import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/MyWidget/MyCommonMethods.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/TIController/MyValidatorController.dart';
import 'package:travel_inspiration/screens/InspiredMode/InspredModeScreen.dart';
import 'package:travel_inspiration/screens/ReflectMode/ReflectModeScreen.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/MyUtility.dart';
import 'package:travel_inspiration/utils/TIPrint.dart';

class ChooseProjectNameScreen extends StatelessWidget {

  int mKey;
  ChooseProjectNameScreen({this.mKey});

  final _formKey = GlobalKey<FormState>();
  TextEditingController projNameController = TextEditingController();
  MyValidatorController myValidatorController = Get.put(MyValidatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(MyImageURL.login), fit: BoxFit.fill)),
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0,bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyTopHeader(headerName: "",headerImgUrl: MyImageURL.project_name_top,),

                  buildProjectNameBlue(),
                  buildBottomImage(context),


                ],
              ),
            ),
          ),
              ),
            ),
      // bottomNavigationBar: buildBottomImage(context),
    );
  }
buildProjectNameBlue(){
    return Container(
alignment: Alignment.center,
      margin: EdgeInsets.only(left: 60),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            bottomLeft: Radius.circular(40)),
        color: MyColors.buttonBgColor,
      ),
      //margin: EdgeInsets.all(20),
      child:buildProjectName(),
    );
}
  buildProjectName(){
    return  Form(
      key: _formKey,
      child: Container(
          //padding: EdgeInsets.symmetric(horizontal: 40,vertical: 50),
          child: TextFormField(
            onTap: (){},
            textAlign: TextAlign.center,
            controller: projNameController,
            style: TextStyle(color: MyColors.whiteColor, fontSize: MyFontSize.size23,fontFamily: MyStrings.bodoni72_Bold,decoration: TextDecoration.none,
            ),
            cursorColor: Colors.black45,
            // keyboardType: edinputType,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: MyColors.lineColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: MyColors.lineColor),
              ),
              border: new UnderlineInputBorder(
                  borderSide: new BorderSide(
                      color: MyColors.lineColor
                  )
              ),
              fillColor: Colors.transparent,
              contentPadding: const EdgeInsets.only(left: 10, right:10),
              hintText: "name_of_project".tr,
              hintStyle: TextStyle(color: MyColors.whiteColor),
              counterText: "",
              filled: true,
            ),
            validator: myValidatorController.validateProjName,
          ),
        ),
    );

  }

  buildBottomImage(context) {
    return Container(
      alignment: Alignment.bottomCenter,
      // height: Get.height * 0.10,
      height: 100,
      width: Get.width,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 40,
                  width: 40,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                GestureDetector(
                  onTap: (){
                    if(_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      MyUtility().focusOut(context);
                      mKey == MyStrings.reflect_key
                          ? Get.to(ReflectModeScreen())
                          : (callCreateInspireProjectAPI());
                    }
                  },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Image.asset(MyImageURL.fleche,height: 90,width: 90,),
                    )),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                    onTap: (){
                      MyCommonMethods.showAlertDialog(msgContent:"project_name_info".tr, myFont:MyStrings.courier_prime_bold);
                    },
                    child: Image.asset(MyImageURL.info_big,height: 40,width: 40,)),
              ],
            ),
          ],
        ),
      ),);
  }
  void callCreateInspireProjectAPI() async{
    ApiManager apiManager = ApiManager();
    Map<String,dynamic> param = {
      "userId" : MyPreference.getPrefStringValue(key: MyPreference.userId),
      "projectName":projNameController.text,
      "fromContinueKM":MyPreference.getPrefIntValue(key: MyPreference.pageVal),
      "projectMode":(MyPreference.getPrefIntValue(key: MyPreference.APPMODE)).toString()
    };
    TIPrint(tag: "param", value: param.toString());
    await apiManager.createInspireProjectAPI(param).then((value) {
      if (value) {
        Get.offAll(InspredModeScreen());
      } else {}
    });
  }
}
