import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:get/get.dart';

import 'MyImageUrls.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin{
  AnimationController rotateArrow360;

  @override
  void initState() {
    // TODO: implement initState
    rotateArrow360= AnimationController(
      vsync:this,
      duration: Duration(seconds:2),
    );
    rotateArrow360.repeat();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    rotateArrow360.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return
      Center(
        child:RotationTransition(
          turns: Tween(begin: 0.0,end: 1.0).animate(rotateArrow360),
          child: Image.asset(
            MyImageURL.arrow3x,
            fit: BoxFit.contain,
            height: Get.height * .08,
            width: Get.height * .08,
          ),
        ),
      );

  }
}


