

class imagesModel{


  String? image;


  imagesModel({
    this.image,





  });

  imagesModel.fromjson(Map<String,dynamic>json){
    image=json['image'];






  }
  Map<String,dynamic> Tomap(){
    return{
      'image':image,





    };
  }


}