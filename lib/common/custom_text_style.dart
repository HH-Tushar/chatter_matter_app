import 'package:flutter/material.dart';

import 'colors.dart';

TextStyle heading({Color? color, FontWeight? fontWeight}) {
  return TextStyle(
    fontSize: 22,
    fontWeight: fontWeight ?? FontWeight.w700,
    color: color ?? customBlack,
    fontFamily: "Roboto",
  );
}
TextStyle headingLarge({Color? color, FontWeight? fontWeight}) {
  return TextStyle(
    fontSize: 26,
    fontWeight: fontWeight ?? FontWeight.w700,
    color: color ?? customBlack,
    fontFamily: "Roboto",
  );
}

TextStyle bodyLarge({Color? color, FontWeight? fontWeight}) {
  return TextStyle(
    fontSize: 16,
    fontWeight: fontWeight ?? FontWeight.w500,
    color: color,
    fontFamily: "Roboto",
  );
}

TextStyle bodyMedium({Color? color, FontWeight? fontWeight}) {
  return TextStyle(
    fontSize: 14,
    fontWeight: fontWeight ?? FontWeight.w400,
    color: color,
    fontFamily: "Roboto",
  );
}

TextStyle bodySmall({Color? color, FontWeight? fontWeight}) {
  return TextStyle(
    fontSize: 12,
    fontWeight: fontWeight ?? FontWeight.w400,
    color: color,
    fontFamily: "Roboto",
  );
}

///
///title
///

TextStyle titleLarge({Color? color, FontWeight? fontWeight}) {
  return TextStyle(
    fontSize: 20,
    fontWeight: fontWeight ?? FontWeight.w600,
    color: color ?? customLightPurple,
    fontFamily: "Roboto",
  );
}

TextStyle titleMedium({Color? color, FontWeight? fontWeight}) {
  return TextStyle(
    fontSize: 18,
    fontWeight: fontWeight ?? FontWeight.w600,
    color: color ?? customBlack,
    fontFamily: "Roboto",
  );
}

TextStyle titleSmall({Color? color, FontWeight? fontWeight}) {
  return TextStyle(
    fontSize: 16,
    fontWeight: fontWeight ?? FontWeight.w500,
    color: color ?? customBlack,
    fontFamily: "Roboto",
  );
}

String formatNumberWithComa(int value) {
  return value.toString().replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (match) => '${match[1]},',
  );
}
