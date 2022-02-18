import 'package:travel_inspiration/APICallServices/ApiParameter.dart';

class FaqListTitleModel {
  String title, image;
  int titleId;
  FaqListTitleModel(this.titleId, this.title, this.image);

  FaqListTitleModel.fromMap(Map map) {
    titleId = map[ApiParameter.titleId];
    title = map[ApiParameter.title].toString();
    image = map[ApiParameter.image].toString();
  }
}
