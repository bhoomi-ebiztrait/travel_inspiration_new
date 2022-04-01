import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiParameter.dart';
import 'package:travel_inspiration/MyWidget/MyCommonMethods.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';

class TIReturnFlightRowWIthImage extends StatelessWidget {
  int index;
  TIReturnFlightRowWIthImage(this.index);

/*  var customFlightModel,tileColor;
  TIAvailableFlightRowWithImage({this.customFlightModel,this.tileColor});*/
   MyController myController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    print("index....$index");
    return Column(
      children: [
        Container(
          height: Get.height*0.08,
          width: Get.width,
          color:myController.myIntReturnList1.value[index][0].outwardSelect == true ? MyColors.lightGreenColor.withOpacity(0.32):Colors.transparent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
               Image.network("https://webapi.etravos.com${myController.myIntReturnList1.value[index][0].imagePath}",width: 50,height: 50,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyTextStart(
                    // ignore: invalid_use_of_protected_member
                    text_name:myController.myIntReturnList1.value[index][0].airLineName.toString(),
                    myFont: MyFont.Courier_Prime_Bold,
                    txtfontsize: MyFontSize.size10,
                  ),
                  MyTextStart(
                   text_name: myController.myIntReturnList1.value[index][0].intNumStops == "0" ? "NonStop": "stop : ${myController.myIntReturnList1.value[index][0].intNumStops}",
                    myFont: MyFont.Courier_Prime,
                    txtfontsize: MyFontSize.size10,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyTextStart(
                    text_name:myController.myIntReturnList1.value[index][0].duration,
                    myFont: MyFont.Courier_Prime_Bold,
                    txtfontsize: MyFontSize.size10,
                  ),
                  MyTextStart(
                    text_name: "${myController.myIntReturnList1.value[index][0].departureAirportCode} -  ${myController.myIntReturnList1.value[index][0].arrivalAirportCode}",
                    myFont: MyFont.Courier_Prime,
                    txtfontsize: MyFontSize.size10,
                  )


                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyTextStart(
                    // text_name:myController.flightList.value[index].fareDetails.totalFare.toString(),
                    text_name:"${((myController.fareList.value[index])/(ApiParameter.ONE_POUND_VAL)).toStringAsFixed(2)} ${ApiParameter.POUND_SYM}",
                    myFont: MyFont.Courier_Prime_Bold,
                    txtfontsize: MyFontSize.size10,
                  ),
                  MyTextStart(
                    text_name:"Per Person",
                    myFont: MyFont.Courier_Prime,
                    txtfontsize: MyFontSize.size10,
                  )
                ],
              )
            ],
          ),
        ),
        MyCommonMethods.myDivider(),

      ],
    );
  }
}

// /*
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:travel_inspiration/MyWidget/MyText.dart';
// import 'package:travel_inspiration/TIController%20/MyController.dart';
// import 'package:travel_inspiration/utils/MyColors.dart';
// import 'package:travel_inspiration/utils/MyFont.dart';
// import 'package:travel_inspiration/utils/MyFontSize.dart';
//
// class TIAvailableFlightRowWithImage extends StatelessWidget {
//
//  int index;
//   TIAvailableFlightRowWithImage(this.index);
//
//   MyController myController = Get.put(MyController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: Get.height*0.08,
//           width: Get.width,
//           color:MyColors.expantionTileBgColor.withOpacity(0.32),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Image.network("https://webapi.etravos.com${myController.flightList.value[index].intOnward.flightSegments[0].imagePath}",width: 50,height: 50,),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   MyTextStart(
//                     // ignore: invalid_use_of_protected_member
//                     text_name:myController.flightList.value[index].intOnward.flightSegments[0].airLineName.toString(),
//                     myFont: MyFont.Courier_Prime_Bold,
//                     txtfontsize: MyFontSize.size10,
//                   ),
//                   MyTextStart(
//                     text_name: myController.flightList.value[index].intOnward.flightSegments[0].stopQuantity == 0 ? "nonStop": "stop : ${myController.flightList.value[index].intOnward.flightSegments[0].stopQuantity}",
//                     myFont: MyFont.Courier_Prime,
//                     txtfontsize: MyFontSize.size10,
//                   )
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   MyTextStart(
//                     text_name:myController.flightList.value[index].intOnward.flightSegments[0].duration,
//                     myFont: MyFont.Courier_Prime_Bold,
//                     txtfontsize: MyFontSize.size10,
//                   ),
//                   */
// /*MyTextStart(
//                     text_name:customFlightModel.ltn+" - "+
//                         customFlightModel.mtm,
//                     myFont: MyFont.Courier_Prime,
//                     txtfontsize: MyFontSize.size10,
//                   )*//*
//
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   MyTextStart(
//                     text_name:myController.flightList.value[index].fareDetails.totalFare.toString(),
//                     myFont: MyFont.Courier_Prime_Bold,
//                     txtfontsize: MyFontSize.size10,
//                   ),
//                   MyTextStart(
//                     text_name:"Per Person",
//                     myFont: MyFont.Courier_Prime,
//                     txtfontsize: MyFontSize.size10,
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//         Divider(
//           height: 1,
//           thickness:2,
//           color:MyColors.expantionTileBgColor.withOpacity(0.32)
//         ),
//
//       ],
//     );
//   }
// }
// */
