import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
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

class ShowMyRouteOnMapScreen extends StatefulWidget {

  @override
  _ShowMyRouteOnMapScreenState createState() => _ShowMyRouteOnMapScreenState();
}

class _ShowMyRouteOnMapScreenState extends State<ShowMyRouteOnMapScreen> {

  MyController myController = Get.put(MyController());

  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};

  bool isClickedDetails = false;

  Placemark address;



  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
   _onAddMarkerButtonPressed();
  }

  void _onAddMarkerButtonPressed() {

    if(myController.selectedRoute.value != null){

      _markers.add(Marker(
// This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(myController.selectedRoute.value.id.toString()),
          position: LatLng(double.parse(myController.selectedRoute.value.destLat),double.parse(myController.selectedRoute.value.destLng)),
          infoWindow: InfoWindow(
            title: myController.selectedPlace.value.name,
            // snippet: "5 Star Rating",
          ),
          icon: BitmapDescriptor.defaultMarker,visible: true
      ));
      _markers.add(Marker(
// This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId("myController.selectedPlace.value.place_id"),
          position: LatLng(double.parse(myController.selectedRoute.value.originLat),double.parse(myController.selectedRoute.value.originLng)),
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
      PointLatLng(double.parse(myController.selectedRoute.value.originLat),double.parse(myController.selectedRoute.value.originLng)),
      PointLatLng(double.parse(myController.selectedRoute.value.destLat),double.parse(myController.selectedRoute.value.destLng)),
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myController.getDistanceAPI(double.parse(myController.selectedRoute.value.originLat),double.parse(myController.selectedRoute.value.originLng));
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
            buildAddress(),
            SizedBox(height: 20,),
            isClickedDetails==true ? buildDistanceUI() :buildButtons(),
            SizedBox(height: 30,),
            buildMap(),
            // SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }

  buildMap() {
   // print("camera ${myController.selectedRoute.value.originLat}");
    return Obx((){
      return Expanded(
        child: GoogleMap(
          markers: _markers,
          //onCameraMove: _onCameraMove,
          onMapCreated: _onMapCreated,
          polylines: Set<Polyline>.of(polylines.values),
          mapType: MapType.normal,
         myLocationEnabled: true,
         initialCameraPosition: CameraPosition(target: LatLng(double.parse(myController.selectedRoute.value.destLat),double.parse(myController.selectedRoute.value.destLng)),zoom: 14.0),
         // initialCameraPosition: CameraPosition(target: LatLng(widget.currentPosition.latitude, widget.currentPosition.latitude),zoom: 18.0),

        ),
      );
    });
  }


  buildAddress() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
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
            child: MyTextStart(text_name: "${myController.selectedRoute.value.endAddress}",
              txtcolor: MyColors.textColor,
              txtfontsize: MyFontSize.size13,
              myFont: MyStrings.courier_prime_bold,
              // maxLine: 5,
            ),
          ),
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
                  // Position originPos = (double.parse(myController.selectedRoute.value.originLat),double.parse(myController.selectedRoute.value.originLng));
                  Position originPosi = Position(latitude:double.parse(myController.selectedRoute.value.originLat),longitude:double.parse(myController.selectedRoute.value.originLng));

                  if(address == null){
                   getCurrentAddress();
                  }else {
                    ScreenTransition.navigateToScreenLeft(
                        screenName: RouteDetailsScreen(currCity: address.name,
                          currAddress:"${address.name},${address.subLocality},${address.locality}",currPos: originPosi));
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
              txtcolor: MyColors.buttonBgColor.withOpacity(1),
            ),
            SizedBox(height: 4,),
            MyTextStart(
              text_name: value,
              txtfontsize: MyFontSize.size14,
              myFont: MyStrings.courier_prime_bold,
              txtcolor: MyColors.buttonBgColor.withOpacity(1),
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
          myController.getDistanceAPI(double.parse(myController.selectedRoute.value.originLat),double.parse(myController.selectedRoute.value.originLng));
        });
      },
      child: Container(
        width: Get.width * .38,
        height: Get.height * .050,
        decoration: BoxDecoration(
          color: MyColors.expantionTileBgColor,
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
          color: MyColors.expantionTileBgColor,
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

    List<Placemark> newAddress = await placemarkFromCoordinates(double.parse(myController.selectedRoute.value.originLat), double.parse(myController.selectedRoute.value.originLng));
    address = newAddress.last;

    /*GeoCode geoCode = GeoCode();

    try {
      address = await geoCode.reverseGeocoding(latitude: double.parse(myController.selectedRoute.value.originLat),longitude: double.parse(myController.selectedRoute.value.originLng));

      print("Latitude: ${address.city}");
      print("Longitude: ${address.streetAddress}");
    } catch (e) {
      print(e);
    }*/
  }

  void goToGoogleDir() async{
    String url = 'https://www.google.com/maps/dir/?api=1&origin=${double.parse(myController.selectedRoute.value.originLat)},${double.parse(myController.selectedRoute.value.originLng)}&destination=${myController.selectedPlace.value.lat},${myController.selectedPlace.value.lng}&travelmode=driving&dir_action=navigate';
    print("google dir url $url");
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
