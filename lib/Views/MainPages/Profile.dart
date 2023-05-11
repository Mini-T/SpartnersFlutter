import 'dart:convert';

import 'package:flutter/cupertino.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authService
        .getPersonalInfos()
        .then((profile) => setState(() => {this.profile = profile}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: ListView(children: [
          const SizedBox(height: 250, child: Text('PROFILE')),
          const Text('Infos personnelles'),
          const SizedBox(height: 250, child: Text('Photo de profile')),
          Column(
            children: profile.toMap().entries.map((entry) {
              return SizedBox(width: MediaQuery.of(context).size.width, child: Components.personalInfo(entry));
            }).toList(),
          )
        ]));
  } 
}
