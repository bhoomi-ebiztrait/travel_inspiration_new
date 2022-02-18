import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyCustomListWithStar.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/TIMyBottomLayout.dart';
import 'package:travel_inspiration/MyWidget/TINoRecordFound.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/TIModel/TIDestinationInProgressModel.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyPreference.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

import 'HotelDetailsScreen.dart';

class PinListScreen extends StatefulWidget {
  String imgIcon,title,travelLougeListTitle,type;
  PinListScreen({this.imgIcon,this.title,this.travelLougeListTitle,this.type});

  @override
  _PinListScreenState createState() => _PinListScreenState();
}

class _PinListScreenState extends State<PinListScreen> {
  MyController myController = Get.put(MyController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // myController.mPinList.value.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {

      getPinItem();

    });
  }

  getPinItem() async{
    Map<String,dynamic> param = {
      "userId":MyPreference.getPrefStringValue(key: MyPreference.userId),
      "type":widget.type,
    };

   await myController.getPinList(param);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body:_buildBodyContent(),
        bottomSheet: MyBottomLayout(
          imgUrl: MyImageURL.travel_book_bottom,
        ),
      ),
    );
  }

  _buildBodyContent(){

      return  SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MyTopHeader(
              headerName:widget.travelLougeListTitle,
              headerImgUrl: MyImageURL.travel_book_top,
              logoImgUrl: MyImageURL.haudos_logo,
              logoCallback: (){
                CommonMethod.getAppMode();
              },
            ),
            SizedBox(
              height: Get.height * .020,
            ),
            buildTitle(),
            SizedBox(
              height: Get.height * .020,
            ),
            //_hotelList(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40,),
              child: Container(
                  height: Get.height,
                  child:_pinList()),
            ),
            SizedBox(
              height: Get.height * .30,
            ),

          ],
        ),
      );

  }

  _pinList() {
    /*if(myController.mPinList.value.length==0){
      return Center(
        child: MyText(
          text_name: MyStrings.txtNoRecordFound,
          myFont: MyFont.Courier_Prime,
          txtcolor: MyColors.textColor,
          txtfontsize: MyFontSize.size28,
        ),
      );
    }*/

      return Obx(() {

          return ListView.builder(
              itemCount: myController.mPinList.value.length,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                TIDestinationInProgressModel mData = TIDestinationInProgressModel();

                mData = myController.mPinList.value[index];
                print("name : ${myController.mPinList.value[index].name}");


                return Slidable(
                  key: ValueKey(mData),

                  endActionPane: ActionPane(
                    extentRatio: 0.25,
                    motion: ScrollMotion(),
                    children: [
                      GestureDetector(
                        onTap: (){
                          callDeletePinAPI(index);
                        },
                        child: Container(
                            padding: EdgeInsets.only(top: 8),
                            alignment: Alignment.topCenter,
                            height: Get.height,
                            color: MyColors.whiteColor,
                            child: Image.asset(
                              MyImageURL.cross_gray3x, fit: BoxFit.fill,)),
                      ),

                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      ScreenTransition.navigateToScreenLeft(screenName:
                      HotelDetailsScreen(place_id: myController.mPinList
                          .value[index]
                          .place_id,
                        name: widget.travelLougeListTitle,
                        photo_ref: myController.mPinList.value[index]
                            .photo_ref,));
                    },
                    child: MyListRowWithStar(
                      heading: mData.name,
                      title: mData.description,
                      subTitle: "Lire la suite",
                      imageUrl: mData.photo_ref != null ? getPhotoImage(
                          mData.photo_ref) : mData.imgUrl,
                      starNumber: mData.rating.toInt(),
                      myRate: mData.rating,
                      starIconSize: Get.width * .05,
                      horizontalPadding: 0.0,
                    ),
                  ),
                );
              });


      });

  }

  buildTitle() {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(width: Get.width*.050,),
          Image.asset(widget.imgIcon,
            height: Get.height*.038,
            width: Get.height*.038,
            fit: BoxFit.contain,
          ),
          SizedBox(width: Get.width*.030,),
          MyText(
            text_name: widget.title.toUpperCase(),
            txtfontsize: MyFontSize.size13,
            txtcolor: MyColors.textColor,
            myFont: MyStrings.courier_prime_bold,
          ),

        ],
      ),
    );
  }

   callDeletePinAPI(int index) async{
     ApiManager apiManager = ApiManager();

     Map<String,dynamic> param = {
       "userId":MyPreference.getPrefStringValue(key: MyPreference.userId),
       "pinId":myController.mPinList.value[index].id,

     };
     await apiManager.deletePinAPI(param).then((value) {
       if (value) {

         setState(() {

           myController.mPinList.value.removeAt(index);

         });

       }
     });

   }
}
