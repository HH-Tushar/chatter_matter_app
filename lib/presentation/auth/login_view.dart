import 'package:chatter_matter_app/common/colors.dart';
import 'package:chatter_matter_app/common/custom_buttons.dart';
import 'package:chatter_matter_app/common/custom_input.dart';
import 'package:chatter_matter_app/common/custom_text_style.dart';
import 'package:chatter_matter_app/common/navigator.dart';
import 'package:chatter_matter_app/common/padding.dart';
import 'package:chatter_matter_app/presentation/auth/forget_password.dart';
import 'package:chatter_matter_app/presentation/auth/register_view.dart';
import 'package:flutter/material.dart';

import '../landing/landing_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/image/customGradiantBg.png",
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    SizedBox(
                      width: 150,
                      child: Image.asset("assets/image/brand_logo.png"),
                    ),
                    vPad35,
                    Text("Login", style: heading()),
                    vPad5,
                    Text(
                      "Chatter Matters by Veenu Inspired",
                      style: bodyMedium(color: customLightGray),
                    ),
                    vPad35,

                    customInput(
                      hintText: "User Email",
                      isEnable: true,
                      onChange: (e) {},
                    ),
                    vPad15,
                    customInput(
                      hintText: "Password",
                      isEnable: true,
                      onChange: (e) {},
                    ),
                    // vPad10,
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () =>
                            animatedNavigateTo(context, ForgetPassword()),
                        child: Text(
                          "Forget Password ?",
                          style: bodyMedium(color: customGray),
                        ),
                      ),
                    ),
                    vPad35,

                    customFilledButton(
                      title: "Log In",
                      onTap: () =>animatedNavigateReplaceAll(context, LandingView()),
                      isLoading: isLoading,
                      width: double.infinity,
                    ),
                    vPad35,
                    Row(
                      children: [
                        Expanded(
                          child: Divider(endIndent: 10, color: customGray),
                        ),
                        Text("Or", style: bodyLarge(color: customDarkGray)),
                        Expanded(child: Divider(indent: 10, color: customGray)),
                      ],
                    ),

                    vPad35,
                    googleLoginButton(),
                    vPad20,
                    appleLoginButton(),
                    vPad20, vPad5,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // spacing: 4,
                      children: [
                        Text("Don’t have any account ?"),
                        TextButton(
                          onPressed: () {
                            animatedNavigateReplace(context, RegisterView());
                          },
                          child: Text(
                            "Sign Up",
                            style: bodyMedium(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
