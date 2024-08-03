import 'package:flutter/material.dart';

extension StringFormat on String {
  Color hexToColor() {
    String hexString = replaceFirst('#', '');
    return Color(int.parse(hexString, radix: 16));
  }
}