import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(
      child: Text('login'),
      onPressed: () => context.go('/login'),
    ));
  }
}
