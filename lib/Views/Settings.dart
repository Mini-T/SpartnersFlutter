import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spartners_app/services/AuthService.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) => Container(
            padding: EdgeInsets.all(10),
            color: Color(0xFFEFEFEF),
            child: SingleChildScrollView(
                controller: scrollController,
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    margin: EdgeInsets.all(26),
                    child: ListView(children: [
                      Center(
                          child: Text('Paramètres',
                              style: TextStyle(
                                  fontFamily: 'Eras',
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400))),
                      Column(children: [
                        Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white), child: Column(children: [  MaterialButton(onPressed: () {authService.logout().then(
                                (value) => value ? Get.offAndToNamed('/auth') : null);}, child: Row(
                          children: [
                            Container(padding: EdgeInsets.all(5), decoration: BoxDecoration(color: Color(0xFF5F5F5F), borderRadius: BorderRadius.circular(3) ), child: SvgPicture.string('''<svg width="18" height="17" viewBox="0 0 18 17" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M8.98989 16.6737H2.49247C1.91806 16.6737 1.36708 16.4455 0.960909 16.0391C0.554742 15.6327 0.32666 15.0814 0.32666 14.5066V2.58752C0.32666 2.01277 0.554742 1.46145 0.960909 1.05504C1.36708 0.648629 1.91806 0.42041 2.49247 0.42041H8.98989C9.56429 0.42041 10.1153 0.648629 10.5214 1.05504C10.9276 1.46145 11.1557 2.01277 11.1557 2.58752V7.89683L15.091 7.87752L13.0595 5.94215C13.0203 5.90542 12.9891 5.86116 12.9675 5.81199C12.9459 5.76283 12.9345 5.70988 12.9339 5.65618C12.9329 5.60197 12.9427 5.548 12.963 5.49772C12.9833 5.44744 13.0135 5.40188 13.0518 5.3636L13.4265 4.9898C13.4641 4.95216 13.5089 4.92225 13.5581 4.90198C13.6074 4.88171 13.6603 4.87134 13.7136 4.87155C13.7665 4.87121 13.8191 4.88169 13.868 4.90198C13.9169 4.92226 13.9611 4.95208 13.9983 4.9898L17.274 8.26533C17.312 8.30305 17.3421 8.34785 17.3626 8.39734C17.383 8.44683 17.3935 8.50013 17.3932 8.55368C17.3932 8.60654 17.3825 8.65864 17.362 8.70738C17.3416 8.75612 17.3117 8.80047 17.274 8.83753L13.9983 12.1141C13.961 12.152 13.9165 12.182 13.8674 12.2025C13.8184 12.2229 13.7657 12.2336 13.7125 12.2334C13.6595 12.2335 13.607 12.2229 13.5581 12.2025C13.5092 12.182 13.4647 12.1519 13.4275 12.1141L13.0529 11.7393C13.015 11.7014 12.9852 11.6562 12.9651 11.6065C12.945 11.5568 12.9351 11.5035 12.936 11.4499C12.9364 11.3959 12.9477 11.3428 12.9691 11.2933C12.9905 11.2437 13.0215 11.199 13.0606 11.1618L15.0921 9.22535L11.1568 9.24598L11.1557 7.89683L6.11052 7.92196C6.00329 7.92196 5.90038 7.96445 5.82446 8.04021C5.74853 8.11597 5.70577 8.21862 5.70548 8.32591V8.86769C5.70548 8.97517 5.74824 9.07845 5.82419 9.15445C5.90015 9.23045 6.0031 9.27296 6.11052 9.27296L11.1568 9.24598V14.5066C11.1568 14.7913 11.1007 15.0732 10.9918 15.3362C10.8829 15.5992 10.7232 15.8381 10.522 16.0394C10.3207 16.2406 10.0819 16.4003 9.81898 16.5092C9.55609 16.618 9.27439 16.6739 8.98989 16.6737Z" fill="white"/>
</svg>
''')),
                            Container(padding: EdgeInsets.symmetric(horizontal: 13), child: Text('Déconnexion', style: TextStyle(fontFamily: 'CircularStd', fontWeight: FontWeight.w900, fontSize: 13),))
                          ],
                        )),],))
                      ])
                    ])))));
  }
}
