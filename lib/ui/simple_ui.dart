import 'package:dropdown_search/dropdown_search.dart';
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
  TextInputType? keyboardType,
  List<String>? autofillHints,
}) {
  final grayTextStyle = Theme.of(
    context,
  ).textTheme.bodyMedium!.copyWith(color: SWColor.gray);
  return TextFormField(
    style: grayTextStyle,
    controller: controller,
    keyboardType: keyboardType,
    autofillHints: autofillHints,
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

Widget tappableReadOnlyInputField({
  required String hintText,
  required TextEditingController controller,
  required BuildContext context,
  required void Function()? onTap,
}) {
  final grayTextStyle = Theme.of(
    context,
  ).textTheme.bodyMedium!.copyWith(color: SWColor.gray);
  return TextFormField(
    readOnly: true,
    onTap: onTap,
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
  );
}

Widget dropdownMenu({
  required String hintText,
  required List<String> data,
  required BuildContext context,
  required void Function(String?) onChanged,
  required String? Function(String?)? validator,
}) {
  final grayTextStyle = Theme.of(
    context,
  ).textTheme.bodyMedium!.copyWith(color: SWColor.gray);
  return DropdownSearch<String>(
    onChanged: onChanged,
    popupProps: PopupProps.menu(
      showSearchBox: false,
      fit: FlexFit.loose,
      menuProps: MenuProps(
        borderRadius: BorderRadius.circular(18.0),
        backgroundColor: SWColor.white,
      ),
      itemBuilder: (context, item, isDisabled, isSelected) {
        return Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 8.0, left: 16.0),
          child: Text(
            item,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: SWColor.gray),
          ),
        );
      },
    ),
    items: (filter, loadProps) {
      return data.where((item) {
        return item.toLowerCase().startsWith(filter.toLowerCase());
      }).toList();
    },
    decoratorProps: DropDownDecoratorProps(
      baseStyle: grayTextStyle,
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
    ),
    validator: validator,
  );
}

Widget dropdownMenuWithSearch({
  required String hintText,
  required List<String> data,
  required BuildContext context,
  required void Function(String?) onChanged,
  required String? Function(String?)? validator,
}) {
  final grayTextStyle = Theme.of(
    context,
  ).textTheme.bodyMedium!.copyWith(color: SWColor.gray);
  return DropdownSearch<String>(
    onChanged: onChanged,
    popupProps: PopupProps.menu(
      showSearchBox: true,
      fit: FlexFit.loose,
      emptyBuilder: (context, searchEntry) {
        if (searchEntry.isEmpty) {
          return SizedBox.shrink();
        } else {
          return Center(
            child: Text(
              "No matches found.",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: SWColor.gray),
            ),
          );
        }
      },

      menuProps: MenuProps(
        borderRadius: BorderRadius.circular(18.0),
        backgroundColor: SWColor.white,
      ),
      searchFieldProps: TextFieldProps(
        style: grayTextStyle,
        decoration: InputDecoration(
          filled: true,
          fillColor: SWColor.grayLight,
          hintText: "Search here...",
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
      ),

      itemBuilder: (context, item, isDisabled, isSelected) {
        return Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 8.0, left: 16.0),
          child: Text(
            item,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: SWColor.gray),
          ),
        );
      },
    ),
    items: (filter, loadProps) {
      if (filter.isEmpty) return [];
      return data.where((item) {
        return item.toLowerCase().startsWith(filter.toLowerCase());
      }).toList();
    },
    decoratorProps: DropDownDecoratorProps(
      baseStyle: grayTextStyle,
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
    ),
    validator: validator,
  );
}
