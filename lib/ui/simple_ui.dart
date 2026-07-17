import 'package:flutter/material.dart';
import 'package:social_walking_2/ui/sw_color.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

Widget customButton({
  required String text,
  required Function() onPressed,
  Color? foregroundColor,
  Color? backgroundColor,
}) {
  return TextButton(
    style: TextButton.styleFrom(
      foregroundColor: foregroundColor ?? SWColor.white,
      backgroundColor: backgroundColor ?? SWColor.blue,
      padding: EdgeInsets.only(top: 14.0, bottom: 14.0),
    ),
    onPressed: onPressed,
    child: Text(text),
  );
}

Widget googleButton({required String text, required Function() onPressed}) {
  return TextButton.icon(
    style: TextButton.styleFrom(
      foregroundColor: SWColor.black,
      backgroundColor: SWColor.white,
      side: BorderSide(color: SWColor.black, width: 2.0),
      padding: EdgeInsets.only(top: 14.0, bottom: 14.0),
    ),
    onPressed: onPressed,
    label: Text(text),
    icon: SvgPicture.asset("images/google.svg", height: 28.0),
  );
}

Widget textInputField({
  required String hintText,
  required TextEditingController controller,
  required BuildContext context,
  required String? Function(String?)? validator,
  bool? isObscured,
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
      errorMaxLines: 2,
    ),
    validator: validator,
    obscureText: isObscured ?? false,
    onTapOutside: (PointerDownEvent event) {
      FocusManager.instance.primaryFocus?.unfocus();
    },
  );
}

Widget dropdownMenu(
  String hintText,
  Map<String, dynamic> data,
  TextEditingController controller,
  BuildContext context,
) {
  final grayTextStyle = Theme.of(
    context,
  ).textTheme.bodyMedium!.copyWith(color: SWColor.gray);
  return DropdownMenu(
    textStyle: grayTextStyle,
    controller: controller,
    hintText: hintText,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: SWColor.grayLight,
      hintStyle: grayTextStyle,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.0),
        borderSide: BorderSide.none,
      ),
      errorStyle: Theme.of(
        context,
      ).textTheme.bodySmall!.copyWith(color: SWColor.red),
      errorMaxLines: 2,
    ),
    dropdownMenuEntries: data.entries
        .map((e) => DropdownMenuEntry(value: e.value, label: e.key))
        .toList(),
  );
}
