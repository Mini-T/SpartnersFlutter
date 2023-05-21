import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spartners_app/Models/UserDTO.dart';
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
  UserDTO profile = UserDTO();
  List listSalle = [];
  List listUser = [];

  Future<void> getLocations() async {
    List userResult = await authService.getUsers();
    List salleResult = await authService.getSalles();
    listUser = userResult;
    listSalle = salleResult;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 5, vsync: this);
    authService
        .getPersonalInfos()
        .then((profile) {
      setState(() => {this.profile = profile});
    });
    getLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _controller,
        children: [HomePage(profile: profile), Profile(profile: profile), Map(listUser: listUser, listSalle: listSalle), Container(), Container()],
      ),
      bottomNavigationBar: TabBar(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              controller: _controller,
              tabs: const [
            Tab(icon: Icon(Icons.house, color: Colors.grey)),
            Tab(icon: Icon(Icons.house, color: Colors.grey)),
            Tab(icon: Icon(Icons.add, color: Colors.grey)),
            Tab(icon: Icon(Icons.house, color: Colors.grey)),
            Tab(icon: Icon(Icons.house, color: Colors.grey)),
          ]),
    );
  }
}
