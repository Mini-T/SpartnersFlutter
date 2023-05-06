import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spartners_app/services/HttpQueries.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  void waitForWidgetBuild() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      HttpQueries.isAuthenticated
          ? null
          : Navigator.pushNamed(context, '/auth');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('LOGO'), actions: [
          Icon(Icons.arrow_circle_right),
          IconButton(
              onPressed: () => HttpQueries.logout().then(
                    (value) =>
                        value ? Navigator.pushNamed(context, '/auth') : null,
                  ),
              icon: Icon(Icons.logout))
        ]),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ListView(children: [
              Column(children: const [
                Text(
                    textAlign: TextAlign.left,
                    'Welcome',
                    style: TextStyle(
                      fontSize: 40,
                    ))
              ]),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Text('TEXT')),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Text('BLOG/ARTICLE')),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          color: Colors.black,
                          height: 50,
                          child: Text('Vos séances')),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          color: Colors.black,
                          height: 50,
                          child: Text('mon abonnement'))
                    ],
                  ))
            ])));
  }
}
