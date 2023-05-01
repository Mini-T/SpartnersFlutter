import 'dart:convert';
import 'dart:developer';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _confirmPasswordKey = GlobalKey<FormFieldState>();
  final _emailKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  DateTime birthDate = DateTime.now();
  bool _isSubscribedToSportsHall = false;
  Map<String, dynamic> httpPayload = {
    'email': '',
    "password": "",
    "firstname": "",
    "lastname": "",
    "sex": "",
    "city": "",
    "age": null,
    "level": "",
    "objective": "",
    "description": "",
    "allowLocation": false,
    "premium": false,
    "latitude": null,
    "longitude": null,
    "sportsHall": null
  };

  final _controller = PageController(initialPage: 0);
  List sportHallsList = [];
  dynamic sportsHallObject = {};

  @override
  void initState() {
    super.initState();
    fetchSportHallsList();
  }

  Future<void> fetchSportHallsList() async {
    var res = await http
        .get(Uri.parse('http://192.168.1.150:8000/api/sports_halls?page=1'));
    if (res.statusCode == 200) {
      dynamic jsonBody = jsonDecode(res.body);
      setState(() {
        sportHallsList = jsonBody['hydra:member'];
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime nowUtc = DateTime.now().toUtc();
    DateTime eighteenYearsAgo =
        DateTime.utc(nowUtc.year - 18, nowUtc.month, nowUtc.day);
    final DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime.utc(1940),
        initialDate: eighteenYearsAgo,
        lastDate: eighteenYearsAgo);
    if (picked != null && picked != birthDate) {
      setState(() {
        birthDate = picked;
      });
    }
  }

  bool validateEmail(String email) {
    final RegExp regex = RegExp(
      r"^[a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
    );
    return regex.hasMatch(email);
  }

  Padding formPart1() => Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            TextFormField(
              key: _emailKey,
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez saisir votre email';
                }
                ;
                if (!validateEmail(value)) {
                  return "Veuillez saisir un email valide";
                }
                return null;
              },
            ),
            TextFormField(
              key: _passwordKey,
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Mot de passe"),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez saisir votre mot de passe';
                }
                return null;
              },
            ),
            TextFormField(
              key: _confirmPasswordKey,
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirmer mot de passe'),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez Confirmer votre mot de passe';
                }
                if (value != _passwordController.text) {
                  return 'Les mots de passes ne correspondent pas';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Créer un compte'),
              onPressed: () {
                if (_emailKey.currentState!.validate() &&
                    _passwordKey.currentState!.validate() &&
                    _confirmPasswordKey.currentState!.validate()) {
                  httpPayload.addAll({'email': _emailController.text});
                  httpPayload.addAll({'password': _passwordController.text});
                  _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear);
                }
              },
            ),
            ElevatedButton(
              child: Text('back'),
              onPressed: () {
                context.go('/login');
              },
            )
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
          onSaved: (value) => httpPayload.addAll({'firstname': value!}),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Nom de famille'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Veuillez saisir votre nom de famille';
            }
            return null;
          },
          onSaved: (value) => httpPayload.addAll({'lastname': value!}),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Niveau'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Veuillez saisir votre email';
            }
            return null;
          },
          onSaved: (value) => httpPayload.addAll({'level': value}),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Objectif'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Veuillez saisir votre email';
            }
            return null;
          },
          onSaved: (value) => httpPayload.addAll({'objective': value!}),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Sexe'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Veuillez saisir votre email';
            }
            return null;
          },
          onSaved: (value) => httpPayload.addAll({'sex': value!}),
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Date de naissance',
            hintText: 'Sélectionnez une date',
            suffixIcon: Icon(Icons.calendar_today),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Veuillez saisir votre date de naissance';
            }
            return null;
          },
          controller: TextEditingController(
            text: birthDate != null
                ? DateFormat('yyyy-MM-dd').format(birthDate)
                : '',
          ),
          onTap: () {
            _selectDate(context);
          },
          onSaved: (value) => httpPayload.addAll({'birthDate': value!}),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Ville'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Veuilez renseigner votre ville';
            }
            return null;
          },
          onSaved: (value) => httpPayload.addAll({'city': value!}),
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
            ? DropdownButton(
                hint: Text(sportsHallObject['name'] != null
                    ? sportsHallObject['name']
                    : 'Sélectionne ta salle de sport'),
                isExpanded: true,
                onChanged: (dynamic value) => {
                      setState(() {
                        sportsHallObject = value != null ? value : null;
                      }),
                      print(value),
                      this.httpPayload['sportsHall'] = value != null ? value['@id'] : null
                    },
                items: sportHallsList.map((sporthall) {
                  return DropdownMenuItem(
                      value: sporthall, child: Text(sporthall['name']));
                }).toList())
            : Container(),
        ElevatedButton(
          child: Text('Continuer'),
          onPressed: () {
            _controller.previousPage(
                duration: Duration(milliseconds: 300), curve: Curves.linear);
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              createUser(httpPayload);
            }
          },
        ),
      ]));

  Future<void> createUser(Map<String, dynamic> userObject) async {
    final headers = {
      'accept': 'application/ld+json',
      'Content-Type': 'application/ld+json'
    };
    var res = await http.post(Uri.parse('http://192.168.1.150:8000/api/users'),
        headers: headers, body: json.encode(userObject));
    if (res.statusCode == 201) {
      print(res.body);
      context.go('/login');
    } else {
      print('Request failed with status: ${res.statusCode}.');
    }
  }

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
