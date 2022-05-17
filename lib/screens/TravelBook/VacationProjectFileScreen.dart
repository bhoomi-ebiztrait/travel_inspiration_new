import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyAlertDialog.dart';
import 'package:travel_inspiration/MyWidget/MyDOBPicker.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/MyTopHeaderTheme.dart';
import 'package:travel_inspiration/MyWidget/TIMyBottomLayout.dart';
import 'package:travel_inspiration/MyWidget/TIPopupGridviewMenu.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/TIModel/TIPopupGridViewModel.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/Loading.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/MyUtility.dart';
import 'package:travel_inspiration/utils/TIPrint.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

import '../PhotoPreviewScreen.dart';
import '../TIPinDestinationToProjectScreen.dart';
import 'TIHotelListScreen.dart';
import 'TIRestaurantListScreen.dart';

class VacationProjectFileScreen extends StatefulWidget {

  /*String title;
  String totalKm;
  String projectMode;
  int id;
  String noOfPerson;
  String pinDestination="";
  String start_vacation_date;

  VacationProjectFileScreen({this.title,this.totalKm,this.projectMode,this.pinDestination,this.noOfPerson,this.id,this.start_vacation_date});*/
  int projIndex;
  VacationProjectFileScreen({this.projIndex});



  @override
  State<VacationProjectFileScreen> createState() => _VacationProjectFileScreenState();
}

class _VacationProjectFileScreenState extends State<VacationProjectFileScreen> {

  MyController myController = Get.put(MyController());
  int personCounter = 0;
  File croppedImg;
  int selectedIndex = -1;
  int selectedTransportIndex = -1;

