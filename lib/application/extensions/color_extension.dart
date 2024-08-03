import 'package:flutter/material.dart';

extension ColorFormat on Color{
  String colorToHexWithAlpha() {
    String hex = value.toRadixString(16).padLeft(8, '0').toUpperCase();
    return '#$hex';
  }
}