import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  Widget imgText(String heading, String quantity, String mesure) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                textAlign: TextAlign.left,
                heading,
                style: TextStyle(color: Colors.white, fontSize: 16)),
            Row(
              children: [
                Text(quantity,
                    style: TextStyle(color: Colors.white, fontSize: 48)),
                Text(mesure,
                    style: TextStyle(color: Colors.white, fontSize: 16))
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
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child:
                            Text('Bonjour!', style: TextStyle(fontSize: 40))),
                    Container(
                        child: Text(profile.firstname ?? '',
                            style: TextStyle(fontSize: 40))),
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
            ),
            Container(
              height: 270,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  image: DecorationImage(
                      image: AssetImage("lib/Assets/images/img.png"),
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
                  color: const Color(0xFFFBBA00)),
              child: Row(children: [
                Container(
                    margin: EdgeInsets.all(10),
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle)),
                Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Spacer(),
                      Text('félicitations, vous avez reussi à vous inscrire ! ',
                          style: TextStyle(color: Colors.black, fontSize: 12)),
                      Text('vous avez maintenant un badge "Membre Spartners"',
                          style: TextStyle(color: Colors.black, fontSize: 12)),
                      Spacer()
                    ]))
              ]),
            ),

          ],
        ));
  }
}
