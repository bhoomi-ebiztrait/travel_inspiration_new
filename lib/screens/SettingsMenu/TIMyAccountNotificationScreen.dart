import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/TIMyBottomLayout.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/TIModel/TIMyAccountNotificationModel.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

class TIMyAccountNotificationScreen extends StatefulWidget {
  @override
  _TIMyAccountNotificationScreenState createState() =>
      _TIMyAccountNotificationScreenState();
}

class _TIMyAccountNotificationScreenState
    extends State<TIMyAccountNotificationScreen> {
  MyController myController = Get.put(MyController());
  ApiManager apiManager = Get.put(ApiManager());
  Map param;

  final notificationList = [
    TIMyAccountNotificationModel(
      title: "txtDestination".tr,
      subTitle: "txtNotificationpush".tr,
      imageUrl: MyImageURL.switch_off,
      isSwitched: 0,
    ),
    TIMyAccountNotificationModel(
      title: "txtKilometres".tr,
      subTitle: "txtNotificationdu".tr,
      imageUrl: MyImageURL.switch_off,
      isSwitched: 0,
    ),
    TIMyAccountNotificationModel(
      title: "txtVacanceen".tr,
      subTitle: "txtRecevoir".tr,
      imageUrl: MyImageURL.switch_off,
      isSwitched: 0,
    ),
  ];

  final modeReflechiList = [
    TIMyAccountNotificationModel(

      title: MyStrings.txtDatelimite,
      subTitle: MyStrings.txtRecevoir2,
      imageUrl: MyImageURL.switch_off,
      isSwitched: 0,
    ),
    TIMyAccountNotificationModel(
      title: MyStrings.txtKilometres,
      subTitle: MyStrings.txtNotificationdu2,
      imageUrl: MyImageURL.switch_off,
      isSwitched: 0,
    ),
  ];

@override
  void initState() {
   /*param={
    "userId":  MyPreference.getPrefStringValue(key: MyPreference.userId),
    "midway_inspire": 0,
    "midway_reflect":0,
    "holiday_vacation":0,
    "deadline_expire":0,
    "weekly_destination":notificationList[0].isSwitched
  };*/
    super.initState();
  /* Map<String,dynamic> param = {
     "userId":MyPreference.getPrefStringValue(key: MyPreference.userId),
   };
   WidgetsBinding.instance.addPostFrameCallback((_) {
     myController.getSettingUser(param);
   });*/

   getSettingsAPI();
  }

  getSettingsAPI() async{
  ApiManager apiManager = ApiManager();
  Map<String,dynamic> param = {
    "userId":MyPreference.getPrefStringValue(key: MyPreference.userId),
  };
  await apiManager.getSettingList(param).then((data){
    setState(() {
      if(data != null){
        notificationList[0].isSwitched = data[0]["weekly_destination"];
        notificationList[1].isSwitched = data[0]["midway_inspire"];
        notificationList[2].isSwitched = data[0]["holiday_vacation"];
        modeReflechiList[0].isSwitched = data[0]["deadline_expire"];
        modeReflechiList[1].isSwitched = data[0]["midway_reflect"];
        /*param={
          "userId":  MyPreference.getPrefStringValue(key: MyPreference.userId),
          "midway_inspire": int.parse(data[0]["midway_inspire"]),
          "midway_reflect":data[0]["midway_reflect"],
          "holiday_vacation":data[0]["holiday_vacation"],
          "deadline_expire":data[0]["deadline_expire"],
          "weekly_destination":data[0]["weekly_destination"]
        };*/
      }
    });
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _buildBodyContent()),
      bottomSheet: MyBottomLayout(
        imgUrl: MyImageURL.setting_bottom,
      ),
    );
  }

  _buildBodyContent() {
    return Container(
      height: Get.height,
      child: Column(
        children: [
          MyTopHeader(
            headerImgUrl: MyImageURL.setting_top,
            headerName: "txtmyCompte".tr,
            logoImgUrl: MyImageURL.haudos_logo,
          ),
          SizedBox(
            height: Get.height * .015,
          ),
          _buildNotificationList(),
        ],
      ),
    );
  }

  _buildNotificationList() {
    return Container(
        width: Get.width,
        margin:
            EdgeInsets.only(left: Get.width * .050, right: Get.width * .050),
        child: _columnData());
  }

  _columnData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "txtNotifications".tr,
          style: TextStyle(
            fontFamily: MyFont.Courier_Prime_Bold,
            fontSize: MyFontSize.size13,
          ),
        ),
        SizedBox(
          height: Get.height * .015,
        ),
        Container(height: Get.height * .20, child: _notificationList()),
        Text(

          MyStrings.txtModeReflechi2,
          style: TextStyle(
              fontFamily: MyFont.Courier_Prime_Bold,
              fontSize: MyFontSize.size13,
              color: MyColors.lightGreenColor),
        ),
        SizedBox(
          height: Get.height * .015,
        ),
        Container(height: Get.height * .25, child: _modeReflechiList()),
      ],
    );
  }

  _notificationList() {
    return ListView.builder(
      itemCount: notificationList.length,
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleSubTitle2(index),
            _buildSwitch2(index),
          ],
        );
      },
    );
  }

  _buildTitleSubTitle2(int index) {
    return Container(
      width: Get.width * .70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notificationList[index].title,
            style: TextStyle(
                fontFamily: MyFont.Courier_Prime_Bold,
                fontSize: MyFontSize.size13),
          ),
          SizedBox(
            height: Get.height * .005,
          ),
          Text(
            notificationList[index].subTitle,
            style: TextStyle(
                fontFamily: MyFont.Courier_Prime_Bold,
                fontSize: MyFontSize.size8),
          ),
          SizedBox(
            height: Get.height * .015,
          ),
        ],
      ),
    );
  }

  _buildSwitch2(int index) {
    return GestureDetector(
        onTap: () {
          //notificationList[index].isSwitched = !notificationList[index].isSwitched;
          if(notificationList[index].isSwitched==0)
            notificationList[index].isSwitched=1;
            else if(notificationList[index].isSwitched==1)
              {
                notificationList[index].isSwitched=0;
              }
          print("onoffstatus......${notificationList[index].title}...............${notificationList[index].isSwitched}");

          notificationstatusAPICall();
          setState(() {});
        },
        child: notificationList[index].isSwitched==1
            ? Image.asset(
                MyImageURL.switch_on,
              )
            : Image.asset(
                MyImageURL.switch_off,
              ));
  }

  _modeReflechiList() {
    return ListView.builder(
        itemCount: modeReflechiList.length,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleSubTitle(index),
              _buildSwitch(index),
            ],
          );
        });
  }

  _buildTitleSubTitle(int index) {
    return Container(
      width: Get.width * .70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            modeReflechiList[index].title,
            style: TextStyle(
                fontFamily: MyFont.Courier_Prime_Bold,
                fontSize: MyFontSize.size13),
          ),
          SizedBox(
            height: Get.height * .005,
          ),
          Text(
            modeReflechiList[index].subTitle,
            style: TextStyle(
                fontFamily: MyFont.Courier_Prime_Bold,
                fontSize: MyFontSize.size8),
          ),
          SizedBox(
            height: Get.height * .015,
          ),
        ],
      ),
    );
  }

  _buildSwitch(int index) {
    return GestureDetector(
        onTap: () {
          //modeReflechiList[index].isSwitched = !modeReflechiList[index].isSwitched;
          print("onoffstatus......${modeReflechiList[index].title}...............${modeReflechiList[index].isSwitched}");
          if(modeReflechiList[index].isSwitched==0)
            modeReflechiList[index].isSwitched=1;
          else if(modeReflechiList[index].isSwitched==1)
          {
            modeReflechiList[index].isSwitched=0;
          }
          notificationstatusAPICall();
          setState(() {});
        },
        child: modeReflechiList[index].isSwitched==1
            ? Image.asset(
                MyImageURL.switch_on,
              )
            : Image.asset(
                MyImageURL.switch_off,
              ));
  }


  notificationstatusAPICall()
  async {
    param={
      "userId":  MyPreference.getPrefStringValue(key: MyPreference.userId),
      "midway_inspire": notificationList[1].isSwitched,//2
      "midway_reflect":modeReflechiList[1].isSwitched,//5
      "holiday_vacation":notificationList[2].isSwitched,//3
      "deadline_expire":modeReflechiList[0].isSwitched,//4
      "weekly_destination":notificationList[0].isSwitched//1
    };
 print("param..................$param");
  await apiManager.notificationstatusAPICall(param).then((response){
 if(response!=null)
   {
   }
  });
  }
}
