

class UserModel{
   String? email;
   String? uId;
   String? name;
   String? phone;
   String? tax_number;

   UserModel({
     this.name,
     this.phone,
     this.uId,
     this.tax_number,
     this.email,


});

   UserModel.fromjson(Map<String,dynamic>json){
     name=json['name'];
     phone=json['phone'];
     tax_number=json['tax_number'];
     email=json['email'];
     uId=json['uId'];




   }
   Map<String,dynamic> Tomap(){
     return{
       'name':name,
       'phone':phone,
       'tax_number':tax_number,
       'email':email,
       'uId':uId,




     };
   }


}