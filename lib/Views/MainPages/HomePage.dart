import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => HomePageState();

}

class HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          Container(child: Text('Welcome', style: TextStyle(fontSize: 40),)),
          Container(margin: EdgeInsets.all(10),height: 120, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)),),
          Container(margin: EdgeInsets.all(10),height: 400, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20))),
          Container(child: Row(children: [
            Expanded(child: Container(margin: EdgeInsets.all(10), height: 100, child: Text('TEST', style: TextStyle(color: Colors.white),),decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)))),
            Expanded(child: Container(margin: EdgeInsets.all(10), height: 100, child: Text('TEST', style: TextStyle(color: Colors.white),),decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)))),
          ])),
          Container(margin: EdgeInsets.all(10),height: 300, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)))
        ],
      )
    );
  }

}