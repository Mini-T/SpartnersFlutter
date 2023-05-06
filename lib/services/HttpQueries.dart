import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class HttpQueries {
  static const _apiAddress = 'http://192.168.1.150:8000';
  static const _storage = FlutterSecureStorage();
  static bool isAuthenticated = false;

  static Future<bool> logout() async {
    await _storage.delete(key: 'jwt');
    isAuthenticated = false;
    print('jwt: ${await _storage.read(key: 'jwt')}, authenticated : $isAuthenticated');
    return !isAuthenticated;
  }

  static Future<bool> login(Map<String, dynamic> loginData) async {
    final headers = {
      'accept': 'application/ld+json',
      'Content-Type': 'application/ld+json'
    };
    var res = await http.post(Uri.parse('$_apiAddress/login'),
        headers: headers, body: json.encode(loginData));
    if (res.statusCode == 200) {
      dynamic body = res.body;
      String token = json.decode(body)['token'];
      await _storage.write(key: 'jwt', value: token);
      return await checkJwt();
    } else {
      print('Request failed with status: ${res.statusCode}.');
      return false;
    }
  }

  static Future<bool> checkJwt() async {
    String? jwt = await _storage.read(key: 'jwt');
    isAuthenticated = _isJwtValid(await jwt);
    return isAuthenticated;

  }

  static bool _isJwtValid(String? token) {
    if(token != null){
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      DateTime expirationDate = DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
      bool isExpired = expirationDate.isBefore(DateTime.now());
      return !isExpired;
    }
    return false;
}

  static Future<void> fetchChats() async {
    var res = await http
        .get(Uri.parse('${_apiAddress}/api/chats'), headers: {'Authorization': 'Bearer ${await _storage.read(key: 'jwt')}'});
    print(await res.body);
  }
  static Future<int> createUser(
      Map<String, dynamic> userObject) async {
    final headers = {
      'accept': 'application/ld+json',
      'Content-Type': 'application/ld+json'
    };
    var res = await http.post(Uri.parse("$_apiAddress/api/users"),
        headers: headers, body: json.encode(userObject));
  return res.statusCode;
  }
}
