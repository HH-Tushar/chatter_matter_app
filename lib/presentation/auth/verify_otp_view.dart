import 'package:chatter_matter_app/common/navigator.dart';
import 'package:chatter_matter_app/presentation/auth/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../common/colors.dart';
import '../../common/custom_buttons.dart';
import '../../common/custom_text_style.dart';
import '../../common/padding.dart';
import '../../common/snack_bar.dart';

class VerifyOtpView extends StatefulWidget {
  const VerifyOtpView({super.key, required this.email});
  final String email;
  @override
  State<VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView> {
  // final ForgetPasswordRepo forgetPasswordRepo = ForgetPasswordRepo();
  // final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String otp = '';

  void verifyOtp() async {
    if (otp.length != 4) {
      showToast(
        context: context,
        title: "Please fill up OTP first",
        toastType: ToastType.warning,
      );
      return;
    }
    // if (formKey.currentState?.validate() != true) return;

    animatedNavigateTo(context, ResetPassword());

    setState(() {
      isLoading = true;
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              SizedBox(width: double.infinity),
              Align(
                alignment: Alignment.centerLeft,
                child: primaryBackButton(context: context),
              ),
              vPad35,
              vPad35,

              Text("Enter The Code", style: titleLarge(color: customBlack)),
              vPad15,
              Text(
                "OTP has been sent to ${widget.email}",
                style: bodyMedium(color: customGray),
              ),
              vPad35,
              vPad35,

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PinCodeTextField(
                  appContext: context,
                  length: 4,
                  autoDismissKeyboard: true,
                  obscureText: false,
                  enabled: !isLoading,
                  animationType: AnimationType.fade,
                  cursorColor: customBlack,
                  enableActiveFill: true,
                  pinTheme: PinTheme(
                    inactiveFillColor: customWhite,
                    activeFillColor: customWhite,
                    selectedFillColor: customWhite,
                    shape: PinCodeFieldShape.box,
                    borderWidth: 1,
                    activeBorderWidth: 1,
                    disabledBorderWidth: 1,

                    // inactiveBorderWidth: 5,
                    borderRadius: BorderRadius.circular(6),
                    fieldHeight: 50,
                    fieldWidth: 75,

                    inactiveColor: customDarkGray,
                    activeColor: customLightPurple,
                    selectedColor: customDarkPurple,
                  ),
                  onChanged: (value) {
                    otp = value;
                    print(value);
                  },
                  onCompleted: (value) {
                    print(value);
                  },
                ),
              ),

              // vPad20,
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Resend code in 10",
                  style: bodySmall(color: customDarkGray),
                ),
              ),
              vPad35,
              customFilledButton(
                isLoading: isLoading,
                title: "Verify OTP",
                width: double.infinity,
                onTap: () => verifyOtp(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
