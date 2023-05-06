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
        body: Container(
            color: Colors.black,
            child: ListView(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  child: Column(children: [
                    Text('Spartners', style: TextStyle(fontSize: 40, color: Colors.white),),
                    Text('identifiez vous', style: TextStyle(fontSize: 20, color: Colors.white),)
                  ],)
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,
                  margin: EdgeInsets.all(20),
                  child: Scaffold(
                    appBar: AppBar(toolbarHeight:0, backgroundColor: Colors.transparent, shadowColor: Colors.transparent,
                      bottom: TabBar(labelColor: Colors.blue,controller: _controller, tabs: const [
                        Tab(child: Text('Login')),
                        Tab(child: Text('Signup'))
                      ]),
                    ),
                    body: TabBarView(controller: _controller, children: [
                      LoginPage(tabController: _controller),
                      RegisterPage(tabController: _controller)
                    ]),
                  ),
                )
              ],
            )));
  }
}
