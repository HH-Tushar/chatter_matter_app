import 'package:carousel_slider/carousel_slider.dart';
import 'package:chatter_matter_app/common/colors.dart';
import 'package:chatter_matter_app/common/custom_input.dart';
import 'package:chatter_matter_app/common/custom_text_style.dart';
import 'package:chatter_matter_app/common/navigator.dart';
import 'package:chatter_matter_app/common/padding.dart';
import 'package:chatter_matter_app/providers/journal_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/question_provider.dart';
import '../subsription/subscription_view.dart';
part 'question_tile.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    String ans = "";
    final JournalProvider journalProvider = context.watch();
    final QuestionProvider questionProvider = context.watch();
    return RefreshIndicator(
      onRefresh: () async=> questionProvider.getQuestion(),
      child: SingleChildScrollView(
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
                onTap: () => animatedNavigateTo(context, SubscriptionView()),
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
      
            SizedBox(
              // height: 400,
              child: CarouselSlider(
                items: List.generate(
                  questionProvider.questionList.length,
                  (i) => customQuestionTile(),
                ),
                options: CarouselOptions(
                  aspectRatio: 1,
                  height: 310,
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                ),
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
      ),
    );
  }
}
