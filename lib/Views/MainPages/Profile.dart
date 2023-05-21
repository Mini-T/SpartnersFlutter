import 'package:flutter/material.dart';
import 'package:spartners_app/Components.dart';
import 'package:spartners_app/Models/UserDTO.dart';
import 'package:spartners_app/services/AuthService.dart';
import 'package:get/get.dart';


class Profile extends StatefulWidget {
  UserDTO profile;

  Profile({required this.profile});

  @override
  State<StatefulWidget> createState() => ProfileState(profile: profile);
}

class ProfileState extends State<Profile> {
  UserDTO profile;


  AuthService authService = AuthService();
  final _key = GlobalKey<FormState>();
  Map<String, dynamic> httpPayload = {};

  ProfileState({required this.profile});

  @override
  void initState() {
    super.initState();
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
                const SizedBox(height: 250, child: Text('PROFILE')),
                const Text('Infos personnelles'),
                const SizedBox(height: 250, child: Text('Photo de profile')),
                Column(
                  children: profile.toMap().entries.map((entry) {
                    return entry.key == 'email'
                        ? Container()
                        : SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Components.personalInfo(entry, httpPayload, onChanged: (dynamic value)
                            {
                              setState(() {
                                httpPayload[entry.key] = value;
                              });
                              print(httpPayload.entries);
                            }
                            )
                    );
                  }).toList(),
                ),
                ElevatedButton(onPressed: () => authService.logout().then((value) => value ? Get.offAndToNamed('/auth') : null), child: Text('Logout'))
              ])),
        ),
        httpPayload.isEmpty ? Container() : Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    _key.currentState!.save();
                  }
                },
                child: const Text('Enregistrer')))
      ],
    );
  }
}
