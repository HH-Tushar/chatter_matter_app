import 'package:chatter_matter_app/common/colors.dart';
import 'package:chatter_matter_app/common/custom_buttons.dart';
import 'package:chatter_matter_app/common/custom_text_style.dart';
import 'package:chatter_matter_app/common/navigator.dart';
import 'package:chatter_matter_app/common/padding.dart';
import 'package:flutter/material.dart';

import 'edit_password.dart';
import 'edit_profile.dart';
import 'privacy_support/security_privacy.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),

      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text("Settings", style: heading())),
          vPad10,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Profile".toUpperCase(),
              style: titleMedium(
                fontWeight: FontWeight.w500,
                color: customDarkGray,
              ),
            ),
          ),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
              side: BorderSide(color: customLightPurple),
            ),
            child: ListTile(
              minTileHeight: 45,
              leading: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: customLightPurple, width: 2),
                ),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 8),

              title: Text("User name"),
              subtitle: Text("User email"),
              trailing: SizedBox(
                height: 40,
                child: customFilledButton(
                  title: "Edit",
                  onTap: () {
                    animatedNavigateTo(context, EditProfile());
                  },
                  isLoading: false,
                  width: 60,
                ),
              ),
            ),
          ),

          Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 8),
            margin: EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              border: Border.all(color: customLightPurple),
              borderRadius: BorderRadius.circular(defaultRadius),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/image/upgrade_tile_bg.png"),
              ),
            ),

            child: Row(
              spacing: 12,
              children: [
                Image.asset("assets/icons/setting_upgrade.png"),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Upgrade to Premium",
                        style: titleSmall(color: customWhite),
                      ),
                      Text(
                        "Unlock all features",
                        style: bodyMedium(color: customDarkPurple),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios_rounded, size: 20),
                ),
              ],
            ),
          ),
          vPad20,

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Settings".toUpperCase(),
              style: titleMedium(
                fontWeight: FontWeight.w500,
                color: customDarkGray,
              ),
            ),
          ),
          _settingsTile(
            icon: "assets/icons/noti.png",
            title: "Push Notifications",
            subTitle: "Daily reminders",
            trailing: Switch(value: true, onChanged: (v) {}),
            baseColor: customGreen,
          ),
          _settingsTile(
            icon: "assets/icons/lock.png",
            title: "Change Password",
            subTitle: "Ensuring your security",
            trailing: IconButton(
              onPressed: () {
                animatedNavigateTo(context, EditPassword());
              },
              icon: Icon(Icons.arrow_forward_ios_rounded, size: 20),
            ),
            baseColor: customGreen,
          ),

          _settingsTile(
            icon: "assets/icons/support.png",
            title: "Support & Legal",
            subTitle: "Support & legal",
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_ios_rounded, size: 20),
            ),
            baseColor: customGreen,
          ),

          _settingsTile(
            icon: "assets/icons/security.png",
            title: "Security & Privacy",
            subTitle: "About your privacy",
            trailing: IconButton(
              onPressed: () {
                animatedNavigateTo(context, SecurityPrivacy());
              },
              icon: Icon(Icons.arrow_forward_ios_rounded, size: 20),
            ),
            baseColor: customGreen,
          ),

          Card(
            elevation: 0,
            color: customLightPurple.withOpacity(.2),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: customLightPurple),
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
            child: ListTile(
              leading: Icon(Icons.logout, color: customDarkPurple),

              // contentPadding: EdgeInsets.symmetric(horizontal: 8),
              // minTileHeight: 45,
              title: Text(
                "Log Out",
                style: titleSmall(color: customDarkPurple),
              ),
            ),
          ),

          vPad20,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Danger Zone".toUpperCase(),
              style: titleMedium(fontWeight: FontWeight.w500, color: customRed),
            ),
          ),

          customOutlinedButton(
            title: "Delete Account",
            onTap: () {},
            isLoading: false,
            baseColor: customRed,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}

_settingsTile({
  required String title,
  required String subTitle,
  required Color baseColor,
  required Widget trailing,
  required String icon,
}) {
  return Card(
    elevation: 0,
    color: customWhite,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: customLightPurple),
      borderRadius: BorderRadius.circular(defaultRadius),
    ),
    child: ListTile(
      leading: Image.asset(icon),
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      minTileHeight: 45,
      title: Text(title),
      subtitle: Text(subTitle),
      trailing: trailing,
    ),
  );
}
