import 'package:chatter_matter_app/application/user/auth_bloc.dart';
import 'package:chatter_matter_app/common/snack_bar.dart';
import 'package:chatter_matter_app/common/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  String newPassword = "";

  String confirmPassword = "";

  String oldPassword = "";

  final _formKey = GlobalKey<FormState>();

  void changePass() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final (data, error) = await Provider.of<UserBloc>(
        context,
        listen: false,
      ).changePassword(oldPassword: oldPassword, newPassword: newPassword);

      if (data != null) {
        showToast(context: context, title: data, toastType: ToastType.success);
      } else {
        showToast(
          context: context,
          title: error?.title ?? "",
          toastType: ToastType.failed,
        );
      }

      setState(() {
        isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = context.watch();
    return Scaffold(
      body: customGradientBackground(
        child: Form(
          key: _formKey,
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      vPad20,

                      Text("Current Password", style: titleSmall()),

                      customInput(
                        hintText: "Enter current password",
                        initialValue: "",
                        isEnable: !isLoading,
                        onChange: (e) => oldPassword = e,
                      ),

                      Text("New Password", style: titleSmall()),

                      customInput(
                        hintText: "Enter new password",
                        initialValue: "",
                        isEnable: !isLoading,
                        validator: (val) =>
                            CommonValidator.passwdValidator(val),
                        onChange: (e) => newPassword = e,
                      ),

                      Text("Confirm Password", style: titleSmall()),

                      customInput(
                        hintText: "Enter confirm password",
                        initialValue: "",
                        isEnable: !isLoading,
                        validator: (val) =>
                            CommonValidator.confirmPasswdValidator(
                              pass: newPassword,
                              val: val,
                            ),
                        onChange: (e) => confirmPassword = e,
                      ),

                      vPad10,

                      customFilledButton(
                        title: "Save Update",
                        onTap: () => changePass(),

                        isLoading: userBloc.isUpdatingPassword,
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
