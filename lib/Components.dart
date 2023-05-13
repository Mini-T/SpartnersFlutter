import 'package:flutter/material.dart';

class Components {
  static Widget personalInfo(MapEntry<String, String> userDTOField, final httpPayload,
      {ValueChanged<String>? onChanged}) {
    return Container(
        child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userDTOField.key),
            TextFormField(initialValue: null, decoration: InputDecoration(constraints: const BoxConstraints(maxWidth: 200), label: Text(userDTOField.value)), onChanged: onChanged),
          ],
        ),
        const Icon(Icons.edit)
      ],
    ));
  }
}
