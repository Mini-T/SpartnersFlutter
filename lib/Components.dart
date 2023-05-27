import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class Components {
  static Widget personalInfo(
      MapEntry<String, dynamic> userDTOField, final httpPayload,
      {ValueChanged<String>? onChanged}) {
    return Container(
        child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userDTOField.key),
            TextFormField(
                initialValue: null,
                decoration: InputDecoration(
                    constraints: const BoxConstraints(maxWidth: 200),
                    label: Text(userDTOField.value ?? '')),
                onChanged: onChanged),
          ],
        ),
        const Icon(Icons.edit)
      ],
    ));
  }

  static Widget article(String title, String text, String image) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(right: 10),
          height: 88,
          width: 88,
          decoration: BoxDecoration(
              image:
                  DecorationImage(fit: BoxFit.fill, image: AssetImage(image)),
              borderRadius: BorderRadius.circular(15)),
        ),
        Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 220,
                child: Text(title.toUpperCase(),
                    style: TextStyle(
                        fontFamily: 'Eras',
                        fontWeight: FontWeight.w400,
                        fontSize: 12))),
            Container(
                width: 220,
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.only(bottom: 40),
                child: Text(text,
                    style: TextStyle(
                        fontFamily: 'CircularStd',
                        fontWeight: FontWeight.w400,
                        fontSize: 13)))
          ],
        ))
      ],
    ));
  }

  static Widget gridProfile(dynamic profile) {
    return Container(
        height: 246,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            height: 116,
            width: 175,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('lib/Assets/images/running_guy.png'))),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Spacer(),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8)),
                            height: 18,
                            width: 71,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: GFButton(
                                    color: Colors.white,
                                    onPressed: () {},
                                    child: Container(
                                        width: double.infinity,
                                        child: Text(
                                            textAlign: TextAlign.center,
                                            'Voir le profil',
                                            style: TextStyle(
                                                fontFamily: 'CircularStd',
                                                fontSize: 5,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black)))))),
                        Spacer(),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8)),
                            height: 18,
                            width: 71,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: GFButton(
                                    color: Color(0xFFFBBA00),
                                    onPressed: () {},
                                    child: Container(
                                        width: double.infinity,
                                        child: Text(
                                            textAlign: TextAlign.center,
                                            'Envoyer un message',
                                            style: TextStyle(
                                                fontFamily: 'CircularStd',
                                                fontSize: 5,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black)))))),
                        Spacer(),
                      ],
                    ))),
          ),
          Container(
              height: 39,
              child: Row(
                children: [
                  Text('${profile["firstname"]}, ${profile['age']} ans')
                ],
              ))
        ]));
  }
}
