import 'package:flutter/material.dart';

import '../application/model/question_model.dart';
import 'colors.dart';
import 'custom_input.dart';
import 'custom_text_style.dart';
import 'padding.dart';

class CustomQuestionTile extends StatelessWidget {
  const CustomQuestionTile({
    super.key,
    required this.question,
    required this.index,
    this.bg,
    this.bgImage
  });
  final Question question;
  final Color? bg;
  final String? bgImage;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 400,
      decoration: BoxDecoration(
        color:bg?? Color(0xffC18DD9),
        borderRadius: BorderRadius.circular(defaultRadius),
      ),

      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(bgImage?? "assets/image/default_question_bg.png"),
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
                          "Question #${index + 1}",
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
                        child: Icon(Icons.share, color: customLightPurple),
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
                    question.title,
                    style: titleSmall(color: customWhite),
                    maxLines: 4,
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
                    onChange: (e) {
                      // ans = e;
                    },
                    fill: true,
                    maxLine: 3,
                  ),

                  InkWell(
                    enableFeedback: true,
                    // onTap: journalProvider.addingHomeJournal
                    //     ? null
                    //     : () async {
                    //         journalProvider.addJournal(
                    //           question: "question",
                    //           ans: ans,
                    //           isHome: true,
                    //         );
                    //       },
                    child: Container(
                      height: 50,
                      // alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                      decoration: BoxDecoration(
                        color: customLightPurple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 16,
                        children: [
                          Icon(Icons.menu_book_rounded, color: customWhite),

                          Text(
                            "Save To Journal",
                            style: bodyLarge(color: customWhite),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
