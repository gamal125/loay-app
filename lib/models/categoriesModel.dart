class categoriesModel{

  String? image;
  String? name;




  categoriesModel({

    this.image,
    this.name,


  });


  categoriesModel.fromjson(Map<String,dynamic>json){

    image=json['image'];
    name=json['name'];





  }
  Map<String,dynamic>Tomap(){
    return{

      'image':image,
      'name':name,



    };
  }
}