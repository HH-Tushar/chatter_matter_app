import 'package:chatter_matter_app/common/colors.dart';
import 'package:chatter_matter_app/common/gradiant_background.dart';
import 'package:chatter_matter_app/providers/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/custom_buttons.dart';
import '../../common/custom_text_style.dart';
import '../../common/padding.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardProvider dashboardProvider = context.watch();
    return Scaffold(
      body: customGradientBackground(
        child: SafeArea(
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
                        Text("Notification", style: heading()),
                        // Text(
                        //   "Subscription",
                        //   style: bodyMedium(color: customGray),
                        // ),
                      ],
                    ),

                    hPad30,
                  ],
                ),
              ),
              vPad15,
              Expanded(
                child: dashboardProvider.notifications.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("You do not have any notification yet."),
                          IconButton(
                            onPressed: () =>
                                dashboardProvider.getNotifications(),
                            icon: Icon(Icons.refresh),
                          ),
                        ],
                      )
                    : ListView.builder(
                        itemCount: dashboardProvider.notifications.length,
                        padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding,
                        ),
                        itemBuilder: (context, index) {
                          final item = dashboardProvider.notifications[index];
                          if (dashboardProvider.notifications.length - 1 <
                                  index &&
                              !dashboardProvider.isNotificationReachEnd) {
                            dashboardProvider.getNotifications();
                          }
                          return Card(
                            child: ListTile(
                              iconColor: customWhite,
                              minTileHeight: 50,
                              leading: Image.asset("assets/icons/noty.png"),
                              title: Text(item.title),
                              subtitle: Text(item.subTitle),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
