import 'package:flutter/material.dart';
import 'package:social_walking_2/ui/sw_color.dart';

Widget multiColorSentence({
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
      foregroundColor: SWColor.white,
      backgroundColor: SWColor.blue,
      padding: EdgeInsets.only(top: 14.0, bottom: 14.0),
    ),
    onPressed: onPressed,
    child: Text(text),
  );
}

Widget textInputField({
  required String hintText,
  required TextEditingController controller,
  required BuildContext context,
  required String? Function(String?)? validator,
}) {
  final grayTextStyle = Theme.of(
    context,
  ).textTheme.bodyMedium!.copyWith(color: SWColor.gray);
  return TextFormField(
    style: grayTextStyle,
    controller: controller,
    decoration: InputDecoration(
      filled: true,
      fillColor: SWColor.grayLight,
      hintText: hintText,
      hintStyle: grayTextStyle,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.0),
        borderSide: BorderSide.none,
      ),
      errorStyle: Theme.of(
        context,
      ).textTheme.bodySmall!.copyWith(color: SWColor.red),
    ),
    validator: validator,
  );
}
