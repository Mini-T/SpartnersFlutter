import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:spartners_app/Views/MainPages/HomePage.dart';
import 'package:spartners_app/Views/MainPages/Profile.dart';
import 'package:spartners_app/services/AuthService.dart';

class MainPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final AuthService authService = AuthService();
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('LOGO'), actions: [
          Icon(Icons.arrow_circle_right),
          IconButton(
              onPressed: () => authService.logout().then(
                    (value) =>
                        value ? Get.toNamed('/auth') : null,
                  ),
              icon: Icon(Icons.logout))
        ]),
        body: PageView(
          controller: _controller,
          children: [
            HomePage(),
            Profile(),
            ElevatedButton(onPressed: () async => authService.fetchChats(), child: Text('request !'))
          ],
        ));
  }
}
