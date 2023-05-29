import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:spartners_app/Components.dart';
import 'package:spartners_app/Models/UserDTO.dart';
import 'package:spartners_app/services/AuthService.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  UserDTO profile;
  List listSalle;
  VoidCallback onRefresh;

  Profile({required this.profile, required this.listSalle, required this.onRefresh});

  @override
  State<StatefulWidget> createState() => ProfileState(profile: profile, listSalle: listSalle, onRefresh: onRefresh);
}

class ProfileState extends State<Profile> {
  final VoidCallback onRefresh;
  UserDTO profile;
  List listSalle;
  late List<String> formattedDate;
  AuthService authService = AuthService();
  final _key = GlobalKey<FormState>();
  Map<String, dynamic> httpPayload = {};
  String _selectedLevel = '';
  String _selectedObjective = '';
  String _selectedSex = '';
  Map<String, dynamic> _selectedSportsHall = {};

  ProfileState({required this.profile, required this.listSalle, required this.onRefresh});

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedSex = profile.sex;
      _selectedLevel = profile.level;
      _selectedObjective = profile.objective;
      _selectedSportsHall = listSalle.firstWhereOrNull((element) => element['id'] == profile.sportsHall);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: Form(
              key: _key,
              child: ListView(children: [
                Center(
                    child: Container(
                        child: Text('Profil',
                            style: TextStyle(
                                fontFamily: 'Eras',
                                fontSize: 30,
                                fontWeight: FontWeight.w400)))),
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Container(
                      height: 111,
                      width: 111,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black12),
                          shape: BoxShape.circle),
                      child: Icon(size: 80, Icons.person_pin)),
                  Container(
                      padding: EdgeInsets.all(33),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  child: Text(profile.firstname,
                                      style: TextStyle(
                                          fontFamily: 'CircularStd',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500))),
                              Container(
                                  child: Text(
                                      "à rejoins le ${profile.getJoinDateInSentence()}",
                                      style: TextStyle(
                                          fontFamily: 'CircularStd',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF7F7F7F))))
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 22),
                              child: GFButton(
                                  size: GFSize.LARGE,
                                  shape: GFButtonShape.pills,
                                  onPressed: () => null,
                                  color: Color(0xFFFBBA00),
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'CircularStd',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
                                  text: 'Aperçu'))
                        ],
                      ))
                ]),
                Components.customExpansionTile(Components.descFormField(
                    initialValue: profile.description, 'Bio', (value) {
                  if (value == profile.description) {
                    httpPayload.remove('lastname');
                    print('void ${httpPayload.isEmpty}');
                    setState(() {});
                    return null;
                  }
                  httpPayload.addAll({'description': value});
                  print('notvoid ${httpPayload.isEmpty}');
                  setState(() {});
                }), profile.description, 'Bio'),
                Components.customExpansionTile(Components.dropDownButton(
                    const [
                      DropdownMenuItem(value: 'Débutant', child: Text('Débutant')),
                      DropdownMenuItem(
                          value: 'Intermédiaire', child: Text('Intermédiaire')),
                      DropdownMenuItem(value: 'Expert', child: Text('Expert'))
                    ], _selectedLevel, (value) {
                  setState(() {
                    _selectedLevel = value!;
                  });
                  if(_selectedLevel == profile.level) {
                    httpPayload.remove('level');
                    return null;
                  }
                  httpPayload.addAll({'level': value});
                  print(httpPayload);
                }, 'Niveau'), profile.level, 'Niveau'),
                Components.customExpansionTile(Components.dropDownButton(
                    const [
                      DropdownMenuItem(value: 'Homme', child: Text('Homme')),
                      DropdownMenuItem(value: 'Femme', child: Text('Femme')),
                      DropdownMenuItem(value: 'Non-binaire', child: Text('Non-binaire')),
                    ], _selectedSex, (value) {
                  setState(() {
                    _selectedSex = value!;
                  });
                  if(_selectedSex == profile.sex) {
                    httpPayload.remove('sex');
                    return null;
                  }
                  httpPayload.addAll({'sex': value});
                  print(httpPayload);
                }, 'Sexe'), profile.sex, 'Sexe'),
                Components.customExpansionTile(Components.dropDownButton(
                    const [
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
                  if(_selectedObjective == profile.objective) {
                    httpPayload.remove('objective');
                    return;
                  }
                  httpPayload.addAll({'objective': value});
                  print(httpPayload);
                }, 'Objectif'), profile.objective, 'Objectif'),
                Components.customExpansionTile(Components.textFormField('Ville', 'Veuillez rentrer une ville valide', (value) {
                  if (value == profile) {
                    httpPayload.remove('city');
                    return;
                  }
                  httpPayload.addAll({'city': value!});
                }), profile.city, 'Ville'),
                profile.sportsHall != null ? Components.customExpansionTile(Components.dropDownButton(listSalle.map((hall) {
                  return DropdownMenuItem(
                  value: hall, child: Text(hall['name']));
                }).cast<DropdownMenuItem>().toList(), _selectedSportsHall['name'], (dynamic value) => {
                  setState(() {
                    print(value);
                    _selectedSportsHall = value;
                  }),
                  httpPayload['sportsHall'] = value['id']
                }, "Salle de sport"), listSalle.firstWhereOrNull((element) => element['id'] == profile.sportsHall)['name'], "Salle de sport") : Container(),
                ElevatedButton(
                    onPressed: () => authService.logout().then(
                        (value) => value ? Get.offAndToNamed('/auth') : null),
                    child: Text('Logout'))
              ])),
        ),
        httpPayload.isEmpty
            ? Container()
            : Positioned(
                bottom: 0,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        _key.currentState!.save();
                        authService.patchUser(httpPayload).then((value) {
                          if (value.statusCode == 200) {
                            print(value.data);
                            ElegantNotification.success(
                                    description: Text(
                                        'Tes informations ont été mise à jour !'))
                                .show(context);
                            Map<String, dynamic> userObj = value.data[0];
                            profile = UserDTO(
                                age: userObj['age'],
                                city: userObj['city'],
                                description: userObj['description'],
                                email: userObj['email'],
                                firstname: userObj['firstname'],
                                joinDate: userObj['joinDate'],
                                lastname: userObj['lastname'],
                                level: userObj['level'],
                                objective: userObj['objective'],
                                sportsHall: userObj['sportsHall'],
                                sex: userObj['sex']);
                            onRefresh();
                            setState(() {});
                          }
                        });
                      }
                    },
                    child: const Text('Enregistrer')))
      ],
    );
  }
}
