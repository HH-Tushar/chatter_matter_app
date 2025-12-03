import 'package:chatter_matter_app/common/colors.dart';
import 'package:chatter_matter_app/common/custom_buttons.dart';
import 'package:chatter_matter_app/common/custom_input.dart';
import 'package:chatter_matter_app/common/custom_text_style.dart';
import 'package:chatter_matter_app/common/navigator.dart';
import 'package:chatter_matter_app/common/padding.dart';
import 'package:chatter_matter_app/presentation/auth/verify_otp_view.dart';
import 'package:flutter/material.dart';

import '../../common/gradiant_background.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool isLoading = false;
  String email = "email@gmail.com";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customGradientBackground(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: primaryBackButton(context: context),
              ),
              vPad35,
              Text("Forget Password", style: heading()),
              Text(
                "Enter the required details",
                style: bodyMedium(color: customGray),
              ),
              vPad35,
              vPad20,
              customInput(
                hintText: "Enter your email",
                isEnable: !isLoading,
                onChange: (e) {},
              ),
              vPad35,
              customFilledButton(
                title: "Next",
                onTap: () =>
                    animatedNavigateTo(context, VerifyOtpView(email: email)),
                isLoading: isLoading,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
