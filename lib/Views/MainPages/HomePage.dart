import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spartners_app/Components.dart';
import 'package:spartners_app/Models/UserDTO.dart';

class HomePage extends StatefulWidget {
  UserDTO profile;

  HomePage({required this.profile});

  @override
  State<StatefulWidget> createState() => HomePageState(profile: profile);
}

class HomePageState extends State<HomePage> {
  UserDTO profile;

  HomePageState({required this.profile});

  @override
  void didUpdateWidget(HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  Widget imgText(String heading, String quantity, String mesure) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                textAlign: TextAlign.left,
                heading.toUpperCase(),
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Eras', fontSize: 16)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(quantity,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontFamily: 'DrukTrial',
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w900)),
                Text(mesure,
                    style: TextStyle(
                        color: Colors.white, fontSize: 16, fontFamily: 'Eras'))
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
                margin: EdgeInsets.all(18),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text('Bonjour!'.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 24,
                                    fontFamily: 'DrukTrial',
                                    fontWeight: FontWeight.w500))),
                        Container(
                            child: Text(profile.firstname ?? '',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontFamily: 'Eras',
                                  fontWeight: FontWeight.w400,
                                ))),
                      ],
                    ),
                    Spacer(),
                    Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey, width: 3)),
                        child: Icon(
                          Icons.person,
                          size: 50,
                        ))
                  ],
                )),
            Container(
              height: 270,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  image: DecorationImage(
                      image: AssetImage("lib/Assets/images/running_guy.png"),
                      fit: BoxFit.cover)),
              child: Stack(
                children: [
                  Positioned(
                      child: imgText("Total Calories", "3,485", "KCAL"),
                      left: 0,
                      top: 0),
                  Positioned(
                    child: imgText("Total Pas", "36,985", "STEP"),
                    left: 0,
                    bottom: 0,
                  ),
                  Positioned(
                    child: imgText("Total Distance", "14,4", "KM"),
                    right: 0,
                    bottom: 0,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(322),
                  color: const Color(0xFF1ED760)),
              child: Row(children: [
                Container(
                    margin: EdgeInsets.all(11),
                    width: 58,
                    height: 58,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Image(
                      image: AssetImage('lib/Assets/images/spotify.png'),
                    )),
                Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Spacer(),
                      Text('Découvre notre nouvelle playlist'.toUpperCase(),
                          style: TextStyle(
                              fontFamily: 'Eras',
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 12)),
                      Text('spotify !'.toUpperCase(),
                          style: TextStyle(
                              fontFamily: 'Eras',
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 12)),
                      Spacer()
                    ]))
              ]),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                child: Column(
              children: [
                Center(
                    child: Text('Programmes d’entraînement'.toUpperCase(),
                        style: TextStyle(
                            fontFamily: 'Eras',
                            fontWeight: FontWeight.w400,
                            fontSize: 17))),
                Container(margin: EdgeInsets.symmetric(vertical: 10), child: Column(children: [
                Components.article(
                    'travailles tes fessiers !',
                    'Découvre notre routine idéale pour muscler tes fessiers !',
                    'lib/Assets/images/crossfit.png'),
                Components.article(
                    'programmes half-body',
                    'Privilégies des séances plus complètes, où le corps entier est mis à contribution !',
                    'lib/Assets/images/squat.png'),
                Components.article(
                    'brûles les graisses et gagne en muscle ',
                    'Mélange du cardio et de la musculation pour perdre du poids !',
                    'lib/Assets/images/tapis.png'),
                ],))],
            ))
          ],
        ));
  }
}
