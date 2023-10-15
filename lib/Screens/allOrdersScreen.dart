
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Screens/testscreen.dart';


import 'package:shop_app/models/OrdersModel.dart';




import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../shared/components/components.dart';



class AllOrdersScreen extends StatelessWidget {
   AllOrdersScreen(this.id );
 String id;

  @override
  Widget build(BuildContext context) {
    var c=MainCubit.get(context);
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {
        if (state is getUsersWaitingOrdersSuccessState) {




          // if (MainCubit.get(context).UsersWaitingOrders.isNotEmpty) {
          //   MainCubit.get(context).UsersWaitingOrders.clear();
          //     MainCubit.get(context).getUsersWaitingOrders();
          //
          // }
          // else {
          //
          //     MainCubit.get(context).getUsersWaitingOrders();
          //
          //
          // }


        };

      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.cyan[400],

          appBar: AppBar(

            iconTheme: IconThemeData(color: Colors.black),
            title: Text("חזור",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                leading:  IconButton(onPressed: (){
                  if(c.UsersHasOrder.length==0){
                    c.AllUsers.forEach((element) {
                      c.getUsersOrders(element.uId!);});
                    navigateTo(context, GetUsersScreen());
                  }else{
                    c.UsersHasOrder.clear();
                    c.AllUsers.forEach((element) {
                      c.getUsersOrders(element.uId!);});
                    navigateTo(context, GetUsersScreen());

                  }

                }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
            actions: [

            ],
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(

              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            backgroundColor: Colors.cyan[400],
          ),
          body: ConditionalBuilder(
            condition: state is! getUsersWaitingOrdersLoadingStates,
            builder:(context)=> SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => catList(
                        MainCubit.get(context).getCustomerOrders[index], context),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount: MainCubit.get(context).getCustomerOrders.length,
                  ),



                ],
              ),

            ), fallback: (context) =>Center(child: CircularProgressIndicator()),
          ),

        );
      },
    );
  }

  Widget catList(OrdersModel model , context) => InkWell(
    onTap: () {




    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
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
            Row(
              children: [
                Container(
                  width: 120.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.white,
                    image: DecorationImage(
                      image: NetworkImage(
                        model.image!,
                      ),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(

                      "כמות      : ${model.amount_orderd!.toString().toUpperCase()}",
                      style:TextStyle( fontWeight: FontWeight.bold,),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(

                      "מחיר    : ${model.price!.toUpperCase()}₪",
                      style:TextStyle( fontWeight: FontWeight.bold,),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(

                      " : סה׳׳כ לתשלום  ${model.amount_orderd!*int.parse(model.price!)}₪",
                      style:TextStyle( fontWeight: FontWeight.bold,),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),

              ],
            ),
            Text(

              "דגם    : ${model.name!.toUpperCase()}",
              style:TextStyle( fontWeight: FontWeight.bold,),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Text(

                  " ${model.username!.toUpperCase()} :    ",
                  style:TextStyle( fontWeight: FontWeight.bold,),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(

                  "גלריה ",
                  style:TextStyle( fontWeight: FontWeight.bold,),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Text(

              "ע-ם/ ת-ז : ${model.tax_number!.toUpperCase()}",
              style:TextStyle( fontWeight: FontWeight.bold,),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(

              "מספר הטלפון      : ${model.phone!.toUpperCase()}",
              style:TextStyle( fontWeight: FontWeight.bold,),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: defaultMaterialButton(function: (){


      MainCubit.get(context).UpdateOrder(
                              image: model.image!,
                              name: model.name!,
                        cat: model.cat!,
                        amount: model.amount_orderd!,
                        price: model.price!,
                        old_amonut: model.old_amount!,
                        state: true,
                        phone: model.phone!,
                        username: model.username!,
                        tax_number: model.tax_number!, Id:id, oreiginal_amount: model.oreiginal_amount! );

      if (MainCubit.get(context).getCustomerOrders.isNotEmpty) {
        MainCubit.get(context).getCustomerOrders.clear();
        MainCubit.get(context).getUsersCustomerOrders(Id: id);

      }
      else {
        MainCubit.get(context).getUsersCustomerOrders(Id: id);

      }



                  }, text: "אישור",width: 100,height: 40,color: Colors.green),
                ),
                Spacer(),

              ],
            ),
          ],
        ),
      ),
    ),
  );
}
