import 'package:chatter_matter_app/common/colors.dart';
import 'package:chatter_matter_app/common/custom_text_style.dart';
import 'package:chatter_matter_app/common/padding.dart';
import 'package:flutter/material.dart';

customFilledButton({
  required String title,
  required VoidCallback onTap,
  required bool isLoading,
  double width = 150,
}) {
  return FilledButton(
    style: FilledButton.styleFrom(
      backgroundColor: customDarkPurple,
      minimumSize: Size(width, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
    ),
    onPressed: isLoading ? null : onTap,
    child: Text(
      title,
      style: titleSmall(fontWeight: FontWeight.w600, color: customWhite),
    ),
  );
}

googleLoginButton() {
  return OutlinedButton(
    onPressed: () {},

    style: OutlinedButton.styleFrom(
      minimumSize: Size(150, 50),
      side: BorderSide(color: customDarkGray),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
        side: BorderSide(color: customDarkGray),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        Image.asset("assets/icons/google.png"),
        Text("Continue with Google", style: bodyLarge(color: customBlack)),
      ],
    ),
  );
}

appleLoginButton() {
  return FilledButton(
    onPressed: () {},

    style: FilledButton.styleFrom(
      backgroundColor: customBlack,
      minimumSize: Size(150, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        Image.asset("assets/icons/apple.png"),
        Text("Continue with Google", style: bodyLarge(color: customWhite)),
      ],
    ),
  );
}

primaryBackButton({required BuildContext context}) {
  return GestureDetector(
    onTap: () => Navigator.pop(context),
    child: Container(
      height: 35,
      width: 35,

      decoration: BoxDecoration(
        color: Color(0xffF8F8F8),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 4,
            spreadRadius: 0,
            color: Colors.grey.shade300,
          ),
        ],
      ),
      child: Icon(Icons.arrow_back_ios_new, size: 15),
    ),
  );
}
