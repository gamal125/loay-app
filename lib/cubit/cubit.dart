import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/cubit/state.dart';
import 'package:shop_app/models/UserModel.dart';
import 'package:shop_app/models/cartModel.dart';
import 'package:shop_app/models/categoriesModel.dart';
import 'package:shop_app/models/productsModel.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shop_app/models/token_model.dart';
import '../models/OrdersModel.dart';
import '../models/images_model.dart';
import '../models/useridmodel.dart';
import '../shared/cache_helper.dart';
class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainInitialStates());
  static MainCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  void ChangeNavBar(int index) {
    currentIndex = index;
    emit(ChangeNavBarItem());
  }
////////////////////////////////////////////////////////////////////////////////////////////////
  void createCorsorImage({
    required String image,
     required String name
  }) {
    imagesModel model = imagesModel(
       image: image,);

    FirebaseFirestore.instance.collection("image").doc(name).set(
        model.Tomap()).then((value) {
      emit(CreateImageSuccessState());
    }).catchError((error) {
      emit(CreateImageErrorStates(error.toString()));
    });
  }
///////////////////////////create Category///////////////////////////////////////////////////////
  void createCategory({
    required String image,
    required String name,}) {
    categoriesModel model = categoriesModel(
      name: name, image: image,);

    FirebaseFirestore.instance.collection("Category").doc(name).set(
        model.Tomap()).then((value) {
      emit(CreateCategorySuccessState());
    }).catchError((error) {
      emit(CreateCategoryErrorStates(error.toString()));
    });
  }
///////////////////////////create product///////////////////////////////////////////////////////
  List<productsModel> ItemsPro = [];
  void createproduct({
    required String image,
    required String name,
    required String cat,
    required num amount,
    required String price,
  }) {
    productsModel model = productsModel(
      name: name,
      image: image,
      catname: cat,
      amount: amount,
      price: price,
    );
    FirebaseFirestore.instance.collection("Category").doc(cat).collection(cat)
        .doc(name).set(model.Tomap())
        .then((value) {
      emit(CreateproductSuccessState());
    }).catchError((error) {
      emit(CreateproductErrorStates(error.toString()));
    });
  }
  ///////////////////add products to cart////////////////////////////
  List<CartModel> cartmodel = [];
  void add_to_cart({
    required String image,
    required String name,
    required String cat,
    required num old_amount,
    required num oreiginal_amount,
    required num amount,
    required String price,
    required bool state,
  }) {
    cartmodel.add(CartModel(
      image: image,
      name: name,
      cat: cat,
      amount_orderd: amount,
      price: price,
      phone: userdata!.phone!,
      tax_number: userdata!.tax_number!,
      username: userdata!.name!,
      old_amount: old_amount,

      id: userdata!.uId!,
      oreiginal_amount: oreiginal_amount,
    ));
  }
///////////////////////////customer create a new order////////////////////////////////////
  void createOrder({
    required String image,
    required String name,
    required String cat,
    required num amount,
    required String price,
    required num old_amonut,
    required num oreiginal_amount,
  }) {
    CartModel model = CartModel(
      name: name,
      image: image,
      price: price,
      cat: cat,
      amount_orderd: amount,
      phone: userdata!.phone!,
      tax_number: userdata!.tax_number!,
      username: userdata!.name!,
      old_amount: old_amonut,
      id: userdata!.uId!,
      oreiginal_amount: oreiginal_amount,
    );
    FirebaseFirestore.instance.collection("users").doc(ud).collection("orders")
        .doc(name).set(model.Tomap())
        .then((value) {
      emit(CreateOrderSuccessState());
    }).catchError((error) {
      emit(CreateOrderErrorStates(error.toString()));
    });
  }
////////////////////////////////get Category///////////////////////////////////////////////////////////
  List<categoriesModel> Items = [];
  void getCategory() {
    FirebaseFirestore.instance.collection('Category').get().then((value) {
      value.docs.forEach((element) {
        Items.add(categoriesModel.fromjson(element.data()));
      });


      emit(GetCategoriesSuccessStates());
    }).catchError((error) {
      emit(GetCategoriesErrorStates(error.toString()));
    });
  }
  ////////////////////get customer data  using app now///////////////////////////////
  var ud = CacheHelper.getData(key: 'uId');
  UserModel? userdata;
  void getUser(uid) {

  uid!=''?  FirebaseFirestore.instance.collection('users').doc(uid.toString())
        .get()
        .then((value) {
      print(value.data());
      userdata = UserModel.fromjson(value.data()!);
      print(userdata!.email!);
    }).catchError((error) {
      emit(GetCategoriesErrorStates(error.toString()));
    }):null;
  }
  /////////////////////////////////////////////////
  File? PickedFile;
  final ImagePicker picker = ImagePicker();
  Future<void> getImage() async {
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      PickedFile = File(imageFile.path);
      emit(UpdateProductImageSuccessStates());
    }
    else {
      var error = 'no Image selected';
      emit(UpdateProductImageErrorStates(error.toString()));
    }
  }
