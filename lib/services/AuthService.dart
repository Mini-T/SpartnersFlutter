import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:spartners_app/Middlewares/RequestMiddleware.dart';
import 'package:spartners_app/Models/UserDTO.dart';
import 'package:http/http.dart' as http;


class AuthService {
  static final AuthService _singleton = AuthService._internal();
  factory AuthService() {
    return _singleton;
  }

  static final apiAddress = 'http://192.168.1.150:8000';
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

  Future<List> getSalles() async {
    final res = await _dio.get('/api/sports_halls');
    return res.data;
  }

  Future<List> getUsers() async {
    final res = await _dio.get('/api/users');
    return res.data;
  }

  Future<dynamic> sendLocation(double latitude, double longitude) async {
    final res = await _dio.patch('/api/changeUserInformation', data: {"latitude": latitude, "longitude": longitude});
  }

  Future<bool> refreshLogin() async {
    AuthService.isAuthenticated = false;
    final refToken = await _storage.read(key: 'refreshToken');
    if (refToken != null) {
      final resp = await http.post(Uri.parse('${AuthService.apiAddress}/api/token/refresh'), headers: {'Content-Type': 'application/json'}, body: jsonEncode({'refresh_token': refToken}));
      if(resp.statusCode == 200) {
        String jwt = jsonDecode(resp.body)['token'];
        String refToken = jsonDecode(resp.body)['refresh_token'];
        _storeTokens(jwt, refToken);
        AuthService.isAuthenticated = true;
        return true;
      };
      await _storage.delete(key: 'refreshToken');
      return false;
    }
    return false;
  }


  Future<bool> login(Map<String, dynamic> loginData) async {
    try {
      var res = await http.post(Uri.parse('$apiAddress/api/login'), body: jsonEncode(loginData), headers: {'accept': 'application/json', 'Content-Type': 'application/json'});
      if (res.statusCode == 200) {
        String token = jsonDecode(res.body)['token'];
        String refToken = jsonDecode(res.body)['refresh_token'];
        await _storeTokens(token, refToken);
        isAuthenticated = true;
        return isAuthenticated;
      } else {
        print('Request failed with status: ${res.statusCode}.');
        return false;
      }
    } catch (e) {
      print("exception: $e");
      return false;
    }
  }



  Future<void> fetchChats() async {
    var res = await _dio.get('/api/chats');
  }

  Future<int?> createUser(Map<String, dynamic> userObject) async {
    try {
      var res = await http.post(Uri.parse('$apiAddress/api/users'), headers: {'Content-Type': 'application/json'}, body: jsonEncode(userObject));
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