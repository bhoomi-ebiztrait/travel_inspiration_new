import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

class PhotoPreviewScreen extends StatefulWidget {

  String sourceName;
  PhotoPreviewScreen(this.sourceName);

  @override
  _PhotoPreviewScreenState createState() => _PhotoPreviewScreenState();
}
enum AppState {
  free,
  picked,
  cropped,
}
class _PhotoPreviewScreenState extends State<PhotoPreviewScreen> {
  File imageFile;
  AppState state;


  @override
  void initState() {
    super.initState();
    state = AppState.free;

    if (state == AppState.free) {
      print("source name: ${widget.sourceName}");
      if(widget.sourceName == "camera".tr){
        _openCamera();
      }else{
        _openGallery();
      }
    }
    else if (state == AppState.picked)
      _cropImage();
    else if (state == AppState.cropped) _clearImage();


  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: MyColors.whiteColor,
      child: _setImageView(),
    );
  }

  void _openGallery() async {
    PickedFile pickedImg = await ImagePicker().getImage(source: ImageSource.gallery);
    imageFile = File(pickedImg.path);
    if (imageFile != null) {
      setState(() {
        state = AppState.picked;
      });
      _cropImage();
    }
  }
  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        cropStyle: CropStyle.circle,
        aspectRatioPresets: Platform.isAndroid
        ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
        ]
        : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: MyColors.whiteColor,
            toolbarWidgetColor: MyColors.lightGreenColor,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {
        state = AppState.cropped;
        Get.back(result: imageFile);
      });
    }
  }

  void _clearImage() {
    imageFile = null;
    setState(() {
      state = AppState.free;
    });
  }

  void _openCamera() async {

    PickedFile pickedImg = await ImagePicker().getImage(source: ImageSource.camera);
    imageFile = File(pickedImg.path);
    if (imageFile != null) {
      setState(() {
        state = AppState.picked;
      });
      _cropImage();
    }
  }
  Widget _setImageView() {
    if (imageFile != null) {
      return Image.file(imageFile, width: 500, height: 500);
    } else {
      return Container(color: Colors.transparent,);
      // return Text("Please select an image");
    }
  }

}