///////////////////////////remove_from_cart///////////////////////////////////
  void remove_from_cart({required CartModel model}) {
    emit(remove_from_cart_loading_stat());

    cartmodel.remove(model);

    emit(remove_from_cart_Success_stat());
  }
//////////////////////////////////////get images fo cursor////////////////////////////////////////////////////////////////
////////////////////////////////get Products///////////////////////////////////////////////////////////
  void getProducts({required String name}) {
    FirebaseFirestore.instance.collection('Category').doc(name)
        .collection(name)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        ItemsPro.add(productsModel.fromjson(element.data()));
      });

      emit(ProductSuccessStates());
    }).catchError((error) {
      emit(ProductErrorStates(error.toString()));
    });
  }
////////////////////////////////get Products old order///////////////////////////////////////////////////////////
  List<OrdersModel> list = [];
  OrdersModel old_ordered_model = OrdersModel(
      image: '',
      name: '',
      cat: '',
      amount_orderd: 0,
      price: '',
      phone: '',
      tax_number: '',
      username: '',
      old_amount: 0,

      id: '',
      oreiginal_amount: null);
  ////////////////////////////////////get Products amount///////////////////////////
  void clearold_amount() {
    old_ordered_model = OrdersModel(
        image: '',
        name: '',
        cat: '',
        amount_orderd: 0,
        oreiginal_amount: 0,
        price: '',
        phone: '',
        tax_number: '',
        username: '',
        old_amount: 0,
        id: '');
  }
  void getamount_Products({required String name}) {
    FirebaseFirestore.instance.collection('users').doc(ud).collection('orders')
        .doc(name).get()
        .then((value) {
      old_ordered_model = OrdersModel.fromjson(value.data()!);
      print(value.data());
      print(old_ordered_model.amount_orderd!);


      emit(getamount_ProductsSuccessStates());
    }).catchError((error) {
      emit(getamount_ProductsErrorStates(error.toString()));
    });
  }
////////////////////////////////updateProduct///////////////////////////////////////////
  void updateProducts({
    required String image,
    required String name,
    required String catnamee,
    required num amount,
    required String price,}) {
    productsModel model = productsModel(
        image: image,
        name: name,
        catname: catnamee,
        amount: amount,
        price: price
    );
    emit(ImageintStates());
    FirebaseFirestore.instance.collection('Category').doc(catnamee).collection(
        catnamee).doc(name).update(model.Tomap()).then((value) {
      emit(UpdateProductSuccessStates());
    }).catchError((error) {
      emit(UpdateProductErrorStates(error.toString()));
    });
  }
////////////////////////////////updateProduct///////////////////////////////////////////
  deleteProducts({
    required String name,
    required String catnamee,}) {
    emit(deleteproductLoadingStates());
    FirebaseFirestore.instance.collection('Category').doc(catnamee).collection(
        catnamee).doc(name).delete().then((value) {
      emit(deleteProductsSuccessStates());
    }).catchError((error) {
      emit(deleteProductsErrorStates(error.toString()));
    });
  }
////////////////////////////////update user///////////////////////////////////////////
  void updateuser({ required String name,
    required String phone,
    required String tax_number,
    required String email,
  }) {
    UserModel model = UserModel(
      name: name,
      phone: phone,
      uId: ud,
      tax_number: tax_number,
      email: email,
    );


    FirebaseFirestore.instance.collection('users').doc(ud)
        .update(model.Tomap())
        .then((value) {
      emit(UpdateuserSuccessStates());
    }).catchError((error) {
      emit(UpdateuserErrorStates(error.toString()));
    });
  }
  String ImageUrl = '';
  //////////////////////////////uploadImage to storage////////////////////////////////////////
  void uploadImage({required String name}) {
    emit(ImageintStates());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri
        .file(PickedFile!.path)
        .pathSegments
        .last}').putFile(PickedFile!).
    then((value) {
      value.ref.getDownloadURL().then((value) {
        ImageUrl = value;
        print(ImageUrl);
        createCategory(image: ImageUrl, name: name);
        PickedFile = null;

        emit(ImageSuccessStates())
        ;
      }).catchError((error) {
        emit(ImageErrorStates(error));
      });
    }).catchError((error) {
      emit(ImageErrorStates(error));
    });
  }
