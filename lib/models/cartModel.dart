class CartModel{

  String image;
  String name;
  String cat;
  num amount_orderd;
  num oreiginal_amount;

  num old_amount;
  String price;
  String phone;
  String tax_number;
  String username;
  String? id;








  CartModel({

    required this.image,
    required this.name,
    required this.cat,
    required this.amount_orderd,
    required this.oreiginal_amount,
    required this.price,
    required this.phone,
    required this.tax_number,
    required this.username,

    required  this.old_amount,
    required this.id



  });


  // CartModel.fromjson(Map<String,dynamic>json){
  //
  //   image=json['image'];
  //   name=json['name'];
  //   uId=json['uId'];
  //   amount_orderd=json['amount'];
  //   price=json['price'];
  //   state=json['state'];
  //
  //
  //
  //
  //
  //
  // }
  Map<String,dynamic>Tomap(){
    return{

      'image':image,
      'name':name,
      'cat':cat,
      'amount':amount_orderd,
      'oreiginal_amount':oreiginal_amount,
      'price':price,
      'phone':phone,
      'tax_number':tax_number,
      'username':username,
      'old_amount':old_amount,
      'id':id,






    };
  }
}