import 'package:chatter_matter_app/common/colors.dart';
import 'package:chatter_matter_app/common/custom_buttons.dart';
import 'package:chatter_matter_app/common/custom_text_style.dart';
import 'package:chatter_matter_app/common/navigator.dart';
import 'package:chatter_matter_app/common/padding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/model/subscription_model.dart';
import '../../application/user/auth_bloc.dart';
import '../../env.dart';
import '../../providers/dashboard_provider.dart';
import '../payments/stripe_web.dart';
import '../payments/test_pay.dart';

class SubscriptionView extends StatelessWidget {
  const SubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardProvider dashboardProvider = context.watch();
    final UserBloc userBloc = context.watch();
    final profile = userBloc.profile;
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
                      Text("Subscription", style: heading()),
                      Text(
                        "Subscription",
                        style: bodyMedium(color: customGray),
                      ),
                    ],
                  ),

                  hPad30,
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  spacing: 15,
                  children: [
                    vPad20,
                    ...List.generate(
                      dashboardProvider.subscriptionPackages.length,
                      (i) => _planTile(
                        data: dashboardProvider.subscriptionPackages[i],
                        isCurrentPackage:
                            dashboardProvider
                                .subscriptionPackages[i]
                                .packageType ==
                            profile?.subscriptionType.name,

                        onTap: () => navigateTo(context, StripePaymentWebView(url: "",)),
                      ),
                    ),

                    vPad35,
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

_planTile({
  required Package data,
  required bool isCurrentPackage,
  required VoidCallback onTap,
}) {
  return Column(
    children: [
      Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          // color: customLightPurple.withAlpha(20),
          border: Border.all(color: customLightPurple, width: 1.5),
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: double.infinity,
              color: customLightPurple,
              child: Center(
                child: Text(
                  data.packageName,
                  textAlign: TextAlign.center,
                  style: titleSmall(color: customWhite),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(data.packageType, style: titleLarge()),
                  hPadExp,
                  Text("$currency ${data.pricePerMonth}", style: titleSmall()),
                  Text(
                    " /month",
                    style: bodyMedium(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),

            Container(
              color: customLightPurple.withAlpha(15),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  vPad5,
                  // Text("Features:"),
                  ...List.generate(
                    data.features.length,
                    (i) => Row(
                      spacing: 10,
                      children: [
                        // Icon(Icons.check_circle_outline_rounded, color: customGray),
                        CircleAvatar(
                          backgroundColor: customLightGray,
                          radius: 11,
                          child: Icon(Icons.check_rounded, size: 16),
                        ),
                        Text(data.features[i]),
                      ],
                    ),
                  ),
                  vPad10,
                  SizedBox(
                    height: 40,
                    child: customFilledButton(
                      title: isCurrentPackage
                          ? "Current Plan"
                          : "Subscribe Package",
                      onTap: onTap,
                      isLoading: isCurrentPackage,
                      width: double.infinity,
                    ),
                  ),

                  vPad5,
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
