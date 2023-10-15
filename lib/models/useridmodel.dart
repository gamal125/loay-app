

class UserIdModel{

  String? uId;
  String? name;


  UserIdModel({
    this.name,

    this.uId,



  });

  UserIdModel.fromjson(Map<String,dynamic>json){
    name=json['name'];

    uId=json['uId'];




  }
  Map<String,dynamic> Tomap(){
    return{
      'name':name,

      'uId':uId,




    };
  }


}