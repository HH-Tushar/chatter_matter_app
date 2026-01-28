import 'package:chatter_matter_app/application/user/auth_bloc.dart';
import 'package:chatter_matter_app/common/colors.dart';
import 'package:chatter_matter_app/common/padding.dart';
import 'package:chatter_matter_app/common/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/custom_buttons.dart';
import '../../common/custom_text_style.dart';

class AgeGroupView extends StatefulWidget {
  const AgeGroupView({super.key});

  @override
  State<AgeGroupView> createState() => _AgeGroupViewState();
}

class _AgeGroupViewState extends State<AgeGroupView> {
  bool isAdultUser = false;
  bool isLoading = false;
  void init() {
    final user = Provider.of<UserBloc>(context, listen: false).profile;
    isAdultUser = (user?.age != null && user!.age > 10);
  }

  void toggle(bool val) {
    setState(() {
      isAdultUser = val;
    });
  }

  void update() async {
    setState(() {
      isLoading = true;
    });

    final (data, error) = await Provider.of<UserBloc>(
      context,
      listen: false,
    ).updateProfile(age: isAdultUser ? 18 : 8);

    if (mounted && data != null) {
      showGlobalOverlayToast(
        context: context,
        message: data,
        type: ToastType.success,
      );
    } else if (mounted && error != null) {
      showGlobalOverlayToast(
        context: context,
        message: error.title ?? "",
        type: ToastType.success,
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 15,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: primaryBackButton(context: context),
              ),

              vPad35,
              Text("Select Your Age Group", style: heading()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Choose your age group to get the appropriate questions for you.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: customGray),
                ),
              ),
              vPad20,

              ListTile(
                onTap: isLoading ? null : () => toggle(false),
                tileColor: !isAdultUser
                    ? customLightPurple.withAlpha(100)
                    : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  side: BorderSide(color: customDarkPurple, width: 1.5),
                ),
                leading: !isAdultUser
                    ? Icon(Icons.radio_button_checked, color: customDarkPurple)
                    : Icon(Icons.radio_button_off),
                title: Text(
                  "4 - 10 Years",
                  style: titleSmall(
                    color: !isAdultUser ? customDarkPurple : null,
                  ),
                ),
              ),

              ListTile(
                onTap: isLoading ? null : () => toggle(true),
                tileColor: isAdultUser
                    ? customLightPurple.withAlpha(100)
                    : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  side: BorderSide(color: customDarkPurple, width: 1.5),
                ),
                leading: isAdultUser
                    ? Icon(Icons.radio_button_checked, color: customDarkPurple)
                    : Icon(Icons.radio_button_off),
                title: Text(
                  "11+ Years",
                  style: titleSmall(
                    color: isAdultUser ? customDarkPurple : null,
                  ),
                ),
              ),

              vPad35,
              customFilledButton(
                width: double.infinity,
                title: "Continue",
                onTap: () => update(),
                isLoading: isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
