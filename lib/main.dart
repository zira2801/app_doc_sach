
import 'package:app_doc_sach/color/mycolor.dart';
import 'package:app_doc_sach/controller/controller.dart';
import 'package:app_doc_sach/model/user_model.dart';
import 'package:app_doc_sach/page/page_admin/dashboard_admin.dart';
import 'package:app_doc_sach/page/slash_screen/slash_screen.dart';
import 'package:app_doc_sach/provider/ui_provider.dart';
import 'package:app_doc_sach/route/app_page.dart';
import 'package:app_doc_sach/route/app_route.dart';
import 'package:app_doc_sach/state/tab_state.dart';
import 'package:app_doc_sach/view/dashboard/dashboard_screen.dart';
import 'package:app_doc_sach/widgets/dashboard_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'provider/tab_provider.dart';
import 'service/local_service/local_auth_service.dart';
import 'view/dashboard/dashboard_binding.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb){
   await Firebase.initializeApp(options: const FirebaseOptions(apiKey: "AIzaSyBnFNsGdqWj__OIIbRZUSjRQvyQMO0krd0",
        authDomain: "appdocsach-77e59.firebaseapp.com",
        projectId: "appdocsach-77e59",
        storageBucket: "appdocsach-77e59.appspot.com",
        messagingSenderId: "119520931791",
        appId: "1:119520931791:android:c38a905e1d751c99c9ecba",
        measurementId: "G-WPMB69QYKQ"));
    FirebaseDatabase.instance.databaseURL = "https://appdocsach-77e59-default-rtdb.firebaseio.com/";

  }
  else {
   await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBnFNsGdqWj__OIIbRZUSjRQvyQMO0krd0",
      appId: "1:119520931791:android:c38a905e1d751c99c9ecba",
      messagingSenderId: "119520931791",
      projectId: "appdocsach-77e59",),

  );
   FirebaseDatabase.instance.databaseURL = "https://appdocsach-77e59-default-rtdb.firebaseio.com/";
  }

 /* final Future<FirebaseApp> _fApp = Firebase.initializeApp(); */
  /*FirebaseDatabase.instance.databaseURL = "https://appdocsach-77e59-default-rtdb.firebaseio.com/";*/
  await Hive.initFlutter();
  Hive.registerAdapter(UsersAdapter());


  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => TabState())
    ],
    child: const MyApp(),
  ));
  configLoading();
}
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false
    ..dismissOnTap = true;
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
            return  GetMaterialApp(
              debugShowCheckedModeBanner: false,
              home: const DashboardAdminWidget(),
              initialRoute: AppRoute.dashboard,
              initialBinding: DashboardBinding(),
              getPages: /*[
                GetPage(
                  name: '/',
                  page: () => const DashBoardScreen(),
                  binding: DashboardBinding(),
                ),
                // Other routes
              ]*/ AppPage.list,
              themeMode: notifier.isDark ? ThemeMode.dark : ThemeMode.light,
              darkTheme: notifier.isDark ? notifier.darkTheme : notifier.lightTheme,
              theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: MyColor.primaryColor),
                  useMaterial3: true
              ),
              builder: EasyLoading.init(),
            );
          }
      ),
    );
  }



}
