import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/TIMyCustomRoundedCornerButton.dart';
import 'package:travel_inspiration/MyWidget/TISearchBar.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/TIModel/TiMyFlightDetailModel.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';



class TIFlightSearchScreen extends StatefulWidget {

  String travelLougeListTitle;
  int selectedIndex;
  TIFlightSearchScreen({this.travelLougeListTitle, this.selectedIndex});
  @override
  TIFlightSearchScreenState createState() => TIFlightSearchScreenState();
}

class TIFlightSearchScreenState extends State<TIFlightSearchScreen> {
  MyController controller = Get.put(MyController());

  TextEditingController _locationSearchTextController = TextEditingController();
  List<TIMyFlightDetailModel> myFlightDetailList = [
    TIMyFlightDetailModel(title: "txtDepuis".tr, subTitle: ""),
    TIMyFlightDetailModel(title: "txtOu".tr, subTitle: ""),
    TIMyFlightDetailModel(title: "txtQuand".tr, subTitle: ""),
    TIMyFlightDetailModel(title: "txtPassagers".tr, subTitle: ""),
  ];
  var _scrollController = ScrollController();
  var _currentLocationSelected = false.obs;



@override
  void initState() {
   controller.airportlist.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: _buildBodyContent()
    ));
  }

  _buildBodyContent(){
    return SingleChildScrollView(
      child: Column(
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
            text_name: widget.selectedIndex == 0
                ? "txtJevoyagedepuis".tr + "  :"
                : "txtJevoyageVers".tr,
            myFont: MyFont.Courier_Prime_Bold,
            txtfontsize: MyFontSize.size13,
            txtcolor: MyColors.textColor,
            txtAlign: TextAlign.center,
          ),
          SizedBox(
            height: Get.height * .020,
          ),
          TISearchBar(
            textFormField: TextFormField(
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: MyFontSize.size10,
                  fontFamily: MyFont.Courier_Prime_Bold),
              //cursorHeight: Get.height * .030,
              cursorColor: MyColors.searchBorderColor,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              controller: _locationSearchTextController,
              onChanged: (value) {
               // _currentLocationSelected.value = false;
                if (value.isNotEmpty && value.length>=5) {
               //   focusOut(context);

                  controller.getAirportList(value,context);
                  controller.update();
                //  autoCompleteSearch(value);
                } else {
                  if (controller.airportlist.length > 0 && mounted) {
                    setState(() {
                      print(controller.airportlist.length);
                    });
                  }
                }
              },
            ),
          ),

          SizedBox(
            height: Get.height * .020,
          ),

        Obx(() {

        return  Container(
            width: Get.width*.85,
            height: double.tryParse(
                (controller.airportlist.length * (Get.height * 0.07)).toString()),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: controller.airportlist.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(controller.airportlist[index].name),
                            Divider(
                                color: Colors.blue
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  onTap: () async {
                    print(controller.airportlist[index].name);
                    if (controller.airportlist[index].place_id != null) {
                      Navigator.of(context).pop(controller.airportlist[index]);
                      controller.airportlist.clear();
                    }
                  },
                );
              },
            ),
          );
        }),
          Container(
            height: Get.height * .42,
          ),
          TIMyCustomRoundedCornerButton(
            onClickCallback: () {
              Get.back();
            },
            buttonWidth: Get.width * .48,
            buttonHeight: Get.height * .050,
            btnBgColor: MyColors.expantionTileBgColor,
            textColor: Colors.white,
            btnText: "txtValider".tr,
            fontSize: MyFontSize.size18,
            myFont: MyFont.Courier_Prime_Bold,
          ),
        ],
      ),
    );
  }


}
