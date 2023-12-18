import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Routes/all_pages.dart';
import 'Routes/routes.dart';
import 'Routes/screen_bindings.dart';

void main() async{



  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  try{
    String? token = await FirebaseMessaging.instance.getToken();
    print("--device---------token:-----${token}");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('deviceToken',token.toString() );

  } on FirebaseException{
    print('__________FirebaseException_____________');
  }
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,

  );
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,

  ]);
  ErrorWidget.builder = (
      
      FlutterErrorDetails details) =>const Scaffold(
    body:Center(child:  CircularProgressIndicator()),
  );
  runApp(const MyApp());

  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: splashScreen,
      getPages: AllPages.getPages(),
      initialBinding: ScreenBindings(),
      title: 'Book N Play',
      theme: getLightTheme(),
      darkTheme: getLightTheme(),
    );
  }
  ThemeData getLightTheme() {
    // TODO change font dynamically
    return ThemeData(
        primaryColor: Colors.white,
        floatingActionButtonTheme:const FloatingActionButtonThemeData(
            elevation: 0, foregroundColor: Colors.white),
        brightness: Brightness.light,


        scrollbarTheme: ScrollbarThemeData(
            thumbVisibility: MaterialStateProperty.all(true),
            thickness: MaterialStateProperty.all(2),
            thumbColor: MaterialStateProperty.all<Color>(Colors.black54)),



        primaryTextTheme: GoogleFonts.poppinsTextTheme(
          //'Montserrat',
          const TextTheme(
            headlineLarge: TextStyle(),
            labelMedium: TextStyle(),
            headlineMedium: TextStyle(),
            headlineSmall: TextStyle(),
            titleSmall: TextStyle(),
            titleLarge: TextStyle(),
            bodyLarge: TextStyle(),
            bodyMedium: TextStyle(),
            bodySmall: TextStyle(),
            titleMedium: TextStyle(),
            labelLarge: TextStyle(),
            labelSmall: TextStyle(),
            displayLarge: TextStyle(),
            displayMedium: TextStyle(),
            displaySmall: TextStyle(),
          ),
          /*TextTheme(
          titleMedium: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: Ui.parseColor(MyColorName.colorTextPrimary),
              height: 1.0),
          titleLarge: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: Ui.parseColor(MyColorName.colorTextPrimary),
              height: 1.0),
          titleSmall: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              color: Ui.parseColor(MyColorName.colorTextPrimary),
              height: 1.0),
          titleLarge: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: Ui.parseColor(MyColorName.colorTextPrimary),
              height: 1.0),
          bodyLarge: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w500,
              color: Ui.parseColor(MyColorName.colorTextPrimary),
              height: 1.0),
          bodyMedium: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w300,
              color: Ui.parseColor(MyColorName.colorTextPrimary),
              height: 1.0),
          bodySmall: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: Ui.parseColor(MyColorName.colorTextPrimary),
              height: 1.0),
          titleMedium: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w400,
              color: Ui.parseColor(MyColorName.colorTextPrimary),
              height: 1.0),
          labelLarge: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
              color: Ui.parseColor(MyColorName.colorTextPrimary),
              height: 1.0),
          labelSmall: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: Ui.parseColor(MyColorName.colorTextPrimary),
              height: 1.0),
          displayLarge: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w300,
              color: Ui.parseColor(MyColorName.colorTextPrimary),
              height: 1.0),
        ),*/
        ),
        textTheme: GoogleFonts.openSansTextTheme(
          const TextTheme(
            headlineLarge: TextStyle(),
            labelMedium: TextStyle(),
            headlineMedium: TextStyle(),
            headlineSmall: TextStyle(),
            titleSmall: TextStyle(),
            titleLarge: TextStyle(),
            bodyLarge: TextStyle(),
            bodyMedium: TextStyle(),
            bodySmall: TextStyle(),
            titleMedium: TextStyle(),
            labelLarge: TextStyle(),
            labelSmall: TextStyle(),
            displayLarge: TextStyle(),
            displayMedium: TextStyle(),
            displaySmall: TextStyle(),
          ),
          /*TextTheme(
          titleMedium: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: Ui.parseColor(MyColorName.colorTextPrimary),
              height: 1.0),
          titleLarge: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: Ui.parseColor(MyColorName.colorTextPrimary),
              height: 1.0),
          titleSmall: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Ui.parseColor(MyColorName.colorTextPrimary),
              height: 1.3),
          titleLarge: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: Ui.parseColor(MyColorName.colorTextPrimary),
              height: 1.0),
          bodyLarge: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Ui.parseColor(MyColorName.colorTextPrimary),
              height: 1.0),
          bodyMedium: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: Ui.parseColor(MyColorName.colorTextPrimary),
              height: 1.0),
          bodySmall: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: Ui.parseColor(MyColorName.colorTextPrimary),
              height: 1.0),
          titleMedium: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w400,
              color: Ui.parseColor(MyColorName.colorTextPrimary),
              height: 1.0),
          labelLarge: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
              color: Ui.parseColor(MyColorName.colorTextPrimary),
              height: 1.2),
          labelSmall: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: Ui.parseColor(MyColorName.colorTextPrimary),
              height: 1.0),
          displayLarge: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
              color: Ui.parseColor(MyColorName.colorTextPrimary),
              height: 1.0),
          displayMedium: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w600,
            color: Ui.parseColor(MyColorName.colorTextPrimary),
          ),
          displaySmall: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            color: Ui.parseColor(MyColorName.colorTextPrimary),
          ),
        ),*/
        ));
  }
}