////////////////////////////////////////////////////////////////////////////////////////////////////////
  void uploadCorsorImage({required String name}) {
    emit(ImageintStates());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri
        .file(PickedFile!.path)
        .pathSegments
        .last}').putFile(PickedFile!).
    then((value) {
      value.ref.getDownloadURL().then((value) {
        ImageUrl = value;
        print(ImageUrl);
        createCorsorImage(image: ImageUrl, name: name);
        PickedFile = null;

        emit(ImageSuccessStates())
        ;
      }).catchError((error) {
        emit(ImageErrorStates(error));
      });
    }).catchError((error) {
      emit(ImageErrorStates(error));
    });
  }
////////////////////////////////uploadImage to database as url///////////////////////////////////////////
  void uploadProductImage({
    required String name,
    required String cat,
    required num amount,
    required String price,
  }) {
    emit(ImageintStates());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri
        .file(PickedFile!.path)
        .pathSegments
        .last}').putFile(PickedFile!).
    then((value) {
      value.ref.getDownloadURL().then((value) {
        ImageUrl = value;
        print(ImageUrl);
        createproduct(image: ImageUrl,
            name: name,
            cat: cat,
            amount: amount,
            price: price);
        PickedFile = null;

        emit(ImageSuccessStates())
        ;
      }).catchError((error) {
        emit(ImageErrorStates(error));
      });
    }).catchError((error) {
      emit(ImageErrorStates(error));
    });
  }
  ////////////////////////////////edit_Product_Image to database as url///////////////////////////////////////////
  void editProductImage({
    required String name,
    required String cat,
    required num amount,
    required String price,
  }) {
    emit(ImageintStates());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri
        .file(PickedFile!.path)
        .pathSegments
        .last}').putFile(PickedFile!).
    then((value) {
      value.ref.getDownloadURL().then((value) {
        ImageUrl = value;
        print(ImageUrl);
        updateProducts(image: ImageUrl,
            name: name,
            catnamee: cat,
            amount: amount,
            price: price);
        PickedFile = null;

        emit(ImageSuccessStates())
        ;
      }).catchError((error) {
        emit(ImageErrorStates(error));
      });
    }).catchError((error) {
      emit(ImageErrorStates(error));
    });
  }
  //////////////////////////////////////////////////////////////////////////////////////////////
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void ShowPassword() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShowPasswordStates());
  }
//////////////////////////////////////////////get all user/////////////////////////////////////////////////////////////////
  List<UserModel> AllUsers = [];
  void getUsers() {

    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        AllUsers.add(UserModel.fromjson(element.data()));
      }

      emit(GetUserIdModelSuccessStates());
    }).catchError((error) {
      emit(GetUserIdModelerrorStates(error.toString()));
    });
  }
  List<imagesModel> AllImages = [];
  void getAllImages() {
emit(GatImagesIntiStates());
    FirebaseFirestore.instance.collection('image').get().then((value) {
      for (var element in value.docs) {
        AllImages.add(imagesModel.fromjson(element.data()));
      }
print(AllImages.length);
      emit(GatImagesSuccessStates());
    }).catchError((error) {
      emit(GatImageserrorStates(error.toString()));
    });
  }
  void deleteUsers(String id) {
emit(DeleteUserIntiStates());
    FirebaseFirestore.instance.collection('users').doc(id).delete().then((value) {
      AllUsers.clear();
      getUsers();
      emit(DeleteUserSuccessStates());
    }).catchError((error) {
      emit(GetUserIdModelerrorStates(error.toString()));
    });
  }
  void deleteCat(String name) {
    emit(DeleteCatIntiStates());
    FirebaseFirestore.instance.collection('Category').doc(name).delete().then((value) {
      Items.clear();
      getCategory();
      emit(DeleteCatSuccessStates());
    }).catchError((error) {
      emit(GetUserIdModelerrorStates(error.toString()));
    });
  }
