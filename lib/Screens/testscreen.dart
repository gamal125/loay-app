import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Screens/CategoriesScreen.dart';
import 'package:shop_app/models/OrdersModel.dart';
import 'package:shop_app/models/useridmodel.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../shared/components/components.dart';
import 'allOrdersScreen.dart';



class GetUsersScreen extends StatelessWidget {
  const GetUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.cyan),
            title: Text("הזנמות",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            leading: IconButton(icon: Icon(Icons.arrow_back_sharp),onPressed: (){


                navigateAndFinish(context, const CategoriesScreen());


            },),
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(

              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            backgroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => catList(
                      MainCubit.get(context).UsersHasOrder[index], context),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: MainCubit.get(context).UsersHasOrder.length,
                ),



              ],
            ),

          ),

        );
      },
    );
  }

  Widget catList(UserIdModel model, context) => InkWell(
    onTap: () {


      if (MainCubit.get(context).getCustomerOrders.isNotEmpty) {
       MainCubit.get(context).getCustomerOrders.clear();
        MainCubit.get(context).getUsersCustomerOrders(Id: model.uId!);
        navigateTo(context, AllOrdersScreen(model.uId!));
      }
      else {
        MainCubit.get(context).getUsersCustomerOrders(Id: model.uId!);
        navigateTo(context, AllOrdersScreen(model.uId!));
      }

    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [

          Text(
            model.name!.toString(),
            style:const TextStyle( fontWeight: FontWeight.bold,color: Colors.cyan),
            maxLines: 1,
            overflow: TextOverflow.ellipsis, ),


          const Spacer(),
          const Text('has new order',style: TextStyle(color: Colors.grey),),
          SizedBox(width: 5),
          const Icon(Icons.looks_one_rounded,color: Colors.red,),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_forward_ios,color: Colors.cyan,
            ),
          ),
        ],
      ),
    ),
  );
}
