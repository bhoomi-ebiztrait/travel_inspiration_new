import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/Models/PlaceDetails.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyRatingBar.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

class ReadReviewScreen extends StatefulWidget {
  const ReadReviewScreen({Key key}) : super(key: key);

  @override
  _ReadReviewScreenState createState() => _ReadReviewScreenState();
}

class _ReadReviewScreenState extends State<ReadReviewScreen> {
  MyController myController = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body:_buildBodyContent(),

        ));
  }

  _buildBodyContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTopHeader(
          headerName:"review".tr.toUpperCase(),
          headerImgUrl: MyImageURL.travel_book_top,
          logoImgUrl: MyImageURL.haudos_logo,
          logoCallback: (){
            CommonMethod.getAppMode();
          },
        ),
        SizedBox(
          height: Get.height * .020,
        ),
        MyText(
          text_name:myController.mPlaceDetails.value.result.name.toUpperCase(),
          myFont: MyFont.Courier_Prime_Bold,
          txtfontsize: MyFontSize.size15,
          txtcolor: MyColors.textColor,
          txtAlign: TextAlign.center,
        ),
        MyRatingBar(
          iconSize: 20,
          itemCount: 5,
          onRateUpdate: null,
          initialRating: myController.mPlaceDetails.value.result.rating,
        ),
        SizedBox(
          height: Get.height * .020,
        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: Get.width*.060),
          child: MyTextStart(
            text_name: "review".tr,
            txtcolor: MyColors.textColor,
            txtfontsize: MyFontSize.size12,
            myFont: MyStrings.courier_prime_bold,
          ),
        ),
        SizedBox(
          height: Get.height * .020,
        ),
        Expanded(child: _reviewList()),
       /* Padding(
          padding: const EdgeInsets.only(bottom: 40,),
          child: Container(
              height: Get.height,
              child:_restaurantList()),
        ),*/


      ],
    );
  }

  _reviewList() {

    return Obx((){
      return Padding(
        padding:  EdgeInsets.symmetric(horizontal: Get.width*.060,vertical: 20),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: myController.mPlaceDetails.value.result.reviews.length,
            itemBuilder: (context, index) {
              return getReviewItem(myController.mPlaceDetails.value.result.reviews[index]);
            }),
      );
    });

  }

  getReviewItem(Reviews review) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Row(
            children: [
              MyTextStart(
                text_name: review.authorName,
                txtfontsize: MyFontSize.size10,
                txtcolor: MyColors.textColor,
                myFont: MyStrings.courier_prime_bold,
              ),
              Spacer(),
              MyRatingBar(
                itemCount: 5,
                initialRating: review.rating.toDouble(),
                onRateUpdate: null,
                iconSize: 15,
              ),
            ],
          ),
        ),
        MyTextStart(
          text_name: review.text,
          txtfontsize: MyFontSize.size10,
          txtcolor: MyColors.textColor,
        ),
        SizedBox(
          height: Get.height * 0.02,
        )
      ],
    );
  }
}
