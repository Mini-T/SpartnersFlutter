import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class HttpQueries {
  static const _apiAddress = 'http://192.168.1.150:8000';
  static const _storage = FlutterSecureStorage();

  static Future<void> logout(BuildContext context) async {
    await _storage.delete(key: 'jwt');
    print('jwt: ${await _storage.read(key: 'jwt')}');
    context.push('/auth');
  }

  static Future<void> login(Map<String, dynamic> loginData, BuildContext context) async {
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
      print(await _storage.read(key: 'jwt'));
      await checkJwt() ? context.pop('/') : print('Wrong Login');
    } else {
      print('Request failed with status: ${res.statusCode}.');
    }
  }

  static Future<bool> checkJwt() async {
    String? jwt = await _storage.read(key: 'jwt');
    return _isJwtValid(await jwt);
  }

  static bool _isJwtValid(String? token) {
    if(token != null){
      print(token);
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      DateTime expirationDate = DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
      bool isExpired = expirationDate.isBefore(DateTime.now());
      return !isExpired;
    }
    return false;
}

  static Future<void> fetchChats() async {
    var res = await http
        .get(Uri.parse('http://192.168.1.150:8000/api/chats'), headers: {'Authorization': 'Bearer ${await _storage.read(key: 'jwt')}'});
    print(await res.body);
  }
  static Future<void> createUser(
      Map<String, dynamic> userObject, BuildContext context) async {
    final headers = {
      'accept': 'application/ld+json',
      'Content-Type': 'application/ld+json'
    };
    var res = await http.post(Uri.parse("$_apiAddress/api/users"),
        headers: headers, body: json.encode(userObject));
    if (res.statusCode == 201) {
      print(res.body);
      context.go('/login');
    } else {
      print('Request failed with status: ${res.statusCode}.');
    }
  }
}
