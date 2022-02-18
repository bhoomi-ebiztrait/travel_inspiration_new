import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';

class MyRatingBar extends StatefulWidget {
 int itemCount;
 double itemSize;
 Function onRateUpdate;
 double initialRating,iconSize,horizontalPaddong;
  MyRatingBar({this.itemCount,this.initialRating,
    this.onRateUpdate,this.iconSize,this.horizontalPaddong=0});

  @override
  _MyRatingBarState createState() => _MyRatingBarState();
}

class _MyRatingBarState extends State<MyRatingBar> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RatingBar.builder(
        initialRating: widget.initialRating,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemSize:widget.iconSize,
        itemCount: widget.itemCount,
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,),
          // size: 15.1,
        itemPadding: EdgeInsets.symmetric(horizontal:widget.horizontalPaddong),
        // onRatingUpdate: null,
        ignoreGestures: true,
        onRatingUpdate: widget.onRateUpdate,
        // updateOnDrag: false,
      ),
    );
  }
}
