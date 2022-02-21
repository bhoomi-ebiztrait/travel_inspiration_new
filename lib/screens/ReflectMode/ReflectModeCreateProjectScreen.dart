import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyCommonMethods.dart';
import 'package:travel_inspiration/MyWidget/MyDOBPicker.dart';
import 'package:travel_inspiration/MyWidget/MyDatePickerWidget.dart';
import 'package:travel_inspiration/MyWidget/MyDestinationPicker.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/MyTopHeadewithTTextFeild.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/TIController/MyValidatorController.dart';
import 'package:travel_inspiration/screens/InspiredMode/InspredModeScreen.dart';
import 'package:travel_inspiration/screens/PopScreen/ShowAlertDialogCreateProfile.dart';
import 'package:travel_inspiration/screens/ReflectMode/ReflectModeScreen.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/MyUtility.dart';
import 'package:travel_inspiration/utils/TIPrint.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

class ReflectModeCreateProjectScreen extends StatefulWidget {
  const ReflectModeCreateProjectScreen({Key key}) : super(key: key);

  @override
  _ReflectModeCreateProjectScreenState createState() => _ReflectModeCreateProjectScreenState();
}

class _ReflectModeCreateProjectScreenState extends State<ReflectModeCreateProjectScreen> {
  int personCounter = 0;
  final _formKey = GlobalKey<FormState>();
  MyController dateController = Get.put(MyController());
  TextEditingController projNameController = TextEditingController();
  MyValidatorController myValidatorController = Get.put(MyValidatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(MyImageURL.login), fit: BoxFit.fill)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
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
                  Container(
                    margin: EdgeInsets.only(left: 60),
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          bottomLeft: Radius.circular(40)),
                      color: MyColors.buttonBgColor,
                    ),
                    //margin: EdgeInsets.all(20),
                    child:MyHeaderText(),
                  ),
                  // MyTopHeadewithTTextFeild(headerName: "name_of_project".tr.toUpperCase(),headerImgUrl: MyImageURL.rm_top,projNameController: projNameController,),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  buildBoodyContent(),
                  SizedBox(height: Get.height*0.06,),

                ],
              ),
            ),
          ),

        ),
      ),
      // bottomNavigationBar: buildBottomImage(),
    );
  }

   buildBoodyContent() {
    return Column(
                  children: [
                    // MyDatePickerWidget(title: MyStrings.my_vacation_date,),
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                    MyText(
                      text_name: "my_vacation_date".tr,
                      txtfontsize: MyFontSize.size15,
                      txtcolor: MyColors.whiteColor,
                      myFont: MyStrings.courier_prime_bold,
                    ),
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                    MyPickPicker(minDate: DateTime.now(),maxDate: ApiParameter.END_DATE,),
                    SizedBox(
                      height: Get.height * 0.06,
                    ),
                    MyText(
                      text_name: "deadline_deatination_date".tr,
                      txtfontsize: MyFontSize.size15,
                      txtcolor: MyColors.whiteColor,
                      myFont: MyStrings.courier_prime_bold,
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    MyDestinationPicker(maxDate: ApiParameter.END_DATE,msg: "dateofVacationStart".tr,),
                    SizedBox(
                      height: Get.height * 0.08,
                    ),
                    MyText(text_name: "number_of_person".tr,
                      txtfontsize: MyFontSize.size15,
                      txtcolor: MyColors.whiteColor,
                      myFont: MyStrings.courier_prime_bold,),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              if(personCounter>0){
                                personCounter--;
                              }
                            });
                          },
                            child: Image.asset(MyImageURL.minus)),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        MyText(text_name: personCounter.toString(),),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        InkWell(
                          onTap: (){
                            setState(() {
                              personCounter++;
                            });
                          },
                            child: Image.asset(MyImageURL.plus)),
                    ],),
                    SizedBox(height: Get.height*0.06,),
                    buildBottomImage(),
                  ],
                );
  }

  buildBottomImage() {
    return Container(
      alignment: Alignment.bottomCenter,
      // height: Get.height * 0.10,
      height: 85,
      width: Get.width,
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage(MyImageURL.rm_bottom),
      //     fit: BoxFit.fill,
      //   ),
      // ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
                onTap: (){
                  if(_formKey.currentState.validate()){
                    _formKey.currentState.save();
                    MyUtility().focusOut(context);
                    if(dateController.selectedDestinationDate.value == ""){
                      return MyCommonMethods.showInfoCenterDialog(
                          msgContent: "dateofVacationEnd".tr,
                          myFont: MyStrings.courier_prime_bold);
                    }
                    if(personCounter > 0) {
                      callCreateProjectAPI();
                      // ScreenTransition.navigateOffAll(screenName: ReflectModeScreen());
                    }else{
                      MyCommonMethods.showInfoCenterDialog(msgContent:"validPersonCount".tr, myFont :MyStrings.courier_prime_bold);
                    }
                  }
                },
                child: Image.asset(MyImageURL.fleche)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10,top: 30),
          child: InkWell(
              onTap: (){
                Get.to(() => AlertDialogCreateProfile(title: "show_mode_msg",myContent: "",));
                //MyCommonMethods.showInfoCenterDialog(msgContent:"show_mode_msg".tr, myFont:MyStrings.courier_prime_bold);
              },
              child: Image.asset(MyImageURL.info_big,height: 30,width: 30,)),
        ),
      ],
    ),);
  }

  void callCreateProjectAPI() async{

    ApiManager apiManager = ApiManager();
    Map<String, dynamic> param = {
      "userId": MyPreference.getPrefStringValue(key: MyPreference.userId),
      // "userId": "43",
      "projectName": projNameController.text,
      "vacationDate": (dateController.selectedDate.value),
      "destinationDate": (dateController.selectedDestinationDate.value),
      "numberOfPerson": personCounter.toString(),
      "fromContinueKM":MyPreference.getPrefIntValue(key: MyPreference.pageVal),
      // "projectMode": "1",
      "projectMode": (MyPreference.getPrefIntValue(key: MyPreference.APPMODE)).toString(),

    };
    TIPrint(tag: "param", value: param.toString());
    await apiManager.createReflectProjectAPI(param).then((value) {
      if (value==true ) {
        dateController.selectedDate.value = "";
        dateController.selectedDestinationDate.value = "";
        ScreenTransition.navigateOffAll(screenName: ReflectModeScreen());
      } else {}
    });
  }

  MyHeaderText(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 60,vertical: 10),
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
    );
  }
}
