import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Components {
  static Widget personalInfo(MapEntry<String, String> userDTOField) {
    return Container(
        child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userDTOField.key),
            ExpansionTile(title: Text(userDTOField.value), children: [TextFormField()]),
          ],
        ),
        Icon(Icons.edit)
      ],
    ));
  }
}
