import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:spartners_app/Views/Dialogs/ProfileDialog.dart';

class Components {
  static Widget personalInfo(MapEntry<String, dynamic> userDTOField,
      final httpPayload,
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
                        label: Text(userDTOField.value.toString() ?? '')),
                    onChanged: onChanged),
              ],
            ),
            const Icon(Icons.edit)
          ],
        ));
  }

  static Widget dropDownButton(List<DropdownMenuItem<dynamic>> choices,
      dynamic currentValue, void Function(dynamic) onChanged, String label) {
    return DropdownButton(
        hint: Text(currentValue != '' ? currentValue.toString() : label),
        isExpanded: true,
        items: choices,
        onChanged: onChanged
    );
  }

  static Widget textFormField(String labelText, String validatorMessage,
      void Function(dynamic) onChanged,
      {String initialValue = '', String invalidChar = 'Contient des caractères invalides'}) {
    return TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(labelText: labelText),
        validator: (value) {
          RegExp regex = RegExp(r'^[\p{L}\-' ' ]+\$', unicode: true);
          if (value!.isEmpty) {
            return validatorMessage;
          }
          if (!regex.hasMatch(value)) {
            return invalidChar;
          }
          return null;
        },
        onChanged: onChanged
    );
  }

  static Widget descFormField(String labelText,
      void Function(dynamic) onChanged,
      {String initialValue = '', String invalidChar = 'Contient des caractères invalides'}) {
    return TextFormField(maxLines: null,
        initialValue: initialValue,
        decoration: InputDecoration(labelText: labelText,),
        validator: (value) {
          return null;
        },
        onChanged: onChanged
    );
  }

  static Widget customExpansionTile(List<Widget> formField, dynamic field, String label) {
    return ExpansionTile(
      title: Row(
        children: [
          Text(label,
              style: TextStyle(
                  fontFamily: 'CircularStd',
                  fontWeight: FontWeight.w900,
                  fontSize: 15)),
          Spacer(),
          Container(width: 180, child: Text(
              field.toString(),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              maxLines: 1,
              style: TextStyle(
                  fontFamily: 'CircularStd',
                  fontWeight: FontWeight.w500,
                  fontSize: 15)))
        ],
      ),
      children: formField
    );
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

  static Widget gridProfile(dynamic profile, BuildContext context) {
    return Container(child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
        height: 207,
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
                                onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) =>
                                        Dialog.fullscreen(
                                            child: ProfileDialog(
                                                userInfo: profile))),
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
    ]),);

  }
}
