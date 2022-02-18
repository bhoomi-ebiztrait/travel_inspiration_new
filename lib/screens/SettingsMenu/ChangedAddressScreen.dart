import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/MyWidget/MyCountryDropdown.dart';
import 'package:travel_inspiration/MyWidget/MyDropdown.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/MyTextFieldWithImage.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/TIController/MyValidatorController.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/MyUtility.dart';

class ChangedAddressScreen extends StatefulWidget {
  @override
  _ChangedAddressScreenState createState() => _ChangedAddressScreenState();
}

class _ChangedAddressScreenState extends State<ChangedAddressScreen> {
  bool isVisible=false;
  final _formkey = GlobalKey<FormState>();
  MyValidatorController myController = Get.put(MyValidatorController());
  TextEditingController addressController = TextEditingController(text: MyPreference.getPrefStringValue(key: MyPreference.address) != "null" ? MyPreference.getPrefStringValue(key: MyPreference.address) : "");
  TextEditingController postalCodeController = TextEditingController(text: MyPreference.getPrefStringValue(key: MyPreference.pinCode) != "null" ? MyPreference.getPrefStringValue(key: MyPreference.pinCode) : "");
  TextEditingController cityController = TextEditingController(text: MyPreference.getPrefStringValue(key: MyPreference.city)!= "null" ? MyPreference.getPrefStringValue(key: MyPreference.city) : "");

  MyController dataController = Get.put(MyController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // dataController.selectedValue.value.countryname = MyPreference.getPrefStringValue(key: MyPreference.country) != "null" ? MyPreference.getPrefStringValue(key: MyPreference.country) : dataController.countryList.value[0].countryname;
    if(MyPreference.getPrefStringValue(key: MyPreference.country) != "null"){
      dataController.selectedValue.value.countryname =  MyPreference.getPrefStringValue(key: MyPreference.country);
    }else{
      if(dataController.countryList.value.length>0 ) {
        dataController.selectedValue.value =
        dataController.countryList.value[0];
      }
      // dataController.selectedValue.value.countryname = dataController.countryList.value[0].countryname;
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Get.back(result: true);
      },
      child: SafeArea(
        child: Scaffold(
          body: Form(
            key: _formkey,
            child: SingleChildScrollView(
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
                    height: Get.height * 0.02,
                  ),
                  buildUpdateAddress(),
                  Visibility(
                      visible: isVisible,
                      child: Container(
                        margin: EdgeInsets.only(left:Get.width*.04,
                        right: Get.width*.04),
                        child: MyText(text_name: "dob_update_msg".tr,
                            txtfontsize: MyFontSize.size13,
                            txtcolor: MyColors.textColor),
                      )),
                ],
              ),
            ),
          ),
          bottomNavigationBar:buildBottomImage(),


        ),
      ),
    );
  }

   buildUpdateAddress() {
    return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:35,vertical:20.0),
                      child: MyTextStart(text_name: "address".tr,txtfontsize: MyFontSize.size13,txtcolor: MyColors.textColor,myFont: MyStrings.courier_prime_bold,),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Get.width * 0.58,
                          child: MyTextFieldWithImage(
                            imageUrl: MyImageURL.location_img,
                            mycontroller: addressController,
                            addlabel: "address".tr,
                            readonly: false,
                            labelColor: MyColors.textColor,
                            edinputType: TextInputType.name,
                            obscureText: false,
                            rightPadding: 10,
                            maxlimit: 200,
                            validator: myController.validateAddress,
                          ),
                        ),
                        Container(
                          width: Get.width * 0.40,
                          child: MyTextFieldWithImage(
                            addlabel: "postal_code".tr,
                            mycontroller: postalCodeController,
                            readonly: false,
                            edinputType: TextInputType.name,
                            obscureText: false,
                            labelColor: MyColors.textColor,
                            leftPadding: 0,
                            rightPadding: 35,
                            validator: myController.validatePostalCode,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: Get.height*0.02,),
                    Container(
                      width: Get.width * 0.58,
                      child: MyTextFieldWithImage(
                        addlabel: "city".tr,
                        mycontroller: cityController,
                        labelColor: MyColors.textColor,
                        readonly: false,
                        edinputType: TextInputType.name,
                        obscureText: false,
                        rightPadding: 10,
                        maxlimit: 200,
                        validator: myController.validateCity,
                      ),
                    ),
                    SizedBox(height: Get.height*0.02,),
                    buildCountry(),
                    SizedBox(height: Get.height*0.04,),
                  ],
                );
  }

  buildCountry() {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0,right:50, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(width: Get.width * 0.45, child:MyDropdown()),
          GestureDetector(
            onTap: (){
              if(_formkey.currentState.validate()){
                _formkey.currentState.save();
              }
              MyUtility().focusOut(context);
              callUpdateAddress();
              /*setState(() {
                isVisible = true;
              });*/
            },
            child: Container(
                width: Get.width * 0.15,
                child: Image.asset(
                  MyImageURL.check_circle,
                )),
          )
        ],
      ),
    );
  }

  buildBottomImage() {
    return Container(
      height: Get.height*.10,
      width: Get.width,
      child:Image.asset(MyImageURL.setting_bottom,
        fit: BoxFit.fitWidth,
      ),
    );
  }

   callUpdateAddress() async{
     ApiManager apiManager = ApiManager();

     Map<String,dynamic> param = {
       "userId": MyPreference.getPrefStringValue(key: MyPreference.userId),
       "country": dataController.selectedValue.value.id != null ? dataController.selectedValue.value.id: dataController.countryList.value[0].id,
       "city":cityController.text,
       "pincode":postalCodeController.text,
       "address":addressController.text
     };

     await apiManager.updateAddressAPI(param).then((value){
       if(value == true){

         setState(() {
           isVisible = true;
           MyPreference.setPrefStringValue(
               key: MyPreference.address,
               value: addressController.text);
           MyPreference.setPrefStringValue(
               key: MyPreference.city,
               value: cityController.text);
           MyPreference.setPrefStringValue(
               key: MyPreference.pinCode,
               value: postalCodeController.text);
           MyPreference.setPrefStringValue(
               key: MyPreference.country,
               value: dataController.selectedValue.value.countryname);
         });
       }
     });

   }
}
