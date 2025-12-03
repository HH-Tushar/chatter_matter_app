import 'package:chatter_matter_app/presentation/auth/login_view.dart';
import 'package:flutter/material.dart';

import '../../common/colors.dart';
import '../../common/custom_buttons.dart';
import '../../common/custom_input.dart';
import '../../common/custom_text_style.dart';
import '../../common/gradiant_background.dart';
import '../../common/navigator.dart';
import '../../common/padding.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  bool isLoading = false;
  String email = "email@gmail.com";
  bool visiblePassword = false;
  bool visibleConfirmPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customGradientBackground(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: Image.asset("assets/image/brand_logo.png"),
              ),
              vPad35,
              Text("Sign Up", style: heading()),
              vPad5,
              Text(
                "Chatter Matters by Veenu Inspired",
                style: bodyMedium(color: customLightGray),
              ),
              vPad35,
              vPad20,
              customInput(
                hintText: "Enter your name",
                isEnable: !isLoading,
                onChange: (e) {},
              ),
              vPad15,
              customInput(
                hintText: "Enter your email",
                isEnable: !isLoading,
                onChange: (e) {},
              ),
              vPad15,
              customInput(
                hintText: "Password",
                isEnable: !isLoading,
                onChange: (e) {},
                onVisible: () => setState(() {
                  visiblePassword = !visiblePassword;
                }),
                visible: !visiblePassword,
              ),
              vPad15,
              customInput(
                hintText: "Confirm Password",
                isEnable: !isLoading,
                onChange: (e) {},
                onVisible: () => setState(() {
                  visibleConfirmPassword = !visibleConfirmPassword;
                }),
                visible: !visibleConfirmPassword,
              ),
              vPad15,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 4,
                children: [
                  Checkbox(value: true, onChanged: (e) {}),

                  Text("I agree the"),
                  Text("User Agreement", style: bodyMedium(color: customGreen)),
                  Text("and"),
                  Text(
                    "Privacy Policy.",
                    style: bodyMedium(color: customGreen),
                  ),
                ],
              ),
              vPad35,
              customFilledButton(
                title: "Sign Up",
                onTap: () {},
                isLoading: isLoading,
                width: double.infinity,
              ),

              vPad35,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // spacing: 4,
                children: [
                  Text("Already have any account ?"),
                  TextButton(
                    onPressed: () {
                      animatedNavigateReplace(context, LoginView());
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
    );
  }
}
