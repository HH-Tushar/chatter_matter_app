import 'package:flutter/material.dart';

import '../../common/custom_buttons.dart';
import '../../common/custom_text_style.dart';
import '../../common/padding.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

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
                      Text("Notification", style: heading()),
                      // Text(
                      //   "Subscription",
                      //   style: bodyMedium(color: customGray),
                      // ),
                    ],
                  ),

                  hPad30,
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Text("You do not have any notification yet."),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
