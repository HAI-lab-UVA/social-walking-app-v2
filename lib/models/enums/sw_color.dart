import 'package:flutter/material.dart';

enum SWColor { orange, lightblue, blue, green, black, white, lightgray, gray }

extension SWColorExtension on SWColor {
  Color get color {
    switch (this) {
      case SWColor.orange:
        return Color(0xffff833d); //ARGB format
      case SWColor.lightblue:
        return Color(0xff00acff);
      case SWColor.blue:
        return Color(0xff473bf0);
      case SWColor.green:
        return Color(0xff16c221);
      case SWColor.black:
        return Color(0xff011627);
      case SWColor.white:
        return Color(0xfffdfffc);
      case SWColor.lightgray:
        return Color(0xffd1e4f4);
      case SWColor.gray:
        return Color(0xff284760);
    }
  }
}
