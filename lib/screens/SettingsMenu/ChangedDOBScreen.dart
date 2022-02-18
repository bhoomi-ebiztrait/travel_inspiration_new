import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyButton.dart';
import 'package:travel_inspiration/MyWidget/MyCommonMethods.dart';
import 'package:travel_inspiration/MyWidget/MyDOBPicker.dart';
import 'package:travel_inspiration/MyWidget/MyDatePickerWidget.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

class ChangedDOBScreen extends StatefulWidget {
  @override
  _ChangedDOBScreenState createState() => _ChangedDOBScreenState();
}

class _ChangedDOBScreenState extends State<ChangedDOBScreen> {

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Get.back(result: true);
      },
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyTopHeader(
                      headerName: "my_account".tr.toUpperCase(),
                      headerImgUrl: MyImageURL.setting_top,
                      logoImgUrl: MyImageURL.haudos_logo,
                    ),
                    SizedBox(
                      height: Get.height * 0.04,
                    ),

                    buildChangeDOB(),
                    SizedBox(height: Get.height*0.06,),

                    buildUpdateBtn(),
                    SizedBox(height: Get.height*0.05,),
                    Visibility(
                      visible: isVisible,
                        child: MyText(text_name: "dob_update_msg".tr,txtfontsize: MyFontSize.size13,txtcolor: MyColors.textColor)),
                  ],
                ),
              ),
            ),

            buildBottomImage(),
          ],
        ),
      ),
    );
  }
  buildBottomImage() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          width: Get.width,

          child: Image.asset(MyImageURL.setting_bottom,fit:BoxFit.fitWidth,)),
    );
  }
   buildUpdateBtn() {
    return GestureDetector(
      onTap: (){
        callUpdateDobAPI();
        /*setState(() {
          isVisible = true;
        });*/
      },
      child: Container( width: Get.width,
                  height: Get.height*0.1,child: Image.asset(MyImageURL.check_circle)),
    );
  }

  buildChangeDOB() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:20.0,horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(text_name: "date_of_birth".tr,txtfontsize: MyFontSize.size13,txtcolor: MyColors.textColor,myFont: MyStrings.courier_prime_bold,),
          SizedBox(height: Get.height*0.04,),
         MyDOBPicker(minDate: ApiParameter.DOB_START,maxDate: ApiParameter.DOB_END,),
        ],
      ),
    );
  }

   callUpdateDobAPI() async{
    ApiManager apiManager = ApiManager();
    MyController dateController = Get.put(MyController());
    Map<String,dynamic> param = {
      "userId": MyPreference.getPrefStringValue(key: MyPreference.userId),
      "dob": dateController.selectedDate.value
    };

    await apiManager.updateDOBAPI(param).then((value){
      if(value == true){

        setState(() {
          isVisible = true;
          MyPreference.setPrefStringValue(key: MyPreference.dob, value: dateController.selectedDate.value);
        });
      }
    });

   }


}
