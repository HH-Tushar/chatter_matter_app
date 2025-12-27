import 'package:chatter_matter_app/common/colors.dart';
import 'package:chatter_matter_app/common/custom_buttons.dart';
import 'package:chatter_matter_app/common/custom_text_style.dart';
import 'package:chatter_matter_app/common/navigator.dart';
import 'package:chatter_matter_app/common/padding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/model/subscription_model.dart';
import '../../application/repo/subscription_repo.dart';
import '../../application/user/auth_bloc.dart';
import '../../env.dart';
import '../../providers/dashboard_provider.dart';
import '../payments/stripe_payment_webview.dart';

class SubscriptionView extends StatefulWidget {
  const SubscriptionView({super.key});

  @override
  State<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  final SubscriptionRepo subscriptionRepo = SubscriptionRepo();
  bool isLoading = false;
  void pay(String id, String planDurationType) async {
    setState(() {
      isLoading = true;
    });

    final (url, error) = await subscriptionRepo.createPaymentSession(
      subscriptionId: id,
      planDurationType: planDurationType,
    );
    if (url != null) {
      navigateTo(context, StripePaymentWebView(url: url));
    }

    setState(() {
      isLoading = false;
    });
  }

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
                      (i) => _PlanTile(
                        data: dashboardProvider.subscriptionPackages[i],
                        isCurrentPackage:
                            dashboardProvider
                                .subscriptionPackages[i]
                                .packageType ==
                            profile?.subscriptionType.name,
                        onPay: (e) => pay(
                          dashboardProvider.subscriptionPackages[i].id,
                          e,
                        ),
                        isLoading: isLoading,
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

class _PlanTile extends StatefulWidget {
  const _PlanTile({
    required this.data,
    required this.isCurrentPackage,
    required this.isLoading,
    required this.onPay,
  });
  final Package data;
  final bool isCurrentPackage;
  final Function(String) onPay;
  final bool isLoading;
  @override
  State<_PlanTile> createState() => __PlanTileState();
}

class __PlanTileState extends State<_PlanTile> {
  Color baseColor = customGray;
  bool? subscribeForYear;
  toggleColor() {
    baseColor = widget.data.packageType == "free"
        ? customGray
        : widget.data.packageType == "vip"
        ? customWarning
        : customLightPurple;
  }

  void toggle(bool val) {
    setState(() {
      if (subscribeForYear == val) {
        subscribeForYear = null;
      } else {
        subscribeForYear = val;
      }
    });
  }

  @override
  void initState() {
    toggleColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.isCurrentPackage);
    return Column(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            // color: customLightPurple.withAlpha(20),
            border: Border.all(color: baseColor, width: 1.5),
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 45,
                width: double.infinity,
                color: baseColor,
                child: Center(
                  child: Text(
                    widget.data.packageName,
                    textAlign: TextAlign.center,
                    style: titleMedium(color: customWhite),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Starting with", style: titleMedium()),
                    hPadExp,
                    Text(
                      "$currency ${widget.data.pricePerMonth}",
                      style: titleSmall(),
                    ),
                    Text(
                      " /month",
                      style: bodyMedium(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),

              Container(
                color: baseColor.withAlpha(15),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    vPad5,
                    // Text("Features:"),
                    ...List.generate(
                      widget.data.features.length,
                      (i) => Row(
                        spacing: 10,
                        children: [
                          // Icon(Icons.check_circle_outline_rounded, color: customGray),
                          CircleAvatar(
                            backgroundColor: baseColor.withAlpha(50),
                            radius: 11,
                            child: Icon(
                              Icons.check_rounded,
                              size: 16,
                              fontWeight: FontWeight.w900,
                              color: baseColor,
                            ),
                          ),
                          Text(widget.data.features[i]),
                        ],
                      ),
                    ),
                    vPad10,
                    SizedBox(width: double.infinity),
                    if (widget.data.packageType != "free")
                      Column(
                        children: [
                          ListTile(
                            onTap: () => toggle(false),
                            leading: subscribeForYear == false
                                ? Icon(
                                    Icons.check_circle_outline,
                                    color: baseColor,
                                  )
                                : Icon(Icons.circle_outlined),
                            tileColor: baseColor.withAlpha(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minTileHeight: 20,
                            title: Text("Monthly"),
                            subtitle: Text(
                              "${widget.data.pricePerMonth}/$currency",
                            ),
                          ),
                          vPad5,
                          ListTile(
                            // selected: true,
                            onTap: () => toggle(true),
                            leading: subscribeForYear == true
                                ? Icon(
                                    Icons.check_circle_outline,
                                    color: baseColor,
                                  )
                                : Icon(Icons.circle_outlined),
                            tileColor: baseColor.withAlpha(80),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minTileHeight: 20,
                            title: Text("Yearly"),
                            subtitle: Text(
                              "${widget.data.pricePerYear}/$currency",
                            ),
                          ),

                          vPad15,

                          SizedBox(
                            height: 40,
                            child: customFilledButton(
                              title: widget.isCurrentPackage
                                  ? "Current Plan"
                                  : "Subscribe Package",
                              onTap: () => widget.onPay(
                                subscribeForYear == true ? "yearly" : "monthly",
                              ),
                              isLoading:
                                  widget.isCurrentPackage ||
                                  widget.isLoading ||
                                  subscribeForYear == null,
                              width: double.infinity,
                            ),
                          ),
                        ],
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
}
