import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spartners_app/Components.dart';

class SalleDialog extends StatelessWidget {
  final Map<String, dynamic> salleInfo;

  SalleDialog({required this.salleInfo});

  @override
  Widget build(BuildContext context) {
    List<dynamic> subscriber = salleInfo['subscribers'];
    return DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) => Container(
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child: SingleChildScrollView(
                controller: scrollController,
                child:
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(25)),
                            height: 5,
                            width:
                                (MediaQuery.of(context).size.width / 3) * 1.5,
                          )),
                          Text(salleInfo['name'],
                              style: const TextStyle(
                                  fontFamily: 'Eras',
                                  fontSize: 35,
                                  fontWeight: FontWeight.w400)),
                          Container(
                              width: double.infinity,
                              margin: EdgeInsets.all(26),
                              child: Center(
                                  child: GridView(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        crossAxisCount: 2),
                                shrinkWrap: true,
                                children: subscriber.map((user) {
                                  return Components.gridProfile(user);
                                }).toList()
                              )))
                        ]),
                  )));
  }
}
