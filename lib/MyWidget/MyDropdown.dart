import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';

import 'MyText.dart';

class MyDropdown extends StatefulWidget {
  const MyDropdown({Key key}) : super(key: key);

  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  ApiManager apiManager = ApiManager();

  MyController dataController = Get.put(MyController());

  @override
  void initState() {


    WidgetsBinding.instance.addPostFrameCallback((_) {
      dataController.getCountries();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        popupDialog();
      },
      child: Container(
        width: 200,
        height: 40,
        // width: Get.width*0.2,

        decoration: BoxDecoration(
            color: MyColors.whiteColor.withOpacity(1),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(13)),
            boxShadow: [
              BoxShadow(
                color: MyColors.dialog_shadowColor,
                blurRadius: 2,
                offset: Offset(1, 1),
              )
            ]),
        child: Obx(() => MyText(
          text_name: dataController.selectedValue.value.countryname != null
              ? dataController.selectedValue.value.countryname
              : dataController.countryList.value.length > 0 ?
          dataController.countryList.value.first.countryname:"",
          txtcolor: MyColors.textColor,
          txtfontsize: MyFontSize.size13,
        ),),
      ),
    );
  }

  popupDialog() {
    return Get.dialog(AlertDialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(13))),
        content: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
              width: 200,
              padding: EdgeInsets.symmetric(vertical: 20),
              // width: Get.width*0.2,
              decoration: BoxDecoration(
                  color: MyColors.whiteColor.withOpacity(1),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.dialog_shadowColor,
                      blurRadius: 2,
                      offset: Offset(1, 1),
                    )
                  ]),
              // width: Get.width * 0.01,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: dataController.countryList.value.length,
                  // itemCount: 4,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        dataController.selectedValue.value =
                        dataController.countryList.value[index];
                        Get.back();

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: MyText(
                          text_name: dataController.countryList.value[index].countryname,
                          txtcolor: MyColors.textColor,
                          txtfontsize: MyFontSize.size13,
                        ),
                      ),
                    );
                  })),
        )));
  }
}