/////////////////////////////////////get users only has order//////////////////////////////
  void x() {
    AllUsers.forEach((element) {
      usersList.add(element.uId!);
    });
    usersList = usersList.toSet().toList();
    print(usersList);
  }
  void getallusersOrder() {
    for (var element in usersList) {
      print(usersList.length);
      getUsersOrders(element);
    }
    usersList.clear();

    emit(donegetUsersOrdersSuccessState());
  }
  ///////////////get user has order details///////////////////
///////////////////////////////////////////////////////////////////////////////////////////
  List<OrdersModel> UsersOrders = [];
  List<UserIdModel> UsersHasOrder = [];
  List<String> userList = [];
  List<String> usersList = [];
////////////////////////////////////for one user///////////////
  getUsersOrders(String id) {
    FirebaseFirestore.instance.collection('users').doc(id)
        .collection('orders')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        UsersOrders.add(OrdersModel.fromjson(element.data()));
      });

      UsersOrders.forEach((element) {
        print(element.username);
        userList.add(element.id!);
        userList = userList.toSet().toList();
      });
      userList.forEach((element) {
        getIdmodel(id: element);
      });
      UsersOrders.clear();
      userList.clear();


      emit(getUsersOrdersSuccessState());
    }

    ).catchError((error) {
      emit(getUsersOrdersErrorStates(error.toString()));
    });
  }
  ///////////////////////////assest/////////////////
  getIdmodel({required String id}) {
    FirebaseFirestore.instance.collection('users').doc(id).get().then((value) {
      UsersHasOrder.add(UserIdModel.fromjson(value.data()!));

      emit(GetUserIdModelSuccessStates());
    }).catchError((error) {
      emit(GetUserIdModelerrorStates(error.toString()));
    });
  }
///////////////////////////////////!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!/////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
  Future<void> sendNotification(String token) async {
    this.token;
    try {
      final body =
      {
        "to": "$token",
        "notification": {
          "title": "${userdata!.name!}",
          "body": "customers have new orders",
          "sound": "defualt"
        },
        "android": {
          "priority": "HIGH",
          "notification":
          {
            "notification_priority": "PRIORITY_MAX",
            "sound": "defualt",
            "default_sound": true,
            "default_vibrate_timings": true,
            "default_light_settings": true
          }
        },
        "data": {
          "type": "XX",
          "id": "IKO",
          "click_action": "FLUTTER_NOTIFICATION_CLICK"
        }
      };

      var response = await post(
          Uri.parse("https://fcm.googleapis.com/fcm/send"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders
                .authorizationHeader: 'key=AAAA_HzXBA4:APA91bG_RdbFdPQCAmiJgkXBu6xFpexl6y2WMzSgOXfAu3S0w0nFRthVBcS0lQ8P4j07bep6-iUSGMnYsQ67KVIhIdB_FIRyG65QRyglCb9O7Fz48CtSzeYe69sy5ZqLRQhxwa4fl3Sv'
          },
          body: jsonEncode(body));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      log(e.toString());
    }
  }
  Future<void> senddeleteNotification(String token) async {
    this.token;
    try {
      final body =
      {
        "to": "$token",
        "notification": {
          "title": "${userdata!.name!}",
          "body": "customers want delete hes account",
          "sound": "defualt"
        },
        "android": {
          "priority": "HIGH",
          "notification":
          {
            "notification_priority": "PRIORITY_MAX",
            "sound": "defualt",
            "default_sound": true,
            "default_vibrate_timings": true,
            "default_light_settings": true
          }
        },
        "data": {
          "type": "XX",
          "id": "IKO",
          "click_action": "FLUTTER_NOTIFICATION_CLICK"
        }
      };

      var response = await post(
          Uri.parse("https://fcm.googleapis.com/fcm/send"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders
                .authorizationHeader: 'key=AAAA_HzXBA4:APA91bG_RdbFdPQCAmiJgkXBu6xFpexl6y2WMzSgOXfAu3S0w0nFRthVBcS0lQ8P4j07bep6-iUSGMnYsQ67KVIhIdB_FIRyG65QRyglCb9O7Fz48CtSzeYe69sy5ZqLRQhxwa4fl3Sv'
          },
          body: jsonEncode(body));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      log(e.toString());
    }
  }
  //////////////////////////////////////////////////////////////////////////////////////
  List<OrdersModel> getCustomerOrders = [];
  void getUsersCustomerOrders({required String Id}) {
    emit(getUsersWaitingOrdersLoadingStates());
    FirebaseFirestore.instance.collection('users').doc(Id)
        .collection('orders')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        getCustomerOrders.add(OrdersModel.fromjson(element.data()));
      });
      print(UsersWaitingOrders.length);

      emit(getUsersWaitingOrdersSuccessState());
    }).catchError((error) {
      emit(getUsersWaitingOrdersErrorStates(error.toString()));
    });
  }
  //////////////////////////get for customer screen/////////////////////////////////////////////////////////////////////
  List<OrdersModel> UsersWaitingOrders = [];
  void getUsersWaitingOrders() {
    FirebaseFirestore.instance.collection('users').doc(ud)
        .collection('orders')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        UsersWaitingOrders.add(OrdersModel.fromjson(element.data()));
      });
      print(UsersWaitingOrders.length);

      emit(getUsersWaitingOrdersSuccessState());
    }).catchError((error) {
      emit(getUsersWaitingOrdersErrorStates(error.toString()));
    });
  }
