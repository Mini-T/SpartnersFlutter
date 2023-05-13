import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:spartners_app/Views/MainPages/HomePage.dart';
import 'package:spartners_app/Views/MainPages/Profile.dart';
import 'package:spartners_app/services/AuthService.dart';
import 'package:spartners_app/Views/MainPages/Map.dart';

class MainPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> with TickerProviderStateMixin {
  final AuthService authService = AuthService();
  late TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 5, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TabBarView(
          controller: _controller,
          children: [
            HomePage(),
            Profile(),
            Map(),
          ],
        ),
      bottomNavigationBar: TabBar(controller: _controller, tabs: const [
        Tab(icon: Icon(Icons.house, color: Colors.grey)),
        Tab(icon: Icon(Icons.house, color: Colors.grey)),
        Tab(icon: Icon(Icons.add, color: Colors.grey)),
        Tab(icon: Icon(Icons.house, color: Colors.grey)),
        Tab(icon: Icon(Icons.house, color: Colors.grey)),
      ]) ,
    );
  }
}
