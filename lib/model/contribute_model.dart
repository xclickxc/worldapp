import 'package:flutter/material.dart';

class Contribute
{
  String name;
  String languageSupport;
  String skillSupport;
  String facebook;
  String instagram;
  String github;
  String gmail;
  Color color;
  Color colorLeft;
  Color colorRight;
  ImageProvider image;
  Contribute({
    Key key,
    this.name,
    this.languageSupport,
    this.color, this.image,
    this.skillSupport,
    this.facebook,
    this.github,
    this.instagram,
    this.gmail,
    this.colorLeft,
    this.colorRight
  });
}