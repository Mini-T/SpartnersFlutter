import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spartners_app/Middlewares/RequestMiddleware.dart';
import 'package:spartners_app/Models/UserDTO.dart';

class AuthService {
  static final AuthService _singleton = AuthService._internal();
  factory AuthService() {
    return _singleton;
  }

  static final apiAddress = 'http://10.0.2.2:8000';
  final _storage = FlutterSecureStorage();
  static bool isAuthenticated = false;
  AuthService._internal();

  final Dio _dio = Dio(BaseOptions(
    baseUrl: AuthService.apiAddress,
    headers: {'accept': 'application/json', 'Content-Type': 'application/json'},
  ))..interceptors.add(RequestMiddleware());

  Future<UserDTO> getPersonalInfos() async {
    String? jwt = await _storage.read(key: 'jwt');
    var res = await _dio.get('/api/me',
        options: Options(headers: {'Authorization': 'Bearer $jwt'}));
    UserDTO userDTO = UserDTO(
        firstname: res.data['firstname'],
        lastname: res.data['lastname'],
        email: res.data['email'],
        sex: res.data['sex'],
        city: res.data['city'],
        level: res.data['level'],
        objective: res.data['objective'],
        description: res.data['description']);
    return userDTO;
  }

  Future<bool> logout() async {
    final refreshToken = await _storage.read(key: 'refreshToken');
    if(refreshToken != null){
      final res = await _dio.post('/api/logout',data: jsonEncode({'refresh_token': refreshToken}));
    }
    await _storage.delete(key: 'jwt');
    await _storage.delete(key:'refreshToken');
    isAuthenticated = false;
    return !isAuthenticated;
  }

   Future<bool> refreshLogin() async {
    final refToken = await _storage.read(key:'refreshToken');
    if (refToken != null) {
      final resp = await _dio.post('/api/token/refresh', data: jsonEncode({'refresh_token': refToken}));
      if(resp.statusCode == 200) {
        String jwt = resp.data['token'];
        String refToken = resp.data['refresh_token'];
        await _storeTokens(jwt, refToken);
        isAuthenticated = true;
        return true;
      };
      await _storage.delete(key: 'refreshToken');
      return false;
    }
    return false;
  }

  Future<bool> login(Map<String, dynamic> loginData) async {
    try {
      var res = await _dio.post('/api/login', data: loginData);
      if (res.statusCode == 200) {
        String token = res.data['token'];
        String refToken = res.data['refresh_token'];
        await _storeTokens(token, refToken);
        isAuthenticated = true;
        return isAuthenticated;
      } else {
        print('Request failed with status: ${res.statusCode}.');
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }



  Future<void> fetchChats() async {
    var res = await _dio.get('/api/chats');
    print(res.data);
  }

  Future<int?> createUser(Map<String, dynamic> userObject) async {
    try {
      var res = await _dio.post('/api/users', data: userObject);
      print(res.data);
      return res.statusCode;
    } catch (e) {
      print(e);
      return 500;
    }
  }

  Future<void> _storeTokens(String jwt, String refreshToken) async {
    await _storage.write(key: 'jwt', value: jwt);
    await _storage.write(key:'refreshToken', value: refreshToken);
  }
}