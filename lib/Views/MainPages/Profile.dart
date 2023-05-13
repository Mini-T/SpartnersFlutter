import 'package:flutter/material.dart';
import 'package:spartners_app/Components.dart';
import 'package:spartners_app/Models/UserDTO.dart';
import 'package:spartners_app/services/AuthService.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  AuthService authService = AuthService();
  UserDTO profile = UserDTO();
  final _key = GlobalKey<FormState>();
  Map<String, dynamic> httpPayload = {};

  @override
  void initState() {
    super.initState();
    authService
        .getPersonalInfos()
        .then((profile) => setState(() => {this.profile = profile}));
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
                            child: Components.personalInfo(entry, httpPayload, onChanged: (value)
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
