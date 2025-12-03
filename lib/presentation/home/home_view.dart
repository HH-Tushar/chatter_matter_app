import 'package:chatter_matter_app/common/colors.dart';
import 'package:chatter_matter_app/common/custom_input.dart';
import 'package:chatter_matter_app/common/custom_text_style.dart';
import 'package:chatter_matter_app/common/padding.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Good morning",
                      style: bodyMedium(fontWeight: FontWeight.w500),
                    ),
                    Row(
                      spacing: 4,
                      children: [
                        Text(
                          "User name",
                          style: titleLarge(color: customBlack),
                        ),
                        Image.asset("assets/icons/hi.png"),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                height: 40,
                width: 40,

                decoration: BoxDecoration(
                  color: Color(0xffF8F8F8),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(4, 4),
                      blurRadius: 4,
                      spreadRadius: 0,
                      color: Colors.grey.shade400,
                    ),
                  ],
                ),
                child: Icon(Icons.notifications, color: customLightPurple),
              ),
            ],
          ),

          vPad20,

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 5,
                      children: [
                        Image.asset("assets/icons/star.png"),
                        Text("Question of the Day", style: titleSmall()),
                      ],
                    ),
                    Text(
                      "Sunday , November 2,2025",
                      style: bodyMedium(color: customDarkGray),
                    ),
                  ],
                ),
              ),

              Container(
                height: 35,
                width: 50,
                decoration: BoxDecoration(
                  color: customWhite,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: customLightGray),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("1", style: bodyLarge(color: customLightPurple)),
                    Text("/1"),
                  ],
                ),
              ),
            ],
          ),

          vPad20,

          Card(
            color: customWhite,
            elevation: 2,
            child: ListTile(
              title: Text("Unlock VIP Access"),
              subtitle: Text("Unlimited que • No ads"),
              leading: Image.asset("assets/icons/vip.png"),
              trailing: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: customLightPurple,
                ),
                child: Text("Upgrade", style: titleSmall(color: customWhite)),
              ),
            ),
          ),

          vPad20,

          Container(
            height: 310,

            decoration: BoxDecoration(
              color: Color(0xffC18DD9),
              borderRadius: BorderRadius.circular(defaultRadius),
            ),

            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset("assets/image/default_question_bg.png"),
                ),

                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 6,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Color(0xffFAF5FF),
                              ),
                              child: Text(
                                "Question #1",
                                style: bodyLarge(color: customDarkPurple),
                              ),
                            ),
                            hPadExp,
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Color(0xffFAF5FF),
                              ),
                              child: Icon(
                                Icons.share,
                                color: customLightPurple,
                              ),
                            ),
                            hPad10,
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Color(0xffFAF5FF),
                              ),
                              child: Icon(
                                Icons.favorite_border,
                                color: customLightPurple,
                              ),
                            ),
                          ],
                        ),

                        Text(
                          "What's something that made you smile today?",
                          style: titleSmall(color: customWhite),
                        ),

                        Row(
                          spacing: 5,
                          children: [
                            Icon(
                              Icons.menu_book_rounded,
                              color: const Color(0xffE0E0E0),
                            ),

                            Text(
                              "Your Thoughts",
                              style: bodyLarge(color: const Color(0xffE0E0E0)),
                            ),
                          ],
                        ),

                        customInput(
                          hintText: "Write Your Thoughts..",
                          isEnable: true,
                          onChange: (e) {},
                          fill: true,
                        ),

                        Container(
                          height: 50,
                          // alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding,
                          ),
                          decoration: BoxDecoration(
                            color: customLightPurple,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 5,
                            children: [
                              Icon(Icons.menu_book_rounded, color: customWhite),

                              Text(
                                "Your Thoughts",
                                style: bodyLarge(color: customWhite),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          vPad20,

          Container(
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultRadius),
              color: customLightYellow,
              border: Border.all(color: Colors.yellow),
            ),

            child: Row(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.error_outline, color: customBrawn),
                Expanded(
                  child: Text(
                    "You've reached your daily limit. Upgrade to continue !",
                    style: bodyMedium(color: customBrawn),
                  ),
                ),
              ],
            ),
          ),

          vPad20,

          Container(color: customGray, height: 150, width: double.infinity),

          vPad35,
        ],
      ),
    );
  }
}
