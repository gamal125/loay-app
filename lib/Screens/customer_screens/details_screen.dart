import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class details extends StatelessWidget {
  const details({Key? key, required this.amount,required this.image,required this.name,required this.price}) : super(key: key);
  final image;
  final name;
  final price;
  final amount;


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(elevation: 0,
      iconTheme: IconThemeData(color: Colors.cyan),
      backgroundColor: Colors.white,),
      body: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.end,children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(width: double.infinity,height: 400,
            decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(image),fit: BoxFit.cover),borderRadius: BorderRadius.circular(20)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
              Text(
                name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,     style: TextStyle(
                fontSize: 30,
                color: Colors.black,
              ),
              ),
              Text(
                '${price!}   ₪',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.red,
                ),
              ),
              Text(
                '${amount.toString()} PcS',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.red,
                ),
              ),
            ],),
          ),


        ],),
      ),
    );
  }
}
