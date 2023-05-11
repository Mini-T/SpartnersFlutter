
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spartners_app/Middlewares/AuthMiddleware.dart';
import 'package:spartners_app/Views/AuthView.dart';
import 'package:spartners_app/Views/MainPage.dart';
import 'package:spartners_app/services/AuthService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      getPages: Routes.appPages,
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

    );
  }
}

class Routes {
  static final List<GetPage> appPages = [
    GetPage(name: '/', page: () => MainPage(), middlewares: [AuthMiddleware()]),
    GetPage(name: '/auth', page: () => AuthView())
  ];
}
