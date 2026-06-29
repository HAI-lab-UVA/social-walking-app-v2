import 'package:flutter/material.dart';

enum SWColor { orange, pink, purple, green, black, white }

extension SWColorExtension on SWColor {
  Color get color {
    switch (this) {
      case SWColor.orange:
        return Color(0xfffb8b24); //ARGB format
      case SWColor.pink:
        return Color(0xffd90386);
      case SWColor.purple:
        return Color(0xff820263);
      case SWColor.green:
        return Color(0xff04a277);
      case SWColor.black:
        return Color(0xff291720);
      case SWColor.white:
        return Color(0xfff5f5f5);
    }
  }
}
