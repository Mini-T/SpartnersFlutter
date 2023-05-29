import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spartners_app/Components.dart';
import 'package:spartners_app/services/AuthService.dart';

class RegisterPage extends StatefulWidget {
  final TabController tabController;

  RegisterPage({required this.tabController});

  @override
  _RegisterPageState createState() =>
      _RegisterPageState(tabController: tabController);
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService authService = AuthService();
  bool duplicateEmail = false;
  final TabController tabController;
  final _registerFormKey = GlobalKey<FormState>(debugLabel: 'registerForm');
  final _confirmPasswordKey = GlobalKey<FormFieldState>();
  final _emailKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  DateTime birthDate = DateTime.now();
  bool _isSubscribedToSportsHall = false;
  Map<String, dynamic> httpPayload = {"level": 'Débutant'};

  final _controller = PageController(initialPage: 0);
  List sportHallsList = [];
  dynamic sportsHallObject = {};
  String _selectedLevel = '';
  String _selectedObjective = '';
  String _selectedSex = '';

  @override
  void initState() {
    super.initState();
  }

  _RegisterPageState({required this.tabController});

  Future<void> fetchSportHallsList() async {
    var res = await http
        .get(Uri.parse('https://anne0080.annecy-mdstudent.yt/api/choices'));
    print(res.body);
    if (res.statusCode == 200) {
      sportHallsList = jsonDecode(res.body);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime nowUtc = DateTime.now().toUtc();
    DateTime eighteenYearsAgo =
        DateTime.utc(nowUtc.year, nowUtc.month, nowUtc.day);
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

  Padding formPart1(BuildContext context) => Padding(
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
            GestureDetector(
              onTap: () => tabController.animateTo(tabController.index - 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Déjà un compte ?"),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        "Se connecter",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      );

  Padding formPart2(BuildContext context) {
    fetchSportHallsList();
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(children: <Widget>[
          Components.textFormField(
              'Prénom',
              'Veuillez saisir votre prénom',
              (value) => httpPayload.addAll({'firstname': value!})),
          Components.textFormField(
              'Nom de famille',
              'Veuillez saisir votre nom de famille',
              (value) => httpPayload.addAll({'lastname': value!})),
          Components.dropDownButton([
            DropdownMenuItem(value: 'Débutant', child: Text('Débutant')),
            DropdownMenuItem(
                value: 'Intermédiaire', child: Text('Intermédiaire')),
            DropdownMenuItem(value: 'Expert', child: Text('Expert'))
          ], _selectedLevel, (value) {
            setState(() {
              _selectedLevel = value!;
            });
            httpPayload.addAll({'level': value});
            print(httpPayload);
          }, 'Niveau'),
          Components.dropDownButton([
            DropdownMenuItem(
                value: 'Perte de poids', child: Text('Perte de poids')),
            DropdownMenuItem(
                value: 'Prise de masse musculaire',
                child: Text('Prise de masse musculaire')),
            DropdownMenuItem(
                value: 'Renforcement musculaire',
                child: Text('Renforcement musculaire')),
            DropdownMenuItem(
                value: 'Améliorer son endurance',
                child: Text('Améliorer son endurance')),
            DropdownMenuItem(value: 'Sèche', child: Text('Sèche'))
          ], _selectedObjective, (value) {
            setState(() {
              _selectedObjective = value!;
            });
            httpPayload.addAll({'objective': value});
            print(httpPayload);
          }, "Objectif"),
          Components.dropDownButton([
            DropdownMenuItem(value: 'Homme', child: Text('Homme')),
            DropdownMenuItem(value: 'Femme', child: Text('Femme')),
            DropdownMenuItem(value: 'Non-binaire', child: Text('Non-binaire')),
          ], _selectedSex, (value) {
            setState(() {
              _selectedSex = value!;
            });
            httpPayload.addAll({'sex': value});
            print(httpPayload);
          }, 'Sexe'),
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
          Components.textFormField('Ville', 'Veuilez renseigner votre ville', (value) => httpPayload.addAll({'city': value!})),
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
                  hint: Text(sportsHallObject['nom'] ??
                      'Sélectionne ta salle de sport'),
                  isExpanded: true,
                  onChanged: (dynamic value) => {
                        setState(() {
                          sportsHallObject = value;
                        }),
                        httpPayload['sportsHall'] =
                            "/api/sports_halls/${value['id']}"
                      },
                  items: sportHallsList.map((sporthall) {
                    return DropdownMenuItem(
                        value: sporthall, child: Text(sporthall['nom']));
                  }).toList())
              : Container(),
          ElevatedButton(
            child: Text('Continuer'),
            onPressed: () {
              if (_registerFormKey.currentState!.validate()) {
                _registerFormKey.currentState!.save();
                authService.createUser(httpPayload).then((value) {
                  switch (value) {
                    case 201:
                      tabController.animateTo(tabController.index - 1);
                      break;
                    case 200:
                      tabController.animateTo(tabController.index - 1);
                      break;
                    case 409:
                      setState(() {
                        duplicateEmail = true;
                      });
                      break;
                  }
                });
              }
            },
          ),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Form(
            key: _registerFormKey,
            child: PageView(
              controller: _controller,
              children: [formPart1(context), formPart2(context)],
            )));
  }
}
