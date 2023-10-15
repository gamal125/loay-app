
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:shop_app/models/UserModel.dart';




import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../../shared/components/components.dart';
import 'customer_screens/myarchiveorders.dart';



class UsersArchievOrdersScreen extends StatelessWidget {
  const UsersArchievOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          body:SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => catList(
                        MainCubit.get(context).AllUsers[index], context),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount: MainCubit.get(context).AllUsers.length,
                  ),



                ],
              ),

            ),




        );
      },
    );
  }

  Widget catList(UserModel model, context) => InkWell(
    onTap: () {
      if (MainCubit.get(context).Usersold_Orders.isNotEmpty) {
        MainCubit.get(context).Usersold_Orders.clear();

        MainCubit.get(context).getUsersOld_Orders2(model.uId!);

        navigateTo(context, MyArchiveOrdersScreen(title: 'הזמנות שמורים',));
      }

      else{
        MainCubit.get(context).getUsersOld_Orders2(model.uId!);


        navigateTo(context, MyArchiveOrdersScreen(title: 'הזמנות שמורים',));}




    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [

          Text(
            model.name!.toString(),
            style:const TextStyle( fontWeight: FontWeight.bold,color: Colors.black),
            maxLines: 1,
            overflow: TextOverflow.ellipsis, ),


          const Spacer(),
          const Text('old user order',style: TextStyle(color: Colors.black54),),
          SizedBox(width: 5),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_forward_ios,color: Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}
