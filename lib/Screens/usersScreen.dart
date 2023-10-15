
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:shop_app/models/UserModel.dart';




import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../../shared/components/components.dart';



class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     int i=0;
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.cyan[400],

          appBar: AppBar(

            iconTheme: IconThemeData(color: Colors.black),
            title: Text("פרטי לקוחות",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),


            systemOverlayStyle: SystemUiOverlayStyle(

              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            backgroundColor: Colors.cyan[400],

          ),
          body: ConditionalBuilder(
            condition: state is! DeleteUserIntiStates,
            builder: (context)=>SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => catList(
                        MainCubit.get(context).AllUsers[index], i,context),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount: MainCubit.get(context).AllUsers.length,
                  ),



                ],
              ),

            ),
            fallback: (context) =>Center(child: CircularProgressIndicator()),

          ),

        );
      },
    );
  }

  Widget catList(UserModel model,int i, context) => InkWell(

    onTap: () {




    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.cyan[100]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(

              " ${model.name!.toString().toUpperCase()}:שם גלריה ",
              style:TextStyle( fontWeight: FontWeight.bold,),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(

              "${model.phone!.toUpperCase()}:מספר הטלפון",
              style:TextStyle( fontWeight: FontWeight.bold,),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            Text(

              "${model.tax_number!}:ע-ם/ ת-ז",
              style:TextStyle( fontWeight: FontWeight.bold,),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(

              "${model.email!}:אימייל",
              style:TextStyle( fontWeight: FontWeight.bold,),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
           Row(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [

               defaultMaterialButton(function: (){

                 i>=3 ?MainCubit.get(context).deleteUsers(model.uId!):i++;




                }, text: "הסר",width: 100,height: 40,color: Colors.red),

             ],
           ),


          ],
        ),
      ),
    ),
  );
}
