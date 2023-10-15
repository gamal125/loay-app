
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Screens/AddScreen.dart';

import 'package:shop_app/Screens/productsScreen.dart';
import 'package:shop_app/Screens/testscreen.dart';
import 'package:shop_app/Screens/usersArchievOrders.dart';
import 'package:shop_app/Screens/usersScreen.dart';

import 'package:shop_app/models/categoriesModel.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../shared/components/components.dart';
import 'addImageScreen.dart';



class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

int i=0;
    var c=MainCubit.get(context);
    c.getAllImages();
  c.token!=null? c.sendtoken(token: c.token!):(){};
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {
        if(state is donegetUsersOrdersSuccessState){
          navigateTo(context, GetUsersScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.cyan),
            title: Text("קטלוג",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              actions: [
                IconButton(onPressed: (){
                  if(c.UsersHasOrder.isNotEmpty){
                      c.UsersHasOrder.clear();
                      c.x();
                      c.getallusersOrder();
                    print(c.usersList.length);

                     }

                  else{

                    c.x();
                    c.getallusersOrder();
                    print(c.usersList.length);



                  }

                }, icon: Icon(Icons.list_rounded,color: Colors.cyan,)),
                IconButton(onPressed: (){navigateTo(context, UsersScreen());}, icon: Icon(Icons.groups_rounded)),
               IconButton(onPressed: (){
               MainCubit.get(context).AllUsers.isNotEmpty?  navigateTo(context, UsersArchievOrdersScreen()):(){};
                 }, icon: Icon(Icons.format_list_numbered))

              ],
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(

                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
              ),
              backgroundColor: Colors.white,
          ),
          body: ConditionalBuilder(
            condition: state is! DeleteCatIntiStates,
            builder: ( context) =>SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Row(
                    children: [
                      Spacer(),
                      IconButton(onPressed: (){
                        navigateTo(context, AddImageScreen());
                      }, icon: Icon(Icons.image,color: Colors.blue,)),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: ConditionalBuilder(
                      builder: (context)=>CarouselSlider(
                        items:c.AllImages
                            .map(
                              (e) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              width: double.infinity,
                              height: 300,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image(
                                  image: NetworkImage(e.image!),
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        )
                            .toList(),
                        options: CarouselOptions(
                          autoPlay: true,
                        ),
                      ), condition:state is! GatImagesIntiStates,
                      fallback: (context) =>
                        Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => catList(
                        MainCubit.get(context).Items[index],i, context),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount: MainCubit.get(context).Items.length,
                  ),
                  Column(

                    children: [
                      defaultMaterialButton(
                          function: () {
                            navigateAndFinish(context, AddScreen());
                          },
                          text: "הוספה"),
                    ],
                  ),


                ],
              ),

            ),
            fallback: ( context) =>Center(child: CircularProgressIndicator()),),

        );
      },
    );
  }

  Widget catList(categoriesModel model,i, context) => InkWell(
    onTap: () {
      if (MainCubit.get(context).ItemsPro.isNotEmpty) {
        MainCubit.get(context).ItemsPro.clear();
        MainCubit.get(context).getProducts(name: model.name!);
        navigateAndFinish(context, ProductsScreen(catname: model.name!));
      }
      else {
        MainCubit.get(context).getProducts(name: model.name!);
        navigateAndFinish(context, ProductsScreen(catname: model.name!));
      }


    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.cyan, width: 2),
              image: DecorationImage(
                image: NetworkImage(
                  model.image!,
                ),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          const Spacer(),
          Text(
            model.name!.toUpperCase(),
            style:TextStyle( fontWeight: FontWeight.bold,),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          IconButton(
            onPressed: () {
              i>=5 ?MainCubit.get(context).deleteCat(model.name!):i++;

            },
            icon: const Icon(
              Icons.arrow_forward_ios,
            ),
          ),
        ],
      ),
    ),
  );
}
