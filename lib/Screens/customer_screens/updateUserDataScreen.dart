

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Screens/customer_screens/custmCategoryScreen.dart';
import 'package:shop_app/Screens/login/login_screen.dart';


import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/state.dart';







import '../../../shared/components/components.dart';
import '../../shared/cache_helper.dart';



class updateUserDataScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var tax_numberController = TextEditingController();

  var usernameController = TextEditingController();
  var phoneController = TextEditingController();
  final auth = FirebaseAuth.instance;
// Pick an image.


  updateUserDataScreen({
    required this.tax_number,
    required this.username,
    required this.phone,
    required this.email
});
  String tax_number;
  String username;
  String phone;
  String email;



  @override
  Widget build(BuildContext context) {
    phoneController.text=phone;
    usernameController.text=username;
    tax_numberController.text=tax_number;
    var ud = CacheHelper.getData(key: 'uId');
    MainCubit.get(context).getUser(ud);
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {
        if (state is UpdateuserSuccessStates) {
        MainCubit.get(context).getUser(ud);
            navigateAndFinish(context,  CustomerCategoriesScreen());



        };
        if(state is LogOutSuccessState){
          navigateAndFinish(context, LoginScreen());
        }
      },
      builder: (context, state) {

        return Scaffold(
          backgroundColor: Colors.white,

          appBar: AppBar(
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.cyan),
          ),
          body: GestureDetector(
            onTap: (){
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Container(

              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "עידכון",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),


                          SizedBox(
                            height: 20,
                          ),
                          defaultTextFormField(
                            onTap: (){
                              MainCubit.get(context).emit(UpdateuserLoadingStates());
                            },
                            controller: usernameController,
                            keyboardType: TextInputType.text,
                            prefix: Icons.drive_file_rename_outline,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter username ';
                              }
                              return null;
                            },
                            label: 'שם גלריה',
                            hint: username,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          defaultTextFormField(
                            onTap: (){
                              MainCubit.get(context).emit(UpdateuserLoadingStates());
                            },
                            controller: tax_numberController,
                            keyboardType: TextInputType.number,
                            prefix: Icons.price_change,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter username ';
                              }
                              return null;
                            },
                            label: 'ע-ם/ ת-ז',
                            hint: tax_number,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          defaultTextFormField(
                            onTap: (){
                              MainCubit.get(context).emit(UpdateuserLoadingStates());
                            },
                            controller: phoneController,
                            keyboardType: TextInputType.text,
                            prefix: Icons.phone,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter phone ';
                              }
                              return null;
                            },
                            label: 'מספר הטלפון',
                            hint: phone,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: defaultMaterialButton(

                              function: () {
                                if (formKey.currentState!.validate()) {


                                  MainCubit.get(context).updateuser(
                                      name: usernameController.text,
                                      phone: phoneController.text,
                                      tax_number: tax_numberController.text,
                                      email: email,  ) ;
                                }
                              },
                              text: 'שמור',
                              radius: 20,
                            ),
                          ),
                        const SizedBox(height: 60,),
//                           Center(
//                             child: defaultMaterialButton(
// color: Colors.red,
//                               function: () {
//                                 MainCubit.get(context).getAdimntoken();
//                                 MainCubit.get(context).getAdimntoken();
//                                 String token= MainCubit.get(context).finnaltoken;
//                                 print(token);
//                                 MainCubit.get(context).senddeleteNotification(token);
//                                MainCubit.get(context).userLogout();
//                               },
//                               text: 'הסר חשבון',
//                               radius: 20,
//                             ),
//                           ),
                          Center(
                            child: MaterialButton(onPressed: (){
                              showDialog(
                                  context: context,
                                  builder: (context) =>
                                      AlertDialog(
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        elevation: 24.0,
                                        title: const Center(
                                            child: Text(
                                              'Delete Account',
                                              textAlign: TextAlign.right,
                                            )),
                                        content: const Text(
                                          'Are you sure you want to delete your account?',
                                          style: TextStyle(fontSize: 12),
                                          textAlign: TextAlign.right,
                                        ),
                                        actions: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              TextButton(
                                                  onPressed: () {

                                                    MainCubit.get(context).getAdimntoken();
                                MainCubit.get(context).getAdimntoken();
                                 String token= MainCubit.get(context).finnaltoken;
                                print(token);
                               MainCubit.get(context).senddeleteNotification(token);


                                                    var uId=CacheHelper.getData(key: 'uId');
                                                    MainCubit.get(context).userdata=null;
                                                    navigateTo(context, CustomerCategoriesScreen());
                                                  },
                                                  child: Text('yes')),
                                              TextButton(
                                                  onPressed: () {
Navigator.pop(context);
                                                  },
                                                  child: Text('no')),
                                            ],
                                          ),
                                        ],
                                      ));
                            },color: Colors.red,child: const Text('Delete Account',style: TextStyle(color: Colors.white),),),
                          ),
                          const Center(child: Text('החשבון יימחק אחרי 48 שעות',style: TextStyle(color: Colors.grey,fontSize: 13),)),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
