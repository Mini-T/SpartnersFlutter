
import 'package:flutter/material.dart';
import 'package:spartners_app/AuthView.dart';
import 'package:spartners_app/HomePage.dart';
import 'package:spartners_app/services/HttpQueries.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/auth': (context) => AuthView(),
      },
      navigatorObservers: [
        MyNavigatorObserver()
      ],
      home: HomePage(),
    );
  }
}

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    route;
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    newRoute!;
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) async {
    if (await _checkAuthentication()){
      return null;
    }
    print('nope');
    Navigator.pushNamed(route.navigator!.context, '/auth');
    return null;
  }

  Future<bool> _checkAuthentication() async {
    await HttpQueries.checkJwt();
    return HttpQueries.isAuthenticated;
  }
}
