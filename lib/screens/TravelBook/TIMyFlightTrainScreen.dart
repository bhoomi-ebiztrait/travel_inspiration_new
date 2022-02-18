import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/Models/GetAirportModel.dart';
import 'package:travel_inspiration/MyWidget/MyCommonMethods.dart';
import 'package:travel_inspiration/MyWidget/MyCountryDropdown.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/MyTravelClassDropdown.dart';
import 'package:travel_inspiration/MyWidget/TIMyCustomRoundedCornerButton.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/TIModel/TiMyFlightDetailModel.dart';
import 'package:travel_inspiration/screens/TravelBook/TIFlightChoiceOfDateScreen.dart';
import 'package:travel_inspiration/screens/TravelBook/TIFlightSearchScreen.dart';
import 'package:travel_inspiration/screens/TravelBook/TIPassangerScreen.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/MyUtility.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

import 'TIAvailableFlightScreen.dart';

class TiMyFlightTrainScreen extends StatefulWidget {
  String travelLougeListTitle;

  bool isSelectRange;

  TiMyFlightTrainScreen({this.travelLougeListTitle});

  TiMyFlightTrainScreenState createState() => TiMyFlightTrainScreenState();
}

class TiMyFlightTrainScreenState extends State<TiMyFlightTrainScreen> {
  List<TIMyFlightDetailModel> myFlightDetailList = [
    TIMyFlightDetailModel(
        title: "txtDepuis".tr, subTitle: ""),
    TIMyFlightDetailModel(title: "txtOu".tr, subTitle: ""),
    TIMyFlightDetailModel(title: "txtQuand".tr, subTitle: ""),
    TIMyFlightDetailModel(
        title: "txtPassagers".tr, subTitle: ""),
    TIMyFlightDetailModel(
        title: "", subTitle: ""),
    TIMyFlightDetailModel(
        title: "", subTitle: ""),
  ];

  MyController myController = Get.put(MyController());
  GetAirportlModel getAirportlModel;
 String mSource,mDestination;
 @override
  void initState() {
    // TODO: implement initState
  // myController.flightList.clear();
   //myController.update();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: _buildBodyContent()));
  }

