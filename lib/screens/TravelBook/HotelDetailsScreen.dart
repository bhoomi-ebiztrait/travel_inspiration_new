import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_inspiration/Models/PlaceDetails.dart';
import 'package:travel_inspiration/MyWidget/MyButton.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyRatingBar.dart';
import 'package:travel_inspiration/MyWidget/MySettingTop.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/MyTitlebar.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/MyUtility.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ReadReviewScreen.dart';

class HotelDetailsScreen extends StatefulWidget {
  String place_id, name,photo_ref;

  HotelDetailsScreen({this.place_id, this.name,this.photo_ref});

  @override
  State<HotelDetailsScreen> createState() => _HotelDetailsScreenState();
}

class _HotelDetailsScreenState extends State<HotelDetailsScreen> {
  MyController myController = Get.put(MyController());

  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    _onAddMarkerButtonPressed();
  }

  void _onAddMarkerButtonPressed() {
    setState(() {

      if(myController.mPlaceDetails.value != null &&  myController.mPlaceDetails.value.result != null){

        _markers.add(Marker(
// This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(myController.mPlaceDetails.value.result.placeId),
          position: LatLng(myController.mPlaceDetails.value.result.geometry.location.lat,myController.mPlaceDetails.value.result.geometry.location.lng),
          infoWindow: InfoWindow(
            title: myController.mPlaceDetails.value.result.name,
            // snippet: "5 Star Rating",
          ),
          icon: BitmapDescriptor.defaultMarker,
        ));

        print("added");

      }


    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myController.mPlaceDetails.value = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myController.getPlaceDetails(widget.place_id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.settingBgColor,
      body: SafeArea(
        child: Obx(() {
          return Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: Get.height*0.30,
                width: Get.width,
                color: MyColors.buttonBgColorHome.withOpacity(0.7),
                child: Column(children: [
                  MyTopHeader(
                    logoImgUrl: MyImageURL.logo_icon,
                    logoCallback: (){
                      CommonMethod.getAppMode();
                    },
                  ),
                  MyTitlebar(title:widget.name),
                ],),
              ),

              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 40,horizontal:10),
                  height: Get.height,
                  color: MyColors.buttonBgColorHome.withOpacity(0.30),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MyText(
                          text_name: (myController.mPlaceDetails.value != null && myController.mPlaceDetails.value.result != null)
                              ? myController.mPlaceDetails.value.result.name
                              : "",
                          myFont: MyStrings.courier_prime_bold,
                          txtfontsize: MyFontSize.size13,
                        ),
                        MyRatingBar(
                          iconSize: 20,
                          itemCount: 5,
                          onRateUpdate: null,
                          initialRating: (myController.mPlaceDetails.value != null && myController.mPlaceDetails.value.result != null)
                              ? myController.mPlaceDetails.value.result.rating
                              : 0.0,
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        /*getTitle(MyStrings.description),
                buildContent(
                      "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut"),
                getTitle(MyStrings.commodites),
                getCommodites(),
                getTitle(MyStrings.room_types),
                getRooms(),*/
                        getTitle("hours".tr),
                        SizedBox(
                          height: Get.height * 0.005,
                        ),
                        getHours(),
                        getTitle("address".tr),
                        buildContent((myController.mPlaceDetails.value != null && myController.mPlaceDetails.value.result != null)
                            ? myController.mPlaceDetails.value.result.formattedAddress
                            : ""),
                        SizedBox(
                          height: Get.height * 0.005,
                        ),
                        buildMap(),
                        getTitle("picture_gallery".tr),
                        getPictures(),
                        getContactInfo(),
                        getReviews(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80.0, vertical: 20),
                          child: MyButton(
                            btn_name: "to_book".tr,
                            bgColor: MyColors.buttonBgColorHome,
                            opacity: 1,
                            myFont: MyStrings.courier_prime_bold,
                            txtcolor: MyColors.whiteColor,
                            // fontWeight: FontWeight.bold,
                            txtfont: MyFontSize.size18,
                            onClick: (){
                              goToBrowser();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),


            ],
          );
        }),
      ),
    );
  }

  buildContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
      child: MyTextStart(
        text_name: content,
        txtfontsize: MyFontSize.size8,
        txtcolor: MyColors.textColor,
      ),
    );
  }

  getHours() {
    var openHourWidgets = List<Widget>();
    if ((myController.mPlaceDetails.value != null && myController.mPlaceDetails.value.result != null)) {
      List<String> mWeekDay =
          myController.mPlaceDetails.value.result.openingHours!= null ? myController.mPlaceDetails.value.result.openingHours.weekdayText:null;
      if(mWeekDay != null) {
        for (int i = 0; i < mWeekDay.length; i++) {
          openHourWidgets.add(
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 4),
              child: new MyTextStart(
                text_name: mWeekDay[i],
                txtcolor: MyColors.textColor,
                txtfontsize: MyFontSize.size8,
              ),
            ),
          );
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          openHourWidgets,
    );
  }



  getContactInfo() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 30),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              _makePhoneCall(myController.mPlaceDetails.value.result.formattedPhoneNumber);
            },
            child: MyText(
              text_name: (myController.mPlaceDetails.value != null && myController.mPlaceDetails.value.result != null)
                  ? myController.mPlaceDetails.value.result.formattedPhoneNumber!= null ? myController.mPlaceDetails.value.result.formattedPhoneNumber:""
                  : "",
              myFont: MyStrings.courier_prime_bold,
              txtfontsize: MyFontSize.size10,
              txtcolor: MyColors.textColor,
            ),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: (myController.mPlaceDetails.value != null && myController.mPlaceDetails.value.result != null)
                          ? myController.mPlaceDetails.value.result.website
                          : "",
                      style: new TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = ()  {
                          goToBrowser();
                        }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  getTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10, bottom: 5),
      child: MyTextStart(
        text_name: title,
        myFont: MyStrings.courier_prime_bold,
        txtfontsize: MyFontSize.size10,
        txtcolor: MyColors.textColor,
      ),
    );
  }

  getPictures() {
    return Container(
      height: Get.height * 0.16,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: (myController.mPlaceDetails.value != null && myController.mPlaceDetails.value.result != null) ? myController.mPlaceDetails.value.result.photos.length : 0,
          itemBuilder: (context, index) {
            return getListItem(myController.mPlaceDetails.value.result.photos[index].photoReference);
          }),
    );
  }

  buildReviews() {
    return Container(
      height: Get.height * 0.20,
      padding: EdgeInsets.only(left: 5, top: 20, bottom: 10),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: (myController.mPlaceDetails.value != null && myController.mPlaceDetails.value.result != null) ? (myController.mPlaceDetails.value.result.reviews.length > 2 ?2 : myController.mPlaceDetails.value.result.reviews.length):0,
          itemBuilder: (context, index) {
            return getReviewItem(myController.mPlaceDetails.value.result.reviews[index]);
          }),
    );
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
                txtfontsize: MyFontSize.size8,
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
          txtfontsize: MyFontSize.size8,
          txtcolor: MyColors.textColor,
        ),
        SizedBox(
          height: Get.height * 0.02,
        )
      ],
    );
  }

  getRooms() {
    return Container(
      height: Get.height * 0.16,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) {
            return getListItem("Chambre double standard");
          }),
    );
  }

  getListItem(String photoRef) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: Get.width * 0.34,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(33)),
          color: MyColors.lightGreenColor,
          image: DecorationImage(
              image: NetworkImage(getPhotoImage(photoRef)),
              fit: BoxFit.fill),
        ),
       /* child: MyText(
          text_name: "$title",
          txtcolor: MyColors.whiteColor,
          txtfontsize: MyFontSize.size13,
          myFont: MyStrings.cagliostro,
        ),*/
      ),
    );
  }

  getCommodites() {
    return Container(
      height: Get.height * 0.10,
      color: MyColors.buttonBgColor.withOpacity(0.32),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    text_name: "Wifi gratuit",
                    txtfontsize: MyFontSize.size8,
                    txtcolor: MyColors.textColor,
                  ),
                  MyText(
                    text_name: "Multilingue",
                    txtfontsize: MyFontSize.size8,
                    txtcolor: MyColors.textColor,
                  ),
                  MyText(
                    text_name: "Terrace",
                    txtfontsize: MyFontSize.size8,
                    txtcolor: MyColors.textColor,
                  ),
                ],
              ),
            );
          }),
    );
  }

  getReviews() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildReviewTitle(),
          buildReviews(),
        ],
      ),
    );
  }

  buildReviewTitle() {
    return Row(
      children: [
        MyText(
          text_name: "review".tr,
          txtcolor: MyColors.textColor,
          txtfontsize: MyFontSize.size10,
          myFont: MyStrings.courier_prime_bold,
        ),
        MyRatingBar(
          itemCount: 5,
          initialRating: (myController.mPlaceDetails.value != null && myController.mPlaceDetails.value.result != null)
              ? myController.mPlaceDetails.value.result.rating
              : 0.0,
          onRateUpdate: null,
          iconSize: 17,
        ),
        Spacer(),
        GestureDetector(
          onTap: (){
            ScreenTransition.navigateToScreenLeft(screenName: ReadReviewScreen());
          },
          child: MyText(
            text_name: "read_all_reviews".tr,
            txtcolor: MyColors.textColor,
            txtfontsize: MyFontSize.size10,
            myFont: MyStrings.courier_prime_bold,
          ),
        ),
      ],
    );
  }

   goToBrowser() async {
    var url =
        myController.mPlaceDetails.value.result.website;
    if(myController.mPlaceDetails.value.result.website != null) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }else{
      MyUtility.showErrorMsg("website URL is not available");
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {

    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  buildMap() {
    return Obx((){
      return Container(
        width: Get.width,
        height: Get.height*0.30,
        child: (myController.mPlaceDetails.value != null && myController.mPlaceDetails.value.result != null) ?GoogleMap(
          markers: _markers,
          //onCameraMove: _onCameraMove,
          onMapCreated: _onMapCreated,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(target: LatLng(myController.mPlaceDetails.value.result.geometry.location.lat, myController.mPlaceDetails.value.result.geometry.location.lng ),zoom: 18.0),
        ): Container(),
      );
    });
  }

}
