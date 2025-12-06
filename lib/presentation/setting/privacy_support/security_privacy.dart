import 'package:chatter_matter_app/common/custom_buttons.dart';
import 'package:chatter_matter_app/common/custom_text_style.dart';
import 'package:chatter_matter_app/common/padding.dart';
import 'package:flutter/material.dart';

import '../../../common/gradiant_background.dart';

class SecurityPrivacy extends StatefulWidget {
  const SecurityPrivacy({super.key});

  @override
  State<SecurityPrivacy> createState() => _SecurityPrivacyState();
}

class _SecurityPrivacyState extends State<SecurityPrivacy> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: customGradientBackgroundWithSvg(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    primaryBackButton(context: context),
                    Text("Security & Privacy", style: heading()),
                    hPad30,
                  ],
                ),

                vPad35,
                Text(
                  "Your privacy is important to us. It is Brainstorming's policy to respect your privacy regarding any information we may collect from you across our website, and other sites we own and operate.\n\n"
                  "We only ask for personal information when we truly need it to provide a service to you. We collect it by fair and lawful means, with your knowledge and consent. We also let you know why we’re collecting it and how it will be used.\n\n"
                  "We only retain collected information for as long as necessary to provide you with your requested service. What data we store, we’ll protect within commercially acceptable means to prevent loss and theft, as well as unauthorized access, disclosure, copying, use or modification.\n\n"
                  "We don’t share any personally identifying information publicly or with third-parties, except when required to by law.",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
