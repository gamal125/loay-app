

class tokenModel{


  String? token;


  tokenModel({
    this.token,





  });

  tokenModel.fromjson(Map<String,dynamic>json){
    token=json['token'];






  }
  Map<String,dynamic> Tomap(){
    return{
      'token':token,





    };
  }


}