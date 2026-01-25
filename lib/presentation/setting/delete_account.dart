import 'package:chatter_matter_app/application/user/auth_bloc.dart';
import 'package:chatter_matter_app/common/custom_input.dart';
import 'package:chatter_matter_app/common/navigator.dart';
import 'package:chatter_matter_app/common/snack_bar.dart';
import 'package:chatter_matter_app/common/validator.dart';
import 'package:chatter_matter_app/presentation/onbording/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/custom_buttons.dart';
import '../../common/custom_text_style.dart';
import '../../common/gradiant_background.dart';
import '../../common/padding.dart';

class DeleteAccountView extends StatefulWidget {
  const DeleteAccountView({super.key});

  @override
  State<DeleteAccountView> createState() => _DeleteAccountViewState();
}

class _DeleteAccountViewState extends State<DeleteAccountView> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  String reason = "";

  void delete(BuildContext cont) async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    final (data, error) = await Provider.of<UserBloc>(
      cont,
      listen: false,
    ).deleteAccount(reason);
    if (data != null) {
      showGlobalOverlayToast(
        context: cont,
        message: data,
        type: ToastType.success,
      );
      navigateReplaceAll(cont, StartScreen());
    } else {
      showGlobalOverlayToast(
        context: cont,
        message: error?.title ?? "",
        type: ToastType.failed,
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: customGradientBackgroundWithSvg(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    primaryBackButton(context: context),
                    Text("Delete Account", style: heading()),
                    hPad30,
                  ],
                ),

                vPad35,
                Text(
                  "All your data will be deleted. We will no longer have access to this account.",
                ),
                vPad15,
                Text("Are you sure you want to delete your account ?"),
                vPad20,
                customInput(
                  hintText: "Reason",
                  isEnable: !isLoading,
                  onChange: (e) => reason = e,
                  minLine: 3,
                  maxLine: 6,
                  validator: (e) => CommonValidator.reasonValidator(e),
                ),
                vPad35,
                Center(
                  child: customFilledButton(
                    title: "Delete Account",
                    onTap: () async => delete(context),
                    isLoading: isLoading,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
