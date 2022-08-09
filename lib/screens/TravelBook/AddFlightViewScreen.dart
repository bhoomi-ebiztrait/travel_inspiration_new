import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';

import '../../APICallServices/ApiParameter.dart';
import '../../MyWidget/MyCommonMethods.dart';
import '../../MyWidget/MyDOBPicker.dart';
import '../../MyWidget/MyDestinationPicker.dart';
import '../../MyWidget/MyTitlebar.dart';
import '../../TIController/MyController.dart';
import '../../TIModel/TIAirlineCompanyModel.dart';
import '../../utils/CommonMethod.dart';
import '../../utils/MyColors.dart';
import '../../utils/MyFont.dart';
import '../../utils/MyFontSize.dart';
import '../../utils/MyStrings.dart';
import '../../utils/TITag.dart';

class AddFlightViewScreen extends StatefulWidget {
  String tag, travelLougeListTitle;
  List<TITransportModel> listAirLine;

  AddFlightViewScreen(this.tag, this.travelLougeListTitle,this.listAirLine);

  @override
  _AddFlightViewScreenState createState() => _AddFlightViewScreenState();
}

class _AddFlightViewScreenState extends State<AddFlightViewScreen> {
  MyController myController = Get.put(MyController());
  final _formKey = GlobalKey<FormState>();
  final edDeparture = TextEditingController();
  final edArrival = TextEditingController();
  final edTicket = TextEditingController();

