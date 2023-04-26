import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _username = "";
  String _password = "";
  String _firstname = '';
  String _lastname = '';
  String _level = '';
  String _objective = '';
  String _sexe = '';
  int? _age = null;
  String _city = '';
  bool _isSubscribedToSportsHall = false;
  String _sportsHall = '';
  Map<String, dynamic> _userProfile = {};

  final _controller = PageController(initialPage: 0);

  Padding formPart1() => Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez saisir votre email';
                }
                return null;
              },
              onSaved: (value) => _email = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
              validator: (value) {
                _password = value!;
                if (value!.isEmpty) {
                  return 'Veuillez saisir votre mot de passe';
                }
                return null;
              },
              onSaved: (value) => _password = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Confirmer mot de passe'),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez Confirmer votre mot de passe';
                }
                if (value != _password) {
                  return 'Les mots de passes ne correspondent pas';
                }
                return null;
              },
              onSaved: (value) => _password = value!,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Créer un compte'),
              onPressed: () {
                if (_email != '' && _password != '') {

                  _controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear);
                }
              },
            ),
          ],
        ),
      );

  Padding formPart2() => Padding(
      padding: EdgeInsets.all(16.0),
      child: ListView(children: <Widget>[
        TextFormField(
          decoration: InputDecoration(labelText: 'Prénom'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Veuillez saisir votre prénom';
            }
            return null;
          },
          onSaved: (value) => _firstname = value!,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Nom de famille'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Veuillez saisir votre nom de famille';
            }
            return null;
          },
          onSaved: (value) => _firstname = value!,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Niveau'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Veuillez saisir votre email';
            }
            return null;
          },
          onSaved: (value) => _firstname = value!,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Objectif'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Veuillez saisir votre email';
            }
            return null;
          },
          onSaved: (value) => _firstname = value!,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Sexe'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Veuillez saisir votre email';
            }
            return null;
          },
          onSaved: (value) => _firstname = value!,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Age'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Veuillez saisir votre age';
            }
            return null;
          },
          onSaved: (value) => _firstname = value!,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Ville'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Veuilez renseigner votre ville';
            }
            return null;
          },
          onSaved: (value) => _firstname = value!,
        ),
        CheckboxListTile(
          title: Text('Membre d\'une salle de sport ?'),
          value: _isSubscribedToSportsHall,
          onChanged: (value) {
            setState(() {
              _isSubscribedToSportsHall = value!;
            });
          },
        ),
        _isSubscribedToSportsHall
            ? TextFormField(
                decoration:
                    InputDecoration(labelText: 'Nom de la salle de sport'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez saisir le nom de la salle de sport';
                  }
                  return null;
                },
                onSaved: (value) => _sportsHall = value!,
              )
            : Container(),
        ElevatedButton(
          child: Text('Continuer'),
          onPressed: () {
            _controller.previousPage(
                duration: Duration(milliseconds: 300), curve: Curves.linear);
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              ;
            }
          },
        ),
      ]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Créer un compte'),
        ),
        body: Form(
            key: _formKey,
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _controller,
              children: [formPart1(), formPart2()],
            )));
  }
}
