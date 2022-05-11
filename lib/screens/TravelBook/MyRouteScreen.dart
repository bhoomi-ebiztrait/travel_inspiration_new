import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/screens/MapScreen.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';
import 'package:url_launcher/url_launcher.dart';

import 'RouteDetailsScreen.dart';

class MyRouteScreen extends StatefulWidget {
  Position currentPosition;
  MyRouteScreen(this.currentPosition);
  @override
  _MyRouteScreenState createState() => _MyRouteScreenState();
}

class _MyRouteScreenState extends State<MyRouteScreen> {

  MyController myController = Get.put(MyController());

  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};

  bool isClickedDetails = false;

  var address;



  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
   _onAddMarkerButtonPressed();
  }

  void _onAddMarkerButtonPressed() {

    if(myController.selectedPlace.value != null){

      if(myController.selectedPlace.value.name == ""){
        myController.selectedPlace.value.name = "";
        myController.selectedPlace.value.lat = widget.currentPosition.latitude;
        myController.selectedPlace.value.lng = widget.currentPosition.longitude;
      }

      _markers.add(Marker(
// This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(myController.selectedPlace.value.place_id),
          position: LatLng(myController.selectedPlace.value.lat,myController.selectedPlace.value.lng),
          infoWindow: InfoWindow(
            title: myController.selectedPlace.value.name,
            // snippet: "5 Star Rating",
          ),
          icon: BitmapDescriptor.defaultMarker,visible: true
      ));
      _markers.add(Marker(
// This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId("myController.selectedPlace.value.place_id"),
          position: LatLng(widget.currentPosition.latitude,widget.currentPosition.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(90),visible: true
      ));

      print("added");
      _getPolyline();

    }


  }
  void _getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      ApiParameter.GOOGLE_API_KEY,
      PointLatLng(widget.currentPosition.latitude,widget.currentPosition.longitude),
      PointLatLng(myController.selectedPlace.value.lat,myController.selectedPlace.value.lng),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    _addPolyLine(polylineCoordinates);
  }
  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentAddress();
    if(myController.selectedPlace.value != null) {
      if (myController.selectedPlace.value.name == "") {
        myController.selectedPlace.value.name = "";
        myController.selectedPlace.value.lat = widget.currentPosition.latitude;
        myController.selectedPlace.value.lng = widget.currentPosition.longitude;
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myController.getDistanceAPI(widget.currentPosition.latitude,widget.currentPosition.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: MyColors.buttonBgColorHome.withOpacity(0.7),
              child: Column(
                children: [
                  buildAddress(),
                  SizedBox(height: 20,),
                  isClickedDetails==true ? buildDistanceUI() :buildButtons(),
                  SizedBox(height: 30,),
                ],
              ),
            ),

            buildMap(),
            // SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }

  buildMap() {
    print("camera ${myController.selectedPlace.value.lat}");
    return Obx((){
      return Expanded(
        child: GoogleMap(
          markers: _markers,
          //onCameraMove: _onCameraMove,
          onMapCreated: _onMapCreated,
          polylines: Set<Polyline>.of(polylines.values),
          mapType: MapType.normal,
         myLocationEnabled: true,
         initialCameraPosition: CameraPosition(target: LatLng(myController.selectedPlace.value.lat, myController.selectedPlace.value.lng ),zoom: 14.0),
         // initialCameraPosition: CameraPosition(target: LatLng(widget.currentPosition.latitude, widget.currentPosition.latitude),zoom: 18.0),

        ),
      );
    });
  }


  buildAddress() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: (){
                if(isClickedDetails == true){
                  setState(() {
                    isClickedDetails = false;
                  });
                }else{
                  Get.back();
                }
              },
              child: Image.asset(MyImageURL.back,
                width: 25,)),
          SizedBox(width: 10,),
          Flexible(
            child: Container(
              width: Get.width*0.6,
              child: MyTextStart(text_name: "${myController.selectedPlace.value.description}",
                txtcolor: MyColors.textColor,
                txtfontsize: MyFontSize.size13,
                myFont: MyStrings.courier_prime_bold,
                // maxLine: 5,
              ),
            ),
          ),
          GestureDetector(
              onTap: (){
                CommonMethod.getAppMode();
              },
              child: Image.asset(MyImageURL.home_icon,width: 50,)),
        ],
      ),
    );
  }

  buildDistanceUI(){
    return Obx((){
      return Padding(
        padding: const EdgeInsets.only(left:40.0,right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildColumn("time".tr, myController.duration.value),
            buildColumn("DISTANCE".tr,myController.distance.value),
            buildColumn("METHODE".tr,"car".tr),
            GestureDetector(
                onTap: (){
                  if(address == null){
                   getCurrentAddress();
                  }else {
                    print("myAdd:: ${address.streetAddress}");
                    ScreenTransition.navigateToScreenLeft(
                        screenName: RouteDetailsScreen(currCity: address.city,
                          currAddress: address.streetAddress,currPos: widget.currentPosition));
                  }
                },
                child: Image.asset(MyImageURL.fleche,height: 80,width: 80,)),
          ],
        ),
      );
    });

  }

   buildColumn(title,value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyTextStart(
              text_name: title,
              txtfontsize: MyFontSize.size10,
              myFont: MyStrings.courier_prime_bold,
              txtcolor: MyColors.whiteColor,
            ),
            SizedBox(height: 4,),
            MyTextStart(
              text_name: value,
              txtfontsize: MyFontSize.size14,
              myFont: MyStrings.courier_prime_bold,
              txtcolor: MyColors.whiteColor,
            ),
          ],
        );
  }

  buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildDetails(),
        _buildDirection(),
      ],
    );
  }

  _buildDetails() {
    return GestureDetector(
      onTap: (){
        setState(() {
          if(address == null){
            getCurrentAddress();
          }
          isClickedDetails = true;
          myController.getDistanceAPI(widget.currentPosition.latitude,widget.currentPosition.longitude);
        });
      },
      child: Container(
        width: Get.width * .38,
        height: Get.height * .050,
        decoration: BoxDecoration(
          color: MyColors.buttonBgColor,
          borderRadius: BorderRadius.all(Radius.circular(Get.width * .050)),
        ),
        child: MyText(
          text_name: "DETAILS".tr,
          myFont: MyFont.Courier_Prime_Bold,
          txtfontsize: MyFontSize.size13,
          txtcolor: MyColors.whiteColor,
          txtAlign: TextAlign.center,
        ),
      ),
    );
  }

  _buildDirection() {
    return GestureDetector(
      onTap: (){
        goToGoogleDir();
      },
      child: Container(
        width: Get.width * .38,
        height: Get.height * .050,
        decoration: BoxDecoration(
          color: MyColors.buttonBgColor,
          borderRadius: BorderRadius.all(Radius.circular(Get.width * .050)),
        ),
        child: MyText(
          text_name: "DIRECTION".tr,
          myFont: MyFont.Courier_Prime_Bold,
          txtfontsize: MyFontSize.size13,
          txtcolor: MyColors.whiteColor,
          txtAlign: TextAlign.center,
        ),
      ),
    );
  }

  void getCurrentAddress() async{
    GeoCode geoCode = GeoCode();

    try {
      address = await geoCode.reverseGeocoding(latitude: widget.currentPosition.latitude,longitude: widget.currentPosition.longitude);

      print("Latitude: ${address.city}");
      print("Longitude: ${address.streetAddress}");
    } catch (e) {
      print(e);
    }
  }

  void goToGoogleDir() async{
    String url = 'https://www.google.com/maps/dir/?api=1&origin=${widget.currentPosition.latitude},${widget.currentPosition.longitude}&destination=${myController.selectedPlace.value.lat},${myController.selectedPlace.value.lng}&travelmode=driving&dir_action=navigate';
    print("google dir url $url");
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
