import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spartners_app/Components.dart';

class SalleDialog extends StatelessWidget {
  final Map<String, dynamic> salleInfo;

  SalleDialog({required this.salleInfo});

  @override
  Widget build(BuildContext context) {
    List<dynamic> subscriber = salleInfo['subscribers'];
    subscriber.sort((a, b) {
      if (a['visible'] && !b['visible']) {
        return -1;
      } else if(!a['visible'] && b['visible']) {
        return 1;

    } else {
        return 0;
    }
    },);
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
                          Text(salleInfo['city'], style: TextStyle(fontFamily: 'Eras',color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 13),),
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
                                      childAspectRatio: 175 / 280,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        crossAxisCount: 2),
                                shrinkWrap: true,
                                children: subscriber.map((user) {
                                  if (user['visible']) {
                                    return Components.gridProfile(user, context);
                                  }
                                  return Container();
                                }).toList()
                              )))
                        ]),
                  )));
  }
}
