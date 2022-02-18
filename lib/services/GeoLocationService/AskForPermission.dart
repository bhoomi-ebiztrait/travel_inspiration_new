
import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class AskForPermission{
    // requestLocationPermission();
    // _gpsService();


/*Checking if your App has been Given Permission*/
  Future<bool> requestLocationPermission({Function onPermissionDenied}) async {

    var granted = await Permission.location.request().isGranted;
    if (granted!=true) {
      requestLocationPermission();
    }else{
      _gpsService();
    }
    print('requestContactsPermission $granted');
    return granted;
  }
/*Show dialog if GPS not enabled and open settings location*/
  Future _checkGps() async {
    if (!(await GeolocatorPlatform.instance.isLocationServiceEnabled())) {
      /*if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Can't get gurrent location"),
              content:const Text('Please make sure you enable GPS and try again'),
              actions: <Widget>[
                FlatButton(child: Text('Ok'),
                  onPressed: () {
                    final AndroidIntent intent = AndroidIntent(
                        action: 'android.settings.LOCATION_SOURCE_SETTINGS');
                    intent.launch();
                    Navigator.of(context, rootNavigator: true).pop();
                    _gpsService();
                  },
                ),
              ],
            );
          },
        );
      }*/
    }}
/*Check if gps service is enabled or not*/
  Future _gpsService() async {
    if (!(await GeolocatorPlatform.instance.isLocationServiceEnabled())) {
      _checkGps();
      return null;
    } else
      return true;
  }

}
