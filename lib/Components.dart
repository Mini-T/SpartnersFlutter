import 'package:flutter/material.dart';

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
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage(image)),
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
}
