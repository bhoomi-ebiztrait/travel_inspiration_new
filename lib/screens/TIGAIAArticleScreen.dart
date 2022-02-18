import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/TIModel/TIArticalListModel.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';

class TIGAIAArticleScreen extends StatelessWidget {
  TIArticalListModel articalListModel;
  TIGAIAArticleScreen({this.articalListModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _buildBodyContent()),
    );
  }

  _buildBodyContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          MyTopHeader(
            headerImgUrl: MyImageURL.gia_topBg,
            headerName: "txtGaia".tr,
            logoImgUrl: MyImageURL.logo_icon,
            logoCallback: () {
              CommonMethod.getAppMode();
            },
          ),
          _buildBodyText(),
        ],
      ),
    );
  }

  _buildBodyText() {
    return Container(
      margin: EdgeInsets.only(
          left: Get.width * .025,
          right: Get.width * .025,
          top: Get.height * .04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child:Text(
              articalListModel.title,
              style:TextStyle(
                  fontFamily: MyFont.Cagliostro_reguler,
                  fontSize: MyFontSize.size16,
                  color: MyColors.lightGreenColor),
            ),
            margin: EdgeInsets.only(left:Get.width*.015),
          ),
          SizedBox(
            height: Get.height * .020,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child:Html(
                  data:articalListModel.detail,
                ),
              ),
              SizedBox(
                width: Get.width * .020,
              ),
              Container(
                height: Get.height * .20,
                width: Get.height * .20,
                margin: EdgeInsets.only(top: Get.height*.020),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(
                            Get.width * .060)),
                    image:DecorationImage(
                        image: NetworkImage(
                          articalListModel.image
                        ),
                        fit: BoxFit.fill)),
              )
            ],
          ),

        ],
      ),
    );
  }
}
