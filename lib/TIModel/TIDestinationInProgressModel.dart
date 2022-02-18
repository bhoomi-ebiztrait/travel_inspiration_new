class TIDestinationInProgressModel{
  String name,description,content = "Voir sur la carte",place_id,imgUrl,photo_ref;
  double lat,lng,km,rating;
  int id;

  TIDestinationInProgressModel({
      this.name
    , this.description, this.content, this.place_id,this.imgUrl,this.lat,this.lng,this.km,this.rating,this.photo_ref,this.id});
}