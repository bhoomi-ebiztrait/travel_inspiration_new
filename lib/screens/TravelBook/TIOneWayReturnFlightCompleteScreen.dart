import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/MyTitlebar.dart';
import 'package:travel_inspiration/MyWidget/TIMyCustomRoundedCornerButton.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/TIModel/TIAvailableFlightModel.dart';
import 'package:travel_inspiration/screens/TravelBook/TIFilterSortFlightScreen.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:url_launcher/url_launcher.dart';

class TIOneWayReturnFlightCompleteScreen extends StatelessWidget {
  String travelogueTitle;
  TIOneWayReturnFlightCompleteScreen(this.travelogueTitle);
  MyController myController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
      body:_buildBodyContent(context),
    ));
  }

  _buildBodyContent(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: Get.height*0.30,
            width: Get.width,
            color: MyColors.buttonBgColorHome.withOpacity(0.7),
            child: Column(
              children: [
                MyTopHeader(
                  logoImgUrl: MyImageURL.haudos_logo,
                ),
                MyTitlebar(title: travelogueTitle,),
              ],
            ),
          ),
          Container(
            height: Get.height,
            width: Get.width,
            color: MyColors.buttonBgColorHome.withOpacity(0.3),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * .03,
                ),
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(
                          text_name: myController.onwardSelectedFlight[0].intDepartureAirportName,
                          myFont: MyFont.Courier_Prime_Bold,
                          txtfontsize: MyFontSize.size13,
                          txtcolor: MyColors.textColor,
                          txtAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: Get.width * .020,
                        ),
                        Container(
                          color: MyColors.textColor,
                          height: 2,
                          width: 8,
                        ),
                        // Image.asset(MyImageURL.arrow_way3x),
                        SizedBox(
                          width: Get.width * .020,
                        ),
                        MyText(
                          text_name: myController.onwardSelectedFlight[myController.onwardSelectedFlight.length-1].intArrivalAirportName,
                          myFont: MyFont.Courier_Prime_Bold,
                          txtfontsize: MyFontSize.size13,
                          txtcolor: MyColors.textColor,
                          txtAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: Get.width * .06),
                      child:GestureDetector(
                        onTap: (){
                          Get.to(TIFilterSortFlightScreen(travelogueTitle));
                        },
                        child: Image.asset(MyImageURL.filter3x,height: 60,width: 60,),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * .02,
                ),
                _selectedFlightOneWayRow(),
                SizedBox(
                  height: Get.height * .02,
                ),
                _togoFlightDetail(context),
                SizedBox(
                  height: Get.height * .010,
                ),
                _returnFlightDetail(context),
                SizedBox(
                  height: Get.height * .010,
                ),
                _bottomTextLayout(),
                SizedBox(
                  height: Get.height * .020,
                ),
                TIMyCustomRoundedCornerButton(
                  onClickCallback: () async{
                    //Get.back();
                    https://www.skyscanner.co.in/transport/flights/amd/blr/220122/?adults=1&adultsv2=1&
                    // cabinclass=economy&children=0&childrenv2=&destinationentityid=27539471
                    // &inboundaltsenabled=false&infants=0&originentityid=27536554&
                    // outboundaltsenabled=false&preferdirects=false&preferflexible=false&ref=home&rtn=0
                    const url = 'https://www.skyscanner.co.in/';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  borderRadius: Get.width*.060,
                  buttonWidth: Get.width * .60,
                  buttonHeight: Get.height * .060,
                  btnBgColor: MyColors.buttonBgColor,
                  textColor: Colors.white,
                  btnText: "txtReserversurle".tr,
                  fontSize: MyFontSize.size13,
                  myFont: MyFont.Courier_Prime_Bold,
                ),
                SizedBox(
                  height: Get.height * .04,
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  _selectedFlightOneWayRow() {
    return Container(
      padding: EdgeInsets.only(right: Get.width * .10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Image.network("https://webapi.etravos.com${myController.onwardSelectedFlight[0].imagePath}",width: 20,height: 20,),
          SizedBox(
            width: Get.width * .030,
          ),
          MyTextStart(
            text_name:"${myController.onwardSelectedFlight[0].departureAirportCode} - ${myController.onwardSelectedFlight[myController.onwardSelectedFlight.length-1].arrivalAirportCode}",
            //text_name: toGoFlightDate.ltn + " - " + toGoFlightDate.mtm,
            myFont: MyFont.Courier_Prime_Bold,
            txtfontsize: MyFontSize.size10,
            txtcolor: MyColors.textColor,
          ),
          SizedBox(
            width: myController.toGoReturnSwitch.value == false ? Get.width * .040:0,
          ),
          myController.toGoReturnSwitch.value == false ? Image.asset(MyImageURL.arrow_way3x,height: 20,width: 30,) :Container(),
          SizedBox(
            width: myController.toGoReturnSwitch.value == false ? Get.width * .020 :0,
          ),
          myController.toGoReturnSwitch.value == false ? Image.network("https://webapi.etravos.com${myController.returnSelectedFlight[0].imagePath}",width: 20,height: 20,):Container(),
          SizedBox(
            width: myController.toGoReturnSwitch.value == false ? Get.width * .030:0,
          ),
          myController.toGoReturnSwitch.value == false ? MyTextStart(
            text_name:"${myController.returnSelectedFlight[0].departureAirportCode} - ${myController.returnSelectedFlight[myController.returnSelectedFlight.length-1].arrivalAirportCode}",
           // text_name: returnFlightData.ltn + " - " + returnFlightData.mtm,
            myFont: MyFont.Courier_Prime_Bold,
            txtfontsize: MyFontSize.size10,
            txtcolor: MyColors.textColor,
          ):Container(),
        ],
      ),
    );
  }

  _togoFlightDetail(BuildContext context) {
    DateTime mDate = DateFormat('yyyy-MM-dd')
        .parse(myController.onwardSelectedFlight[0].departureDateTime);
    String mDateStr = DateFormat('MMMM dd, yyyy').format(mDate);
 print("myController.onwardSelectedFlight.length................>${myController.onwardSelectedFlight.length}");
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: Get.width,
        margin: EdgeInsets.only(left: Get.width * .05, right: Get.width * .05),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: MyColors.textColor),
            color: MyColors.whiteColor.withOpacity(0.32),
            borderRadius: BorderRadius.all(Radius.circular(Get.width * .06))),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Image.network("https://webapi.etravos.com${myController.onwardSelectedFlight[0].imagePath}", height: Get.height * .04,
                    width: Get.height * .04,
                    fit: BoxFit.contain,),
                  SizedBox(
                    width: Get.width * .03,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyTextStart(
                        // text_name: "",
                        text_name: myController.onwardSelectedFlight[0].airLineName,
                        myFont: MyFont.Courier_Prime_Bold,
                        txtfontsize: MyFontSize.size10,
                        txtcolor: MyColors.textColor,
                      ),
                      MyTextStart(
                        text_name: myController.onwardSelectedFlight[0].intNumStops == "0" ? "NonStop": "stop : ${myController.onwardSelectedFlight[0].intNumStops}",
                        myFont: MyFont.Courier_Prime,
                        txtfontsize: MyFontSize.size10,
                        txtcolor: MyColors.textColor,
                      ),
                      MyTextStart(
                        text_name: mDateStr,
                        myFont: MyFont.Courier_Prime,
                        txtfontsize: MyFontSize.size10,
                        txtcolor: MyColors.textColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: Get.width * .15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyTextStart(
                        text_name:myController.onwardSelectedFlight[0].flightNumber,
                        // text_name: myController.flightList.value[index].intOnward.flightSegments[0].flightNumber,
                        myFont: MyFont.Courier_Prime,
                        txtfontsize: MyFontSize.size10,
                        txtcolor: MyColors.textColor,
                      ),
                      MyTextStart(
                        text_name:
                        myController.selectedTravelClass.value.className!=null? myController.selectedTravelClass.value.className:"",
                        myFont: MyFont.Courier_Prime,
                        txtfontsize: MyFontSize.size10,
                        txtcolor: MyColors.textColor,
                      )
                    ],
                  ),
                ],
              ),
              children: [
                Container(
                  margin: EdgeInsets.only(left: Get.width * .08),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: myController.onwardSelectedFlight.length,
                      itemBuilder: (context,index){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * .010,
                        ),
                        MyTextStart(
                          text_name: "${myController.onwardSelectedFlight[index].intDepartureAirportName} (${myController.onwardSelectedFlight[index].departureAirportCode})",
                          myFont: MyFont.Courier_Prime,
                          txtfontsize: MyFontSize.size10,
                          txtcolor: MyColors.textColor,
                        ),
                        SizedBox(
                          height: Get.height * .02,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              MyImageURL.return_plane_image3x,
                              height: Get.height * .030,
                              width: Get.height * .030,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              width: Get.width * .030,
                            ),
                            MyTextStart(
                              text_name: myController.onwardSelectedFlight[index].duration,
                              // text_name: myController.flightList.value[index].intOnward.flightSegments[0].duration,
                              myFont: MyFont.Courier_Prime_Bold,
                              txtfontsize: MyFontSize.size10,
                              txtcolor: MyColors.textColor,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * .02,
                        ),
                        MyTextStart(
                          text_name: "${myController.onwardSelectedFlight[index].intArrivalAirportName} (${myController.onwardSelectedFlight[index].arrivalAirportCode})",
                          myFont: MyFont.Courier_Prime,
                          txtfontsize: MyFontSize.size10,
                          txtcolor: MyColors.textColor,
                        ),
                        SizedBox(
                          height: Get.height * .02,
                        ),
                      ],
                    );
                  }),
                )
              ],
              trailing: Obx(() =>
                  Image.asset(myController.toGoExpanded.value
                      ? MyImageURL.arrow_dropdown_up
                      : MyImageURL.arrow_dropdown_down,
                    height: Get.height*.025,
                    width: Get.height*.025,
                    fit: BoxFit.contain,color: MyColors.buttonBgColor,)),
              onExpansionChanged: (bool isExpanding) {
                myController.toGoExpanded.value = isExpanding;
              }),
        ),
      ),
    );
    /*return ListView.builder(
        itemCount: 1,
        shrinkWrap: true,
        itemBuilder: (context,index){
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: Get.width,
          margin: EdgeInsets.only(left: Get.width * .05, right: Get.width * .05),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: MyColors.expantionTileBgColor.withOpacity(0.32),
              borderRadius: BorderRadius.all(Radius.circular(Get.width * .06))),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    */
    /*Image.asset(
                      toGoFlightDate.imgPath,
                      height: Get.height * .04,
                      width: Get.height * .04,
                      fit: BoxFit.contain,
                    ),*/
    /*
                    Image.network("https://webapi.etravos.com${myController.myIntOnwordsList.value[index].imagePath}", height: Get.height * .04,
                      width: Get.height * .04,
                      fit: BoxFit.contain,),
                    SizedBox(
                      width: Get.width * .03,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyTextStart(
                          // text_name: "",
                          text_name: myController.myIntOnwordsList.value[index].airLineName,
                          myFont: MyFont.Courier_Prime_Bold,
                          txtfontsize: MyFontSize.size10,
                          txtcolor: MyColors.textColor,
                        ),
                        MyTextStart(
                          text_name: myController.myIntOnwordsList.value[index].intNumStops == "0" ? "NonStop": "stop : ${myController.myIntOnwordsList.value[index].intNumStops}",
                          myFont: MyFont.Courier_Prime,
                          txtfontsize: MyFontSize.size10,
                          txtcolor: MyColors.textColor,
                        ),
                        MyTextStart(
                          text_name: mDateStr,
                          myFont: MyFont.Courier_Prime,
                          txtfontsize: MyFontSize.size10,
                          txtcolor: MyColors.textColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: Get.width * .15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyTextStart(
                          text_name:myController.myIntOnwordsList.value[index].flightNumber,
                          // text_name: myController.flightList.value[index].intOnward.flightSegments[0].flightNumber,
                          myFont: MyFont.Courier_Prime_Bold,
                          txtfontsize: MyFontSize.size10,
                          txtcolor: MyColors.textColor,
                        ),
                        MyTextStart(
                          text_name:
                         myController.selectedTravelClass.value.className!=null? myController.selectedTravelClass.value.className:"",
                          myFont: MyFont.Courier_Prime,
                          txtfontsize: MyFontSize.size10,
                          txtcolor: MyColors.textColor,
                        )
                      ],
                    ),
                  ],
                ),
                children: [
                  Container(
                    margin: EdgeInsets.only(left: Get.width * .08),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * .010,
                        ),
                        MyTextStart(
                          text_name: "${myController.myIntOnwordsList.value[index].intDepartureAirportName} (${myController.myIntOnwordsList.value[index].departureAirportCode})",
                          myFont: MyFont.Courier_Prime,
                          txtfontsize: MyFontSize.size10,
                          txtcolor: MyColors.textColor,
                        ),
                        SizedBox(
                          height: Get.height * .02,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              MyImageURL.return_plane_image3x,
                              height: Get.height * .030,
                              width: Get.height * .030,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              width: Get.width * .030,
                            ),
                            MyTextStart(
                              text_name: myController.myIntOnwordsList.value[index].duration,
                              // text_name: myController.flightList.value[index].intOnward.flightSegments[0].duration,
                              myFont: MyFont.Courier_Prime_Bold,
                              txtfontsize: MyFontSize.size10,
                              txtcolor: MyColors.textColor,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * .02,
                        ),
                        MyTextStart(
                          text_name: "${myController.myIntOnwordsList.value[index].intArrivalAirportName} (${myController.myIntOnwordsList.value[index].arrivalAirportCode})",
                          myFont: MyFont.Courier_Prime,
                          txtfontsize: MyFontSize.size10,
                          txtcolor: MyColors.textColor,
                        ),
                        SizedBox(
                          height: Get.height * .05,
                        ),
                      ],
                    ),
                  )
                ],
                trailing: Obx(() =>
                    Image.asset(myController.toGoExpanded.value
                        ? MyImageURL.arrow_dropdown_up
                        : MyImageURL.arrow_dropdown_down,
                      height: Get.height*.025,
                      width: Get.height*.025,
                      fit: BoxFit.contain,)),
                onExpansionChanged: (bool isExpanding) {
                  myController.toGoExpanded.value = isExpanding;
                }),
          ),
        ),
      );
    });*/
  }

  _returnFlightDetail(BuildContext context){
    String mDateStr;
    if(myController.toGoReturnSwitch.value == false) {
      DateTime mDate = DateFormat('yyyy-MM-dd')
          .parse(myController.returnSelectedFlight[0].departureDateTime);
      mDateStr = DateFormat('MMMM dd, yyyy').format(mDate);
      print("listcount................${myController.returnSelectedFlight.length}");
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: Get.width,
          margin: EdgeInsets.only(left: Get.width * .05, right: Get.width * .05),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: MyColors.textColor),
              color: MyColors.whiteColor.withOpacity(0.32),
              borderRadius: BorderRadius.all(Radius.circular(Get.width * .06))),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*Image.asset(
                      toGoFlightDate.imgPath,
                      height: Get.height * .04,
                      width: Get.height * .04,
                      fit: BoxFit.contain,
                    ),*/
                    Image.network("https://webapi.etravos.com${myController.returnSelectedFlight[0].imagePath}", height: Get.height * .04,
                      width: Get.height * .04,
                      fit: BoxFit.contain,),
                    SizedBox(
                      width: Get.width * .03,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyTextStart(
                          // text_name: "",
                          text_name: myController.returnSelectedFlight[0].airLineName,
                          myFont: MyFont.Courier_Prime_Bold,
                          txtfontsize: MyFontSize.size10,
                          txtcolor: MyColors.textColor,
                        ),
                        MyTextStart(
                          text_name: myController.returnSelectedFlight[0].intNumStops == "0" ? "NonStop": "stop : ${myController.returnSelectedFlight[0].intNumStops}",
                          myFont: MyFont.Courier_Prime,
                          txtfontsize: MyFontSize.size10,
                          txtcolor: MyColors.textColor,
                        ),
                        MyTextStart(
                          text_name: mDateStr,
                          myFont: MyFont.Courier_Prime,
                          txtfontsize: MyFontSize.size10,
                          txtcolor: MyColors.textColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: Get.width * .15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyTextStart(
                          text_name:myController.returnSelectedFlight[0].flightNumber,
                          // text_name: myController.flightList.value[index].intOnward.flightSegments[0].flightNumber,
                          myFont: MyFont.Courier_Prime,
                          txtfontsize: MyFontSize.size10,
                          txtcolor: MyColors.textColor,
                        ),
                        MyTextStart(
                          text_name:
                          myController.selectedTravelClass.value.className!=null? myController.selectedTravelClass.value.className:"",
                          myFont: MyFont.Courier_Prime,
                          txtfontsize: MyFontSize.size10,
                          txtcolor: MyColors.textColor,
                        )
                      ],
                    ),
                  ],
                ),
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: myController.returnSelectedFlight.length,
                      itemBuilder: (context,index){
                        return Container(
                          margin: EdgeInsets.only(left: Get.width * .08),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: Get.height * .010,
                              ),
                              MyTextStart(
                                text_name: "${myController.returnSelectedFlight[index].intDepartureAirportName} (${myController.returnSelectedFlight[index].departureAirportCode})",
                                myFont: MyFont.Courier_Prime,
                                txtfontsize: MyFontSize.size10,
                                txtcolor: MyColors.textColor,
                              ),
                              SizedBox(
                                height: Get.height * .02,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    MyImageURL.return_plane_image3x,
                                    height: Get.height * .030,
                                    width: Get.height * .030,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(
                                    width: Get.width * .030,
                                  ),
                                  MyTextStart(
                                    text_name: myController.returnSelectedFlight[index].duration,
                                    // text_name: myController.flightList.value[index].intOnward.flightSegments[0].duration,
                                    myFont: MyFont.Courier_Prime_Bold,
                                    txtfontsize: MyFontSize.size10,
                                    txtcolor: MyColors.textColor,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * .02,
                              ),
                              MyTextStart(
                                text_name: "${myController.returnSelectedFlight[index].intArrivalAirportName} (${myController.returnSelectedFlight[index].arrivalAirportCode})",
                                myFont: MyFont.Courier_Prime,
                                txtfontsize: MyFontSize.size10,
                                txtcolor: MyColors.textColor,
                              ),
                              SizedBox(
                                height: Get.height * .02,
                              ),
                            ],
                          ),
                        );
                      })
                ],
                trailing: Obx(() =>
                    Image.asset(myController.toGoExpanded.value
                        ? MyImageURL.arrow_dropdown_up
                        : MyImageURL.arrow_dropdown_down,
                      height: Get.height*.025,
                      width: Get.height*.025,
                      fit: BoxFit.contain,color: MyColors.buttonBgColor,)),
                onExpansionChanged: (bool isExpanding) {
                  myController.toGoExpanded.value = isExpanding;
                }),
          ),
        ),
      );
    }else{
      return Container();
    }
    print("myVisibi : ${myController.toGoReturnSwitch.value}");

  }
  _bottomTextLayout(){
    return Container(
      margin: EdgeInsets.only(left: Get.width * .06,
          right: Get.width * .06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyTextStart(
                text_name:"txtTotal".tr,
                myFont: MyFont.Courier_Prime_Bold,
                txtfontsize: MyFontSize.size13,
                txtcolor: MyColors.textColor,
              ),
              MyTextStart(
                text_name:"${myController.totalFare.toString()} ${ApiParameter.POUND_SYM}",
                myFont: MyFont.Courier_Prime_Bold,
                txtfontsize: MyFontSize.size13,
                txtcolor: MyColors.textColor,
              ),
            ],
          ),
          SizedBox(height: Get.height*.005,),
          MyTextStart(
            text_name:myController.passenger,
            myFont: MyFont.Courier_Prime,
            txtfontsize: MyFontSize.size10,
            txtcolor: MyColors.textColor,
          ),
          SizedBox(height: Get.height*.005,),
          MyTextStart(
            text_name:"*Les termes et conditions de vols sont à \n retrouver sur le site du partenaire. \n *Haudos n’est pas une agence de voyage et ne gère pas les réservations. Les \nréservations se font directement sur le site partenaire.",
            myFont: MyFont.Courier_Prime,
            txtfontsize: MyFontSize.size6,
            txtcolor: MyColors.textColor,
          ),
        ],
      ),
    );
  }
}