  var popupItemList = [
    TIPopupGridViewModel(
      iconPath: MyImageURL.plane_icon,
      title: "txtVOLS".tr,
    ),
    TIPopupGridViewModel(
      iconPath: MyImageURL.train2x_icon,
      title: "txtTRAINS".tr,
    ),
    TIPopupGridViewModel(
      iconPath: MyImageURL.car,
      title: "txtROUTE".tr,
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    personCounter = myController.allProjectList[widget.projIndex].projectNoPerson != null ? int.parse(myController.allProjectList[widget.projIndex].projectNoPerson):0;
    myController.selectedDate.value = myController.allProjectList[widget.projIndex].projectVacationDate;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        await _updateInfoDialog();
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    MyTopHeaderTheme(
                      headerName:"${myController.allProjectList[widget.projIndex].title.toUpperCase()}\n${myController.allProjectList[widget.projIndex].pinDestination.toUpperCase()}",
                      headerImgUrl: MyImageURL.setting_top,
                      networkImgUrl: myController.allProjectList[widget.projIndex].project_image,
                      // networkImgUrl: widget.themeURL,
                      croppedImg: croppedImg,
                      backArrowCallback: (){
                        _updateInfoDialog();
                      },
                    ),
                    Positioned(
                      bottom: 10,
                        right: 30,
                        child: GestureDetector(
                            onTap: () async{
                             // showImageOptionDialog();
                              croppedImg = await Get.to(
                                      () => PhotoPreviewScreen("gallery".tr));
                              if (croppedImg != null) {
                                print("crop ${croppedImg.path}");
                                updateTheme();
                              } else {
                                setState(() {
                                  Get.back();
                                });
                              }

                            },
                            child: Image.asset(MyImageURL.edit_pencil))),

                  ],
                ),
                SizedBox(
                  height: Get.height*0.02,
                ),
                MyText(
                  text_name: int.parse(myController.allProjectList[widget.projIndex].projectMode) == ApiParameter.REFLECT_MODE ? "project_release_in_reflect".tr : "project_release_in_inspire".tr,
                  txtfontsize: MyFontSize.size14,
                  txtcolor: MyColors.textColor,
                  myFont: MyStrings.courier_prime_bold,
                ),
                SizedBox(
                  height: Get.height*0.03,
                ),
                buildPersonCountAndKm(),
                SizedBox(
                  height: Get.height*0.03,
                ),
                MyText(
                  text_name: "vacation_date".tr,
                  txtfontsize: MyFontSize.size13,
                  myFont: MyStrings.courier_prime_bold,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                MyDOBPicker(
                  minDate: DateTime.now(),
                  maxDate: ApiParameter.END_DATE,
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                buildOptions(),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                MyText(
                  text_name: "travel".tr,
                  txtfontsize: MyFontSize.size13,
                  myFont: MyStrings.courier_prime_bold,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                buildTransport(),
                SizedBox(
                  height: Get.height*0.12,
                ),
              ],
            ),
          ),

        ),
      ),
    );
  }

   buildPersonCountAndKm() {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyTextStart(
                  text_name: "${myController.allProjectList[widget.projIndex].totalKm} KM",
                  txtfontsize: MyFontSize.size23,
                  txtcolor: int.parse(myController.allProjectList[widget.projIndex].projectMode) == ApiParameter.REFLECT_MODE ?MyColors.lightGreenColor:MyColors.lineColor,
                  myFont: MyStrings.courier_prime_bold,
                ),
                Container(
                  width: Get.width*0.005,
                  height: Get.height*0.03,
                  color: MyColors.lineColor,
                ),
                buildPersonCount(),
              ],
            );
  }

  buildPersonCount() {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
            onTap: () {
              setState(() {
                if (personCounter > 0) {
                  personCounter--;
                }
              });
            },
            child: Image.asset(MyImageURL.minus_blue,height: 50,width: 50,)),
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
            child: Image.asset(MyImageURL.plus_blue,height: 50,width: 50,),),
      ],
    );
  }

  buildOptions() {
    return  Container(
      height: Get.height * .12,
      child: TIPopupGridviewMenu(popupTitle: "",startIndex: 0,endIndex: 2,),
    );
  }

  buildTransport() {
    return  Container(
      height: Get.height * .12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _columnItem(0),
          _columnItem(1),
          _columnItem(2),

        ],
      ),
    );
  }
  _columnItem(int index){
    int selectedMode = int.parse(myController.allProjectList[widget.projIndex].projectMode);
    return  GestureDetector(
      onTap: (){
        setState(() {
          selectedTransportIndex = index;
        });
      },
      child: Container(
        height: Get.height*0.2,
        width: Get.width*0.3,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selectedTransportIndex == index ? selectedMode == ApiParameter.REFLECT_MODE?MyColors.lightGreenColor:MyColors.lineColor:MyColors.whiteColor,

        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              popupItemList[index].iconPath,
              height: Get.height * .04,
              width: Get.height * .04,
              fit: BoxFit.fill,
              //color: selectedIndex == index ? selectedMode == ApiParameter.REFLECT_MODE?MyColors.lightGreenColor:MyColors.lineColor:MyColors.buttonBgColor,
            ),
            SizedBox(
              height: Get.height * .020,
            ),
            MyText(
              text_name: popupItemList[index].title,
              myFont: MyFont.Courier_Prime_Bold,
              txtfontsize: MyFontSize.size11,
              //txtcolor: selectedIndex == index ?  MyColors.lineColor:MyColors.textColor,
              txtAlign: TextAlign.center,
              height: 1,
            ),
          ],
        ),
      ),
    );
  }
  showImageOptionDialog() {
    return Get.dialog(AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyText(
                text_name: "choose_option".tr,
                txtcolor: MyColors.textColor,
                txtfontsize: MyFontSize.size16,
                myFont: MyStrings.courier_prime_bold,
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              InkWell(
                  onTap: () async {
                    // _openGallery();
                    croppedImg = await Get.to(
                            () => PhotoPreviewScreen("gallery".tr));
                    if (croppedImg != null) {
                      print("crop ${croppedImg.path}");
                      updateTheme();
                    } else {
                      setState(() {
                        Get.back();
                      });
                    }
                    /* setState(() {
                        Get.back();

                      });*/
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: MyText(
                      text_name: "gallery".tr,
                      txtcolor: MyColors.textColor,
                      txtfontsize: MyFontSize.size13,
                    ),
                  )),
              SizedBox(
                height: Get.height * 0.02,
              ),
              InkWell(
                  onTap: () async {
                    croppedImg = await Get.to(
                            () => PhotoPreviewScreen("camera".tr));
                    if (croppedImg != null) {
                      print("crop ${croppedImg.path}");
                      updateTheme();
                    } else {
                      setState(() {
                        Get.back();
                      });
                    }
                    /*    setState(() {
                        Get.back();

                      });*/
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: MyText(
                      text_name: "camera".tr,
                      txtcolor: MyColors.textColor,
                      txtfontsize: MyFontSize.size13,
                    ),
                  )),
            ],
          ),
        )));
  }

  updateTheme() async {
    ApiManager apiManager = ApiManager();
    Map<String, String> param = {
      // "userID": MyPreference.getPrefStringValue(key: MyPreference.userId),
      "userId": MyPreference.getPrefStringValue(key: MyPreference.userId),
      "projectId": myController.allProjectList[widget.projIndex].id.toString(),
    };
    TIPrint(tag: "param", value: param.toString());
    await apiManager.updateThemeAPI(param, croppedImg.path).then((value) {
      setState(() {
        //Get.back();
        // myController.mCroppedImg = croppedImg;
        // myController.allProjectList[widget.projIndex].project_image = croppedImg.path;
      });
      if (value != null) {
      } else {}
    });
  }
  _updateInfoDialog(){
    Get.dialog(MyAlertDialog(title: "",
      content: "save changes?",
      funYes: (){
        Get.back();
      callUpdateProjectApi();
      },
      funNo: (){
        Get.back();
        // Get.back();
        ScreenTransition.navigateOff(screenName: TIPinDestinationToProjectScreen());
      },),barrierDismissible: false);

  }



  callUpdateProjectApi()async{
    Get.dialog(Loading());
    ApiManager apiManager = ApiManager();
    Map<String, String> param = {
      "userId": MyPreference.getPrefStringValue(key: MyPreference.userId),
      "projectId": myController.allProjectList[widget.projIndex].id.toString(),
      "start_vacation_date":myController.selectedDate.value,
      "no_of_person":personCounter.toString()
    };

    apiManager.updateProjectApiCall(param:param).
    then((response){
      Get.back();
      if(response.isSuccess()){
        myController.allProjectList[widget.projIndex].projectNoPerson = personCounter.toString();
        myController.allProjectList[widget.projIndex].projectVacationDate = myController.selectedDate.value;
        ScreenTransition.navigateOff(screenName: TIPinDestinationToProjectScreen());
        // Get.back();
      }else{
        MyUtility.showErrorMsg(response.getMessage());
      }


    });
  }

}

