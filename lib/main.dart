import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spartners_app/AuthView.dart';
import 'package:spartners_app/HomePage.dart';
import 'package:spartners_app/LoginPage.dart';
import 'package:spartners_app/RegisterPage.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _router = GoRouter(routes: [
    GoRoute(path: '/', builder: (context,state) => HomePage()),
    GoRoute(path: '/auth', builder: (context, state) => AuthView())
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Spartners',
      routerConfig: _router,
    );
  }
}