///////////////////////////////// get for customer screen   /////////////////////////////////////
  List<OrdersModel> Usersold_Orders = [];
  void getUsersOld_Orders() {
    FirebaseFirestore.instance.collection('users').doc(ud).collection(
        'old_orders').get().then((value) {
      value.docs.forEach((element) {
        Usersold_Orders.add(OrdersModel.fromjson(element.data()));
      });


      emit(getUsersWaitingOrdersSuccessState());
    }).catchError((error) {
      emit(getUsersWaitingOrdersErrorStates(error.toString()));
    });
  }
  void getUsersOld_Orders2(String id) {
    FirebaseFirestore.instance.collection('users').doc(id).collection(
        'old_orders').get().then((value) {
      value.docs.forEach((element) {
        Usersold_Orders.add(OrdersModel.fromjson(element.data()));
      });


      emit(getUsersWaitingOrdersSuccessState());
    }).catchError((error) {
      emit(getUsersWaitingOrdersErrorStates(error.toString()));
    });
  }

//////////////////////////////////////////////////////////////////////////
  void UpdateOrder({
    required String image,
    required String name,
    required String cat,
    required num amount,
    required String price,
    required num old_amonut,
    required bool state,
    required String phone,
    required String username,
    required String tax_number,
    required String Id,
    required num oreiginal_amount,
  }) {
    OrdersModel model = OrdersModel(
      name: name,
      image: image,
      price: price,
      cat: cat,
      amount_orderd: amount,
      phone: phone,
      tax_number: tax_number,
      username: username,
      old_amount: old_amonut,
      id: Id,
      oreiginal_amount: oreiginal_amount,


    );
    emit(updateCreateOrderLoadingStates());
    FirebaseFirestore.instance.collection("users").doc(Id).collection(
        "old_orders").doc(name).set(model.Tomap()).then((value) {
      emit(updateOrderSuccessState());
    }).catchError((error) {
      emit(updateOrderErrorStates(error.toString()));
    });
    FirebaseFirestore.instance.collection("users").doc(Id).collection("orders")
        .doc(name).delete()
        .then((value) {
      emit(updateOrderSuccessState());
    }).catchError((error) {
      emit(updateOrderErrorStates(error.toString()));
    });
  }
  String? token;
  String finnaltoken="";
  tokenModel? geted_Admin_token;

   setAdmintoken()async{
    token= await FirebaseMessaging.instance.getToken();

    print(token);

  }


void getAdimntoken()async{
   //fyHg6PxCSwWj-eTjR6teuH:APA91bHYz3YvyWYUACt235ZU3Crf7RR_Oel0rHzuRCMJ2Q2-Dt1dMZsS4BuU-9d7jw6K3V8b4quZoi4QdmwgxDc-zHhs4FXO8HcmEysdsZSz7KyzzGZP_avojHdEIY-OAfXsGJM-ElBx
  await FirebaseFirestore.instance.collection("token").doc("token").get().then((value) {
        geted_Admin_token=tokenModel.fromjson(value.data()!);
        finnaltoken= geted_Admin_token!.token!;

  }).catchError((error) {
  });
}
  void sendtoken({
    required String token,


  }) {
    tokenModel model=tokenModel(
        token: token


    );

    FirebaseFirestore.instance.collection("token").doc("token").set(model.Tomap()).then((value) {

    }).catchError((error) {
    });
  }
  Future<void> userLogout() async {
    emit(LogOutLoadingState());
    await  FirebaseAuth.instance.signOut() .then((value) {

      emit(LogOutSuccessState());
    }).catchError((error) {
      emit(LogOutErrorState(error.toString()));
    });
  }
}







