import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:untitled_ai/help/global.dart';
import 'help/pref.dart';

import 'screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Pref.initialize();

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,

        themeMode: Pref.defaultTheme,

        darkTheme: ThemeData(
            useMaterial3: false,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.black87,
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
              ),
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              titleTextStyle:
              TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            )),

        theme: ThemeData(
            useMaterial3: false,
            appBarTheme: const AppBarTheme(
              elevation: 0,
              centerTitle: true,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
              ),
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: Colors.black54),
              titleTextStyle: TextStyle(
                  color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold),
            )),

      home: const SplashScreen());
  }
}

extension AppTheme on ThemeData {
  Color get lightTextColor =>
      brightness == Brightness.dark ? Colors.white : Colors.black54;

  Color get buttonColor =>
      brightness == Brightness.dark ? Colors.white.withOpacity(.1) : Colors.black54.withOpacity(.3);
}
