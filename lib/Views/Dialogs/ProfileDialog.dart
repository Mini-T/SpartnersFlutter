import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileDialog extends StatelessWidget {
  final userInfo;

  ProfileDialog({required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: ListView(
          children: [
            Center(child: Text('Profil', style: TextStyle(fontSize: 40))),
            Center(
                child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                        border: Border.all(width: 10, color: Colors.grey), borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                      child: Icon(Icons.person, size: 60),
                    ))),
            Center(child: Text(userInfo['firstname'], style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold))),
            Center(child: Text(userInfo['level'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.grey))),
            Center(child: Text(userInfo['description'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.grey))),
            ElevatedButton(onPressed: () {}, style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.all(15)),shape: MaterialStatePropertyAll(CircleBorder())), child: Icon(Icons.chat))
          ],
        ));
  }
}
