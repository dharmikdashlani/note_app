import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

NeumorphicButton SocialButton(
    {required String imageLocation, required Function()? press}) {
  return NeumorphicButton(
    margin: EdgeInsets.all(0),
    padding: EdgeInsets.all(0),
    onPressed: press,
    style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.circle(), color: Colors.white),
    child: CircleAvatar(
      backgroundColor: Colors.white,
      radius: 30,
      child: Image.asset(imageLocation),
    ),
  );
}
