import 'package:chatter_matter_app/common/colors.dart';
import 'package:chatter_matter_app/common/custom_buttons.dart';
import 'package:chatter_matter_app/common/custom_text_style.dart';
import 'package:chatter_matter_app/common/padding.dart';
import 'package:flutter/material.dart';

import '../../env.dart';

class SubscriptionView extends StatelessWidget {
  const SubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  primaryBackButton(context: context),
                  Column(
                    children: [
                      Text("Subscription", style: heading()),
                      Text(
                        "Subscription",
                        style: bodyMedium(color: customGray),
                      ),
                    ],
                  ),

                  hPad30,
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  spacing: 15,
                  children: [
                    vPad20,
                    _planTile(),
                    _planTile(),
                    _planTile(),
                    vPad35,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_planTile() {
  return Column(
    children: [
      Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          // color: customLightPurple.withAlpha(20),
          border: Border.all(color: customLightPurple, width: 1.5),
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: double.infinity,
              color: customLightPurple,
              child: Center(
                child: Text(
                  "Standard",
                  textAlign: TextAlign.center,
                  style: titleSmall(color: customWhite),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Standard", style: titleLarge()),
                  hPadExp,
                  Text("$currency 99.5", style: titleSmall()),
                  Text(
                    " /month",
                    style: bodyMedium(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),

            Container(
              color: customLightPurple.withAlpha(15),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  vPad5,
                  // Text("Features:"),
                  ...List.generate(
                    3,
                    (i) => Row(
                      spacing: 10,
                      children: [
                        // Icon(Icons.check_circle_outline_rounded, color: customGray),
                        CircleAvatar(
                          backgroundColor: customLightGray,
                          radius: 11,
                          child: Icon(Icons.check_rounded, size: 16),
                        ),
                        Text("3 question a day"),
                      ],
                    ),
                  ),
                  vPad10,
                  SizedBox(
                    height: 40,
                    child: customFilledButton(
                      title: "Subscribe Package",
                      onTap: () {},
                      isLoading: true,
                      width: double.infinity,
                    ),
                  ),

                  vPad5,
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
