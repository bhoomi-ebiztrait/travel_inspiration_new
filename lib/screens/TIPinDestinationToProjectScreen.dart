import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:travel_inspiration/APICallServices/ApiManager.dart';
import 'package:travel_inspiration/MyWidget/MyDropDownButton.dart';
import 'package:travel_inspiration/MyWidget/MyLoginHeader.dart';
import 'package:travel_inspiration/MyWidget/MyText.dart';
import 'package:travel_inspiration/MyWidget/TIMyBottomLayout.dart';
import 'package:travel_inspiration/TIController/MyController.dart';
import 'package:travel_inspiration/TIModel/TIPinDestationModel.dart';
import 'package:travel_inspiration/screens/TravelBook/ShareProjectScreen.dart';
import 'package:travel_inspiration/screens/TravelBook/VacationProjectFileScreen.dart';
import 'package:travel_inspiration/utils/CommonMethod.dart';
import 'package:travel_inspiration/utils/MyColors.dart';
import 'package:travel_inspiration/utils/MyFont.dart';
import 'package:travel_inspiration/utils/MyFontSize.dart';
import 'package:travel_inspiration/utils/MyImageUrls.dart';
import 'package:travel_inspiration/utils/MyStrings.dart';
import 'package:travel_inspiration/utils/TIScreenTransition.dart';

class TIPinDestinationToProjectScreen extends StatefulWidget {

  String travelLougeTitle, popupTitle = "";

  TIPinDestinationToProjectScreen({this.travelLougeTitle});
  @override
  _TIPinDestinationToProjectScreenState createState() =>
      _TIPinDestinationToProjectScreenState();
}

class _TIPinDestinationToProjectScreenState
    extends State<TIPinDestinationToProjectScreen>
    with SingleTickerProviderStateMixin {
  MyController myController = Get.put(MyController());



  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState

    myController.stopTracking();
    animationController = AnimationController(
        duration: const Duration(seconds: 2), vsync: this);
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      myController.getAllProject();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:_buildBodyContent()
      ),
      bottomSheet: MyBottomLayout(
        imgUrl: MyImageURL.travel_book_bottom,
      ),
    );
  }

  _buildBodyContent(){
    return  Obx(() => Column(
      children: [
        MyTopHeader(
          headerName:widget.travelLougeTitle!= null ?widget.travelLougeTitle.toUpperCase():"",
          headerImgUrl: MyImageURL.travel_book_top,
          logoImgUrl: MyImageURL.haudos_logo,
          logoCallback: (){
            CommonMethod.getAppMode();
          },
        ),
        SizedBox(
          height: Get.height * .04,
        ),

        Container(height: Get.height * .30, child: _destinationList()),
        SizedBox(
          height: Get.height * .05,
        ),
        myController.rotateArrow.value
            ? Container(
        )
            : Container(),
      ],
    ));
  }

  _destinationList() {
    return Obx((){
      return ListView.builder(
          itemCount: myController.allProjectList.length,
          itemBuilder: (context, index) {
            return Slidable(
              key: ValueKey(myController.allProjectList[index]),
              endActionPane: ActionPane(
                extentRatio: 0.28,
                motion: ScrollMotion(),
                children: [
                  Container(
                    // alignment: Alignment.topCenter,
                    height: Get.height,
                    width: Get.width * 0.28,
                    color: MyColors.whiteColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap:(){
                              ScreenTransition.navigateToScreenLeft(screenName: ShareProjectScreen(myController.allProjectList[index].id,index));
                            },
                            child: Image.asset(MyImageURL.share_btn,)),
                        GestureDetector(
                            onTap: (){
                              callDeleteProj(myController.allProjectList[index].id,index);
                            },
                            child: Image.asset(MyImageURL.cross,width: 30,)),
                      ],
                    ),
                  ),

                ],
              ),
              child: ListTile(
                onTap: () {
                  /*for (int i = 0; i < myController.allProjectList.length; i++) {
                  if (index == i) {
                    setState(() {
                      myController.allProjectList[i].isSelected =
                          !myController.allProjectList[i].isSelected;
                      if(myController.allProjectList[i].isSelected){
                       myController.rotateArrow.value = true;


                      }else{
                      //  myController.rotateArrow.value = false;
                        animationController.reset();

                      }
                      Future.delayed(Duration(seconds:1),(){
                        myController.rotateArrow.value=false;
                        myController.allProjectList[i].pinDestination=" - test $i";
                        myController.allProjectList[i].isSelected=false;
                      });

                    });


                  } else {
                    setState(() {
                      myController.allProjectList[i].isSelected = false;
                    });
                  }
                }*/
                },
                contentPadding: EdgeInsets.only(
                  left: Get.height * .040,
                  right: Get.height * .040,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                myController.allProjectList[index].pinDestination != "" ? "${myController.allProjectList[index].title.toUpperCase()} - ${myController.allProjectList[index].pinDestination.toUpperCase()}":
                "${myController.allProjectList[index].title.toUpperCase()}",
                      style: TextStyle(
                          fontFamily: MyFont.Courier_Prime_Bold,
                          fontSize: MyFontSize.size13),
                    ),
                    GestureDetector(
                      onTap: (){

                        ScreenTransition.navigateOff(
                            screenName: VacationProjectFileScreen(projIndex: index));

                        /* ScreenTransition.navigateToScreenLeft(
                            screenName: VacationProjectFileScreen(title:myController.allProjectList[index].title,
                              pinDestination:myController.allProjectList[index].pinDestination,
                              projectMode: myController.allProjectList[index].projectMode,
                              totalKm: myController.allProjectList[index].totalKm,
                              id: myController.allProjectList[index].id,
                            ));*/
                        // if(result == true)
                      },
                      child: Image.asset(
                        MyImageURL.arrow_right,
                        height: Get.height * .040,
                        width: Get.height * .040,
                        fit: BoxFit.fill,
                      ),
                    )
                  ],
                ),
                tileColor: MyColors.expantionTileBgColor.withOpacity(0.32),
                /*tileColor: myController.allProjectList[index].isSelected
                    ? MyColors.tileColor
                    : MyColors.expantionTileBgColor.withOpacity(0.32),*/
              ),
            );
          });
    });
  }

   callDeleteProj(int projId, int index) async{
    ApiManager apiManager = ApiManager();

    apiManager.deleteProjAPI(projId).then((value){
      if(value == true){
        if(myController.selectedProject != null && projId == myController.selectedProject.value.id){
          //myController.selectedProject.value = "";
          myController.selectedProject = null;
        }
        myController.allProjectList.removeAt(index);
      }
    });
  }


}
