import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyCommonMethods.dart';
import 'package:travel_inspiration/MyWidget/MyDOBPicker.dart';
import 'package:travel_inspiration/MyWidget/MyDestinationPicker.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/TICommonPopup.dart';
import 'package:travel_inspiration/MyWidget/TIMyBottomLayout.dart';
import 'package:travel_inspiration/MyWidget/TIMyCustomRoundedCornerButton.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/TIModel/TIAirlineCompanyModel.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/Loading.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TITag.dart';

class TIFlightAndTrainManualAddScreen extends StatefulWidget {
  String travelLougeListTitle, Tag;

  TIFlightAndTrainManualAddScreen({this.travelLougeListTitle, this.Tag});

  @override
  _TIFlightAndTrainManualAddScreenState createState() =>
      _TIFlightAndTrainManualAddScreenState();
}

class _TIFlightAndTrainManualAddScreenState
    extends State<TIFlightAndTrainManualAddScreen> {
  MyController myController = Get.put(MyController());
  final _formKey = GlobalKey<FormState>();
  final edDeparture = TextEditingController();
  final edArrival = TextEditingController();
  final edTicket = TextEditingController();

  var timeMorning_Delivery;
  var airlineName = "";



  @override
  void initState() {
    super.initState();
    myController.isAddFlightMenual_FT_ManualAddS.value = false;

    myController.callgetAirlinesAPI(widget.Tag);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      myController.getTransportList(widget.Tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          resizeToAvoidBottomInset: true,
          body: GetBuilder(
              init: MyController(),
              builder: (controller) {
                return FutureBuilder<List<TITransportModel>>(
                  builder: (BuildContext context,
                      AsyncSnapshot<List<TITransportModel>> snapShot) {
                    if (!snapShot.hasData) {
                      if (snapShot.connectionState == ConnectionState.waiting) {
                        return Loading();
                      }
                    }
                    if (snapShot.data.isEmpty) {
                      return Container();
                    }

                    return SingleChildScrollView(
                        child: _buildBodyContent(
                            listAirLine: snapShot.requireData));
                  },
                  future: myController.futureAireline_FT_ManualAddS.value,
                );
              }),
          //  body:SingleChildScrollView(child:_buildBodyContent()),
          bottomNavigationBar: _bottomLayout(),
        ),
      ),
    );
  }

  _buildBodyContent({List<TITransportModel> listAirLine}) {
    return Column(
      children: [
        MyTopHeader(
          // headerName:_centerTitle(),
          headerName:
              "${myController.selectedProject.value.title != null ? myController.selectedProject.value.title.toUpperCase():""}\n${widget.travelLougeListTitle.toUpperCase()}",
          headerImgUrl: MyImageURL.travel_book_top,
          logoImgUrl: MyImageURL.haudos_logo,
        ),
        myController.isAddFlightMenual_FT_ManualAddS.value
            ? _addFlightView(listAirLine: listAirLine)
            : _addFlight_button(),
      ],
    );
  }

