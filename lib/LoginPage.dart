import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spartners_app/http/HttpQueries.dart';

class LoginPage extends StatefulWidget {
  final TabController tabController;

  LoginPage({required this.tabController});


  @override
  _LoginPageState createState() => _LoginPageState(tabController: tabController);
}

class _LoginPageState extends State<LoginPage> {
  static final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";

  final TabController tabController;

  bool validateEmail(String email) {
    final RegExp regex = RegExp(
      r"^[a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
    );
    return regex.hasMatch(email);
  }

  Map<String, dynamic> httpPayload = {"email": null, "password": null};

  _LoginPageState({required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Form(
                key: _LoginPageState._formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Email'),
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
                      decoration: const InputDecoration(labelText: 'Mot de passe'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null) {
                          return 'Veuillez saisir votre mot de passe';
                        }
                        return null;
                      },
                      onSaved: (value) => httpPayload['password'] = value!,
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      child: const Text('Connexion'),

                      onPressed: () {
                        if (_LoginPageState._formKey.currentState!.validate()) {
                          _LoginPageState._formKey.currentState!.save();
                          HttpQueries.login(httpPayload, context);
                        }
                      },
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => tabController.animateTo(tabController.index + 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Pas de compte ? "),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "Créer un compte",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    )),
                  ],
                ),
              ),
            ],
          )),
    );
  }

}
