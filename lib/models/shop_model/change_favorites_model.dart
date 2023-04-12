class ChangeFavoritesModel{
  late bool? status;
  late String? message;
  ChangeFavoritesModel({this.status,this.message});
  ChangeFavoritesModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
  }
}