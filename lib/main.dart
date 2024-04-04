import 'package:flutter/material.dart';
import 'package:flutter_application_1/users/fragments/body_overview_screen.dart';
import 'package:flutter_application_1/users/fragments/overview_app_screen.dart';
import 'package:flutter_application_1/users/quanlydangnhap/login_screen.dart';
import 'package:flutter_application_1/users/userPreferences/user_preferences.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'doctorship',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // primarySwatch: Colors.green,
            scaffoldBackgroundColor: Color.fromARGB(255, 244, 242, 242),
            accentColor: Color.fromARGB(255, 214, 194, 135),
            textTheme: const TextTheme(
              headline6: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
        home: FutureBuilder(
          future: RememberUserPrefs.readUserInfo(),
          builder: (context, datasnapshot) {
            if (datasnapshot.data == null) {
              return LoginScreen();
            } else {
              return OverViewAppScreen();
            }
          },
        ));
  }
}
