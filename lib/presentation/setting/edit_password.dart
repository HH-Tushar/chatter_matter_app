import 'package:flutter/material.dart';

import '../../common/custom_buttons.dart';
import '../../common/custom_input.dart';
import '../../common/custom_text_style.dart';
import '../../common/gradiant_background.dart';
import '../../common/padding.dart';

class EditPassword extends StatefulWidget {
  const EditPassword({super.key});

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customGradientBackground(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  primaryBackButton(context: context),
                  Text("Change Password", style: heading()),
                  hPad30,
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    vPad20,

                    Text("Current Password", style: titleSmall()),

                    customInput(
                      hintText: "Enter current password",
                      initialValue: "",
                      isEnable: false,
                      onChange: (e) {},
                    ),

                    Text("New Password", style: titleSmall()),

                    customInput(
                      hintText: "Enter new password",
                      initialValue: "",
                      isEnable: false,
                      onChange: (e) {},
                    ),

                    Text("Confirm Password", style: titleSmall()),

                    customInput(
                      hintText: "Enter confirm password",
                      initialValue: "",
                      isEnable: false,
                      onChange: (e) {},
                    ),

                    vPad10,

                    customFilledButton(
                      title: "Save Update",
                      onTap: () {},
                      isLoading: isLoading,
                      width: double.infinity,
                    ),
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
