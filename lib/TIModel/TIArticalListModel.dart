import 'package:travel_inspiration/APICallServices/ApiParameter.dart';

class TIArticalListModel{
  String  id,title,detail,image;

  TIArticalListModel.fromMap(Map map){
    id=map[ApiParameter.id].toString();
    title=map[ApiParameter.title].toString();
    detail=map[ApiParameter.detail].toString();
    image=map[ApiParameter.image].toString();
  }  
}