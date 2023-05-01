import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";

  bool validateEmail(String email) {
    final RegExp regex = RegExp(
      r"^[a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
    );
    return regex.hasMatch(email);
  }

  Map<String, dynamic> httpPayload = {"email": null, "password": null};

  Future<void> login(Map<String, dynamic> loginData) async {
    final headers = {
      'accept': 'application/ld+json',
      'Content-Type': 'application/ld+json'
    };
    var res = await http.post(Uri.parse('http://192.168.1.150:8000/login'),
        headers: headers, body: json.encode(loginData));
    if (res.statusCode == 200) {
      print(res.body);
    } else {
      print('Request failed with status: ${res.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez saisir votre email';
                  }
                  if (!validateEmail(value)) {
                    return 'Veuillez saisir un email valide';
                  }
                  return null;
                },
                onSaved: (value) => httpPayload['email'] = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mot de passe'),
                obscureText: true,
                validator: (value) {
                  if (value == null) {
                    return 'Veuillez saisir votre mot de passe';
                  }
                  return null;
                },
                onSaved: (value) =>  httpPayload['password'] = value!,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Connexion'),
                onPressed: () {

                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    login(httpPayload);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}