/*  Visibility(
  visible:myController.showFlightAndTrainPopup.value,
  child: BackdropFilter(
  filter:myController.showFlightAndTrainPopup.value?
  ImageFilter.blur(sigmaX:5,sigmaY: 5):
  ImageFilter.blur(sigmaX:0,sigmaY: 0),
  child:_showFlightAndTrainPopup(),
  ),
  ),*/

  Widget _addFlight_button() {
    return Column(
      children: [
        SizedBox(
          height: Get.height * .04,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: Get.width * .3,
            ),
            Image.asset(
              _centerImage(),
              height: Get.height * .040,
              width: Get.height * .040,
              fit: BoxFit.contain,
            ),
            SizedBox(
              width: Get.width * .030,
            ),
            MyText(
              text_name: _centerSubTitle(),
              myFont: MyFont.Courier_Prime_Bold,
              txtfontsize: MyFontSize.size13,
              txtcolor: MyColors.textColor,
              txtAlign: TextAlign.center,
            ),
            SizedBox(
              width: Get.width * .15,
            ),
            Obx((){
              return Visibility(
                visible: myController.transportList.value.length > 0 ? true :false,
                child: InkWell(
                  onTap: () {
                    getDeviceToken();
                    myController.isAddFlightMenual_FT_ManualAddS.value = true;
                  },
                  child: Image.asset(
                    MyImageURL.add_button3x,
                    height: Get.height * .06,
                    width: Get.height * .06,
                    fit: BoxFit.fill,
                  ),
                ),
              );
            }),
          ],
        ),
        SizedBox(
          height: Get.height * .04,
        ),
        _showList(),
        // buildButtonView();
      ],
    );
  }

  _showList() {
    return Obx(() {
      if (myController.transportList != null && myController.transportList.value.length > 0) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: myController.transportList.value.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.only(right: 20.0, left: 20, bottom: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyTextStart(
                          txtcolor: MyColors.textColor,
                          txtfontsize: MyFontSize.size12,
                          myFont: MyStrings.courier_prime_bold,
                          text_name:
                              "${myController.transportList[index].departure} - ${myController.transportList[index].arrival}",
                        ),
                        MyTextStart(
                          txtcolor: MyColors.textColor,
                          txtfontsize: MyFontSize.size12,
                          myFont: MyStrings.courier_prime_bold,
                          text_name:
                              "${myController.transportList[index].airline}",
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MyTextStart(
                          txtcolor: MyColors.textColor,
                          txtfontsize: MyFontSize.size12,
                          myFont: MyStrings.courier_prime_bold,
                          text_name:
                              "${myController.transportList[index].departDate} - ${myController.transportList[index].arriveDate}",
                        ),
                      ],
                    ),
                  ],
                ),
              );
            });
      } else {
        return buildButtonView();
      }
    });
  }

  Widget _addFlightView({List<TITransportModel> listAirLine}) {
    return Container(
      padding: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              TextFormField(
                controller: edDeparture,
                decoration: InputDecoration(
                    hintText: "Departure".tr,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: MyColors.lineColor))),
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
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: MyColors.lineColor))),
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
                height: Get.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  airlineView(listAirLine: listAirLine),
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
                          border: InputBorder.none),
                      validator: (value) => CheckEmptyvalue(
                          value: value,
                          errormsg: MyStrings.Please_enter_ticket),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget airlineView({List<TITransportModel> listAirLine}) {
    return Container(
      width: Get.width * 0.5,
      // height: 35,
      padding: EdgeInsets.only(
          top: Get.width * 0.02,
          bottom: Get.width * 0.02,
          right: Get.width * 0.01,
          left: Get.width * 0.01),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
              //spreadRadius: 1
            ),
          ]),
      child: DropdownButton<TITransportModel>(
        isExpanded: true,
        isDense: true,
        icon: Container(),
        dropdownColor: Colors.white,
        focusColor: Colors.white,
        value: timeMorning_Delivery,
        elevation: 5,
        underline: Container(),
        style: TextStyle(color: Colors.white),
        iconEnabledColor: Colors.black,
        items: listAirLine
            .map<DropdownMenuItem<TITransportModel>>((TITransportModel value) {
          return DropdownMenuItem<TITransportModel>(
            value: value,
            child: Text(
              value.name,
              overflow: TextOverflow.visible,
              style: TextStyle(
                  color: MyColors.textColor,
                  fontFamily: MyFont.Courier_Prime_Bold,
                  fontSize: MyFontSize.size15),
            ),
          );
        }).toList(),
        hint: Text(
          widget.Tag == TITag.TAGPLAIN
              ? "Airline_company".tr
              : "Train_company".tr,
          overflow: TextOverflow.visible,
          style: TextStyle(
              color: MyColors.textColor,
              fontFamily: MyFont.Courier_Prime_Bold,
              fontSize: MyFontSize.size15),
        ),
        onChanged: (var value) {
          setState(() {
            timeMorning_Delivery = value;
            airlineName = value.name;
          });
        },
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  _showFlightAndTrainPopup() {
    return TICommonPopup(
      childWidget: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                  top: Get.height * .025, right: Get.height * .02),
              child: GestureDetector(
                onTap: () {
                  myController.showFlightAndTrainPopup.value = false;
                },
                child: Image.asset(
                  MyImageURL.cross3x,
                  height: Get.height * .050,
                  width: Get.height * .050,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          SizedBox(
            height: Get.height * .04,
          ),
          Padding(
            padding:
                EdgeInsets.only(left: Get.width * .06, right: Get.width * .06),
            child: MyText(
              text_name: "txtFlightPopupData".tr,
              myFont: MyFont.Courier_Prime,
              txtfontsize: MyFontSize.size13,
              txtAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: Get.height * .06,
          ),
          Image.asset(
            MyImageURL.document_popup,
            height: Get.height * .08,
            width: Get.height * .08,
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: Get.height * .06,
          ),
          MyText(
            text_name: "ou",
            myFont: MyFont.Courier_Prime_Bold,
            txtfontsize: MyFontSize.size18,
            txtcolor: MyColors.textColor,
            txtAlign: TextAlign.center,
          ),
          SizedBox(
            height: Get.height * .06,
          ),
          TIMyCustomRoundedCornerButton(
            onClickCallback: () {},
            btnText: "txtDeviensPremium".tr,
            myFont: MyFont.Courier_Prime_Bold,
            fontSize: MyFontSize.size18,
            textColor: Colors.white,
            buttonWidth: Get.width * .60,
            buttonHeight: Get.height * .060,
            borderRadius: Get.width * .060,
            btnBgColor: MyColors.expantionTileBgColor,
          )
        ],
      ),
    );
  }

  _bottomLayout() {
    return Stack(
      alignment: Alignment.center,
      children: [
        MyBottomLayout(
          imgUrl: MyImageURL.travel_book_bottom,
        ),
        myController.isAddFlightMenual_FT_ManualAddS.value
            ? Positioned(
                right: 0,
                left: 0,
                child: Container(
                  height: 40,
                  width: 40,
                  //padding:EdgeInsets.only(top:Get.width*.06, right: Get.width*.06),
                  child: GestureDetector(
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          if (myController.selectedDestinationDate.value !=
                              "") {
                            if (airlineName.isNotEmpty) {
                              myController.calladdFlightAPI(
                                  departure: edDeparture.text,
                                  arrival: edArrival.text,
                                  arrivalDate: myController.selectedDate.value,
                                  departureDate: myController
                                      .selectedDestinationDate.value,
                                  airline: airlineName,
                                  ticketNo: edTicket.text,
                                  projectId:
                                      myController.selectedProject.value.id,
                                  tag: widget.Tag);
                            } else {
                              MyCommonMethods.showAlertDialog(
                                  msgContent: widget.Tag == TITag.TAGPLAIN
                                      ? MyStrings.Please_select_airline
                                      : MyStrings.Please_select_train,
                                  myFont: MyStrings.courier_prime);
                            }
                          } else {
                            MyCommonMethods.showAlertDialog(
                                msgContent: MyStrings
                                    .Please_select_arrival_departure_date,
                                myFont: MyStrings.courier_prime);
                          }
                        }
                      },
                      child: Image.asset(MyImageURL.check_circle)),
                ),
              )
            : Positioned(
                right: 0,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: Get.width * .06, right: Get.width * .06),
                  child: GestureDetector(
                      onTap: () {
                        myController.showFlightAndTrainPopup.value = true;
                      },
                      child: Image.asset(MyImageURL.info_big)),
                ),
              ),
      ],
    );
  }

  _centerTitle() {
    switch (widget.Tag) {
      case TITag.TAGPLAIN:
        return "${myController.selectedProject.value.title.toUpperCase()} ${widget.travelLougeListTitle.toUpperCase()}";
        return "ADVENTURE2023 MONTPELLIER";
        break;
      case TITag.TAGTRAIN:
        return "ADVENTURE2023 MONTPELLIER";
        break;
    }
  }

  _centerImage() {
    switch (widget.Tag) {
      case TITag.TAGPLAIN:
        return MyImageURL.plane_icon;
        break;
      case TITag.TAGTRAIN:
        return MyImageURL.train2x_icon;
        break;
    }
  }

  _centerSubTitle() {
    switch (widget.Tag) {
      case TITag.TAGPLAIN:
        return "txtMESVOLS".tr;
        break;
      case TITag.TAGTRAIN:
        return "txtMesTrains".tr;
        break;
    }
  }

  TextStyle _buttonStyle() {
    return TextStyle(
        color: MyColors.textColor.withOpacity(0.8),
        fontFamily: MyFont.Courier_Prime,
        fontSize: MyFontSize.size15);
  }

  buildButtonView() {
    return Container(
      child: InkWell(
        onTap: () {
          getDeviceToken();
          myController.isAddFlightMenual_FT_ManualAddS.value = true;
        },
        child: Image.asset(
          MyImageURL.add_button3x,
          height: Get.height * .10,
          width: Get.height * .10,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

/*class TIFlightAndTrainManualAddScreen extends StatelessWidget {
  String travelLougeListTitle,Tag;

  TIFlightAndTrainManualAddScreen({this.travelLougeListTitle,this.Tag});

  MyController myController=Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:_buildBodyContent()
      ),
    );
  }

  _buildBodyContent(){
    return Obx(()=>
        Stack(
          children:[
            _addFlightAndTrainManualWidget(),
            Align(
                alignment: Alignment.bottomCenter,
                child:_bottomLayout()),

            Visibility(
              visible:myController.showFlightAndTrainPopup.value,
              child: BackdropFilter(
                filter:myController.showFlightAndTrainPopup.value?
                ImageFilter.blur(sigmaX:5,sigmaY: 5):
                ImageFilter.blur(sigmaX:0,sigmaY: 0),
                child:_showFlightAndTrainPopup(),
              ),
            ),
          ],
        ));
  }

  _addFlightAndTrainManualWidget() {
    return Column(
      children: [
        MyTopHeader(
          headerName:_centerTitle(),
          headerImgUrl: MyImageURL.travel_book_top,
          logoImgUrl: MyImageURL.haudos_logo,
        ),
        SizedBox(
          height: Get.height * .04,
        ),
       myController.isAddFlightMenual_FT_ManualAddS.value? _addFlightView(): _addFlight_button()
      ],
    );
  }

  Widget _addFlight_button(){
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            _centerImage(),
            height: Get.height * .040,
            width: Get.height * .040,
            fit: BoxFit.contain,
          ),
          SizedBox(
            width: Get.width * .030,
          ),
          MyText(
            text_name: _centerSubTitle(),
            myFont: MyFont.Courier_Prime_Bold,
            txtfontsize: MyFontSize.size13,
            txtcolor: MyColors.textColor,
            txtAlign: TextAlign.center,
          ),
        ],
      ),
      SizedBox(
        height: Get.height * .04,
      ),
      Image.asset(
        MyImageURL.add_button3x,
        height: Get.height * .10,
        width: Get.height * .10,
        fit: BoxFit.fill,
      ),
    ],);
  }

  Widget _addFlightView(){
    return Container(
      child: Column(
        children: [
          TextFormField(

          )
        ],
      ),
    );
  }

  _showFlightAndTrainPopup(){
    return TICommonPopup(
      childWidget:Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                  top:Get.height * .025,right: Get.height*.02),
              child: GestureDetector(
                onTap: () {
                  myController.showFlightAndTrainPopup.value=false;
                },
                child: Image.asset(
                  MyImageURL.cross3x,
                  height: Get.height * .050,
                  width: Get.height * .050,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          SizedBox(height: Get.height*.04,),
          Padding(
            padding:EdgeInsets.only(left:Get.width*.06,
                right:Get.width*.06),
            child: MyText(
              text_name: MyStrings.txtFlightPopupData,
              myFont: MyFont.Courier_Prime,
              txtfontsize: MyFontSize.size13,
              txtAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: Get.height*.06,),
          Image.asset(MyImageURL.document_popup,
            height: Get.height*.08,
            width: Get.height*.08,
            fit: BoxFit.contain,),
          SizedBox(height: Get.height*.06,),
          MyText(
            text_name:"ou",
            myFont: MyFont.Courier_Prime_Bold,
            txtfontsize: MyFontSize.size18,
            txtcolor: MyColors.textColor,
            txtAlign: TextAlign.center,
          ),
          SizedBox(height: Get.height*.06,),
          TIMyCustomRoundedCornerButton(
            onClickCallback: (){

            },
            btnText:MyStrings.txtDeviensPremium,
            myFont: MyFont.Courier_Prime_Bold,
            fontSize: MyFontSize.size18,
            textColor: Colors.white,
            buttonWidth: Get.width*.60,
            buttonHeight: Get.height*.060,
            borderRadius: Get.width*.060,
            btnBgColor: MyColors.expantionTileBgColor,
          )
        ],
      ),
    );
  }
  _bottomLayout(){
    return  Stack(
      alignment: Alignment.centerRight,
      children: [
        MyBottomLayout(
          imgUrl: MyImageURL.travel_book_bottom,
        ),
        Padding(
          padding:EdgeInsets.only(top:Get.width*.06,
              right: Get.width*.06),
          child: GestureDetector(
              onTap: (){
                myController.showFlightAndTrainPopup.value=true;
              },
              child: Image.asset(MyImageURL.info_big)),
        ),
      ],
    );
  }

  _centerTitle(){
    switch (Tag) {
      case TITag.TAGPLAIN:
        return "ADVENTURE2023 MONTPELLIER";
        break;
      case TITag.TAGTRAIN:
        return "ADVENTURE2023 MONTPELLIER";
        break;

    }
  }

  _centerImage(){
    switch (Tag) {
      case TITag.TAGPLAIN:
        return MyImageURL.plane_icon;
        break;
      case TITag.TAGTRAIN:
        return MyImageURL.train2x_icon;
        break;

    }
  }
  _centerSubTitle(){
    switch (Tag) {
      case TITag.TAGPLAIN:
        return  MyStrings.txtMESVOLS;
        break;
      case TITag.TAGTRAIN:
        return  MyStrings.txtMesTrains;
        break;

    }
  }


}*/
