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
import 'package:travel_inspiration/screens/InspiredMode/InspredModeScreen.dart';
import 'package:travel_inspiration/screens/ReflectMode/ReflectModeScreen.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTopHeadewithTTextFeild(headerName: "name_of_project".tr.toUpperCase(),headerImgUrl: MyImageURL.rm_top,projNameController: projNameController,),
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
      bottomNavigationBar: buildBottomImage(),
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
                      txtfontsize: MyFontSize.size13,
                      myFont: MyStrings.courier_prime_bold,
                    ),
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                    MyDOBPicker(minDate: DateTime.now(),maxDate: ApiParameter.END_DATE,),
                    SizedBox(
                      height: Get.height * 0.06,
                    ),
                    MyText(
                      text_name: "deadline_deatination_date".tr,
                      txtfontsize: MyFontSize.size13,
                      myFont: MyStrings.courier_prime_bold,
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    MyDestinationPicker(maxDate: ApiParameter.END_DATE,msg: "dateofVacationStart".tr,),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    MyText(text_name: "number_of_person".tr,),
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
                    SizedBox(height: Get.height*0.09,),
                  ],
                );
  }

  buildBottomImage() {
    return Container(
      alignment: Alignment.bottomCenter,
      // height: Get.height * 0.10,
      height: 85,
      width: Get.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(MyImageURL.rm_bottom),
          fit: BoxFit.fill,
        ),
      ),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
                onTap: (){
                  MyCommonMethods.showInfoCenterDialog(msgContent:"show_mode_msg".tr, myFont:MyStrings.courier_prime_bold);
                },
                child: Image.asset(MyImageURL.info_big,height: 50,width: 50,))
          ],
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
}
