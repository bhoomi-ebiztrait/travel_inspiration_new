import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyCommonMethods.dart';
import 'package:travel_inspiration/MyWidget/MyDOBPicker.dart';
import 'package:travel_inspiration/MyWidget/MyDatePickerWidget.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/MyTextFieldWithImage.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/TIController/MyValidatorController.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/MyUtility.dart';
import 'package:travel_inspiration/utils/TIPrint.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

import 'TIPinDestinationToProjectScreen.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({Key key}) : super(key: key);

  @override
  _CreateProjectScreenState createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  int personCounter = 0;
  final _formKey = GlobalKey<FormState>();
  TextEditingController projNameController = TextEditingController();
  MyValidatorController myValidatorController =
      Get.put(MyValidatorController());
  MyController myController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomImage(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                MyTopHeader(
                  headerName: "create_new_project".tr.toUpperCase(),
                  headerImgUrl: MyImageURL.travel_book_top,
                  logoImgUrl: MyImageURL.logo_icon,
                  logoCallback: () {
                    CommonMethod.getAppMode();
                  },
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                buildProjectName(),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                MyText(
                  text_name: "vacation_date".tr,
                  txtfontsize: MyFontSize.size13,
                  myFont: MyStrings.courier_prime_bold,
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                MyDOBPicker(
                  minDate: DateTime.now(),
                  maxDate: ApiParameter.END_DATE,
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                MyText(
                  text_name: "number_of_person".tr,
                  myFont: MyStrings.courier_prime_bold,
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                buildPersonCount(),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                GestureDetector(
                    onTap: () {
                      //Get.off(TIPinDestinationToProjectScreen(travelLougeTitle: MyStrings.txtMesprojets,));

                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        MyUtility().focusOut(context);

                        if (personCounter > 0) {
                          callCreateSubProjectAPI();
                        } else {
                          MyCommonMethods.showInfoCenterDialog(
                              msgContent: "validPersonCount".tr,
                              myFont: MyStrings.courier_prime_bold);
                        }
                      }
                    },
                    child: Image.asset(
                      MyImageURL.check_circle,
                      height: 50,
                      width: 50,
                    )),
                SizedBox(
                  height: Get.height * 0.09,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildPersonCount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
            onTap: () {
              setState(() {
                if (personCounter > 0) {
                  personCounter--;
                }
              });
            },
            child: Image.asset(MyImageURL.minus)),
        SizedBox(
          width: Get.width * 0.02,
        ),
        MyText(
          text_name: personCounter.toString(),
        ),
        SizedBox(
          width: Get.width * 0.02,
        ),
        InkWell(
            onTap: () {
              setState(() {
                personCounter++;
              });
            },
            child: Image.asset(MyImageURL.plus)),
      ],
    );
  }

  buildBottomImage() {
    return Container(
        width: Get.width,
        child: Image.asset(
          MyImageURL.travel_book_bottom,
          fit: BoxFit.fitWidth,
        ));
  }

  buildProjectName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
      child: TextFormField(
        textAlign: TextAlign.center,
        controller: projNameController,
        style:
            TextStyle(color: MyColors.textColor, fontSize: MyFontSize.size13),
        cursorColor: Colors.black45,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MyColors.lineColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MyColors.lineColor),
          ),
          border: new UnderlineInputBorder(
              borderSide: new BorderSide(color: MyColors.lineColor)),
          fillColor: MyColors.whiteColor,
          contentPadding: const EdgeInsets.only(left: 10, right: 10),
          hintText: "${"name_of_project".tr} :",
          hintStyle: TextStyle(
            color: MyColors.textColor,
          ),
          // labelText: "${MyStrings.name_of_project} :",
          // labelStyle: TextStyle(color: MyColors.textColor,),
          alignLabelWithHint: true,
          counterText: "",
          filled: true,
        ),
        validator: myValidatorController.validateProjName,
      ),
    );
  }

  void callCreateSubProjectAPI() async {
    String start_date;
    if (myController.selectedDate.value != "") {
      start_date = myController.selectedDate.value;
    } else {
      start_date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    }
    print("start date : $start_date");
    ApiManager apiManager = ApiManager();
    Map<String, dynamic> param = {
      "userId": MyPreference.getPrefStringValue(key: MyPreference.userId),
      "project_id": myController.selectedProject.value.id.toString(),
      "name": projNameController.text,
      "start_vacation_date": start_date,
      "no_person": personCounter.toString(),
      "city": myController.selectedPlace.value.name,
      // "userId": "43",
    };
    TIPrint(tag: "param", value: param.toString());
    await apiManager.createSubProjectAPI(param).then((value) {
      if (value == true) {
        myController.selectedDate.value = "";
        Get.off(TIPinDestinationToProjectScreen(
          travelLougeTitle: "txtMesprojets".tr,
        ));
      } else {}
    });
  }


}
