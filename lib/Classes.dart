import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconCinsiyet extends StatelessWidget {
  final String cinsiyet;
  final IconData? icon;

  IconCinsiyet(
      {this.cinsiyet = 'default', this.icon = FontAwesomeIcons.addressBook});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 50,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          cinsiyet,
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class MyContainer extends StatelessWidget {
  final Widget? child;
  final Color? renk;

  MyContainer({this.renk = Colors.white, this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      margin: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: renk,
      ),
    );
  }
}
