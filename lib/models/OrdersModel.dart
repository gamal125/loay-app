class OrdersModel{

  String? image;
  String? name;
  String? cat;
  num? amount_orderd;
  num? oreiginal_amount;
  num? old_amount;
  String? price;
  String? phone;
  String? tax_number;
  String? username;
  String? id;
  OrdersModel({

    required this.image,
    required this.name,
    required this.cat,
    required this.amount_orderd,
    required this.oreiginal_amount,
    required this.price,
    required this.phone,
    required this.tax_number,
    required this.username,
    required this.old_amount,
    required this.id




  });


  OrdersModel.fromjson(Map<String,dynamic>json){


    name=json['name'];
    cat=json['cat'];
    old_amount=json['old_amount'];
    oreiginal_amount=json['oreiginal_amount'];

    price=json['price'];
    image=json['image'];
    username=json['username'];
    amount_orderd=json['amount'];
    phone=json['phone'];

    tax_number=json['tax_number'];
    id=json['id'];







  }
  Map<String,dynamic>Tomap(){
    return{


      'image':image,
      'name':name,
      'cat':cat,
      'amount':amount_orderd,
      'price':price,
      'phone':phone,
      'tax_number':tax_number,
      'username':username,
      'old_amount':old_amount,
      'oreiginal_amount':oreiginal_amount,
      'id':id,







    };
  }
}