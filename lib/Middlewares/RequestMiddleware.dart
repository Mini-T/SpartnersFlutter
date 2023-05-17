import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../services/AuthService.dart';

class RequestMiddleware extends Interceptor {
  final _storage = FlutterSecureStorage();

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String? jwt = await _storage.read(key: 'jwt');

    if (jwt == null) {
      return handler.next(options);
    }
    if (_isJwtValid(jwt)) {
      options.headers['Authorization'] = 'Bearer $jwt';
    } else {
      if(options.path != '/api/logout') {
        final res = await refreshLogin(jwt);
        if(!res) {
          Get.offAndToNamed('/auth');
          return;
        }
        jwt = await _storage.read(key: 'jwt');
        options.headers['Authorization'] = 'Bearer $jwt';
      }

    }
    return handler.next(options);
  }

  bool _isJwtValid(String? token) {
    if (token != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      DateTime expirationDate =
      DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
      bool isExpired = expirationDate.isBefore(DateTime.now());
      return !isExpired;
    }
    return false;
  }

  Future<bool> refreshLogin(String? currentJwt) async {
    AuthService.isAuthenticated = false;
    final refToken = await _storage.read(key: 'refreshToken');
    if (refToken != null) {
      final resp = await http.post(Uri.parse('${AuthService.apiAddress}/api/token/refresh'), headers: {'Content-Type': 'application/json'}, body: jsonEncode({'refresh_token': refToken}));
      if(resp.statusCode == 200) {
        String jwt = jsonDecode(resp.body)['token'];
        String refToken = jsonDecode(resp.body)['refresh_token'];
        await _storage.write(key: 'jwt', value: jwt);
        await _storage.write(key: 'refreshToken', value: refToken);
        AuthService.isAuthenticated = true;
        return true;
      };
      await _storage.delete(key: 'refreshToken');
      return false;
    }
    return false;
  }
}