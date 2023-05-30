import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';

class ProfileDialog extends StatelessWidget {
  final userInfo;

  ProfileDialog({required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: Container(
            margin: EdgeInsets.all(25),
            child: ListView(
              children: [
                Center(
                    child: Container(
                        width: 288,
                        height: 288,
                        decoration: BoxDecoration(
                            border: Border.all(width: 10, color: Colors.grey),
                            borderRadius: BorderRadius.circular(20)),
                        child: const Center(
                          child: Icon(Icons.person, size: 60),
                        ))),
                Center(
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Text(userInfo['firstname'],
                            style: const TextStyle(
                                fontSize: 42, fontWeight: FontWeight.bold)))),
                Center(
                    child: Text(userInfo['description'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey))),
                Center(
                    child: Container(
                        child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 3),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 1),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xFFFBBA00)),
                            height: 18,
                            child: Text(
                              userInfo['level'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'CircularStd',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            )),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 1),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xFFFBBA00)),
                            height: 18,
                            child: Text(
                              userInfo['objective'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'CircularStd',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ))
                      ],
                    ),
                    Spacer(),
                    GFButton(size: GFSize.LARGE, color: Color(0xFFFBBA00),shape: GFButtonShape.pills, child: Container(width: 80, child: Text('Envoyer un message', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),)),onPressed: () => null)
                  ],
                ))),
                Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(26),
                    child: Center(
                        child: GridView(
                          physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 2),
                            shrinkWrap: true,
                            children: [
                              Container(color: Color(0xFFFBBA00), width: MediaQuery.of(context).size.width * 0.44, height: MediaQuery.of(context).size.height * 0.50, child: Center(child: Icon(Icons.photo))),
                              Container(color: Color(0xFFFBBA00), width: MediaQuery.of(context).size.width * 0.44, height: MediaQuery.of(context).size.height * 0.50, child: Center(child: Icon(Icons.photo))),
                              Container(color: Color(0xFFFBBA00), width: MediaQuery.of(context).size.width * 0.44, height: MediaQuery.of(context).size.height * 0.50, child: Center(child: Icon(Icons.photo))),
                              Container(color: Color(0xFFFBBA00), width: MediaQuery.of(context).size.width * 0.44, height: MediaQuery.of(context).size.height * 0.50, child: Center(child: Icon(Icons.photo))),
                              Container(color: Color(0xFFFBBA00), width: MediaQuery.of(context).size.width * 0.44, height: MediaQuery.of(context).size.height * 0.50, child: Center(child: Icon(Icons.photo))),
                              Container(color: Color(0xFFFBBA00), width: MediaQuery.of(context).size.width * 0.44, height: MediaQuery.of(context).size.height * 0.50, child: Center(child: Icon(Icons.photo)))
                            ]
                        )))
              ],
            )));
  }
}
