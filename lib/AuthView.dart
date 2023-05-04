import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spartners_app/LoginPage.dart';

import 'RegisterPage.dart';

class AuthView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AuthViewState();
}

class AuthViewState extends State<AuthView> with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(color: Colors.black, child: ListView(
          children: [
            Container(height: MediaQuery.of(context).size.height / 4,),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.6,
                margin: EdgeInsets.all(20),
                child: TabBarView(controller: _controller, children: [
                  LoginPage(tabController: _controller),
                  RegisterPage(tabController: _controller)
                ]))
          ],
        )));
  }
}
