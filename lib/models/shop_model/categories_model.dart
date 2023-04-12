class CategoriesModel{
  late bool ?status;
  late CategoriesData ?data;
  CategoriesModel({this.status,this.data});
  CategoriesModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    if(json['data']!=null){
      data = CategoriesData.fromJson(json['data']);
    }
  }
}
class CategoriesData{
  late int currentPage;
  List<DataModel>data=[];
  CategoriesData.fromJson(Map<String,dynamic>json){
    currentPage=json['current_page'];
    json['data'].forEach((element){
      data.add(DataModel.fromJson(element)) ;
    });
  }
}
class DataModel{
  late int id;
  late String name;
  late String image;
  DataModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}