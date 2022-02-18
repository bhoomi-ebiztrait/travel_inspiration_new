import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_inspiration/TIModel/TIDestinationInProgressModel.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';

class MapScreen extends StatefulWidget {
  TIDestinationInProgressModel mList;
  MapScreen(this.mList);
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  Completer<GoogleMapController> _controller = Completer();
   // LatLng _center;
  //LatLng _lastMapPosition ;
  final Set<Marker> _markers = {};

  /*void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }*/

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    _onAddMarkerButtonPressed();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //getCurrentLatLng();


  }
  /*getCurrentLatLng() async{
    Position _getCurrentPosition = await determineCurrentPosition();
    _center = LatLng(_getCurrentPosition.latitude,_getCurrentPosition.longitude);
    // _lastMapPosition = LatLng(_center.latitude, _center.longitude);
  }*/

  void _onAddMarkerButtonPressed() {
    setState(() {

      _markers.add(Marker(
// This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(widget.mList.place_id),
        position: LatLng(widget.mList.lat,widget.mList.lng),
        infoWindow: InfoWindow(
          title: widget.mList.name,
          // snippet: "5 Star Rating",
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));

     /* for(int i=0;i<myController.mList.length;i++) {
        _markers.add(Marker(
// This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(myController.mList[i].place_id),
          position: LatLng(myController.mList[i].lat,myController.mList[i].lng),
          infoWindow: InfoWindow(
            title: myController.mList[i].name,
            // snippet: "5 Star Rating",
          ),
          icon: BitmapDescriptor.defaultMarker,
        ));
      }*/
      print("added");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: _markers,
        //onCameraMove: _onCameraMove,
        onMapCreated: _onMapCreated,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(target: LatLng(widget.mList.lat,widget.mList.lng),zoom: 15.0),
      ),
    );
  }
}
