
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Screens/CategoriesScreen.dart';
import 'package:shop_app/Screens/customer_screens/custmCategoryScreen.dart';
import 'package:shop_app/Screens/login/cubit/cubit.dart';
import 'package:shop_app/Screens/register/cubit/cubit.dart';

import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/cache_helper.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

}


void main() async {
  Widget widget;
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //     AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);

  await CacheHelper.init();
  await Firebase.initializeApp();
  ///////////to make notification////////////////


  print("token below this line");
  var token= await FirebaseMessaging.instance.getToken();
  print(token);
  FirebaseMessaging.onMessage.listen((event) {
print(event.data.toString());
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });
  ///////////////////////////////////////////////////////
  var uId=CacheHelper.getData(key: 'uId');


  if(uId != null){

    if(uId =="gZ4kalQLDlWHHikMTsY904jHRFu1"){
      widget= SplashScreenView(
              duration: 3000,
              pageRouteTransition: PageRouteTransition.SlideTransition,
              navigateRoute: CategoriesScreen(),
              text: ' Welcome mr/Loay',
              textType: TextType.ColorizeAnimationText,
              textStyle:  TextStyle(     fontSize: 40,
                fontWeight: FontWeight.w700,) ,


          );

    }
    else{

      widget= SplashScreenView(
          duration: 3000,
          pageRouteTransition: PageRouteTransition.SlideTransition,
          navigateRoute: CustomerCategoriesScreen(),
          text: ' Welcome Dear',
          textType: TextType.ColorizeAnimationText,
          textStyle: TextStyle(     fontSize: 40,
            fontWeight: FontWeight.w700,) ,

          backgroundColor:  Colors.white
      );


    }
  }
  else{


    widget=SplashScreenView(
        duration: 3000,
        pageRouteTransition: PageRouteTransition.SlideTransition,
        navigateRoute: CustomerCategoriesScreen(),
        text: ' welcome  ',
        textType: TextType.ColorizeAnimationText,
        textStyle: TextStyle(     fontSize: 40,
          fontWeight: FontWeight.w700,) ,

        backgroundColor:  Colors.white
    );




  }
  runApp(


       MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {

   MyApp({ required this.startWidget});
   Widget startWidget;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var uId=CacheHelper.getData(key: 'uId');





    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
        BlocProvider<MainCubit>(
          create: (context) => MainCubit()..getCategory()..setAdmintoken()..getAllImages()..getUsers()..getAdimntoken()..getUser(uId),
        ),
        BlocProvider<RegisterCubit>(
          create: (context) => RegisterCubit(),
        ),
      ],
      child:MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      theme: ThemeData(


        primarySwatch: Colors.blue,),
      home:  startWidget,
    ));
  }
}


