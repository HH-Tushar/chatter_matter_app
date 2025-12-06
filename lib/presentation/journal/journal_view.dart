import 'package:chatter_matter_app/common/colors.dart';
import 'package:chatter_matter_app/common/custom_text_style.dart';
import 'package:chatter_matter_app/common/padding.dart';
import 'package:flutter/material.dart';

class JournalView extends StatelessWidget {
  const JournalView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        spacing: 15,
        children: [
          Text("My Journal", style: heading()),

          Text(
            "Your conversation reflections",
            style: bodyMedium(color: customDarkGray),
          ),

          _customTile(),
          _customTile(),
          _customTile(),
          _customTile(),
          _customTile(),
        ],
      ),
    );
  }
}

_customTile() {
  return Container(
    padding: EdgeInsets.all(13),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(defaultRadius),
      color: customWhite,
      border: Border.all(color: customLightPurple),
    ),

    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Today", style: bodySmall(color: customGray)),
            GestureDetector(
              // splashRadius: 1,
              onTap: () {},
              child: Icon(Icons.delete_forever, color: customRed, size: 20),
            ),
          ],
        ),

        vPad10,
        Text(
          "What's the funniest memory we've shared together?",
          style: titleSmall(),
        ),
        vPad10,
        Text(
          "I remember building pillow forts with my siblings on rainy days. We'd spend hours creating elaborate things",
          style: bodyMedium(color: customDarkGray),
        ),
      ],
    ),
  );
}