  var timeMorning_Delivery;
  var airlineName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: Get.height * 0.30,
                width: Get.width,
                color: MyColors.buttonBgColorHome.withOpacity(0.70),
                //padding: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),
                child: Column(
                  children: [
                    MyTopHeader(
                      logoImgUrl: MyImageURL.haudos_logo,
                    ),
                    MyTitlebar(
                      title:
                          "${myController.selectedProject.value.title != null ? myController.selectedProject.value.title.toUpperCase() : ""}\n${widget.travelLougeListTitle.toUpperCase()}",
                    ),
                  ],
                ),
              ),
              Container(
                height: Get.height,
                width: Get.width,
                color: MyColors.buttonBgColorHome.withOpacity(0.30),
                child: buildForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 30),
        child: Column(
          children: [
            TextFormField(
              controller: edDeparture,
              decoration: InputDecoration(
                  hintText: "Departure".tr,
                  hintStyle: TextStyle(
                      color: MyColors.textColor,
                      fontFamily: MyStrings.courier_prime_bold),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              MyColors.buttonBgColorHome.withOpacity(0.75)))),
              validator: (value) => CheckEmptyvalue(
                  value: value, errormsg: MyStrings.Please_enter_depart),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: edArrival,
              decoration: InputDecoration(
                  hintText: "Arrival".tr,
                  hintStyle: TextStyle(
                      color: MyColors.textColor,
                      fontFamily: MyStrings.courier_prime_bold),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              MyColors.buttonBgColorHome.withOpacity(0.75)))),
              validator: (value) => CheckEmptyvalue(
                  value: value, errormsg: MyStrings.Please_enter_arrival),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "Date_of_departure".tr,
              style: TextStyle(
                  fontFamily: MyFont.Courier_Prime_Bold,
                  color: MyColors.textColor,
                  fontSize: MyFontSize.size13),
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            MyDOBPicker(
              minDate: DateTime.now(),
              maxDate: ApiParameter.END_DATE,
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Text(
              "Arrival_date".tr,
              style: TextStyle(
                  fontFamily: MyFont.Courier_Prime_Bold,
                  color: MyColors.textColor,
                  fontSize: MyFontSize.size13),
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            MyDestinationPicker(
              maxDate: ApiParameter.END_DATE,
              msg: "arrivalDate".tr,
            ),

            /* InkWell(
                        onTap: ()async{
                          final result = await tiCalendarDialog(myMinDate: ApiParameter.START_DATE,myMaxDate: ApiParameter.END_DATE,context: Get.context);
                          if(result !=null){
                            if(result.isNotEmpty){
                              print(result);
                              myController.year_AD_FT_ManualAddS.value =  convertStringToDate(sDate: result,dateFormate: "yyyy");
                              myController.month_AD_FT_ManualAddS.value =  convertStringToDate(sDate: result,dateFormate: "MMMM");
                              myController.month_Number_AD_FT_ManualAddS.value =  convertStringToDate(sDate: result,dateFormate: "MM");
                              myController.date_AD_FT_ManualAddS.value =  convertStringToDate(sDate: result,dateFormate: "dd");
                              myController.update();
                            }
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Container(width: 60,padding: EdgeInsets.only(left: 10,right: 10,top: 8,bottom: 8),
                                  alignment: Alignment.center,
                                  child: Text(myController.date_AD_FT_ManualAddS.value.isNotEmpty?myController.date_AD_FT_ManualAddS.value:"Date".tr,style: _buttonStyle(), )),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Container(padding: EdgeInsets.only(left: 25,right: 25,top: 8,bottom: 8),
                                  width: 130,
                                  alignment: Alignment.center,
                                  child: Text(myController.month_AD_FT_ManualAddS.value.isNotEmpty?myController.month_AD_FT_ManualAddS.value:"Month".tr,style: _buttonStyle(), )),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Container(padding: EdgeInsets.only(left: 10,right: 10,top: 8,bottom: 8),
                                  width: 65,
                                  alignment: Alignment.center,
                                  child: Text(myController.year_AD_FT_ManualAddS.value.isNotEmpty?myController.year_AD_FT_ManualAddS.value:"Year".tr,style: _buttonStyle(), )),
                            ),
                          ],
                        ),
                      ),
*/
            SizedBox(
              height: Get.height * 0.06,
            ),

            /* InkWell(
                        onTap: ()async{
                          final result = await tiCalendarDialog(myMinDate: ApiParameter.START_DATE,myMaxDate: ApiParameter.END_DATE,context: Get.context);
                          if(result !=null){
                            if(result.isNotEmpty){
                              print(result);
                              myController.year_DD_FT_ManualAddS.value =  convertStringToDate(sDate: result,dateFormate: "yyyy");
                              myController.month_DD_FT_ManualAddS.value =  convertStringToDate(sDate: result,dateFormate: "MMMM");
                              myController.month_Number_DD_FT_ManualAddS.value =  convertStringToDate(sDate: result,dateFormate: "MM");
                              myController.date_DD_FT_ManualAddS.value =  convertStringToDate(sDate: result,dateFormate: "dd");
                              myController.update();
                            }
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Container(padding: EdgeInsets.only(left: 10,right: 10,top: 8,bottom: 8),
                                  alignment: Alignment.center,
                                  width: 60,
                                  child: Text(myController.date_DD_FT_ManualAddS.value.isNotEmpty?myController.date_DD_FT_ManualAddS.value:"Date".tr,style: _buttonStyle(), )),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Container(padding: EdgeInsets.only(left: 25,right: 25,top: 8,bottom: 8),
                                  width: 130,
                                  alignment: Alignment.center,
                                  child: Text(myController.month_DD_FT_ManualAddS.value.isNotEmpty?myController.month_DD_FT_ManualAddS.value:"Month".tr,style: _buttonStyle(), )),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Container(padding: EdgeInsets.only(left: 10,right: 10,top: 8,bottom: 8),
                                  alignment: Alignment.center,
                                  width: 65,
                                  child: Text(myController.year_DD_FT_ManualAddS.value.isNotEmpty?myController.year_DD_FT_ManualAddS.value:"Year".tr,style: _buttonStyle(), )),
                            ),
                          ],
                        ),
                      ),*/
            SizedBox(
              height: Get.height * 0.02,
            ),
            airlineView(listAirLine: widget.listAirLine),
            SizedBox(
              height: Get.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                 // airlineView(listAirLine: widget.listAirLine),
                Expanded(
                  child: TextFormField(
                    controller: edTicket,
                    style: TextStyle(
                        color: MyColors.textColor,
                        fontFamily: MyFont.Courier_Prime_Bold,
                        fontSize: MyFontSize.size15),
                    expands: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "TICKET".tr,
                      hintStyle: TextStyle(
                          color: MyColors.textColor,
                          fontFamily: MyFont.Courier_Prime_Bold,
                          fontSize: MyFontSize.size15),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: MyColors.buttonBgColorHome
                                  .withOpacity(0.75))),
                    ),
                    validator: (value) => CheckEmptyvalue(
                        value: value, errormsg: MyStrings.Please_enter_ticket),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            GestureDetector(
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    if (myController.selectedDestinationDate.value != "") {
                      if (airlineName.isNotEmpty) {
                        myController.calladdFlightAPI(
                            departure: edDeparture.text,
                            arrival: edArrival.text,
                            arrivalDate: myController.selectedDate.value,
                            departureDate:
                                myController.selectedDestinationDate.value,
                            airline: airlineName,
                            ticketNo: edTicket.text,
                            projectId: myController.selectedProject.value.id,
                            tag: widget.tag);
                      } else {
                        MyCommonMethods.showAlertDialog(
                            msgContent: widget.tag == TITag.TAGPLAIN
                                ? MyStrings.Please_select_airline
                                : MyStrings.Please_select_train,
                            myFont: MyStrings.courier_prime);
                      }
                    } else {
                      MyCommonMethods.showAlertDialog(
                          msgContent:
                              MyStrings.Please_select_arrival_departure_date,
                          myFont: MyStrings.courier_prime);
                    }
                  }
                },
                child: Image.asset(MyImageURL.green_check,height: 60,width: 60,)),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget airlineView({List<TITransportModel> listAirLine}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48.0),
      child: Container(
        width: Get.width,
        height: 55,

        // width: Get.width*0.2,

        decoration: BoxDecoration(
            color: MyColors.whiteColor.withOpacity(1),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                color: MyColors.dialog_shadowColor,
                blurRadius: 2,
                offset: Offset(1, 1),
              )
            ]),
        child: DropdownButton<TITransportModel>(
         isExpanded: true,
          //isDense: true,
          icon: Container(),
          dropdownColor: Colors.white,
          focusColor: Colors.white,
          value: timeMorning_Delivery,
          elevation: 5,
         underline: Container(),
         //  style: TextStyle(color: Colors.white,),
          alignment: Alignment.center,
          // iconEnabledColor: Colors.black,
          items: listAirLine
              .map<DropdownMenuItem<TITransportModel>>((TITransportModel value) {
            return DropdownMenuItem<TITransportModel>(
              value: value,
              child:MyText(
                text_name: value.name,
                txtcolor:  MyColors.textColor.withOpacity(1.0),
                txtfontsize: MyFontSize.size15,
                myFont: MyFont.Courier_Prime,
              ),
              /*Text(
                value.name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                style: TextStyle(
                    color: MyColors.textColor,
                    fontFamily: MyFont.Courier_Prime,
                    fontSize: MyFontSize.size15),
              ),*/
            );
          }).toList(),
          hint:MyText(
            text_name: widget.tag == TITag.TAGPLAIN
                ? "Airline_company".tr
                : "Train_company".tr,
            txtcolor:  MyColors.textColor.withOpacity(1.0),
            txtfontsize: MyFontSize.size15,
            myFont: MyFont.Courier_Prime,
          ),
          /*Text(
            widget.tag == TITag.TAGPLAIN
                ? "Airline_company".tr
                : "Train_company".tr,
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
            style: TextStyle(
                color: MyColors.textColor,
                fontFamily: MyFont.Courier_Prime,
                fontSize: MyFontSize.size15),
          ),*/
          onChanged: (var value) {
            setState(() {
              timeMorning_Delivery = value;
              airlineName = value.name;
            });
          },
         // borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
