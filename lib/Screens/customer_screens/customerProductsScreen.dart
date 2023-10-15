
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Screens/customer_screens/CartScreen.dart';
import 'package:shop_app/Screens/customer_screens/details_screen.dart';
import 'package:shop_app/Screens/login/login_screen.dart';



import '../../cubit/cubit.dart';
import '../../cubit/state.dart';

import '../../models/productsModel.dart';
import '../../shared/components/components.dart';
import 'custmCategoryScreen.dart';





class CustomerProductsScreen extends StatefulWidget {
  CustomerProductsScreen({required this.catname});
  String catname;

  @override
  State<CustomerProductsScreen> createState() => _CustomerProductsScreenState();
}

class _CustomerProductsScreenState extends State<CustomerProductsScreen> {
  var amountController = TextEditingController();

  @override
  Widget build(BuildContext context,) {

    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              navigateAndFinish(context, CustomerCategoriesScreen());
            }, icon: Icon(Icons.arrow_back_ios)),
            title: Text("דף הבית",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(

              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.cyan),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1 / 1.5,
                  children: List.generate(

                    MainCubit.get(context).ItemsPro.length,(index) => GridProducts(MainCubit.get(context).ItemsPro[index], context,TextEditingController()),
                  ),
                ),

              ],
            ),
          ),



          floatingActionButton: FloatingActionButton(
            onPressed: (){
                navigateTo(context, CartScreen());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add_shopping_cart_outlined),
          ),

        );
      },
    );
  }

  Widget GridProducts(productsModel model, context,TextEditingController text) => InkWell(
    onTap: () {

 navigateTo(context, details(amount: model.amount, image: model.image, name: model.name, price: model.price));
    },
    child: Stack(
      children: [

        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.none,
          elevation: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Image(
                  image: NetworkImage(
                    model.image!,
                  ),
                  width: double.infinity,
                  height: 100.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text(
                          '${model.price!}₪',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),


                            Spacer(),
                        SizedBox( // <-- SEE HERE
                          width: 70,
                          height: 35,
                          child: TextFormField(

                            decoration: InputDecoration(

                              border: OutlineInputBorder(),
                              hintText:"0",
                            ),
                            controller: text,
                            textAlignVertical: TextAlignVertical.bottom,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 14),



                          ),
                        ),

                      ],
                    ),
                          SizedBox(
                            height: 10,
                          ),
                    defaultMaterialButton(

                      function: () {
                        if(MainCubit.get(context).userdata!=null) {
                          MainCubit.get(context).clearold_amount();
                          MainCubit.get(context).getamount_Products(name: model.name!);
                          num? x;
                          MainCubit.get(context).old_ordered_model.amount_orderd == 0 ? x = 0 : x = MainCubit
                              .get(context)
                              .old_ordered_model
                              .amount_orderd!;


                          if (text.text.isNotEmpty && text.text != "0") {
                            num v = int.parse(text.text);
                            if (v <= model.amount!) {
                              MainCubit.get(context).add_to_cart(
                                  image: model.image!,
                                  name: model.name!,

                                  cat: widget.catname,
                                  amount: v,
                                  price: model.price!,
                                  old_amount: x,
                                  state: false,
                                  oreiginal_amount: model.amount!)
                              ;


                              setState(() {
                                model.amount =
                                    model.amount! - int.parse(text.text);
                                text.text = "0";
                              });
                            }
                            else {
                              print("more than value");
                            }
                          }
                          else {
                            print("cancelled");
                          }
                        }
                        else{
                          navigateTo(context, LoginScreen());
                        }

                      }
                      ,
                      text: 'הוספה לעגלה',
                      radius: 20,
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),


        Positioned.fill(
          child: Align(
            alignment: Alignment(1, -1),
            child: ClipRect(
              child: Banner(
                message: '${model.amount!}\ PcS',
                textStyle: const TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  letterSpacing: 0.5,
                ),
                location: BannerLocation.topStart,
                color: Colors.green,
                child: Container(
                  height: 100.0,
                ),
              ),
            ),
          ),
        ),

      ],
    ),
  );
}
