import 'package:chatter_matter_app/application/user/auth_bloc.dart';
import 'package:chatter_matter_app/common/colors.dart';
import 'package:chatter_matter_app/common/custom_buttons.dart';
import 'package:chatter_matter_app/common/custom_input.dart';
import 'package:chatter_matter_app/common/custom_text_style.dart';
import 'package:chatter_matter_app/common/padding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/gradiant_background.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = context.watch();
    return Material(
      child: customGradientBackground(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  primaryBackButton(context: context),
                  Text("Edit Profile", style: heading()),
                  hPad30,
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    vPad20,

                    CircleAvatar(radius: 50),
                    vPad10,

                    Text("Full Name", style: titleSmall()),
                    customInput(
                      hintText: "Your Name",
                      initialValue: userBloc.profile?.name ?? "",
                      isEnable: !isLoading,
                      onChange: (e) {},
                    ),

                    Text("Email", style: titleSmall()),

                    customInput(
                      hintText: "Your Email",
                      initialValue: userBloc.profile!.email,
                      isEnable: false,
                      onChange: (e) {},
                    ),
                    vPad15,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Current Status"),
                            Row(
                              children: [
                                Text("7 Days", style: titleLarge()),
                                Icon(
                                  Icons.local_fire_department,
                                  color: customRed,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total Entries"),
                            Row(
                              children: [
                                Text("14", style: titleLarge()),
                                Icon(Icons.local_fire_department_outlined),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                    // ConstrainedBox(constraints: constraints)
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return Stack(
                          children: [
                            Container(
                              height: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  defaultRadius,
                                ),
                                color: customLightGray,
                              ),
                            ),
                            Container(
                              height: 10,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  defaultRadius,
                                ),
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xffFFFAB9),
                                    const Color(0xffFB64B6),
                                    const Color(0xffC27AFF),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    Center(child: Text("68% of milestone")),

                    vPad35,
                    customFilledButton(
                      title: "Save Update",
                      onTap: () {},
                      isLoading: isLoading,
                      width: double.infinity,
                    ),
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
