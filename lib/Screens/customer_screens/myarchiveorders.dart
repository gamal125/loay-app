
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:shop_app/models/OrdersModel.dart';




import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../../shared/components/components.dart';



class MyArchiveOrdersScreen extends StatelessWidget {
  const MyArchiveOrdersScreen({Key? key,required this.title}) : super(key: key);
final String title;
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.cyan[400],
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(title,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            actions: [

            ],

            systemOverlayStyle: SystemUiOverlayStyle(

              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            backgroundColor: Colors.cyan[400],
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                  catList(MainCubit.get(context).Usersold_Orders[index], context),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: MainCubit.get(context).Usersold_Orders.length,
                ),



              ],
            ),

          ),

        );
      },
    );
  }

  Widget catList(OrdersModel model, context) => InkWell(
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
          Row(
            children: [
              Text(

                "${model.amount_orderd!.toString().toUpperCase()} ",
                style:TextStyle( fontWeight: FontWeight.bold,),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                ": כמות",
                style:TextStyle( fontWeight: FontWeight.bold,),
                textDirection: TextDirection.ltr,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(

                "${model.price!.toString().toUpperCase()}₪ ",
                style:TextStyle( fontWeight: FontWeight.bold,),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(

                ": מחיר",
                style:TextStyle( fontWeight: FontWeight.bold,),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

            ],
          ),
          Text("________________")
        ],
      ),

      ],
  ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(

              "${model.amount_orderd!*int.parse(model.price!)}₪",
              style:TextStyle( fontWeight: FontWeight.bold,),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(

              ": סה׳׳כ לתשלום",
              style:TextStyle( fontWeight: FontWeight.bold,),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

          ],
        ),
  Text(

    " דגם:${model.name!}",
  style:TextStyle( fontWeight: FontWeight.bold,),
  maxLines: 1,
  textDirection: TextDirection.rtl,
  overflow: TextOverflow.ellipsis,
  ),
  Text(

  "מצב הזמנה :נשלח",
  style:TextStyle( fontWeight: FontWeight.bold,),
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
  ),
  ],
  ),
    ),
    ),
  );
}
