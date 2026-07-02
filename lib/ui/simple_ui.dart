import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:social_walking_2/ui/sw_color.dart';

Widget multicolorSentence({
  required List<String> text,
  required List<Color?> colors,
  required TextStyle? style,
}) {
  return Text.rich(
    TextSpan(
      style: style,
      children: [
        for (int i = 0; i < text.length; i++)
          TextSpan(
            text: text[i],
            style: TextStyle(color: colors[i]),
          ),
      ],
    ),
    textAlign: TextAlign.center,
  );
}

Widget indigoButton({required String text, required Function() onPressed}) {
  return TextButton(
    style: TextButton.styleFrom(
      foregroundColor: SWColor.white.color,
      backgroundColor: SWColor.blue.color,
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
    ),
    onPressed: onPressed,
    child: Text(text),
  );
}
