import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:spartners_app/services/AuthService.dart';

class AuthMiddleware extends GetMiddleware {

  @override
  RouteSettings? redirect(String? route)  {
    return AuthService.isAuthenticated ? null :  const RouteSettings(name: '/auth');
  }
}