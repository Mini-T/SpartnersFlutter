import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SalleDialog extends StatelessWidget {
  final salleInfo;

  SalleDialog({required this.salleInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: ListView(
          children: [
            Center(
                child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                        border: Border.all(width: 10, color: Colors.grey), borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                      child: Icon(Icons.person, size: 60),
                    ))),
            Center(child: Text(salleInfo['name'], style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold))),
             ],
        ));
  }

}