  _buildBodyContent() {
    return SingleChildScrollView(
      child: Obx(() => Column(
            children: [
              MyTopHeader(
                headerName: widget.travelLougeListTitle,
                headerImgUrl: MyImageURL.travel_book_top,
                logoImgUrl: MyImageURL.haudos_logo,
              ),
              SizedBox(
                height: Get.height * .020,
              ),
              MyText(
                text_name: "txtRechercherunvol".tr + "  :",
                myFont: MyFont.Courier_Prime_Bold,
                txtfontsize: MyFontSize.size13,
                txtcolor: MyColors.textColor,
                txtAlign: TextAlign.center,
              ),
              SizedBox(
                height: Get.height * .020,
              ),
              _buildGotoWidget(),
              SizedBox(
                height: Get.height * .020,
              ),
              _buildReturWidget(),
              GestureDetector(
                onTap: () {
                  callFlightApi();
                  /*if(checkValidation()) {
                    callFlightApi();
                    // ScreenTransition.navigateToScreenLeft(
                    //     screenName: TIAvailableFlightScreen());
                  }*/
                },
                child: Container(
                  width: Get.width * .48,
                  height: Get.height * .050,
                  decoration: BoxDecoration(
                    color: MyColors.expantionTileBgColor,
                    borderRadius:
                        BorderRadius.all(Radius.circular(Get.width * .050)),
                  ),
                  child: MyText(
                    text_name: "txtRechercher".tr,
                    myFont: MyFont.Courier_Prime_Bold,
                    txtfontsize: MyFontSize.size18,
                    txtcolor: Colors.white,
                    txtAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * .020,
              ),
            ],
          )),
    );
  }

  _buildReturWidget() {
    return Container(
        height: Get.height * .40,
        margin: EdgeInsets.only(left: Get.width * .06, right: Get.width * .06,bottom: 20),
        child: myController.toGoReturnSwitch.value
            ? _tabBarContentView()
            : _tabBarContentView());
  }

  _toGoWidget(String centerText) {
    return Container(
      width: Get.width * .38,
      height: Get.height * .050,
      decoration: BoxDecoration(
        color: MyColors.expantionTileBgColor,
        borderRadius: BorderRadius.all(Radius.circular(Get.width * .050)),
      ),
      child: MyText(
        text_name: centerText,
        myFont: MyFont.Courier_Prime_Bold,
        txtfontsize: MyFontSize.size13,
        txtcolor: Colors.white,
        txtAlign: TextAlign.center,
      ),
    );
  }

  _returnWidget(String centerText) {
    return Container(
      width: Get.width * .38,
      height: Get.height * .050,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: MyColors.expantionTileBgColor, blurRadius: 2.0)
        ],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(Get.width * .050)),
      ),
      child: MyText(
        text_name: centerText,
        myFont: MyFont.Courier_Prime_Bold,
        txtfontsize: MyFontSize.size13,
        txtcolor: Colors.black,
        txtAlign: TextAlign.center,
      ),
    );
  }

  _tabBarContentView() {
    return ListView.builder(
      shrinkWrap: true,
        itemCount: myFlightDetailList.length,
        itemBuilder: (context, index) {
        if(index==4){
          return MyFlightTypeDropdown();
        }else if(index == 5){
          return MyTravelClassDropdown();
        }
        else {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: Get.width * .60,
                    // color: Colors.green,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyTextStart(
                          text_name: myFlightDetailList[index].title,
                          txtcolor:
                          MyColors.expantionTileBgColor.withOpacity(1.0),
                          myFont: MyFont.Courier_Prime,
                          txtfontsize: MyFontSize.size15,
                        ),
                        MyTextStart(
                          text_name: myFlightDetailList[index].subTitle,
                          txtcolor:
                          MyColors.expantionTileBgColor.withOpacity(1.0),
                          myFont: MyFont.Courier_Prime,
                          txtfontsize: MyFontSize.size12,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: GestureDetector(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                  builder: (context) =>
                                      TIFlightSearchScreen(
                                          travelLougeListTitle:
                                          widget.travelLougeListTitle,
                                          selectedIndex: 0)))
                                  .then((value) {
                                print("returned: $value");
                                getAirportlModel = value;
                                myFlightDetailList[0].subTitle =
                                    getAirportlModel.name;
                                setState(() {});
                                getIATACode(
                                    getAirportlModel.geometry.location.lat,
                                    getAirportlModel.geometry.location.lng)
                                    .then((data) {
                                  myController.mSource.value = data["IATA"];
                                  mSource=data["IATA"];
                                  print("IATAcode.......${data["IATA"]}");
                                });
                              });

                              break;
                            case 1:
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                  builder: (context) =>
                                      TIFlightSearchScreen(
                                          travelLougeListTitle:
                                          widget.travelLougeListTitle,
                                          selectedIndex: 1)))
                                  .then((value) {
                                print("returned: $value");
                                getAirportlModel = value;
                                myFlightDetailList[1].subTitle =
                                    getAirportlModel.name;
                                setState(() {});
                                getIATACode(
                                    getAirportlModel.geometry.location.lat,
                                    getAirportlModel.geometry.location.lng)
                                    .then((data) {
                                  myController.mDestination.value =data["IATA"];
                                  mDestination=data["IATA"];
                                  print("IATAcode.......${data["IATA"]}");
                                });
                              });
                              /* ScreenTransition.navigateToScreenLeft(
                                  screenName: TIFlightSearchScreen(
                                travelLougeListTitle: widget.travelLougeListTitle,
                                selectedIndex: 1,
                              ));*/
                              break;
                            case 2:
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                  builder: (context) =>
                                      TIFlightChoiceOfDateScreen(
                                      )))
                                  .then((value) {
                                print("returned: ${value}");
                                myFlightDetailList[2].subTitle = value;
                                setState(() {

                                });
                              });
                              /*  ScreenTransition.navigateToScreenLeft(
                                  screenName: TIFlightChoiceOfDateScreen());*/
                              break;
                            case 3:
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                  builder: (context) =>
                                      TIPassangerScreen(
                                        travelLougeListTitle:
                                        widget.travelLougeListTitle,
                                      )))
                                  .then((value) {
                                myFlightDetailList[index].subTitle = "";
                                print("returned: ${value.length}");
                                for (int i = 0; i < value.length; i++) {
                                  print(value[i]);
                                  myFlightDetailList[index].subTitle =
                                      myFlightDetailList[index].subTitle +
                                          ", " + value[i];

                                }
                                myController.passenger = myFlightDetailList[index].subTitle;
                                setState(() {

                                });
                              });
                              // ScreenTransition.navigateToScreenLeft(
                              //     screenName: TIPassangerScreen(
                              //   travelLougeListTitle:
                              //       widget.travelLougeListTitle,
                              // ));
                              break;
                          }
                        },
                        child: Image.asset(MyImageURL.plus)),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: Get.width * .02, bottom: Get.height * .03),
                child: Divider(
                  height: 0.2,
                  thickness: 2,
                  color: MyColors.lineColor,
                ),
              ),


            ],
          );
        }

        });
  }

  _buildGotoWidget() {
    return Container(
      margin: EdgeInsets.only(left: Get.width * .06, right: Get.width * .06),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        GestureDetector(
          onTap: () {
            myController.toGoReturnSwitch.value = true;
            //to go(Aller)=true;
          },
          child: myController.toGoReturnSwitch.value
              ? _toGoWidget("txtALLER".tr)
              : _returnWidget("txtALLER".tr),
        ),
        SizedBox(
          width: Get.width * .04,
        ),
        GestureDetector(
          onTap: () {
            myController.toGoReturnSwitch.value = false;
            //return(Retour)=false;
          },
          child: myController.toGoReturnSwitch.value
              ? _returnWidget("txtRETOUR".tr)
              : _toGoWidget("txtRETOUR".tr),
        )
      ]),
    );
  }


  checkValidation(){

   if(mSource == null){
     return MyCommonMethods.showInfoCenterDialog(
         msgContent: "location_required".tr,
         myFont: MyStrings.courier_prime_bold);
   }else if(mDestination == null){
     return MyCommonMethods.showInfoCenterDialog(
         msgContent: "location_required".tr,
         myFont: MyStrings.courier_prime_bold);
   }else if(myController.selectedStartDate.value == null){
     return MyCommonMethods.showInfoCenterDialog(
         msgContent: "date_required".tr,
         myFont: MyStrings.courier_prime_bold);
   }else if(myController.selectedFlightType.value == null){
     return MyCommonMethods.showInfoCenterDialog(
         msgContent: "flight_required".tr,
         myFont: MyStrings.courier_prime_bold);
   }
   else if(myController.selectedTravelClass.value == null){
     return MyCommonMethods.showInfoCenterDialog(
         msgContent: "travel_class_required".tr,
         myFont: MyStrings.courier_prime_bold);
   }else{
     return true;
   }
   }


  callFlightApi() async{

    ApiManager apiManager = ApiManager();
    Map<String,String> param = {
      //
      "source":mSource,
      "destination":mDestination,
      "journeyDate":myController.selectedStartDate.value,
      "returnDate":myController.selectedEndDate.value,
      "tripType":myController.toGoReturnSwitch.value ? "1" : "2",
      "flightType":myController.selectedFlightType.value.value.toString(),
      "adults":myController.noOfAdults.value.toString(),
      "children":myController.noOfChildrens.value.toString(),
      "infants":myController.noOfBabes.value.toString(),
      "travelClass":myController.selectedTravelClass.value.classCode,
      "userType":"5",
// international two way
//       source=HYD&destination=DXB&journeyDate=10-02-2022&tripType=2&flightType=1
//       &adults=2&children=0&infants=0&travelClass=E&userType=5&returnDate=14-02-2022&startPrice=1000
//       &endPrice=10000&shortPrice=true&shortDuration=true&stop=true
     /* "source":"HYD",
      "destination":"DXB",
      "journeyDate":"20-02-2022",
      "tripType":"2",
      "flightType":"2",
      "adults":"2",
      "children":"0",
      "infants":"0",
      "travelClass":"E",
      "userType":"5",
      "returnDate":"24-02-2022"*/

     /* // domestic one way
      "source":"HYD",
      "destination":"BLR",
      "journeyDate":"14-01-2022",
      "tripType":"1",
      "flightType":"1",
      "adults":"1",
      "children":"1",
      "infants":"0",
      "travelClass":"E",
      "userType":"5",
      "returnDate":"16-01-2022"*/

    /*  // international one way
      "source":"HYD",
      "destination":"AMS",
      "journeyDate":"20-01-2022",
      "tripType":"1",
      "flightType":"2",
      "adults":"1",
      "children":"1",
      "infants":"0",
      "travelClass":"E",
      "userType":"5",
      "returnDate":"26-01-2022"*/
    };

    print("param : ${param.toString()}");
    myController.getFlightSearch(param,false);
    // ScreenTransition.navigateToScreenLeft(
    //     screenName: TIAvailableFlightScreen());
   /*  WidgetsBinding.instance.addPostFrameCallback((_) {
       myController.getFlightSearch(param);
       ScreenTransition.navigateToScreenLeft(
           screenName: TIAvailableFlightScreen());
    });*/

   /* await apiManager.getAvailableFlightList(param).then((flightList){
      myController.flightList.value = flightList;
      ScreenTransition.navigateToScreenLeft(
          screenName: TIAvailableFlightScreen());
    });*/

  }


}
