
import 'package:app_doc_sach/color/mycolor.dart';
import 'package:app_doc_sach/page/slash_screen/slash_screen.dart';
import 'package:app_doc_sach/provider/ui_provider.dart';
import 'package:app_doc_sach/state/tab_state.dart';
import 'package:app_doc_sach/view/dashboard/dashboard_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'provider/tab_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb){
    Firebase.initializeApp(options: const FirebaseOptions(apiKey: "AIzaSyA4kf3WYLv6NKE7GIiGqBUVVilKMXVmntw",
        authDomain: "appdocsach-77e59.firebaseapp.com",
        projectId: "appdocsach-77e59",
        storageBucket: "appdocsach-77e59.appspot.com",
        messagingSenderId: "119520931791",
        appId: "1:119520931791:web:8ef3e0fb27b03c91c9ecba",
        measurementId: "G-WPMB69QYKQ"));

  }
  else {
   await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBnFNsGdqWj__OIIbRZUSjRQvyQMO0krd0",
      appId: "1:119520931791:android:c38a905e1d751c99c9ecba",
      messagingSenderId: "119520931791",
      projectId: "appdocsach-77e59",),
  );
 /* FirebaseDatabase.instance.databaseURL = "https://appdocsach-77e59-default-rtdb.firebaseio.com/";*/
  }

 /* final Future<FirebaseApp> _fApp = Firebase.initializeApp();*/
  /*FirebaseDatabase.instance.databaseURL = "https://appdocsach-77e59-default-rtdb.firebaseio.com/";*/
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TabState())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => UiProvider()..init(),
      child: Consumer <UiProvider>(
          builder: (context,UiProvider notifier, child) {
            if(notifier.isDark){
              SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Colors.transparent,
              );
            }
            else{
              SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark,
              );
            }
            return  MaterialApp(
              debugShowCheckedModeBanner: false,
              home: const SlashScreen(),
              themeMode: notifier.isDark ? ThemeMode.dark : ThemeMode.light,
              darkTheme: notifier.isDark ? notifier.darkTheme : notifier.lightTheme,
              theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: MyColor.primaryColor),
                  useMaterial3: true
              ),
            );
          }
      ),
    );
  }
}
