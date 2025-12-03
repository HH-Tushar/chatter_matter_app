import 'package:chatter_matter_app/common/colors.dart';
import 'package:chatter_matter_app/common/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget customInput({
  required String hintText,
  String? initialValue,
  required bool isEnable,
  bool? visible,
  bool? fill = false,
  bool applyBorder = false,
  TextInputFormatter? formatter,
  required Function(String)? onChange,
  VoidCallback? onVisible,
}) {
  return TextFormField(
    obscureText: visible ?? false,
    enabled: isEnable,
    initialValue: initialValue,
    style: bodyMedium(color: Colors.grey.shade700),
    inputFormatters: formatter != null ? [formatter] : null,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: bodyMedium(color: customGray),
      filled: fill,
      fillColor: customWhite,
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade700),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade700),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade700),
        borderRadius: BorderRadius.circular(8),
      ),

      suffixIcon: visible == true
          ? IconButton(onPressed: onVisible, icon: Icon(Icons.visibility))
          : visible == false
          ? IconButton(onPressed: onVisible, icon: Icon(Icons.visibility_off))
          : null,
    ),

    onChanged: onChange,
  );
}
