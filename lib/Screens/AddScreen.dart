

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Screens/CategoriesScreen.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/state.dart';






import '../../shared/components/components.dart';



class AddScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var imageController = TextEditingController();

  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var c= MainCubit.get(context);

    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {

        if (state is ImageSuccessStates ) {

            if (c.Items.isNotEmpty) {
              c.Items.clear();
              c.getCategory();
              navigateAndFinish(context, const CategoriesScreen());
            }
            else {
              navigateAndFinish(context, const CategoriesScreen());
            }
          }


        ;},
      builder: (context, state) {

        var Image=c.PickedFile;
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

                          SizedBox(
                            height: 10,
                          ),

                      InkWell(
                        onTap: (){
                          c.getImage();
                        },
                        child: Container(
                        width: double.infinity,
                          height: 300,

                          decoration: Image != null ?
                          BoxDecoration(image: DecorationImage(image: FileImage(Image) ))
                              : BoxDecoration(image: DecorationImage(image: NetworkImage(
                              'https://www.leedsandyorkpft.nhs.uk/advice-support/wp-content/uploads/sites/3/2021/06/pngtree-image-upload-icon-photo-upload-icon-png-image_2047546.jpg') ))
                          ,
                    ),
                      ) ,
                          SizedBox(
                            height: 20,
                          ),
                          defaultTextFormField(
                            onTap: (){

                            },
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            prefix: Icons.drive_file_rename_outline,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter name ';
                              }
                              return null;
                            },
                            label: 'בחר שם',
                            hint: 'Enter your name',
                          ),

                          SizedBox(
                            height: 20,
                          ),


                          ConditionalBuilder(
                            condition:state is! ImageintStates ,
                            builder: ( context)=> Center(
                              child: defaultMaterialButton(function: () {
                                if (formKey.currentState!.validate()) {

                                  MainCubit.get(context).uploadImage(name: nameController.text);

                                }}, text: 'הוספה', radius: 20,),
                            ),
                            fallback: (context)=>const Center(child: CircularProgressIndicator(),),)],
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
